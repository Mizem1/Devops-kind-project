import { Module } from '@nestjs/common';
import { AuthModule } from './auth/auth.module';
import { UserModule } from './user/user.module';
import { DatabaseModule } from './database/database.module';
import { ConfigModule } from './config/config.module';
import { AppController } from './app.controller';

@Module({
  imports: [AuthModule, UserModule, DatabaseModule, ConfigModule],
  controllers: [AppController],
})
export class AppModule {}

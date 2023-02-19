Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADDDD69C189
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 18:04:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbjBSRE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 12:04:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbjBSREX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 12:04:23 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7E2312BC1;
        Sun, 19 Feb 2023 09:04:04 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id b11so1381024wrw.5;
        Sun, 19 Feb 2023 09:04:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R5DznUOeG1bSZpiguL2OeIOBwVtC+RrZVMm6C8Ip3Ls=;
        b=Bxxx1UfOrDCDm213wEbKLNFnQpw6xLyS8GqgDBFYmElba0m/lvUAXPI+CpoxkrPEEn
         f21OvLta4AiZH6eQcJaGGeD69xNaUGphQdIIaSLPvpE/H5xoSfEdQr8iNdUzSGGrYRbZ
         kJY4PA1jvbw4eA/+6YmCM1vGHPxY+jVQTuQ4jm3StAs/XJEA6PCtCTkPSCc89bYK2Zn2
         8xOGQOSHEDbFrw7AGPqZvpXIfQlhoKnzaaGvxWTtC6zGWF6/tJvAb9SOwyTOsaPKvH4j
         30Yuz7wP/dyqcFmU81hws22L+W8jkeaNBvEcoSccrC3NhV9Jk6NvomCqiw3HoxVpoPY5
         mwTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R5DznUOeG1bSZpiguL2OeIOBwVtC+RrZVMm6C8Ip3Ls=;
        b=QqgA3zSLjeU+EdpgHrw0s7mN+dioZ5FGAANREAQdo9y/pmrKSHi0kJxZtSxLwUi8xx
         /D5bfkKeY0FnKP9TCBc7rEp8Vnj01k2pXI/g9lcRGvhorH77cA3mWRPSYuib+3Jda4S7
         j2ABM52lmdusUisHEP7WDjJGSrbsmP1L/fdM4NZn5fpvfZwB8l6ssLsY7I+FY6cFnNWM
         UsErM5xtHOaIihfy8vAde74QOuWLfDxPbpCtyNKf+FXJoXKDuiJQ0qS2UDSHheW8I056
         /awXL+hWwepe8M/Ey+wF+1g0xoOMudJrsQ6skLzYoAUvJHCdPjT+1VOD/K3RbUEDK8D6
         z6kA==
X-Gm-Message-State: AO0yUKXLWp/3r93rHudQWhSbdr1XE/A96pCgnM1c/WT0GYf2cYJsqENd
        3ekYAjRfPptzFq/IJ8iKkL1slmAeDsM=
X-Google-Smtp-Source: AK7set88C/0F9UaqFtEhEStoYTf1q8gilq2iA2lZtMduEwk5QujHpkOZKqDDjd5TpM8RqCkUJ0K4+Q==
X-Received: by 2002:a5d:4e51:0:b0:2c5:a605:80c0 with SMTP id r17-20020a5d4e51000000b002c5a60580c0mr441448wrt.11.1676826242875;
        Sun, 19 Feb 2023 09:04:02 -0800 (PST)
Received: from localhost.localdomain (6.red-83-37-22.dynamicip.rima-tde.net. [83.37.22.6])
        by smtp.gmail.com with ESMTPSA id m11-20020a5d6a0b000000b002c55ec7f661sm9918548wru.5.2023.02.19.09.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Feb 2023 09:04:02 -0800 (PST)
From:   Angel Iglesias <ang.iglesiasg@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     Angel Iglesias <ang.iglesiasg@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alexandru Lazar <alazar@startmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andreas Klinger <ak@it-klinger.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 7/7] iio: pressure: bmp280: Add nvmem operations for BMP580
Date:   Sun, 19 Feb 2023 18:03:06 +0100
Message-Id: <f3f453d9b2c0f7820ca9c56e24e2165b6c39bb67.1676823250.git.ang.iglesiasg@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1676823250.git.ang.iglesiasg@gmail.com>
References: <cover.1676823250.git.ang.iglesiasg@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pressure sensor BMP580 contains a non-volatile memory that stores
trimming and configuration params. That memory provides an programmable
user range of three 2-byte words.

Signed-off-by: Angel Iglesias <ang.iglesiasg@gmail.com>

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index a7d26d81ec08..1e7534d7c4a6 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -28,6 +28,7 @@
 #include <linux/bitfield.h>
 #include <linux/device.h>
 #include <linux/module.h>
+#include <linux/nvmem-provider.h>
 #include <linux/regmap.h>
 #include <linux/delay.h>
 #include <linux/iio/iio.h>
@@ -1284,6 +1285,80 @@ static int bmp580_soft_reset(struct bmp280_data *data)
 	return 0;
 }
 
+/**
+ * bmp580_nvm_operation() - Helper function to commit NVM memory operations
+ * @data: sensor data struct
+ * @is_write: flag to signal write operation
+ */
+static int bmp580_nvm_operation(struct bmp280_data *data, bool is_write)
+{
+	unsigned long timeout, poll;
+	unsigned int reg;
+	int ret;
+
+	/* Check NVM ready flag */
+	ret = regmap_read(data->regmap, BMP580_REG_STATUS, &reg);
+	if (ret) {
+		dev_err(data->dev, "failed to check nvm status\n");
+		return ret;
+	}
+	if (!(reg & BMP580_STATUS_NVM_RDY_MASK)) {
+		dev_err(data->dev, "sensor's nvm is not ready\n");
+		return -EIO;
+	}
+
+	/* Start NVM operation sequence */
+	ret = regmap_write(data->regmap, BMP580_REG_CMD, BMP580_CMD_NVM_OP_SEQ_0);
+	if (ret) {
+		dev_err(data->dev, "failed to send nvm operation's first sequence\n");
+		return ret;
+	}
+	if (is_write) {
+		/* Send NVM write sequence */
+		ret = regmap_write(data->regmap, BMP580_REG_CMD,
+				   BMP580_CMD_NVM_WRITE_SEQ_1);
+		if (ret) {
+			dev_err(data->dev, "failed to send nvm write sequence\n");
+			return ret;
+		}
+		/* Datasheet says on 4.8.1.2 it takes approximately 10ms */
+		poll = 2000;
+		timeout = 12000;
+	} else {
+		/* Send NVM read sequence */
+		ret = regmap_write(data->regmap, BMP580_REG_CMD,
+				   BMP580_CMD_NVM_READ_SEQ_1);
+		if (ret) {
+			dev_err(data->dev, "failed to send nvm read sequence\n");
+			return ret;
+		}
+		/* Datasheet says on 4.8.1.1 it takes approximately 200us */
+		poll = 50;
+		timeout = 400;
+	}
+	if (ret) {
+		dev_err(data->dev, "failed to write command sequence\n");
+		return -EIO;
+	}
+
+	/* Wait until NVM is ready again */
+	ret = regmap_read_poll_timeout(data->regmap, BMP580_REG_STATUS, reg,
+				       (reg & BMP580_STATUS_NVM_RDY_MASK),
+				       poll, timeout);
+	if (ret) {
+		dev_err(data->dev, "error checking nvm operation status\n");
+		return ret;
+	}
+
+	/* Check NVM error flags */
+	if ((reg & BMP580_STATUS_NVM_ERR_MASK) || (reg & BMP580_STATUS_NVM_CMD_ERR_MASK)) {
+		dev_err(data->dev, "error processing nvm operation\n");
+		return -EIO;
+	}
+
+	return 0;
+}
+
 /*
  * Contrary to previous sensors families, compensation algorithm is builtin.
  * We are only required to read the register raw data and adapt the ranges
@@ -1379,8 +1454,140 @@ static const int bmp580_odr_table[][2] = {
 	[BMP580_ODR_0_125HZ] =	{0, 125000},
 };
 
+const int bmp580_nvmem_addrs[] = { 0x20, 0x21, 0x22 };
+
+static int bmp580_nvmem_read(void *priv, unsigned int offset, void *val,
+			     size_t bytes)
+{
+	struct bmp280_data *data = priv;
+	u16 *dst = val;
+	int ret, addr;
+
+	pm_runtime_get_sync(data->dev);
+	mutex_lock(&data->lock);
+
+	/* Set sensor in standby mode */
+	ret = regmap_update_bits(data->regmap, BMP580_REG_ODR_CONFIG,
+				 BMP580_MODE_MASK | BMP580_ODR_DEEPSLEEP_DIS,
+				 BMP580_ODR_DEEPSLEEP_DIS |
+				 FIELD_PREP(BMP580_MODE_MASK, BMP580_MODE_SLEEP));
+	if (ret) {
+		dev_err(data->dev, "failed to change sensor to standby mode\n");
+		goto exit;
+	}
+	/* Wait standby transition time */
+	usleep_range(2500, 3000);
+
+	while (bytes >= sizeof(*dst)) {
+		addr = bmp580_nvmem_addrs[offset / sizeof(*dst)];
+
+		ret = regmap_write(data->regmap, BMP580_REG_NVM_ADDR,
+				   FIELD_PREP(BMP580_NVM_ROW_ADDR_MASK, addr));
+		if (ret) {
+			dev_err(data->dev, "error writing nvm address\n");
+			goto exit;
+		}
+
+		ret = bmp580_nvm_operation(data, false);
+		if (ret)
+			goto exit;
+
+		ret = regmap_bulk_read(data->regmap, BMP580_REG_NVM_DATA_LSB, &data->le16,
+				       sizeof(data->le16));
+		if (ret) {
+			dev_err(data->dev, "error reading nvm data regs\n");
+			goto exit;
+		}
+
+		*dst++ = le16_to_cpu(data->le16);
+		bytes -= sizeof(*dst);
+		offset += sizeof(*dst);
+	}
+exit:
+	/* Restore chip config */
+	data->chip_info->chip_config(data);
+	mutex_unlock(&data->lock);
+	pm_runtime_mark_last_busy(data->dev);
+	pm_runtime_put_autosuspend(data->dev);
+	return ret;
+}
+
+static int bmp580_nvmem_write(void *priv, unsigned int offset, void *val,
+			      size_t bytes)
+{
+	struct bmp280_data *data = priv;
+	u16 *buf = val;
+	int ret, addr;
+
+	pm_runtime_get_sync(data->dev);
+	mutex_lock(&data->lock);
+
+	/* Set sensor in standby mode */
+	ret = regmap_update_bits(data->regmap, BMP580_REG_ODR_CONFIG,
+				 BMP580_MODE_MASK | BMP580_ODR_DEEPSLEEP_DIS,
+				 BMP580_ODR_DEEPSLEEP_DIS |
+				 FIELD_PREP(BMP580_MODE_MASK, BMP580_MODE_SLEEP));
+	if (ret) {
+		dev_err(data->dev, "failed to change sensor to standby mode\n");
+		goto exit;
+	}
+	/* Wait standby transition time */
+	usleep_range(2500, 3000);
+
+	while (bytes >= sizeof(*buf)) {
+		addr = bmp580_nvmem_addrs[offset / sizeof(*buf)];
+
+		ret = regmap_write(data->regmap, BMP580_REG_NVM_ADDR, BMP580_NVM_PROG_EN |
+				   FIELD_PREP(BMP580_NVM_ROW_ADDR_MASK, addr));
+		if (ret) {
+			dev_err(data->dev, "error writing nvm address\n");
+			goto exit;
+		}
+		data->le16 = cpu_to_le16(*buf++);
+
+		ret = regmap_bulk_write(data->regmap, BMP580_REG_NVM_DATA_LSB, &data->le16,
+					sizeof(data->le16));
+		if (ret) {
+			dev_err(data->dev, "error writing LSB NVM data regs\n");
+			goto exit;
+		}
+
+		ret = bmp580_nvm_operation(data, true);
+		if (ret)
+			goto exit;
+
+		/* Disable programming mode bit */
+		ret = regmap_update_bits(data->regmap, BMP580_REG_NVM_ADDR,
+					 BMP580_NVM_PROG_EN, 0);
+		if (ret) {
+			dev_err(data->dev, "error resetting nvm write\n");
+			goto exit;
+		}
+
+		bytes -= sizeof(*buf);
+		offset += sizeof(*buf);
+	}
+exit:
+	/* Restore chip config */
+	data->chip_info->chip_config(data);
+	mutex_unlock(&data->lock);
+	pm_runtime_mark_last_busy(data->dev);
+	pm_runtime_put_autosuspend(data->dev);
+	return ret;
+}
+
 static int bmp580_preinit(struct bmp280_data *data)
 {
+	struct nvmem_config config = {
+		.dev = data->dev,
+		.priv = data,
+		.name = "bmp580_nvmem",
+		.word_size = sizeof(u16),
+		.stride = sizeof(u16),
+		.size = 3 * sizeof(u16),
+		.reg_read = bmp580_nvmem_read,
+		.reg_write = bmp580_nvmem_write,
+	};
 	unsigned int reg;
 	int ret;
 
@@ -1408,7 +1615,8 @@ static int bmp580_preinit(struct bmp280_data *data)
 		return -EIO;
 	}
 
-	return 0;
+	/* Register nvmem device */
+	return PTR_ERR_OR_ZERO(devm_nvmem_register(config.dev, &config));
 }
 
 static int bmp580_chip_config(struct bmp280_data *data)
diff --git a/drivers/iio/pressure/bmp280.h b/drivers/iio/pressure/bmp280.h
index cd4c5be36ed7..5c0563ce7572 100644
--- a/drivers/iio/pressure/bmp280.h
+++ b/drivers/iio/pressure/bmp280.h
@@ -104,6 +104,9 @@
 #define BMP580_FILTER_63X		6
 #define BMP580_FILTER_127X		7
 
+#define BMP580_NVM_ROW_ADDR_MASK	GENMASK(5, 0)
+#define BMP580_NVM_PROG_EN		BIT(6)
+
 #define BMP580_TEMP_SKIPPED		0x7f7f7f
 #define BMP580_PRESS_SKIPPED		0x7f7f7f
 
-- 
2.39.2


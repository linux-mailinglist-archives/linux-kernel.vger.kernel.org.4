Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B17E6E9D10
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 22:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231861AbjDTUXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 16:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232339AbjDTUWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 16:22:55 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACDEB5FEF;
        Thu, 20 Apr 2023 13:22:41 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-5067736607fso1439219a12.0;
        Thu, 20 Apr 2023 13:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682022161; x=1684614161;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4bgsJpUillj+ROOKmPY+NOq2XaUUvqxBoyDP1agT4DQ=;
        b=YtkWBNnB3M22bp632yPBmyBZ8ObuUXnqtx5L2PgdHXqVJcTmVn6Pk1faAyc/5UqgSB
         HDPZTeaZHsljSaVKqdezbLhSEPj4Ptit4xZtgHDx5UTcSNkEEmN78iT9abgfCGrWi84X
         rDEJnaVlH3T00FVnkhLOFaH2d+x7q4rbCCKk4oUZLZ32rT/6xHYoRPwHomM6A7pU/eOL
         XycwV877HEBH9CLl/iJ4Vplw0jb7rrjBpbQ092zU2RcTuwEAOkniRK5gmPq+sFaaiMKl
         1b94tZEishb4yOnFiV3ua4SAFKZ1jHXvOAhJyzJ+ErEtO/5jLxea71hrq8QIJqn1Rp6u
         hIDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682022161; x=1684614161;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4bgsJpUillj+ROOKmPY+NOq2XaUUvqxBoyDP1agT4DQ=;
        b=b8f9ySY6ASMl0GTiEiq8WAX0VwowOwqLDof6d7D6CFwKPv6ISM/oCG/3MWmsPY5kRq
         RZ45BsShKxrtw/56EVXEh+Q/Mm4CZEEeQ+WC0BY1u5dfS1nGzIYiz3ImYh57E3HJij+/
         fbu9Gisn+AzonEEyKgf3bj+hT0xv554Q1tH3jQUb0IrZ1EHO4ggyVz11bc/K3POaFFe4
         EXEKaOramX8Ds4FDx3RPy5Ug9IIO1eDN2c5Yk/fCmBKrnGj9/fYhIxUP/Ivb7lXUPUTl
         WEdruoqtiQAhxRQ7w/FuDGEdOuZxaAmBuRs2D+ZM6zxcPK4RaPxruWKyiQdQJ3Ov+9Db
         zaCw==
X-Gm-Message-State: AAQBX9cemywB6G16tka3ASQ7l7Pg4b2rLBvtBAaR4CnUS/UE5HPk42Gp
        JujDYcX3LsPnm/g3k02CKd4=
X-Google-Smtp-Source: AKy350YmBe7XClGbCcc8CSEbLYZrZBQl0NmE5zhEHGzF2/EXUL9s4PHqz5HNKb4Fsa17wWnp4xs3cg==
X-Received: by 2002:a17:906:2ca:b0:953:4987:4b8 with SMTP id 10-20020a17090602ca00b00953498704b8mr129005ejk.47.1682022160854;
        Thu, 20 Apr 2023 13:22:40 -0700 (PDT)
Received: from carbian.fritz.box ([2a02:8109:aa3f:ead8::d7e8])
        by smtp.gmail.com with ESMTPSA id q14-20020a17090676ce00b00932ba722482sm1136881ejn.149.2023.04.20.13.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 13:22:40 -0700 (PDT)
From:   Mehdi Djait <mehdi.djait.k@gmail.com>
To:     jic23@kernel.org, mazziesaccount@gmail.com
Cc:     krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Mehdi Djait <mehdi.djait.k@gmail.com>
Subject: [PATCH v2 4/5] iio: accel: kionix-kx022a: Add a function to retrieve number of bytes in buffer
Date:   Thu, 20 Apr 2023 22:22:04 +0200
Message-Id: <2c5d71e37fc7e000091189b3c5d66ede1a6015d2.1682019544.git.mehdi.djait.k@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1682019544.git.mehdi.djait.k@gmail.com>
References: <cover.1682019544.git.mehdi.djait.k@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since Kionix accelerometers use various numbers of bits to report data, a
device-specific function is required.
Move the driver's private data to the header file to support the new function.
Make the allocation of the "buffer" array in the fifo_flush function dynamic
and more generic.

Signed-off-by: Mehdi Djait <mehdi.djait.k@gmail.com>
---
v2:
- separated this change from the chip_info introduction and made it a patch in v2 
- changed the function from generic implementation for to device-specific one
- removed blank lines pointed out by checkpatch
- changed the allocation of the "buffer" array in __kx022a_fifo_flush

 drivers/iio/accel/kionix-kx022a.c | 72 +++++++++++++------------------
 drivers/iio/accel/kionix-kx022a.h | 37 ++++++++++++++++
 2 files changed, 66 insertions(+), 43 deletions(-)

diff --git a/drivers/iio/accel/kionix-kx022a.c b/drivers/iio/accel/kionix-kx022a.c
index 7f9a2c29790b..1c81ea1657b9 100644
--- a/drivers/iio/accel/kionix-kx022a.c
+++ b/drivers/iio/accel/kionix-kx022a.c
@@ -150,36 +150,6 @@ static const struct regmap_config kx022a_regmap_config = {
 	.cache_type = REGCACHE_RBTREE,
 };
 
-struct kx022a_data {
-	struct regmap *regmap;
-	struct iio_trigger *trig;
-	struct device *dev;
-	struct iio_mount_matrix orientation;
-	int64_t timestamp, old_timestamp;
-
-	int irq;
-	int inc_reg;
-	int ien_reg;
-
-	unsigned int state;
-	unsigned int odr_ns;
-
-	bool trigger_enabled;
-	/*
-	 * Prevent toggling the sensor stby/active state (PC1 bit) in the
-	 * middle of a configuration, or when the fifo is enabled. Also,
-	 * protect the data stored/retrieved from this structure from
-	 * concurrent accesses.
-	 */
-	struct mutex mutex;
-	u8 watermark;
-
-	/* 3 x 16bit accel data + timestamp */
-	__le16 buffer[8] __aligned(IIO_DMA_MINALIGN);
-	struct {
-		__le16 channels[3];
-		s64 ts __aligned(8);
-	} scan;
 };
 
 static const struct iio_mount_matrix *
@@ -340,7 +310,6 @@ static int kx022a_turn_on_off_unlocked(struct kx022a_data *data, bool on)
 		dev_err(data->dev, "Turn %s fail %d\n", str_on_off(on), ret);
 
 	return ret;
-
 }
 
 static int kx022a_turn_off_lock(struct kx022a_data *data)
@@ -595,34 +564,50 @@ static int kx022a_drop_fifo_contents(struct kx022a_data *data)
 	return regmap_write(data->regmap, data->chip_info->buf_clear, 0x0);
 }
 
+static int kx022a_get_fifo_bytes(struct kx022a_data *data)
+{
+	struct device *dev = regmap_get_device(data->regmap);
+	int ret, fifo_bytes;
+
+	ret = regmap_read(data->regmap, KX022A_REG_BUF_STATUS_1, &fifo_bytes);
+	if (ret) {
+		dev_err(dev, "Error reading buffer status\n");
+		return ret;
+	}
+
+	/* Let's not overflow if we for some reason get bogus value from i2c */
+	if (fifo_bytes == KX022A_FIFO_FULL_VALUE)
+		fifo_bytes = KX022A_FIFO_MAX_BYTES;
+
+	return fifo_bytes;
+}
+
 static int __kx022a_fifo_flush(struct iio_dev *idev, unsigned int samples,
 			       bool irq)
 {
 	struct kx022a_data *data = iio_priv(idev);
-	struct device *dev = regmap_get_device(data->regmap);
-	__le16 buffer[KX022A_FIFO_LENGTH * 3];
+	__le16 *buffer;
 	uint64_t sample_period;
 	int count, fifo_bytes;
 	bool renable = false;
 	int64_t tstamp;
 	int ret, i;
 
-	ret = regmap_read(data->regmap, KX022A_REG_BUF_STATUS_1, &fifo_bytes);
-	if (ret) {
-		dev_err(dev, "Error reading buffer status\n");
-		return ret;
-	}
+	/* 3 axis, 2 bytes of data for each of the axis */
+	buffer = kmalloc(data->chip_info->fifo_length * 6, GFP_KERNEL);
+	if (!buffer)
+		return -ENOMEM;
 
-	/* Let's not overflow if we for some reason get bogus value from i2c */
-	if (fifo_bytes == KX022A_FIFO_FULL_VALUE)
-		fifo_bytes = KX022A_FIFO_MAX_BYTES;
+	fifo_bytes = data->chip_info->get_fifo_bytes(data);
 
 	if (fifo_bytes % KX022A_FIFO_SAMPLES_SIZE_BYTES)
 		dev_warn(data->dev, "Bad FIFO alignment. Data may be corrupt\n");
 
 	count = fifo_bytes / KX022A_FIFO_SAMPLES_SIZE_BYTES;
-	if (!count)
+	if (!count) {
+		kfree(buffer);
 		return 0;
+	}
 
 	/*
 	 * If we are being called from IRQ handler we know the stored timestamp
@@ -704,6 +689,7 @@ static int __kx022a_fifo_flush(struct iio_dev *idev, unsigned int samples,
 	if (renable)
 		enable_irq(data->irq);
 
+	kfree(buffer);
 	return ret;
 }
 
@@ -1016,6 +1002,7 @@ const struct kx022a_chip_info kx022a_chip_info = {
 	.inc5		  = KX022A_REG_INC5,
 	.inc6		  = KX022A_REG_INC6,
 	.xout_l		  = KX022A_REG_XOUT_L,
+	.get_fifo_bytes	  = kx022a_get_fifo_bytes,
 };
 EXPORT_SYMBOL_NS_GPL(kx022a_chip_info, IIO_KX022A);
 
@@ -1143,7 +1130,6 @@ int kx022a_probe_internal(struct device *dev, const struct kx022a_chip_info *chi
 	if (ret)
 		return dev_err_probe(data->dev, ret, "Could not request IRQ\n");
 
-
 	ret = devm_iio_trigger_register(dev, indio_trig);
 	if (ret)
 		return dev_err_probe(data->dev, ret,
diff --git a/drivers/iio/accel/kionix-kx022a.h b/drivers/iio/accel/kionix-kx022a.h
index 3c31e7d88f78..43e32e688258 100644
--- a/drivers/iio/accel/kionix-kx022a.h
+++ b/drivers/iio/accel/kionix-kx022a.h
@@ -11,6 +11,8 @@
 #include <linux/bits.h>
 #include <linux/regmap.h>
 
+#include <linux/iio/iio.h>
+
 #define KX022A_REG_WHO		0x0f
 #define KX022A_ID		0xc8
 
@@ -76,6 +78,39 @@
 
 struct device;
 
+struct kx022a_data {
+	const struct kx022a_chip_info *chip_info;
+	struct regmap *regmap;
+	struct iio_trigger *trig;
+	struct device *dev;
+	struct iio_mount_matrix orientation;
+	int64_t timestamp, old_timestamp;
+
+	int irq;
+	int inc_reg;
+	int ien_reg;
+
+	unsigned int state;
+	unsigned int odr_ns;
+
+	bool trigger_enabled;
+	/*
+	 * Prevent toggling the sensor stby/active state (PC1 bit) in the
+	 * middle of a configuration, or when the fifo is enabled. Also,
+	 * protect the data stored/retrieved from this structure from
+	 * concurrent accesses.
+	 */
+	struct mutex mutex;
+	u8 watermark;
+
+	/* 3 x 16bit accel data + timestamp */
+	__le16 buffer[8] __aligned(IIO_DMA_MINALIGN);
+	struct {
+		__le16 channels[3];
+		s64 ts __aligned(8);
+	} scan;
+};
+
 /**
  * struct kx022a_chip_info - Kionix accelerometer chip specific information
  *
@@ -100,6 +135,7 @@ struct device;
  * @inc5:		interrupt control register 5
  * @inc6:		interrupt control register 6
  * @xout_l:		x-axis output least significant byte
+ * @get_fifo_bytes:	function pointer to get number of bytes in the FIFO buffer
  */
 struct kx022a_chip_info {
 	const char *name;
@@ -123,6 +159,7 @@ struct kx022a_chip_info {
 	u8 inc5;
 	u8 inc6;
 	u8 xout_l;
+	int (*get_fifo_bytes)(struct kx022a_data *);
 };
 
 int kx022a_probe_internal(struct device *dev, const struct kx022a_chip_info *chip_info);
-- 
2.30.2


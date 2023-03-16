Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 299516BDD2E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 00:49:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbjCPXtQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 19:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbjCPXtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 19:49:08 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F8F0DC0B3;
        Thu, 16 Mar 2023 16:49:02 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id fd5so14069702edb.7;
        Thu, 16 Mar 2023 16:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679010540;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BHOfwF0qK+PrkQHja2Ho0/BROuWEHxqoREiF1AMr5eI=;
        b=RNY0x7B3VY7kmKriNYwgDQUa7CnCICtuqYL249NG47SNTiFQNuHrvszideNSzGVAuM
         JUSoI9VPbWg5fRshq6Qm+G2KVxXQnbeDdYytppXZ6hkXEpKtDCoc+vdNf1zY0e/kHqX+
         TDKBN0kHj1Y+LXuvVhW0QXHkUQXDSm3JaIQxiYGomnkmC7Ms+IPu+wLDwVehDt467nPC
         sM4iqH2v66k/vQ9U7vDkKOrznbUBAKlKhRiYxxLxbMK/8QPKK7pyf+e7Pdwvkq5ZEK2O
         EWd0vPzZ8igZ4QVJpa7enP+5g4XuX0C0AOTko0S8+xrQ/CjS16InMbUNw5EIu6GdvpLX
         hecw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679010540;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BHOfwF0qK+PrkQHja2Ho0/BROuWEHxqoREiF1AMr5eI=;
        b=klAQHsQSqxt/fcHzty4jueSlWUjKP2YOZxUGe3Z27ZsRlBEKVPEWBZmYX8S/vYhZzc
         sFGZTxmffxv82r/U5J/oS5rH36dZtf8GF+Ak1T5Nabc44KXEU09YYGo7sPFk8Lh9bEfM
         9YAxBoaUBuvLK0/b0cZJZV2Tu5uQ6QEEOiKS/Ch+82alnEkJV4Jk/QpAK7LLKkf2KkzM
         BZ/yoa+HnZRNEf52l1Kw8hPxAy0CxtAuQ48gxzrzvyfjhVOKd5dwa1oxs11ULUw0VEhl
         lvMUpLp5kj5rVv0ykb1/7lCMyDVE3skoUCXxgSPiRNbbc3kR0nldbIFJHKbeHN7FMxlp
         gkLg==
X-Gm-Message-State: AO0yUKXKihQLuVHf/M0pOVJo3Yxco9gnG8MYXiA/6wUDOxqpAwdnHNUK
        ZNwGPye1Eyd/ev7e3NxoHfM=
X-Google-Smtp-Source: AK7set+0QvON2JoWzf4kKzlBuBYCVjOYcxJzwENaWWBVec49pD87vX8KVPn3QnjetcOAq/EOI2zzKQ==
X-Received: by 2002:a17:906:1751:b0:8b0:f277:5cde with SMTP id d17-20020a170906175100b008b0f2775cdemr12932793eje.32.1679010540022;
        Thu, 16 Mar 2023 16:49:00 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8109:aa3f:ead8::a442])
        by smtp.gmail.com with ESMTPSA id h24-20020a1709062dd800b008db605598b9sm226896eji.67.2023.03.16.16.48.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 16:48:58 -0700 (PDT)
From:   Mehdi Djait <mehdi.djait.k@gmail.com>
To:     jic23@kernel.org, mazziesaccount@gmail.com
Cc:     krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Mehdi Djait <mehdi.djait.k@gmail.com>
Subject: [PATCH 3/3] iio: accel: Add support for Kionix/ROHM KX132 accelerometer
Date:   Fri, 17 Mar 2023 00:48:37 +0100
Message-Id: <6f31fe7dbd142c01315891f6868ff75f7d7cde32.1679009443.git.mehdi.djait.k@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1679009443.git.mehdi.djait.k@gmail.com>
References: <cover.1679009443.git.mehdi.djait.k@gmail.com>
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

Add support for the basic accelerometer features such as getting the
acceleration data via IIO. (raw reads, triggered buffer [data-ready] or
using the WMI IRQ).

Datasheet: https://kionixfs.azureedge.net/en/document/KX132-1211-Technical-Reference-Manual-Rev-5.0.pdf
Signed-off-by: Mehdi Djait <mehdi.djait.k@gmail.com>
---
 drivers/iio/accel/kionix-kx022a-i2c.c |   2 +
 drivers/iio/accel/kionix-kx022a-spi.c |   2 +
 drivers/iio/accel/kionix-kx022a.c     | 126 ++++++++++++++++++++++++++
 drivers/iio/accel/kionix-kx022a.h     |  53 +++++++++++
 4 files changed, 183 insertions(+)

diff --git a/drivers/iio/accel/kionix-kx022a-i2c.c b/drivers/iio/accel/kionix-kx022a-i2c.c
index 21c4c0ae1a68..f9b2383c43f1 100644
--- a/drivers/iio/accel/kionix-kx022a-i2c.c
+++ b/drivers/iio/accel/kionix-kx022a-i2c.c
@@ -38,12 +38,14 @@ static int kx022a_i2c_probe(struct i2c_client *i2c)
 
 static const struct i2c_device_id kx022a_i2c_id[] = {
 	{ .name = "kx022a", .driver_data = (kernel_ulong_t)&kx_chip_info[KX022A] },
+	{ .name = "kx132",  .driver_data = (kernel_ulong_t)&kx_chip_info[KX132] },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, kx022a_i2c_id);
 
 static const struct of_device_id kx022a_of_match[] = {
 	{ .compatible = "kionix,kx022a", .data = &kx_chip_info[KX022A] },
+	{ .compatible = "kionix,kx132",  .data = &kx_chip_info[KX132] },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, kx022a_of_match);
diff --git a/drivers/iio/accel/kionix-kx022a-spi.c b/drivers/iio/accel/kionix-kx022a-spi.c
index ec076af0f261..86a10d6d33ff 100644
--- a/drivers/iio/accel/kionix-kx022a-spi.c
+++ b/drivers/iio/accel/kionix-kx022a-spi.c
@@ -38,12 +38,14 @@ static int kx022a_spi_probe(struct spi_device *spi)
 
 static const struct spi_device_id kx022a_spi_id[] = {
 	{ .name = "kx022a", .driver_data = (kernel_ulong_t)&kx_chip_info[KX022A] },
+	{ .name = "kx132",  .driver_data = (kernel_ulong_t)&kx_chip_info[KX132] },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, kx022a_spi_id);
 
 static const struct of_device_id kx022a_of_match[] = {
 	{ .compatible = "kionix,kx022a", .data = &kx_chip_info[KX022A] },
+	{ .compatible = "kionix,kx132",  .data = &kx_chip_info[KX132] },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, kx022a_of_match);
diff --git a/drivers/iio/accel/kionix-kx022a.c b/drivers/iio/accel/kionix-kx022a.c
index 27e8642aa8f5..3cacec99f792 100644
--- a/drivers/iio/accel/kionix-kx022a.c
+++ b/drivers/iio/accel/kionix-kx022a.c
@@ -128,6 +128,101 @@ static const struct regmap_config kx022a_regmap_config = {
 	.cache_type = REGCACHE_RBTREE,
 };
 
+/* Regmap configs kx132 */
+static const struct regmap_range kx132_volatile_ranges[] = {
+	{
+		.range_min = KX132_REG_XADP_L,
+		.range_max = KX132_REG_COTR,
+	}, {
+		.range_min = KX132_REG_TSCP,
+		.range_max = KX132_REG_INT_REL,
+	}, {
+		/* The reset bit will be cleared by sensor */
+		.range_min = KX132_REG_CNTL2,
+		.range_max = KX132_REG_CNTL2,
+	}, {
+		.range_min = KX132_REG_BUF_STATUS_1,
+		.range_max = KX132_REG_BUF_READ,
+	},
+};
+
+static const struct regmap_access_table kx132_volatile_regs = {
+	.yes_ranges = &kx132_volatile_ranges[0],
+	.n_yes_ranges = ARRAY_SIZE(kx132_volatile_ranges),
+};
+
+static const struct regmap_range kx132_precious_ranges[] = {
+	{
+		.range_min = KX132_REG_INT_REL,
+		.range_max = KX132_REG_INT_REL,
+	},
+};
+
+static const struct regmap_access_table kx132_precious_regs = {
+	.yes_ranges = &kx132_precious_ranges[0],
+	.n_yes_ranges = ARRAY_SIZE(kx132_precious_ranges),
+};
+
+static const struct regmap_range kx132_read_only_ranges[] = {
+	{
+		.range_min = KX132_REG_XADP_L,
+		.range_max = KX132_REG_INT_REL,
+	}, {
+		.range_min = KX132_REG_BUF_STATUS_1,
+		.range_max = KX132_REG_BUF_STATUS_2,
+	}, {
+		.range_min = KX132_REG_BUF_READ,
+		.range_max = KX132_REG_BUF_READ,
+	},
+};
+
+static const struct regmap_access_table kx132_ro_regs = {
+	.no_ranges = &kx132_read_only_ranges[0],
+	.n_no_ranges = ARRAY_SIZE(kx132_read_only_ranges),
+};
+
+static const struct regmap_range kx132_write_only_ranges[] = {
+	{
+		.range_min = KX132_REG_MAN_WAKE,
+		.range_max = KX132_REG_MAN_WAKE,
+	}, {
+		.range_min = KX132_REG_SELF_TEST,
+		.range_max = KX132_REG_SELF_TEST,
+	}, {
+		.range_min = KX132_REG_BUF_CLEAR,
+		.range_max = KX132_REG_BUF_CLEAR,
+	},
+};
+
+static const struct regmap_access_table kx132_wo_regs = {
+	.no_ranges = &kx132_write_only_ranges[0],
+	.n_no_ranges = ARRAY_SIZE(kx132_write_only_ranges),
+};
+
+static const struct regmap_range kx132_noinc_read_ranges[] = {
+	{
+		.range_min = KX132_REG_BUF_READ,
+		.range_max = KX132_REG_BUF_READ,
+	},
+};
+
+static const struct regmap_access_table kx132_nir_regs = {
+	.yes_ranges = &kx132_noinc_read_ranges[0],
+	.n_yes_ranges = ARRAY_SIZE(kx132_noinc_read_ranges),
+};
+
+static const struct regmap_config kx132_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.volatile_table = &kx132_volatile_regs,
+	.rd_table = &kx132_wo_regs,
+	.wr_table = &kx132_ro_regs,
+	.rd_noinc_table = &kx132_nir_regs,
+	.precious_table = &kx132_precious_regs,
+	.max_register = KX132_MAX_REGISTER,
+	.cache_type = REGCACHE_RBTREE,
+};
+
 static const struct iio_mount_matrix *
 kx022a_get_mount_matrix(const struct iio_dev *idev,
 			const struct iio_chan_spec *chan)
@@ -175,6 +270,13 @@ static const struct iio_chan_spec kx022a_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(3),
 };
 
+static const struct iio_chan_spec kx132_channels[] = {
+	KX022A_ACCEL_CHAN(X, 0, KX132),
+	KX022A_ACCEL_CHAN(Y, 1, KX132),
+	KX022A_ACCEL_CHAN(Z, 2, KX132),
+	IIO_CHAN_SOFT_TIMESTAMP(3),
+};
+
 /*
  * The sensor HW can support ODR up to 1600 Hz, which is beyond what most of the
  * Linux CPUs can handle without dropping samples. Also, the low power mode is
@@ -249,6 +351,30 @@ const struct kx022a_chip_info kx_chip_info[] = {
 		.inc6		  = KX022A_REG_INC6,
 		.xout_l		  = KX022A_REG_XOUT_L,
 	},
+	[KX132] = {
+		.name		  = "kx132",
+		.type		  = KX132,
+		.regmap_config	  = &kx132_regmap_config,
+		.channels	  = kx132_channels,
+		.num_channels	  = ARRAY_SIZE(kx132_channels),
+		.fifo_length	  = KX132_FIFO_LENGTH,
+		.who		  = KX132_REG_WHO,
+		.id		  = KX132_ID,
+		.cntl		  = KX132_REG_CNTL,
+		.cntl2		  = KX132_REG_CNTL2,
+		.odcntl		  = KX132_REG_ODCNTL,
+		.buf_cntl1	  = KX132_REG_BUF_CNTL1,
+		.buf_cntl2	  = KX132_REG_BUF_CNTL2,
+		.buf_clear	  = KX132_REG_BUF_CLEAR,
+		.buf_status1	  = KX132_REG_BUF_STATUS_1,
+		.buf_smp_lvl_mask = KX132_MASK_BUF_SMP_LVL,
+		.buf_read	  = KX132_REG_BUF_READ,
+		.inc1		  = KX132_REG_INC1,
+		.inc4		  = KX132_REG_INC4,
+		.inc5		  = KX132_REG_INC5,
+		.inc6		  = KX132_REG_INC6,
+		.xout_l		  = KX132_REG_XOUT_L,
+	},
 };
 EXPORT_SYMBOL_NS_GPL(kx_chip_info, IIO_KX022A);
 
diff --git a/drivers/iio/accel/kionix-kx022a.h b/drivers/iio/accel/kionix-kx022a.h
index 3bb40e9f5613..7e43bdb37156 100644
--- a/drivers/iio/accel/kionix-kx022a.h
+++ b/drivers/iio/accel/kionix-kx022a.h
@@ -90,8 +90,61 @@
 #define KX022A_REG_SELF_TEST	0x60
 #define KX022A_MAX_REGISTER	0x60
 
+
+#define KX132_REG_WHO		0x13
+#define KX132_ID		0x3d
+
+#define KX132_FIFO_LENGTH	86
+
+#define KX132_REG_CNTL2		0x1c
+#define KX132_REG_CNTL		0x1b
+#define KX132_MASK_RES		BIT(6)
+#define KX132_GSEL_2		0x0
+#define KX132_GSEL_4		BIT(3)
+#define KX132_GSEL_8		BIT(4)
+#define KX132_GSEL_16		GENMASK(4, 3)
+
+#define KX132_REG_INS2		0x17
+#define KX132_MASK_INS2_WMI	BIT(5)
+
+#define KX132_REG_XADP_L	0x02
+#define KX132_REG_XOUT_L	0x08
+#define KX132_REG_YOUT_L	0x0a
+#define KX132_REG_ZOUT_L	0x0c
+#define KX132_REG_COTR		0x12
+#define KX132_REG_TSCP		0x14
+#define KX132_REG_INT_REL	0x1a
+
+#define KX132_REG_ODCNTL	0x21
+
+#define KX132_REG_BTS_WUF_TH	0x4a
+#define KX132_REG_MAN_WAKE	0x4d
+
+#define KX132_REG_BUF_CNTL1	0x5e
+#define KX132_REG_BUF_CNTL2	0x5f
+#define KX132_REG_BUF_STATUS_1	0x60
+#define KX132_REG_BUF_STATUS_2	0x61
+#define KX132_MASK_BUF_SMP_LVL	GENMASK(9, 0)
+#define KX132_REG_BUF_CLEAR	0x62
+#define KX132_REG_BUF_READ	0x63
+#define KX132_ODR_SHIFT		3
+#define KX132_FIFO_MAX_WMI_TH	86
+
+#define KX132_REG_INC1		0x22
+#define KX132_REG_INC5		0x26
+#define KX132_REG_INC6		0x27
+#define KX132_IPOL_LOW		0
+#define KX132_IPOL_HIGH		KX_MASK_IPOL
+#define KX132_ITYP_PULSE	KX_MASK_ITYP
+
+#define KX132_REG_INC4		0x25
+
+#define KX132_REG_SELF_TEST	0x5d
+#define KX132_MAX_REGISTER	0x76
+
 enum kx022a_device_type {
 	KX022A,
+	KX132,
 };
 
 enum {
-- 
2.30.2


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCE3F750700
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 13:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233341AbjGLLuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 07:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233331AbjGLLtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 07:49:15 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E285210C
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 04:48:31 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-313fb7f0f80so6900531f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 04:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1689162503; x=1691754503;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i5BOr/cNAxLqespyX9yFLeLzm/eFPOS6HvzeibnDsPE=;
        b=eFKUE+hsXTXdVoZU/iamy44AFLV+pMDVAtXHkJgt9l4OlmmlA2YH61u8RCY83gil44
         MCKUX0J08FctFthaeX6s6fQ+HYux1GlyfqMFsOR0LFMUUwwFIoA0qpVp0a/LRFz4LpSJ
         AgV5JN4O1P8GwuvpWeCFmoksvBGgCezw5E5FiL4r9FthpPV0ksyOv+frifxdwixNXfcI
         NXL259LldlSJpUs0XElVi8nJPj5vlKP9iywhwqmHSawEFtSWjnO+jjGqGWq44Tqz0vYb
         7ScntcmRdSO9tzZwLmPJJWwnqIfTv9QNz7KcB15Ne443TV2uVcJuBWJ6i4ua4fQ2zF8C
         9mow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689162503; x=1691754503;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i5BOr/cNAxLqespyX9yFLeLzm/eFPOS6HvzeibnDsPE=;
        b=aC6nxF4km7jrNZEySEy++fvkl3Fo2PvO0RW1+3CEozZygVPV3zG36vpHz5eu5B2v/k
         m1s5Pzkp24x2NUKy6O+uWSBTp0QxcQZJ2t2R9tjb463PY+LSSIpi0z28zWGF8YpQK1Ds
         BnCBwgAExI1w5xIaKPqewpeTn9anx4TqwhV6LE3qELNmPid0E4LO9oa1mq4eKvPigeds
         ZgVfhOpz3t8S88Lf27aX0wCetwNbuKr2uCN6UhRbw/BIbEF/mL6B1aoX8OmVH0YSE+q3
         JdcbooqV3WQYL710VY7AAE4/e3aXEajwxU/nVUVKnpsLs3brhKVvOL3sUdEwo30DQ7wH
         XJ8A==
X-Gm-Message-State: ABy/qLbmyutwISA6ex033Xcq8BngObl50peLhtWD/Rqujho/v3J9cuV2
        8e9yZhU2Fyu2mEM1pwoRpt9dng==
X-Google-Smtp-Source: APBJJlEEhHBvM+eUHyM06WHoH5MvzwC3d7TIGscJLcajhsTTUrYwOe65chTKH5iIbLWYddmuAffZkQ==
X-Received: by 2002:a5d:4c88:0:b0:314:35df:4a3e with SMTP id z8-20020a5d4c88000000b0031435df4a3emr16296631wrs.7.1689162502828;
        Wed, 12 Jul 2023 04:48:22 -0700 (PDT)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id j2-20020a5d4482000000b003143867d2ebsm4867463wrq.63.2023.07.12.04.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 04:48:22 -0700 (PDT)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     devicetree@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Naresh Solanki <Naresh.Solanki@9elements.com>
Subject: [PATCH 8/8] hwmon: (pmbus/mp2975) Add OCP limit
Date:   Wed, 12 Jul 2023 13:47:49 +0200
Message-ID: <20230712114754.500477-8-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230712114754.500477-1-Naresh.Solanki@9elements.com>
References: <20230712114754.500477-1-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrick Rudolph <patrick.rudolph@9elements.com>

Add support for PMBUS_IOUT_OC_FAULT_LIMIT.
Add a helper function to convert the limit to LINEAR11 format
and read data->info.phases[0] on MP2971 and MP2973 as well.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
---
 drivers/hwmon/pmbus/mp2975.c | 76 ++++++++++++++++++++++++++++++------
 1 file changed, 65 insertions(+), 11 deletions(-)

diff --git a/drivers/hwmon/pmbus/mp2975.c b/drivers/hwmon/pmbus/mp2975.c
index 27a9724aed68..0a6669f865f6 100644
--- a/drivers/hwmon/pmbus/mp2975.c
+++ b/drivers/hwmon/pmbus/mp2975.c
@@ -65,6 +65,10 @@
 #define MP2973_VID_STEP_SEL_R2		BIT(3)
 #define MP2973_IMVP9_EN_R2		BIT(13)
 
+#define MP2973_MFR_OCP_TOTAL_SET	0x5f
+#define MP2973_OCP_TOTAL_CUR_MASK	GENMASK(6, 0)
+#define MP2973_MFR_OCP_LEVEL_RES	BIT(15)
+
 #define MP2973_MFR_READ_IOUT_PK		0x90
 #define MP2973_MFR_READ_POUT_PK		0x91
 
@@ -153,6 +157,41 @@ mp2975_vid2direct(int vrf, int val)
 	return 0;
 }
 
+#define MAX_LIN_MANTISSA	(1023 * 1000)
+#define MIN_LIN_MANTISSA	(511 * 1000)
+
+/* Converts a milli-unit DIRECT value to LINEAR11 format */
+static u16 mp2975_data2reg_linear11(s64 val)
+{
+	s16 exponent = 0, mantissa;
+	bool negative = false;
+
+	/* simple case */
+	if (val == 0)
+		return 0;
+
+	/* Reduce large mantissa until it fits into 10 bit */
+	while (val >= MAX_LIN_MANTISSA && exponent < 15) {
+		exponent++;
+		val >>= 1;
+	}
+	/* Increase small mantissa to improve precision */
+	while (val < MIN_LIN_MANTISSA && exponent > -15) {
+		exponent--;
+		val <<= 1;
+	}
+
+	/* Convert mantissa from milli-units to units */
+	mantissa = clamp_val(DIV_ROUND_CLOSEST_ULL(val, 1000), 0, 0x3ff);
+
+	/* restore sign */
+	if (negative)
+		mantissa = -mantissa;
+
+	/* Convert to 5 bit exponent, 11 bit mantissa */
+	return (mantissa & 0x7ff) | ((exponent << 11) & 0xf800);
+}
+
 static int
 mp2975_read_phase(struct i2c_client *client, struct mp2975_data *data,
 		  int page, int phase, u8 reg)
@@ -297,6 +336,20 @@ static int mp2973_read_word_data(struct i2c_client *client, int page,
 		ret = pmbus_read_word_data(client, page, phase,
 					   MP2973_MFR_READ_IOUT_PK);
 		break;
+	case PMBUS_IOUT_OC_FAULT_LIMIT:
+		ret = mp2975_read_word_helper(client, page, phase,
+					      MP2973_MFR_OCP_TOTAL_SET,
+					      GENMASK(15, 0));
+		if (ret < 0)
+			return ret;
+
+		if (ret & MP2973_MFR_OCP_LEVEL_RES)
+			ret = 2 * (ret & MP2973_OCP_TOTAL_CUR_MASK);
+		else
+			ret = ret & MP2973_OCP_TOTAL_CUR_MASK;
+
+		ret = mp2975_data2reg_linear11(ret * info->phases[page] * 1000);
+		break;
 	case PMBUS_UT_WARN_LIMIT:
 	case PMBUS_UT_FAULT_LIMIT:
 	case PMBUS_VIN_UV_WARN_LIMIT:
@@ -307,7 +360,6 @@ static int mp2973_read_word_data(struct i2c_client *client, int page,
 	case PMBUS_IIN_OC_FAULT_LIMIT:
 	case PMBUS_IOUT_OC_LV_FAULT_LIMIT:
 	case PMBUS_IOUT_OC_WARN_LIMIT:
-	case PMBUS_IOUT_OC_FAULT_LIMIT:
 	case PMBUS_IOUT_UC_FAULT_LIMIT:
 	case PMBUS_POUT_OP_FAULT_LIMIT:
 	case PMBUS_POUT_OP_WARN_LIMIT:
@@ -481,11 +533,13 @@ mp2975_identify_multiphase(struct i2c_client *client, struct mp2975_data *data,
 	if (info->phases[0] > data->max_phases[0])
 		return -EINVAL;
 
-	mp2975_set_phase_rail1(info);
-	num_phases2 = min(data->max_phases[0] - info->phases[0],
-			  data->max_phases[1]);
-	if (info->phases[1] && info->phases[1] <= num_phases2)
-		mp2975_set_phase_rail2(info, num_phases2);
+	if (data->chip_id == mp2975) {
+		mp2975_set_phase_rail1(info);
+		num_phases2 = min(data->max_phases[0] - info->phases[0],
+				  data->max_phases[1]);
+		if (info->phases[1] && info->phases[1] <= num_phases2)
+			mp2975_set_phase_rail2(info, num_phases2);
+	}
 
 	return 0;
 }
@@ -879,12 +933,12 @@ static int mp2975_probe(struct i2c_client *client)
 			data->info.num_regulators = MP2975_PAGE_NUM;
 	}
 
-	if (data->chip_id == mp2975) {
-		/* Identify multiphase configuration. */
-		ret = mp2975_identify_multiphase(client, data, info);
-		if (ret)
-			return ret;
+	/* Identify multiphase configuration. */
+	ret = mp2975_identify_multiphase(client, data, info);
+	if (ret)
+		return ret;
 
+	if (data->chip_id == mp2975) {
 		/* Identify VID setting per rail. */
 		ret = mp2975_identify_rails_vid(client, data, info);
 		if (ret < 0)
-- 
2.41.0


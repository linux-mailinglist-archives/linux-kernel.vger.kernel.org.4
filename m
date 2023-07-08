Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 706E474BC97
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 09:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231788AbjGHH3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 03:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbjGHH3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 03:29:43 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7E22212C;
        Sat,  8 Jul 2023 00:29:38 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3687TICP028548;
        Sat, 8 Jul 2023 07:29:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=9MjsQNWdIv3lZ/n6BtCORJEwPCirEffpYln+LYLXhYQ=;
 b=YoEORpVsQd+ad7BdErjM975LWi28pRslbJtGnaQB/Hutg8PXciUKz/tCuPCPNcCk8XLo
 QE50UlH6oMzLOwrGdDKRi679vo6+PwRBts5ZI249DC0J/WHV6BZPe38wtPd/r1rfqxws
 gQtNCLbPQ+3HfgIRdKjmVp/0GXZ9h6Ml8a83DzqBs150m4/P0GrH3RYM7cqsdTV+Axf3
 5gXJJ+Hw+s1PLYDzQQ0Rtu/3h10nR0S3SdEqwYoh6t2JuIFNYHqPqP8LC8eV2nZQuBAV
 NbAiT5YdJj8XClz7PviLKhKAxavT3bDf68TGwph0089Mj/BrjZQCp5+Mlw6jswbDB7aC 8A== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rpxry093y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 08 Jul 2023 07:29:18 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3687TI5N027559
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 8 Jul 2023 07:29:18 GMT
Received: from hu-jprakash-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Sat, 8 Jul 2023 00:29:11 -0700
From:   Jishnu Prakash <quic_jprakash@quicinc.com>
To:     <agross@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linus.walleij@linaro.org>,
        <Jonathan.Cameron@huawei.com>, <sboyd@kernel.org>,
        <dmitry.baryshkov@linaro.org>, <quic_subbaram@quicinc.com>,
        <quic_collinsd@quicinc.com>, <quic_kamalw@quicinc.com>,
        <quic_jestar@quicinc.com>, <marijn.suijten@somainline.org>,
        <andriy.shevchenko@linux.intel.com>,
        <krzysztof.kozlowski@linaro.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jishnu Prakash <quic_jprakash@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-iio@vger.kernel.org>
CC:     <linux-arm-msm-owner@vger.kernel.org>
Subject: [PATCH 02/11] iio: adc: Update driver files for ADC7 rename for QCOM PMICs
Date:   Sat, 8 Jul 2023 12:58:26 +0530
Message-ID: <20230708072835.3035398-3-quic_jprakash@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230708072835.3035398-1-quic_jprakash@quicinc.com>
References: <20230708072835.3035398-1-quic_jprakash@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Hlx1yHEIxW2vmW01Tp4u6T18VqAOLm8O
X-Proofpoint-GUID: Hlx1yHEIxW2vmW01Tp4u6T18VqAOLm8O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-08_04,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 priorityscore=1501 mlxscore=0 malwarescore=0 bulkscore=0 clxscore=1015
 suspectscore=0 impostorscore=0 adultscore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2305260000 definitions=main-2307080065
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The correct name for this version of ADCs should be ADC5 Gen2
instead of ADC7. Update the driver files for this name change.

Signed-off-by: Jishnu Prakash <quic_jprakash@quicinc.com>
---
 drivers/iio/adc/qcom-spmi-adc5.c         | 93 +++++++++++++-----------
 drivers/iio/adc/qcom-vadc-common.c       | 36 ++++-----
 include/linux/iio/adc/qcom-vadc-common.h | 12 +--
 3 files changed, 73 insertions(+), 68 deletions(-)

diff --git a/drivers/iio/adc/qcom-spmi-adc5.c b/drivers/iio/adc/qcom-spmi-adc5.c
index 0a4fd3a46113..3ac1ee500a67 100644
--- a/drivers/iio/adc/qcom-spmi-adc5.c
+++ b/drivers/iio/adc/qcom-spmi-adc5.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2018, 2020, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include <linux/bitops.h>
@@ -87,7 +88,7 @@
 /* For PMIC7 */
 #define ADC_APP_SID				0x40
 #define ADC_APP_SID_MASK			GENMASK(3, 0)
-#define ADC7_CONV_TIMEOUT			msecs_to_jiffies(10)
+#define ADC5_GEN2_CONV_TIMEOUT		msecs_to_jiffies(10)
 
 enum adc5_cal_method {
 	ADC5_NO_CAL = 0,
@@ -270,7 +271,7 @@ static int adc5_configure(struct adc5_chip *adc,
 	return adc5_write(adc, ADC5_USR_DIG_PARAM, buf, sizeof(buf));
 }
 
-static int adc7_configure(struct adc5_chip *adc,
+static int adc5_gen2_configure(struct adc5_chip *adc,
 			struct adc5_channel_prop *prop)
 {
 	int ret;
@@ -352,7 +353,7 @@ static int adc5_do_conversion(struct adc5_chip *adc,
 	return ret;
 }
 
-static int adc7_do_conversion(struct adc5_chip *adc,
+static int adc5_gen2_do_conversion(struct adc5_chip *adc,
 			struct adc5_channel_prop *prop,
 			struct iio_chan_spec const *chan,
 			u16 *data_volt, u16 *data_cur)
@@ -362,14 +363,14 @@ static int adc7_do_conversion(struct adc5_chip *adc,
 
 	mutex_lock(&adc->lock);
 
-	ret = adc7_configure(adc, prop);
+	ret = adc5_gen2_configure(adc, prop);
 	if (ret) {
 		dev_err(adc->dev, "ADC configure failed with %d\n", ret);
 		goto unlock;
 	}
 
 	/* No support for polling mode at present */
-	wait_for_completion_timeout(&adc->complete, ADC7_CONV_TIMEOUT);
+	wait_for_completion_timeout(&adc->complete, ADC5_GEN2_CONV_TIMEOUT);
 
 	ret = adc5_read(adc, ADC5_USR_STATUS1, &status, 1);
 	if (ret)
@@ -416,7 +417,7 @@ static int adc5_fwnode_xlate(struct iio_dev *indio_dev,
 	return -EINVAL;
 }
 
-static int adc7_fwnode_xlate(struct iio_dev *indio_dev,
+static int adc5_gen2_fwnode_xlate(struct iio_dev *indio_dev,
 			     const struct fwnode_reference_args *iiospec)
 {
 	struct adc5_chip *adc = iio_priv(indio_dev);
@@ -471,12 +472,12 @@ static int adc5_read_raw(struct iio_dev *indio_dev,
 				mask, adc5_do_conversion);
 }
 
-static int adc7_read_raw(struct iio_dev *indio_dev,
+static int adc5_gen2_read_raw(struct iio_dev *indio_dev,
 			 struct iio_chan_spec const *chan, int *val, int *val2,
 			 long mask)
 {
 	return adc_read_raw_common(indio_dev, chan, val, val2,
-				mask, adc7_do_conversion);
+				mask, adc5_gen2_do_conversion);
 }
 
 static const struct iio_info adc5_info = {
@@ -484,9 +485,9 @@ static const struct iio_info adc5_info = {
 	.fwnode_xlate = adc5_fwnode_xlate,
 };
 
-static const struct iio_info adc7_info = {
-	.read_raw = adc7_read_raw,
-	.fwnode_xlate = adc7_fwnode_xlate,
+static const struct iio_info adc5_gen2_info = {
+	.read_raw = adc5_gen2_read_raw,
+	.fwnode_xlate = adc5_gen2_fwnode_xlate,
 };
 
 struct adc5_channels {
@@ -561,37 +562,37 @@ static const struct adc5_channels adc5_chans_pmic[ADC5_MAX_CHANNEL] = {
 					SCALE_HW_CALIB_THERM_100K_PULLUP)
 };
 
-static const struct adc5_channels adc7_chans_pmic[ADC5_MAX_CHANNEL] = {
-	[ADC7_REF_GND]		= ADC5_CHAN_VOLT("ref_gnd", 0,
+static const struct adc5_channels adc5_gen2_chans_pmic[ADC5_MAX_CHANNEL] = {
+	[ADC5_GEN2_REF_GND]		= ADC5_CHAN_VOLT("ref_gnd", 0,
 					SCALE_HW_CALIB_DEFAULT)
-	[ADC7_1P25VREF]		= ADC5_CHAN_VOLT("vref_1p25", 0,
+	[ADC5_GEN2_1P25VREF]		= ADC5_CHAN_VOLT("vref_1p25", 0,
 					SCALE_HW_CALIB_DEFAULT)
-	[ADC7_VPH_PWR]		= ADC5_CHAN_VOLT("vph_pwr", 1,
+	[ADC5_GEN2_VPH_PWR]		= ADC5_CHAN_VOLT("vph_pwr", 1,
 					SCALE_HW_CALIB_DEFAULT)
-	[ADC7_VBAT_SNS]		= ADC5_CHAN_VOLT("vbat_sns", 3,
+	[ADC5_GEN2_VBAT_SNS]		= ADC5_CHAN_VOLT("vbat_sns", 3,
 					SCALE_HW_CALIB_DEFAULT)
-	[ADC7_DIE_TEMP]		= ADC5_CHAN_TEMP("die_temp", 0,
-					SCALE_HW_CALIB_PMIC_THERM_PM7)
-	[ADC7_AMUX_THM1_100K_PU] = ADC5_CHAN_TEMP("amux_thm1_pu2", 0,
-					SCALE_HW_CALIB_THERM_100K_PU_PM7)
-	[ADC7_AMUX_THM2_100K_PU] = ADC5_CHAN_TEMP("amux_thm2_pu2", 0,
-					SCALE_HW_CALIB_THERM_100K_PU_PM7)
-	[ADC7_AMUX_THM3_100K_PU] = ADC5_CHAN_TEMP("amux_thm3_pu2", 0,
-					SCALE_HW_CALIB_THERM_100K_PU_PM7)
-	[ADC7_AMUX_THM4_100K_PU] = ADC5_CHAN_TEMP("amux_thm4_pu2", 0,
-					SCALE_HW_CALIB_THERM_100K_PU_PM7)
-	[ADC7_AMUX_THM5_100K_PU] = ADC5_CHAN_TEMP("amux_thm5_pu2", 0,
-					SCALE_HW_CALIB_THERM_100K_PU_PM7)
-	[ADC7_AMUX_THM6_100K_PU] = ADC5_CHAN_TEMP("amux_thm6_pu2", 0,
-					SCALE_HW_CALIB_THERM_100K_PU_PM7)
-	[ADC7_GPIO1_100K_PU]	= ADC5_CHAN_TEMP("gpio1_pu2", 0,
-					SCALE_HW_CALIB_THERM_100K_PU_PM7)
-	[ADC7_GPIO2_100K_PU]	= ADC5_CHAN_TEMP("gpio2_pu2", 0,
-					SCALE_HW_CALIB_THERM_100K_PU_PM7)
-	[ADC7_GPIO3_100K_PU]	= ADC5_CHAN_TEMP("gpio3_pu2", 0,
-					SCALE_HW_CALIB_THERM_100K_PU_PM7)
-	[ADC7_GPIO4_100K_PU]	= ADC5_CHAN_TEMP("gpio4_pu2", 0,
-					SCALE_HW_CALIB_THERM_100K_PU_PM7)
+	[ADC5_GEN2_DIE_TEMP]		= ADC5_CHAN_TEMP("die_temp", 0,
+					SCALE_HW_CALIB_PMIC_THERM_PM5_GEN2)
+	[ADC5_GEN2_AMUX_THM1_100K_PU] = ADC5_CHAN_TEMP("amux_thm1_pu2", 0,
+					SCALE_HW_CALIB_THERM_100K_PU_PM5_GEN2)
+	[ADC5_GEN2_AMUX_THM2_100K_PU] = ADC5_CHAN_TEMP("amux_thm2_pu2", 0,
+					SCALE_HW_CALIB_THERM_100K_PU_PM5_GEN2)
+	[ADC5_GEN2_AMUX_THM3_100K_PU] = ADC5_CHAN_TEMP("amux_thm3_pu2", 0,
+					SCALE_HW_CALIB_THERM_100K_PU_PM5_GEN2)
+	[ADC5_GEN2_AMUX_THM4_100K_PU] = ADC5_CHAN_TEMP("amux_thm4_pu2", 0,
+					SCALE_HW_CALIB_THERM_100K_PU_PM5_GEN2)
+	[ADC5_GEN2_AMUX_THM5_100K_PU] = ADC5_CHAN_TEMP("amux_thm5_pu2", 0,
+					SCALE_HW_CALIB_THERM_100K_PU_PM5_GEN2)
+	[ADC5_GEN2_AMUX_THM6_100K_PU] = ADC5_CHAN_TEMP("amux_thm6_pu2", 0,
+					SCALE_HW_CALIB_THERM_100K_PU_PM5_GEN2)
+	[ADC5_GEN2_GPIO1_100K_PU]	= ADC5_CHAN_TEMP("gpio1_pu2", 0,
+					SCALE_HW_CALIB_THERM_100K_PU_PM5_GEN2)
+	[ADC5_GEN2_GPIO2_100K_PU]	= ADC5_CHAN_TEMP("gpio2_pu2", 0,
+					SCALE_HW_CALIB_THERM_100K_PU_PM5_GEN2)
+	[ADC5_GEN2_GPIO3_100K_PU]	= ADC5_CHAN_TEMP("gpio3_pu2", 0,
+					SCALE_HW_CALIB_THERM_100K_PU_PM5_GEN2)
+	[ADC5_GEN2_GPIO4_100K_PU]	= ADC5_CHAN_TEMP("gpio4_pu2", 0,
+					SCALE_HW_CALIB_THERM_100K_PU_PM5_GEN2)
 };
 
 static const struct adc5_channels adc5_chans_rev2[ADC5_MAX_CHANNEL] = {
@@ -652,7 +653,7 @@ static int adc5_get_fw_channel_data(struct adc5_chip *adc,
 
 	/* virtual channel number = sid << 8 | channel number */
 
-	if (adc->data->info == &adc7_info) {
+	if (adc->data->info == &adc5_gen2_info) {
 		sid = chan >> ADC_CHANNEL_OFFSET;
 		chan = chan & ADC_CHANNEL_MASK;
 	}
@@ -715,7 +716,7 @@ static int adc5_get_fw_channel_data(struct adc5_chip *adc,
 		/* Digital controller >= 5.3 have hw_settle_2 option */
 		if ((dig_version[0] >= ADC5_HW_SETTLE_DIFF_MINOR &&
 			dig_version[1] >= ADC5_HW_SETTLE_DIFF_MAJOR) ||
-			adc->data->info == &adc7_info)
+			adc->data->info == &adc5_gen2_info)
 			ret = qcom_adc5_hw_settle_time_from_dt(value, data->hw_settle_2);
 		else
 			ret = qcom_adc5_hw_settle_time_from_dt(value, data->hw_settle_1);
@@ -774,10 +775,10 @@ static const struct adc5_data adc5_data_pmic = {
 				1, 2, 4, 8, 16, 32, 64, 128},
 };
 
-static const struct adc5_data adc7_data_pmic = {
+static const struct adc5_data adc5_gen2_data_pmic = {
 	.full_scale_code_volt = 0x70e4,
-	.adc_chans = adc7_chans_pmic,
-	.info = &adc7_info,
+	.adc_chans = adc5_gen2_chans_pmic,
+	.info = &adc5_gen2_info,
 	.decimation = (unsigned int [ADC5_DECIMATION_SAMPLES_MAX])
 				{85, 340, 1360},
 	.hw_settle_2 = (unsigned int [VADC_HW_SETTLE_SAMPLES_MAX])
@@ -808,7 +809,11 @@ static const struct of_device_id adc5_match_table[] = {
 	},
 	{
 		.compatible = "qcom,spmi-adc7",
-		.data = &adc7_data_pmic,
+		.data = &adc5_gen2_data_pmic,
+	},
+	{
+		.compatible = "qcom,spmi-adc5-gen2",
+		.data = &adc5_gen2_data_pmic,
 	},
 	{
 		.compatible = "qcom,spmi-adc-rev2",
diff --git a/drivers/iio/adc/qcom-vadc-common.c b/drivers/iio/adc/qcom-vadc-common.c
index d5209f32adb3..1f4cd3be68fa 100644
--- a/drivers/iio/adc/qcom-vadc-common.c
+++ b/drivers/iio/adc/qcom-vadc-common.c
@@ -100,7 +100,7 @@ static const struct vadc_map_pt adcmap_100k_104ef_104fb_1875_vref[] = {
 	{ 46,	125000 },
 };
 
-static const struct vadc_map_pt adcmap7_die_temp[] = {
+static const struct vadc_map_pt adcmap5_gen2_die_temp[] = {
 	{ 857300, 160000 },
 	{ 820100, 140000 },
 	{ 782500, 120000 },
@@ -118,7 +118,7 @@ static const struct vadc_map_pt adcmap7_die_temp[] = {
 /*
  * Resistance to temperature table for 100k pull up for NTCG104EF104.
  */
-static const struct vadc_map_pt adcmap7_100k[] = {
+static const struct vadc_map_pt adcmap5_gen2_100k[] = {
 	{ 4250657, -40960 },
 	{ 3962085, -39936 },
 	{ 3694875, -38912 },
@@ -309,7 +309,7 @@ static int qcom_vadc_scale_hw_calib_therm(
 				const struct u32_fract *prescale,
 				const struct adc5_data *data,
 				u16 adc_code, int *result_mdec);
-static int qcom_vadc7_scale_hw_calib_therm(
+static int qcom_vadc5_gen2_scale_hw_calib_therm(
 				const struct u32_fract *prescale,
 				const struct adc5_data *data,
 				u16 adc_code, int *result_mdec);
@@ -325,7 +325,7 @@ static int qcom_vadc_scale_hw_calib_die_temp(
 				const struct u32_fract *prescale,
 				const struct adc5_data *data,
 				u16 adc_code, int *result_mdec);
-static int qcom_vadc7_scale_hw_calib_die_temp(
+static int qcom_vadc5_gen2_scale_hw_calib_die_temp(
 				const struct u32_fract *prescale,
 				const struct adc5_data *data,
 				u16 adc_code, int *result_mdec);
@@ -334,11 +334,11 @@ static struct qcom_adc5_scale_type scale_adc5_fn[] = {
 	[SCALE_HW_CALIB_DEFAULT] = {qcom_vadc_scale_hw_calib_volt},
 	[SCALE_HW_CALIB_THERM_100K_PULLUP] = {qcom_vadc_scale_hw_calib_therm},
 	[SCALE_HW_CALIB_XOTHERM] = {qcom_vadc_scale_hw_calib_therm},
-	[SCALE_HW_CALIB_THERM_100K_PU_PM7] = {
-					qcom_vadc7_scale_hw_calib_therm},
+	[SCALE_HW_CALIB_THERM_100K_PU_PM5_GEN2] = {
+					qcom_vadc5_gen2_scale_hw_calib_therm},
 	[SCALE_HW_CALIB_PMIC_THERM] = {qcom_vadc_scale_hw_calib_die_temp},
-	[SCALE_HW_CALIB_PMIC_THERM_PM7] = {
-					qcom_vadc7_scale_hw_calib_die_temp},
+	[SCALE_HW_CALIB_PMIC_THERM_PM5_GEN2] = {
+					qcom_vadc5_gen2_scale_hw_calib_die_temp},
 	[SCALE_HW_CALIB_PM5_CHG_TEMP] = {qcom_vadc_scale_hw_chg5_temp},
 	[SCALE_HW_CALIB_PM5_SMB_TEMP] = {qcom_vadc_scale_hw_smb_temp},
 };
@@ -530,7 +530,7 @@ static int qcom_vadc_scale_code_voltage_factor(u16 adc_code,
 	return (int) voltage;
 }
 
-static int qcom_vadc7_scale_hw_calib_therm(
+static int qcom_vadc5_gen2_scale_hw_calib_therm(
 				const struct u32_fract *prescale,
 				const struct adc5_data *data,
 				u16 adc_code, int *result_mdec)
@@ -538,15 +538,15 @@ static int qcom_vadc7_scale_hw_calib_therm(
 	s64 resistance = adc_code;
 	int ret, result;
 
-	if (adc_code >= RATIO_MAX_ADC7)
+	if (adc_code >= RATIO_MAX_ADC5_GEN2)
 		return -EINVAL;
 
 	/* (ADC code * R_PULLUP (100Kohm)) / (full_scale_code - ADC code)*/
 	resistance *= R_PU_100K;
-	resistance = div64_s64(resistance, RATIO_MAX_ADC7 - adc_code);
+	resistance = div64_s64(resistance, RATIO_MAX_ADC5_GEN2 - adc_code);
 
-	ret = qcom_vadc_map_voltage_temp(adcmap7_100k,
-				 ARRAY_SIZE(adcmap7_100k),
+	ret = qcom_vadc_map_voltage_temp(adcmap5_gen2_100k,
+				 ARRAY_SIZE(adcmap5_gen2_100k),
 				 resistance, &result);
 	if (ret)
 		return ret;
@@ -595,7 +595,7 @@ static int qcom_vadc_scale_hw_calib_die_temp(
 	return 0;
 }
 
-static int qcom_vadc7_scale_hw_calib_die_temp(
+static int qcom_vadc5_gen2_scale_hw_calib_die_temp(
 				const struct u32_fract *prescale,
 				const struct adc5_data *data,
 				u16 adc_code, int *result_mdec)
@@ -606,7 +606,7 @@ static int qcom_vadc7_scale_hw_calib_die_temp(
 	voltage = qcom_vadc_scale_code_voltage_factor(adc_code,
 				prescale, data, 1);
 
-	return qcom_vadc_map_voltage_temp(adcmap7_die_temp, ARRAY_SIZE(adcmap7_die_temp),
+	return qcom_vadc_map_voltage_temp(adcmap5_gen2_die_temp, ARRAY_SIZE(adcmap5_gen2_die_temp),
 			voltage, result_mdec);
 }
 
@@ -681,10 +681,10 @@ u16 qcom_adc_tm5_gen2_temp_res_scale(int temp)
 {
 	int64_t resistance;
 
-	resistance = qcom_vadc_map_temp_voltage(adcmap7_100k,
-		ARRAY_SIZE(adcmap7_100k), temp);
+	resistance = qcom_vadc_map_temp_voltage(adcmap5_gen2_100k,
+		ARRAY_SIZE(adcmap5_gen2_100k), temp);
 
-	return div64_s64(resistance * RATIO_MAX_ADC7, resistance + R_PU_100K);
+	return div64_s64(resistance * RATIO_MAX_ADC5_GEN2, resistance + R_PU_100K);
 }
 EXPORT_SYMBOL(qcom_adc_tm5_gen2_temp_res_scale);
 
diff --git a/include/linux/iio/adc/qcom-vadc-common.h b/include/linux/iio/adc/qcom-vadc-common.h
index aa21b032e861..a926e369a3ca 100644
--- a/include/linux/iio/adc/qcom-vadc-common.h
+++ b/include/linux/iio/adc/qcom-vadc-common.h
@@ -53,7 +53,7 @@
 #define ADC5_USR_DATA_CHECK			0x8000
 
 #define R_PU_100K				100000
-#define RATIO_MAX_ADC7				BIT(14)
+#define RATIO_MAX_ADC5_GEN2			BIT(14)
 
 /*
  * VADC_CALIB_ABSOLUTE: uses the 625mV and 1.25V as reference channels.
@@ -95,12 +95,12 @@ struct vadc_linear_graph {
  *	lookup table. The hardware applies offset/slope to adc code.
  * SCALE_HW_CALIB_XOTHERM: Returns XO thermistor voltage in millidegC using
  *	100k pullup. The hardware applies offset/slope to adc code.
- * SCALE_HW_CALIB_THERM_100K_PU_PM7: Returns temperature in millidegC using
- *	lookup table for PMIC7. The hardware applies offset/slope to adc code.
+ * SCALE_HW_CALIB_THERM_100K_PU_PM5_GEN2: Returns temperature in millidegC using
+ *	lookup table for PMIC5 Gen2. The hardware applies offset/slope to adc code.
  * SCALE_HW_CALIB_PMIC_THERM: Returns result in milli degree's Centigrade.
  *	The hardware applies offset/slope to adc code.
  * SCALE_HW_CALIB_PMIC_THERM: Returns result in milli degree's Centigrade.
- *	The hardware applies offset/slope to adc code. This is for PMIC7.
+ *	The hardware applies offset/slope to adc code. This is for PMIC5 Gen2.
  * SCALE_HW_CALIB_PM5_CHG_TEMP: Returns result in millidegrees for PMIC5
  *	charger temperature.
  * SCALE_HW_CALIB_PM5_SMB_TEMP: Returns result in millidegrees for PMIC5
@@ -115,9 +115,9 @@ enum vadc_scale_fn_type {
 	SCALE_HW_CALIB_DEFAULT,
 	SCALE_HW_CALIB_THERM_100K_PULLUP,
 	SCALE_HW_CALIB_XOTHERM,
-	SCALE_HW_CALIB_THERM_100K_PU_PM7,
+	SCALE_HW_CALIB_THERM_100K_PU_PM5_GEN2,
 	SCALE_HW_CALIB_PMIC_THERM,
-	SCALE_HW_CALIB_PMIC_THERM_PM7,
+	SCALE_HW_CALIB_PMIC_THERM_PM5_GEN2,
 	SCALE_HW_CALIB_PM5_CHG_TEMP,
 	SCALE_HW_CALIB_PM5_SMB_TEMP,
 	SCALE_HW_CALIB_INVALID,
-- 
2.25.1


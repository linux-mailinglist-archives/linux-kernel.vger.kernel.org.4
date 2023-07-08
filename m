Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE4A374BC9D
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 09:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbjGHHbC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 03:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjGHHa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 03:30:59 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A66A26A3;
        Sat,  8 Jul 2023 00:30:16 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3686m97J030713;
        Sat, 8 Jul 2023 07:29:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=CVfSTBsME1YBUy39JcUB1nJBZosOIQqVCJw4hAdukoc=;
 b=Is8taVaTLFOYenAkp711b7y8bAlHcNUt6VdNeHC4a6JEYbwNwrsoc0zJu3YqscwyjbeI
 UVY/0EXofMzidUmnm3vsJKVKG2x+88mS17573RkXViamN3TZ+joo39B1ogDX6Vcw+5dC
 5u14lzeBBkV+HNceRz2aszItkxFuYWDbzWXPa95wt18gA3ec+NK/jZ2RPbjTk5Hg8mz5
 5q6LtvCCTjoyRus1JC0BpyDxzvYtqpifAftlHG5+qURHB9tjABucDk+eeeV5Dg5ZeSQD
 f9fjXzWTSetE9+h4853PC2Dj/APOKjqQS0MCwXfbmvsjRKk56wV4nXyUOuQUY/rrGq3N 4w== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rpyd6r7ue-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 08 Jul 2023 07:29:46 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3687Ti3i027669
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 8 Jul 2023 07:29:45 GMT
Received: from hu-jprakash-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Sat, 8 Jul 2023 00:29:38 -0700
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
        <linux-arm-msm@vger.kernel.org>, <linux-iio@vger.kernel.org>
CC:     <linux-arm-msm-owner@vger.kernel.org>,
        Jishnu Prakash <quic_jprakash@quicinc.com>
Subject: [PATCH 05/11] iio: adc: qcom-spmi-adc5: remove support for ADC7 compatible string
Date:   Sat, 8 Jul 2023 12:58:29 +0530
Message-ID: <20230708072835.3035398-6-quic_jprakash@quicinc.com>
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
X-Proofpoint-GUID: IqNPqMj5cR2sAece8oFQeJEs18eSlFCN
X-Proofpoint-ORIG-GUID: IqNPqMj5cR2sAece8oFQeJEs18eSlFCN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-08_03,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 adultscore=0 spamscore=0 phishscore=0 mlxlogscore=999 priorityscore=1501
 clxscore=1015 bulkscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307080065
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that usage of "ADC7" name has been replaced with usage of "ADC5
Gen2" name everywhere, remove the "qcom,spmi-adc7" compatible string.

Signed-off-by: Jishnu Prakash <quic_jprakash@quicinc.com>
---
 drivers/iio/adc/qcom-spmi-adc5.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/iio/adc/qcom-spmi-adc5.c b/drivers/iio/adc/qcom-spmi-adc5.c
index 3ac1ee500a67..6cebeaa69a75 100644
--- a/drivers/iio/adc/qcom-spmi-adc5.c
+++ b/drivers/iio/adc/qcom-spmi-adc5.c
@@ -807,10 +807,6 @@ static const struct of_device_id adc5_match_table[] = {
 		.compatible = "qcom,spmi-adc5",
 		.data = &adc5_data_pmic,
 	},
-	{
-		.compatible = "qcom,spmi-adc7",
-		.data = &adc5_gen2_data_pmic,
-	},
 	{
 		.compatible = "qcom,spmi-adc5-gen2",
 		.data = &adc5_gen2_data_pmic,
-- 
2.25.1


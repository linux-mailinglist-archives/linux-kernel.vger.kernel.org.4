Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D976E663816
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 05:20:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbjAJEUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 23:20:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbjAJEUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 23:20:19 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0418338ACD;
        Mon,  9 Jan 2023 20:20:17 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30A3atog016573;
        Tue, 10 Jan 2023 04:20:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=BnYYqzMhmFm8/pHnrigKlooDqfUIkryCoC4mP89yIs8=;
 b=o8Ub1YUQr7N7ir856+7UN2Xh374OekTSIXhZiyGUa8ClpNm0p48cO9Ak8Z+LlatR4RaY
 PphG0KWlshjzWUWUpyKMdfrZpu2pYyuFLn0sbKrXkYOTXhvZ5QvaX5qD2kMTzmg40SZU
 Ytao2ZN4j1UaHW5M6TKnRLL8a+4qE0lek9pNGiGwQn7lZQqG4+l0q3eLqJyVTmahiLkT
 jrRt3Cj+zE5feIgBYWu/7gzTA86qjDommXNpHF5SutZQxh4NK0f9+ZgcweYEYwGOp2iZ
 tPWyO9eIZjGMVOz1FnziuG13l8FVGOQNEFIdkOktgQSlrz92e5bZDWUs1SDlj6clyD7c pQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n0q6es2nm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Jan 2023 04:20:11 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30A4K9Ue004027
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Jan 2023 04:20:09 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 9 Jan 2023 20:20:09 -0800
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] soc: qcom: ramp_controller: Make things static
Date:   Mon, 9 Jan 2023 20:20:04 -0800
Message-ID: <20230110042004.2378444-1-quic_bjorande@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: aQMDeETSARUTkZsoM0eFCIGxRQqW5_st
X-Proofpoint-ORIG-GUID: aQMDeETSARUTkZsoM0eFCIGxRQqW5_st
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-09_16,2023-01-09_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 clxscore=1011 impostorscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 mlxscore=0 bulkscore=0 spamscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301100025
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The five msm8976_cfg_* objects ought to be static, as reported by LKP
and sparse, fix this.

drivers/soc/qcom/ramp_controller.c:235:27: sparse: sparse: symbol 'msm8976_cfg_dfs_sid' was not declared. Should it be static?
drivers/soc/qcom/ramp_controller.c:246:27: sparse: sparse: symbol 'msm8976_cfg_link_sid' was not declared. Should it be static?
drivers/soc/qcom/ramp_controller.c:250:27: sparse: sparse: symbol 'msm8976_cfg_lmh_sid' was not declared. Should it be static?
drivers/soc/qcom/ramp_controller.c:256:27: sparse: sparse: symbol 'msm8976_cfg_ramp_en' was not declared. Should it be static?
drivers/soc/qcom/ramp_controller.c:262:27: sparse: sparse: symbol 'msm8976_cfg_ramp_dis' was not declared. Should it be static?

Fixes: a723c95fa137 ("soc: qcom: Add Qualcomm Ramp Controller driver")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
 drivers/soc/qcom/ramp_controller.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/soc/qcom/ramp_controller.c b/drivers/soc/qcom/ramp_controller.c
index 93652b07e812..dc74d2a19de2 100644
--- a/drivers/soc/qcom/ramp_controller.c
+++ b/drivers/soc/qcom/ramp_controller.c
@@ -232,7 +232,7 @@ static const struct regmap_config qrc_regmap_config = {
 	.fast_io = true,
 };
 
-const struct reg_sequence msm8976_cfg_dfs_sid[] = {
+static const struct reg_sequence msm8976_cfg_dfs_sid[] = {
 	{ 0x10, 0xfefebff7 },
 	{ 0x14, 0xfdff7fef },
 	{ 0x18, 0xfbffdefb },
@@ -243,23 +243,23 @@ const struct reg_sequence msm8976_cfg_dfs_sid[] = {
 	{ 0x2c, 0x8102 }
 };
 
-const struct reg_sequence msm8976_cfg_link_sid[] = {
+static const struct reg_sequence msm8976_cfg_link_sid[] = {
 	{ 0x40, 0xfc987 }
 };
 
-const struct reg_sequence msm8976_cfg_lmh_sid[] = {
+static const struct reg_sequence msm8976_cfg_lmh_sid[] = {
 	{ 0x30, 0x77706db },
 	{ 0x34, 0x5550249 },
 	{ 0x38, 0x111 }
 };
 
-const struct reg_sequence msm8976_cfg_ramp_en[] = {
+static const struct reg_sequence msm8976_cfg_ramp_en[] = {
 	{ 0x50, 0x800 }, /* pre_en */
 	{ 0x50, 0xc00 }, /* en */
 	{ 0x50, 0x400 }  /* post_en */
 };
 
-const struct reg_sequence msm8976_cfg_ramp_dis[] = {
+static const struct reg_sequence msm8976_cfg_ramp_dis[] = {
 	{ 0x50, 0x0 }
 };
 
-- 
2.37.3


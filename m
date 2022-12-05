Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0369464350E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 20:58:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbiLET6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 14:58:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233224AbiLET5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 14:57:37 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E242716F;
        Mon,  5 Dec 2022 11:56:55 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B5H57D6010444;
        Mon, 5 Dec 2022 19:56:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=SwIthtXub12oTCL5AfqCfDxY9hVKMxBJ72vq3m/LE3k=;
 b=KMnzbKD2wPo0//xZkvNR+Fqxfrhpx8WWUP/tHKhkDThN4E049t1vPabYiwwxnRLguDeu
 yY8cG+u1zObx53BmH3RbJLvq4NHIF1yb3UakBP8dqiEEwZl8SPuP9mVllRCUoS1s2h3e
 9fK+5YycGqM3wzNp17DjRB49pKsDTlhio04izOWR5w9r3PBzUGY82XkcsWvpYr2wvhiF
 d345uUSNmCAuokXLfbUPRZlrCt5KLcCI3obRGoNsphROnENRDqXvC0U+PAwCnzf700eB
 DR+U9IYJ8/20WmesusdMBW4F667staY1lfN3P2tP0Ccbu6Z2njku+RpyQ54oBjkfLjhV OQ== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3m7wff4wbr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Dec 2022 19:56:41 +0000
Received: from nasanex01a.na.qualcomm.com ([10.52.223.231])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2B5JueCR011710
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 5 Dec 2022 19:56:40 GMT
Received: from asutoshd-linux1.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 5 Dec 2022 11:56:40 -0800
Date:   Mon, 5 Dec 2022 11:56:39 -0800
From:   Asutosh Das <quic_asutoshd@quicinc.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC:     <martin.petersen@oracle.com>, <jejb@linux.ibm.com>,
        <andersson@kernel.org>, <vkoul@kernel.org>,
        <quic_cang@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <linux-scsi@vger.kernel.org>, <dmitry.baryshkov@linaro.org>,
        <ahalaney@redhat.com>, <abel.vesa@linaro.org>,
        <alim.akhtar@samsung.com>, <avri.altman@wdc.com>,
        <bvanassche@acm.org>
Subject: Re: [PATCH v4 15/23] scsi: ufs: ufs-qcom: Use bitfields where
 appropriate
Message-ID: <20221205195639.GD15334@asutoshd-linux1.qualcomm.com>
References: <20221201174328.870152-1-manivannan.sadhasivam@linaro.org>
 <20221201174328.870152-16-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <20221201174328.870152-16-manivannan.sadhasivam@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: kADvq0Q0XZQV3FK0BXYitfAd8x5Lq8ux
X-Proofpoint-ORIG-GUID: kADvq0Q0XZQV3FK0BXYitfAd8x5Lq8ux
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-05_01,2022-12-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 bulkscore=0 phishscore=0 malwarescore=0 impostorscore=0 adultscore=0
 mlxlogscore=999 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212050166
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 01 2022 at 09:45 -0800, Manivannan Sadhasivam wrote:
>Use bitfield macros where appropriate to simplify the driver.
>
>Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>---
> drivers/ufs/host/ufs-qcom.h | 61 +++++++++++++++++--------------------
> 1 file changed, 28 insertions(+), 33 deletions(-)
>
LGTM.

Reviewed-by: Asutosh Das <quic_asutoshd@quicinc.com>


>diff --git a/drivers/ufs/host/ufs-qcom.h b/drivers/ufs/host/ufs-qcom.h
>index 44466a395bb5..9d96ac71b27f 100644
>--- a/drivers/ufs/host/ufs-qcom.h
>+++ b/drivers/ufs/host/ufs-qcom.h
>@@ -17,12 +17,9 @@
> #define DEFAULT_CLK_RATE_HZ     1000000
> #define BUS_VECTOR_NAME_LEN     32
>
>-#define UFS_HW_VER_MAJOR_SHFT	(28)
>-#define UFS_HW_VER_MAJOR_MASK	(0x000F << UFS_HW_VER_MAJOR_SHFT)
>-#define UFS_HW_VER_MINOR_SHFT	(16)
>-#define UFS_HW_VER_MINOR_MASK	(0x0FFF << UFS_HW_VER_MINOR_SHFT)
>-#define UFS_HW_VER_STEP_SHFT	(0)
>-#define UFS_HW_VER_STEP_MASK	(0xFFFF << UFS_HW_VER_STEP_SHFT)
>+#define UFS_HW_VER_MAJOR_MASK	GENMASK(31, 28)
>+#define UFS_HW_VER_MINOR_MASK	GENMASK(27, 16)
>+#define UFS_HW_VER_STEP_MASK	GENMASK(15, 0)
>
> /* vendor specific pre-defined parameters */
> #define SLOW 1
>@@ -76,24 +73,28 @@ enum {
> #define UFS_CNTLR_3_x_x_VEN_REGS_OFFSET(x)	(0x400 + x)
>
> /* bit definitions for REG_UFS_CFG1 register */
>-#define QUNIPRO_SEL		0x1
>-#define UTP_DBG_RAMS_EN		0x20000
>+#define QUNIPRO_SEL		BIT(0)
>+#define UFS_PHY_SOFT_RESET	BIT(1)
>+#define UTP_DBG_RAMS_EN		BIT(17)
> #define TEST_BUS_EN		BIT(18)
> #define TEST_BUS_SEL		GENMASK(22, 19)
> #define UFS_REG_TEST_BUS_EN	BIT(30)
>
>+#define UFS_PHY_RESET_ENABLE	1
>+#define UFS_PHY_RESET_DISABLE	0
>+
> /* bit definitions for REG_UFS_CFG2 register */
>-#define UAWM_HW_CGC_EN		(1 << 0)
>-#define UARM_HW_CGC_EN		(1 << 1)
>-#define TXUC_HW_CGC_EN		(1 << 2)
>-#define RXUC_HW_CGC_EN		(1 << 3)
>-#define DFC_HW_CGC_EN		(1 << 4)
>-#define TRLUT_HW_CGC_EN		(1 << 5)
>-#define TMRLUT_HW_CGC_EN	(1 << 6)
>-#define OCSC_HW_CGC_EN		(1 << 7)
>+#define UAWM_HW_CGC_EN		BIT(0)
>+#define UARM_HW_CGC_EN		BIT(1)
>+#define TXUC_HW_CGC_EN		BIT(2)
>+#define RXUC_HW_CGC_EN		BIT(3)
>+#define DFC_HW_CGC_EN		BIT(4)
>+#define TRLUT_HW_CGC_EN		BIT(5)
>+#define TMRLUT_HW_CGC_EN	BIT(6)
>+#define OCSC_HW_CGC_EN		BIT(7)
>
> /* bit definition for UFS_UFS_TEST_BUS_CTRL_n */
>-#define TEST_BUS_SUB_SEL_MASK	0x1F  /* All XXX_SEL fields are 5 bits wide */
>+#define TEST_BUS_SUB_SEL_MASK	GENMASK(4, 0)  /* All XXX_SEL fields are 5 bits wide */
>
> #define REG_UFS_CFG2_CGC_EN_ALL (UAWM_HW_CGC_EN | UARM_HW_CGC_EN |\
> 				 TXUC_HW_CGC_EN | RXUC_HW_CGC_EN |\
>@@ -101,17 +102,11 @@ enum {
> 				 TMRLUT_HW_CGC_EN | OCSC_HW_CGC_EN)
>
> /* bit offset */
>-enum {
>-	OFFSET_UFS_PHY_SOFT_RESET           = 1,
>-	OFFSET_CLK_NS_REG                   = 10,
>-};
>+#define OFFSET_CLK_NS_REG		0xa
>
> /* bit masks */
>-enum {
>-	MASK_UFS_PHY_SOFT_RESET             = 0x2,
>-	MASK_TX_SYMBOL_CLK_1US_REG          = 0x3FF,
>-	MASK_CLK_NS_REG                     = 0xFFFC00,
>-};
>+#define MASK_TX_SYMBOL_CLK_1US_REG	GENMASK(9, 0)
>+#define MASK_CLK_NS_REG			GENMASK(23, 10)
>
> /* QCOM UFS debug print bit mask */
> #define UFS_QCOM_DBG_PRINT_REGS_EN	BIT(0)
>@@ -135,15 +130,15 @@ ufs_qcom_get_controller_revision(struct ufs_hba *hba,
> {
> 	u32 ver = ufshcd_readl(hba, REG_UFS_HW_VERSION);
>
>-	*major = (ver & UFS_HW_VER_MAJOR_MASK) >> UFS_HW_VER_MAJOR_SHFT;
>-	*minor = (ver & UFS_HW_VER_MINOR_MASK) >> UFS_HW_VER_MINOR_SHFT;
>-	*step = (ver & UFS_HW_VER_STEP_MASK) >> UFS_HW_VER_STEP_SHFT;
>+	*major = FIELD_GET(UFS_HW_VER_MAJOR_MASK, ver);
>+	*minor = FIELD_GET(UFS_HW_VER_MINOR_MASK, ver);
>+	*step = FIELD_GET(UFS_HW_VER_STEP_MASK, ver);
> };
>
> static inline void ufs_qcom_assert_reset(struct ufs_hba *hba)
> {
>-	ufshcd_rmwl(hba, MASK_UFS_PHY_SOFT_RESET,
>-			1 << OFFSET_UFS_PHY_SOFT_RESET, REG_UFS_CFG1);
>+	ufshcd_rmwl(hba, UFS_PHY_SOFT_RESET, FIELD_PREP(UFS_PHY_SOFT_RESET, UFS_PHY_RESET_ENABLE),
>+		    REG_UFS_CFG1);
>
> 	/*
> 	 * Make sure assertion of ufs phy reset is written to
>@@ -154,8 +149,8 @@ static inline void ufs_qcom_assert_reset(struct ufs_hba *hba)
>
> static inline void ufs_qcom_deassert_reset(struct ufs_hba *hba)
> {
>-	ufshcd_rmwl(hba, MASK_UFS_PHY_SOFT_RESET,
>-			0 << OFFSET_UFS_PHY_SOFT_RESET, REG_UFS_CFG1);
>+	ufshcd_rmwl(hba, UFS_PHY_SOFT_RESET, FIELD_PREP(UFS_PHY_SOFT_RESET, UFS_PHY_RESET_DISABLE),
>+		    REG_UFS_CFG1);
>
> 	/*
> 	 * Make sure de-assertion of ufs phy reset is written to
>-- 
>2.25.1
>

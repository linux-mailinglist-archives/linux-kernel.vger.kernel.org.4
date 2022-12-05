Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0A3564351F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 20:59:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231888AbiLET7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 14:59:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbiLET7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 14:59:46 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AA24F5;
        Mon,  5 Dec 2022 11:59:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1670270385; x=1701806385;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IJWNp4qP9S37kkrGBvbHjVZEUGTuxm3+Wx+bTfe/e9g=;
  b=YVQvaLxrGx1WQADa2GMRQr0xOxizQ1YVr3T5LHt/XNUBO/GY6hPvAJs7
   qXj0GXF1MiYIQ2EipwR+g/E0pBnkxR1benCKVr2pLE5TnTzCz05JesE0R
   Q/2ME/YnhaHVVqOMAYXCpfkfxeWsDlCmAtCJ4Ry05AqG24hJY+XMLLZMT
   c=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 05 Dec 2022 11:59:45 -0800
X-QCInternal: smtphost
Received: from unknown (HELO nasanex01a.na.qualcomm.com) ([10.52.223.231])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 11:59:44 -0800
Received: from asutoshd-linux1.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 5 Dec 2022 11:59:42 -0800
Date:   Mon, 5 Dec 2022 11:59:42 -0800
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
Subject: Re: [PATCH v4 17/23] scsi: ufs: ufs-qcom: Fix the Qcom register name
 for offset 0xD0
Message-ID: <20221205195942.GF15334@asutoshd-linux1.qualcomm.com>
References: <20221201174328.870152-1-manivannan.sadhasivam@linaro.org>
 <20221201174328.870152-18-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <20221201174328.870152-18-manivannan.sadhasivam@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 01 2022 at 09:45 -0800, Manivannan Sadhasivam wrote:
>On newer UFS revisions, the register at offset 0xD0 is called,
>REG_UFS_PARAM0. Since the existing register, RETRY_TIMER_REG is not used
>anywhere, it is safe to use the new name.
>
>Reviewed-by: Andrew Halaney <ahalaney@redhat.com>
>Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>---
> drivers/ufs/host/ufs-qcom.h | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>
Reviewed-by: Asutosh Das <quic_asutoshd@quicinc.com>


>diff --git a/drivers/ufs/host/ufs-qcom.h b/drivers/ufs/host/ufs-qcom.h
>index 9d96ac71b27f..7fe928b82753 100644
>--- a/drivers/ufs/host/ufs-qcom.h
>+++ b/drivers/ufs/host/ufs-qcom.h
>@@ -33,7 +33,8 @@ enum {
> 	REG_UFS_TX_SYMBOL_CLK_NS_US         = 0xC4,
> 	REG_UFS_LOCAL_PORT_ID_REG           = 0xC8,
> 	REG_UFS_PA_ERR_CODE                 = 0xCC,
>-	REG_UFS_RETRY_TIMER_REG             = 0xD0,
>+	/* On older UFS revisions, this register is called "RETRY_TIMER_REG" */
>+	REG_UFS_PARAM0                      = 0xD0,
> 	REG_UFS_PA_LINK_STARTUP_TIMER       = 0xD8,
> 	REG_UFS_CFG1                        = 0xDC,
> 	REG_UFS_CFG2                        = 0xE0,
>-- 
>2.25.1
>

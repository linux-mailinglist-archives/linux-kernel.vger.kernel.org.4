Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53F4763FC52
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 00:54:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbiLAXyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 18:54:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbiLAXyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 18:54:49 -0500
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4265FC4CCF;
        Thu,  1 Dec 2022 15:54:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1669938888; x=1701474888;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7NnFjFewjuibKEk2xU+3KbUhw6Lla4EMjf1pe2o8yTI=;
  b=e4TBayPk0XJoYOQGUKBFP4aqdPrO2PKg7wj0XkBLOBX1Tmjfw2Kj9q9p
   xdMMMuNi1Zw3GT77E76r/atXk3Tz+0z8gerQyLYRR4Hma196xLmePmrIk
   sFxnzQVTupXHcLMYpb2Onm4/FLNZUO49MLvW3fHBxTPnB5HiIGv4GdUlh
   s=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 01 Dec 2022 15:54:47 -0800
X-QCInternal: smtphost
Received: from unknown (HELO nasanex01a.na.qualcomm.com) ([10.52.223.231])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2022 15:54:47 -0800
Received: from asutoshd-linux1.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Thu, 1 Dec 2022 15:54:47 -0800
Date:   Thu, 1 Dec 2022 15:54:47 -0800
From:   Asutosh Das <quic_asutoshd@quicinc.com>
To:     Andrew Halaney <ahalaney@redhat.com>
CC:     <andersson@kernel.org>, <agross@kernel.org>,
        <konrad.dybcio@linaro.org>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <p.zabel@pengutronix.de>,
        <linux-arm-msm@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH 0/4] scsi: ufs: ufs-qcom: Debug clean ups
Message-ID: <20221201235447.GD9934@asutoshd-linux1.qualcomm.com>
References: <20221201230810.1019834-1-ahalaney@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <20221201230810.1019834-1-ahalaney@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 01 2022 at 15:09 -0800, Andrew Halaney wrote:
>This patch series attempts to clean up some debug code paths in the
>ufs-qcom driver.
>
>Andrew Halaney (4):
>  scsi: ufs: ufs-qcom: Drop unnecessary NULL checks
>  scsi: ufs: ufs-qcom: Clean up dbg_register_dump
>  scsi: ufs: ufs-qcom: Remove usage of dbg_print_en
>  scsi: ufs: ufs-qcom: Use dev_err() where possible
>
> drivers/ufs/host/ufs-qcom.c | 135 +++++++++++++-----------------------
> drivers/ufs/host/ufs-qcom.h |  11 ---
> 2 files changed, 48 insertions(+), 98 deletions(-)
>
>-- 
>2.38.1
>
>
This series makes sense to me. Thanks.

Reviewed-by: Asutosh Das <quic_asutoshd@quicinc.com>

-asd

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5511B67A04D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 18:38:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233118AbjAXRiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 12:38:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjAXRiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 12:38:11 -0500
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F15813D57
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 09:38:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1674581889; x=1706117889;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=qnalg7uet8XUM56Ch3E35qRaYhE1U+O38DTWlNeNDD0=;
  b=gYAhGzUWlA85dyJLQmIqX38Xhc20rKi15fLPYyqyEJ3ok5ZpVJldL+GF
   ExWaSI30nc2mEI5yt74g2TaAwpUBsAX0F4lm2nTzEkcev8nnX84oBc+lZ
   VUQGfg8b+EoQ5lIQKJ8nfVUeiPWalG+mOH9KTM6kXQW02rSNwNpNkogZl
   Y=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 24 Jan 2023 09:38:08 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.45.79.139])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2023 09:38:08 -0800
Received: from [10.216.52.174] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 24 Jan
 2023 09:38:04 -0800
Message-ID: <4611bc21-fa4d-6234-0faf-80e945bf8e83@quicinc.com>
Date:   Tue, 24 Jan 2023 23:08:01 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] arm64: el2_setup.h: fix spelling typo in comments
Content-Language: en-US
To:     Prathu Baronia <prathubaronia2011@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Zhiyuan Dai <daizhiyuan@phytium.com.cn>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20230123110639.10473-1-prathubaronia2011@gmail.com>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <20230123110639.10473-1-prathubaronia2011@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/23/2023 4:36 PM, Prathu Baronia wrote:
> - "evailable" -> "available"
> 
> Signed-off-by: Prathu Baronia <prathubaronia2011@gmail.com>
> ---
>   arch/arm64/include/asm/el2_setup.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/el2_setup.h b/arch/arm64/include/asm/el2_setup.h
> index 668569adf4d3..40567b9bb019 100644
> --- a/arch/arm64/include/asm/el2_setup.h
> +++ b/arch/arm64/include/asm/el2_setup.h
> @@ -177,7 +177,7 @@
>   /**
>    * Initialize EL2 registers to sane values. This should be called early on all
>    * cores that were booted in EL2. Note that everything gets initialised as
> - * if VHE was not evailable. The kernel context will be upgraded to VHE > + * if VHE was not available. The kernel context will be upgraded to VHE


Reviewed-by: Mukesh Ojha <quic_mojha@quicinc.com>

-Mukesh

>    * if possible later on in the boot process
>    *
>    * Regs: x0, x1 and x2 are clobbered.

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45A5D6E7363
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 08:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231605AbjDSGgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 02:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231600AbjDSGgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 02:36:48 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFF1355B5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 23:36:06 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33J3RSJs001612;
        Wed, 19 Apr 2023 08:35:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=nfvufc35zjDb7jJXYkjh00hZeWTjRTL12FY73FXZ6ks=;
 b=jggeKV14ZhJD+/ZL160DP8FmVWuWcTTAifvo1kyBZ8YkMaiA8MCp/JzLd+UhnoeZYESA
 hxZ4F4THJkjCba8O6KvCTIBu0pStwl3Fq9JjIOlXXTAAS3enym4+PvXXPeiTRCQ1m4ln
 yd+j9jLTtbWOupegZmgRgXCFSUHifVeGgFgKX7f1Lr4AaRHB5cVWF7y1S5nUlezLWfV4
 CPHgPW2oYygd3muaADJszhhAcNPzTvJiTWrAV1VniFTMJATdH45L4ppL//nUGhG4kv+Z
 D23NtopzCoI+k8QthtVC4LPwCxrXw3iXeWw89OV/0TGRsRMu8ehqmaESBjUhIX3NsIwu Cg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3q1rq2e5an-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Apr 2023 08:35:39 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7362F100034;
        Wed, 19 Apr 2023 08:34:01 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 6887620FA4B;
        Wed, 19 Apr 2023 08:34:01 +0200 (CEST)
Received: from [10.201.21.26] (10.201.21.26) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Wed, 19 Apr
 2023 08:34:00 +0200
Message-ID: <2f1c0da9-1f98-9cfc-b4e6-ba254aa2b30d@foss.st.com>
Date:   Wed, 19 Apr 2023 08:33:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] irqchip/st: remove stih415/stih416 and stid127 platforms
 support
Content-Language: en-US
To:     Alain Volmat <avolmat@me.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>
CC:     <linux-kernel@vger.kernel.org>
References: <20230416190501.18737-1-avolmat@me.com>
From:   Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20230416190501.18737-1-avolmat@me.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.21.26]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-19_03,2023-04-18_01,2023-02-09_01
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alain

On 4/16/23 21:05, Alain Volmat wrote:
> Remove support for the already no more supported stih415 and stih416
> platforms.  Remove as well the stid127 platform which never made it
> up to the kernel.
> 
> Signed-off-by: Alain Volmat <avolmat@me.com>
> ---
> Patch previously sent via serie: https://lore.kernel.org/all/20230209091659.1409-4-avolmat@me.com/
> 
>  drivers/irqchip/irq-st.c | 15 ---------------
>  1 file changed, 15 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-st.c b/drivers/irqchip/irq-st.c
> index 1b83512b29c6..819a12297b58 100644
> --- a/drivers/irqchip/irq-st.c
> +++ b/drivers/irqchip/irq-st.c
> @@ -15,10 +15,7 @@
>  #include <linux/regmap.h>
>  #include <linux/slab.h>
>  
> -#define STIH415_SYSCFG_642		0x0a8
> -#define STIH416_SYSCFG_7543		0x87c
>  #define STIH407_SYSCFG_5102		0x198
> -#define STID127_SYSCFG_734		0x088
>  
>  #define ST_A9_IRQ_MASK			0x001FFFFF
>  #define ST_A9_IRQ_MAX_CHANS		2
> @@ -44,22 +41,10 @@ struct st_irq_syscfg {
>  };
>  
>  static const struct of_device_id st_irq_syscfg_match[] = {
> -	{
> -		.compatible = "st,stih415-irq-syscfg",
> -		.data = (void *)STIH415_SYSCFG_642,
> -	},
> -	{
> -		.compatible = "st,stih416-irq-syscfg",
> -		.data = (void *)STIH416_SYSCFG_7543,
> -	},
>  	{
>  		.compatible = "st,stih407-irq-syscfg",
>  		.data = (void *)STIH407_SYSCFG_5102,
>  	},
> -	{
> -		.compatible = "st,stid127-irq-syscfg",
> -		.data = (void *)STID127_SYSCFG_734,
> -	},
>  	{}
>  };
>  
Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice

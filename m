Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCEBD71263A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 14:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242870AbjEZME7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 08:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231158AbjEZMEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 08:04:44 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FDE9E42;
        Fri, 26 May 2023 05:04:34 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34QB9RZk010987;
        Fri, 26 May 2023 14:04:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=m3cJVkCFNQF2leqnS9Qg9XF0d/nmB54SuFFqMjaXqbc=;
 b=RskGATPlhzQdHBxRTT8T+tyvofn6NYBLv46g3YoFniuh6BY4WVRBIbfgpFUcVJ9jPiqX
 ZjVtahK0Ista0dD/OP8cq6L/aG9qcwH/2+QslBnVgMSStLZndPrEvcEIpvtKqKbvb7U9
 kJFe7XKDnSqxtDscih73Nt4N7jXKs0a3ZKta5xerWJ62T/tQIel1mLMXWUEs8uzZTde5
 E5jbDCeVf6UpMQlgON54AOmshCvFjxlG+T2KVCbQiHBnKeRv6VCWAe/flR2mx01iFpmX
 SxCpfVoU12u9wbBW8/KWQqoRmrjwHNSM34aKXRbv1O5367+SVmtJdQp/7KMY0T4nc+05 /w== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3qt2uyhjja-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 May 2023 14:04:14 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5A02710002A;
        Fri, 26 May 2023 14:04:13 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 5172C22A6FC;
        Fri, 26 May 2023 14:04:13 +0200 (CEST)
Received: from [10.48.0.148] (10.48.0.148) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Fri, 26 May
 2023 14:04:12 +0200
Message-ID: <d7fc3df2-aae7-d3b2-ea29-14d266289d1d@foss.st.com>
Date:   Fri, 26 May 2023 14:04:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/2] backlight: gpio_backlight: add new property
 default-brightness-level
Content-Language: en-US
To:     Alexandru Ardelean <alex@shruggie.ro>,
        <dri-devel@lists.freedesktop.org>, <linux-leds@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-fbdev@vger.kernel.org>
CC:     <lee@kernel.org>, <daniel.thompson@linaro.org>,
        <jingoohan1@gmail.com>, <pavel@ucw.cz>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <deller@gmx.de>, Yannick Fertre <yannick.fertre@foss.st.com>
References: <20230519200520.10657-1-alex@shruggie.ro>
From:   Philippe CORNU <philippe.cornu@foss.st.com>
In-Reply-To: <20230519200520.10657-1-alex@shruggie.ro>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.0.148]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-26_01,2023-05-25_03,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/19/23 22:05, Alexandru Ardelean wrote:
> From: Yannick Fertre <yannick.fertre@foss.st.com>
> 
> Add new property to set a brightness by default at probe.
> 
> Reviewed-by: Philippe CORNU <philippe.cornu@foss.st.com>

Hi Alexandru,

Many thanks for your patch.

You have sent a patch originally pushed on the STMicroelectronics github 
as mentioned in your commit message (no problem with that :-). But, the 
"Reviewed-by" inside this github patch is linked to our gerrit STM 
internal server so you can not use it directly for mainlining this patch.

So please, re-send your this patch without my "Reviewed-by".

Many thanks
Philippe :-)


> Signed-off-by: Yannick Fertre <yannick.fertre@foss.st.com>
> Signed-off-by: Alexandru Ardelean <alex@shruggie.ro>
> ---
> 
> Link to original patch:
>    https://github.com/STMicroelectronics/linux/commit/c4067d7bd883c6fa14ffd49892c4ce663cdafe98
> 
>   drivers/video/backlight/gpio_backlight.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/video/backlight/gpio_backlight.c b/drivers/video/backlight/gpio_backlight.c
> index 6f78d928f054..d3fa3a8bef4d 100644
> --- a/drivers/video/backlight/gpio_backlight.c
> +++ b/drivers/video/backlight/gpio_backlight.c
> @@ -53,6 +53,7 @@ static int gpio_backlight_probe(struct platform_device *pdev)
>   	struct backlight_device *bl;
>   	struct gpio_backlight *gbl;
>   	int ret, init_brightness, def_value;
> +	u32 value;
>   
>   	gbl = devm_kzalloc(dev, sizeof(*gbl), GFP_KERNEL);
>   	if (gbl == NULL)
> @@ -93,7 +94,11 @@ static int gpio_backlight_probe(struct platform_device *pdev)
>   	else
>   		bl->props.power = FB_BLANK_UNBLANK;
>   
> -	bl->props.brightness = 1;
> +	ret = device_property_read_u32(dev, "default-brightness-level", &value);
> +	if (!ret && value <= props.max_brightness)
> +		bl->props.brightness = value;
> +	else
> +		bl->props.brightness = 1;
>   
>   	init_brightness = backlight_get_brightness(bl);
>   	ret = gpiod_direction_output(gbl->gpiod, init_brightness);

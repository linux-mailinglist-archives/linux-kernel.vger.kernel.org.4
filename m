Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D71E0638AB8
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 14:00:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbiKYM75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 07:59:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbiKYM7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 07:59:25 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C112421BF
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 04:59:12 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id 83-20020a1c0256000000b003d03017c6efso5458895wmc.4
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 04:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xAwDeLMDI7jjJICxpuML25RfdqA6Cct7LkWV25vDTYU=;
        b=Y5a6fIYD6fefsUga9jeZ6gQhDhnIy/oo5V973q+1AyvwYEVWseFjU6EI5w+ZM0ir/K
         WVD2xm0KZUHZBxq61q8bNIGvbQFNwL6fbhC91x55xttVQhG05+xteRY+qhC0yTf4QIMM
         KIwVNs5VKlWJLSVTZ/izvgt712WWZFWfKKOn1KG6btlcnGw+moEOzaUe6FjudVwWKGmN
         Bx4HZ8z+l7CNMipP50eWZrLe980kGBgfk5/7siS84hYe5CLKrXx5dn7S5ku33POGIGDA
         MwoOVKiPninQTH1DikIhfvY6xYAYLQ34lVPuzkEuPoqZF0WSQASCzu4Jn2hqkK4d3zfY
         wKrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xAwDeLMDI7jjJICxpuML25RfdqA6Cct7LkWV25vDTYU=;
        b=LxspSrg/FNTzfr9Wqhr0WTHrdC6Ui5IwMm2nX98ybMQwVuAJu7VL3LHJte197wZBIp
         3MLc+tcmJh0reLfzL9SiV4JFNQr+IXFUCfdyQHrlwMaQizRDWaYTeNS/xJ8odXXxil3n
         7QZqPGPv3nNQVYCnd6JSDIU/5OuCoyjmfyUPo/rL9pq2eiAxryIUvqEf8DzVI4ERvgK+
         R/CL9sgU5jvsGebryxuSX5YLHsytDYbII5NwEtZWSd9L9oXCQkagg3Cu88eGcQk/h+tO
         c4gpgAjmanVhXyh5eQk6nrCxOgY5zFBhuGHmp1RS4/0LZyMdnW4HQErcK1TPz+W6PUpP
         pcAg==
X-Gm-Message-State: ANoB5pmSODBkGJsGi5+Qr6RTYYGWuacOaLOQUmtxyo7CSh+ZmfSPIZpM
        duAWUrEnVSDzYx2rVDWQg0YQKQ==
X-Google-Smtp-Source: AA0mqf7mEGKLa42qccOR51NJrHfVji46zsVRrQCeKgATOV8TvhZ+PAqLLRnZL3faN6fZ6R9yxZK58A==
X-Received: by 2002:a05:600c:3b09:b0:3cf:987a:2bf with SMTP id m9-20020a05600c3b0900b003cf987a02bfmr15034111wms.157.1669381150938;
        Fri, 25 Nov 2022 04:59:10 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:84a5:7e09:b15:f1fe? ([2a01:e0a:982:cbb0:84a5:7e09:b15:f1fe])
        by smtp.gmail.com with ESMTPSA id fn9-20020a05600c688900b003cf6a55d8e8sm5100190wmb.7.2022.11.25.04.59.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Nov 2022 04:59:10 -0800 (PST)
Message-ID: <038bebc1-2999-69d0-9c3d-e25acf61e31d@linaro.org>
Date:   Fri, 25 Nov 2022 13:59:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 3/6] soc: amlogic: meson-pwrc: Add NNA power domain for
 A311D
Content-Language: en-US
To:     Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        "moderated list:ARM/Amlogic Meson SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson SoC support" 
        <linux-amlogic@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20221125111921.37261-1-tomeu.vizoso@collabora.com>
 <20221125111921.37261-4-tomeu.vizoso@collabora.com>
Organization: Linaro Developer Services
In-Reply-To: <20221125111921.37261-4-tomeu.vizoso@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/11/2022 12:19, Tomeu Vizoso wrote:
> Based on power initialization sequence in downstream driver.
> 
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> ---
>   drivers/soc/amlogic/meson-ee-pwrc.c | 17 +++++++++++++++++
>   1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/soc/amlogic/meson-ee-pwrc.c b/drivers/soc/amlogic/meson-ee-pwrc.c
> index dd5f2a13ceb5..925cfaf50d11 100644
> --- a/drivers/soc/amlogic/meson-ee-pwrc.c
> +++ b/drivers/soc/amlogic/meson-ee-pwrc.c
> @@ -46,6 +46,9 @@
>   #define HHI_NANOQ_MEM_PD_REG1		(0x47 << 2)
>   #define HHI_VPU_MEM_PD_REG2		(0x4d << 2)
>   
> +#define G12A_HHI_NANOQ_MEM_PD_REG0	(0x43 << 2)
> +#define G12A_HHI_NANOQ_MEM_PD_REG1	(0x44 << 2)
> +
>   struct meson_ee_pwrc;
>   struct meson_ee_pwrc_domain;
>   
> @@ -106,6 +109,13 @@ static struct meson_ee_pwrc_top_domain sm1_pwrc_usb = SM1_EE_PD(17);
>   static struct meson_ee_pwrc_top_domain sm1_pwrc_pci = SM1_EE_PD(18);
>   static struct meson_ee_pwrc_top_domain sm1_pwrc_ge2d = SM1_EE_PD(19);
>   
> +static struct meson_ee_pwrc_top_domain g12a_pwrc_nna = {	\
> +		.sleep_reg = GX_AO_RTI_GEN_PWR_SLEEP0, 		\
> +		.sleep_mask = BIT(16) | BIT(17),		\
> +		.iso_reg = GX_AO_RTI_GEN_PWR_ISO0, 		\
> +		.iso_mask = BIT(16) | BIT(17), 			\
> +	};
> +
>   /* Memory PD Domains */
>   
>   #define VPU_MEMPD(__reg)					\
> @@ -217,6 +227,11 @@ static struct meson_ee_pwrc_mem_domain sm1_pwrc_mem_audio[] = {
>   	{ HHI_AUDIO_MEM_PD_REG0, GENMASK(27, 26) },
>   };
>   
> +static struct meson_ee_pwrc_mem_domain g12a_pwrc_mem_nna[] = {
> +	{ G12A_HHI_NANOQ_MEM_PD_REG0, 0xffffffff },
> +	{ G12A_HHI_NANOQ_MEM_PD_REG1, 0xffffffff },

Weird it's not 0xff like on SM1, I looked at the A311D Datasheet and
HHI_NANOQ_MEM_PD_REG0 is 31:0 so 0xffffffff is correct, but
HHI_NANOQ_MEM_PD_REG1 is 23:0 so 0xFFFFFF is the correct value.

Bur please replace with GENMASK(31, 0) and GENMASK(23, 0) to align with the
rest of the code.

> +};
> +
>   #define VPU_PD(__name, __top_pd, __mem, __is_pwr_off, __resets, __clks)	\
>   	{								\
>   		.name = __name,						\
> @@ -253,6 +268,8 @@ static struct meson_ee_pwrc_domain_desc g12a_pwrc_domains[] = {
>   	[PWRC_G12A_VPU_ID]  = VPU_PD("VPU", &gx_pwrc_vpu, g12a_pwrc_mem_vpu,
>   				     pwrc_ee_is_powered_off, 11, 2),
>   	[PWRC_G12A_ETH_ID] = MEM_PD("ETH", meson_pwrc_mem_eth),
> +	[PWRC_G12A_NNA_ID] = TOP_PD("NNA", &g12a_pwrc_nna, g12a_pwrc_mem_nna,
> +				    pwrc_ee_is_powered_off),
>   };
>   
>   static struct meson_ee_pwrc_domain_desc gxbb_pwrc_domains[] = {

With this fixed:

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>


Thanks,
Neil


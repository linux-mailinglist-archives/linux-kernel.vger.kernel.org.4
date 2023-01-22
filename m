Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C333676CA4
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 13:05:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbjAVMFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 07:05:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjAVMFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 07:05:17 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BB601633D
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 04:05:16 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id e19-20020a05600c439300b003db1cac0c1fso7273717wmn.5
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 04:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VNwLqElMoNVz4I6lJ0Ng631u7U2KDL6Cz3pngMAQMGo=;
        b=rG7IuNKTjo2Q0FRAcnNF/kjKZSePGxYgMuxpmZtZ0Dnl3oKTpTSyHa8d82DPlWtxXF
         KBAwdlgnQHMvMOdIxsQL9SAYv9drWre1S/mS/70ZxaMAk/1iRTdhKi/u7N07TFzIGL2R
         IeO5FDI1FCIuBQv5eSH74ZKrt10oPrPJgyitkG/820ToHTgEZNgG1QPkK4Qe8B539geL
         fquTPWUQffUR9wncgLTuUqRgSB3hr0UKWJ4jPMdFIW5Uftn1l2TPUw61pf6nJ+5sojcg
         rT7EWnSOseI1I88GcK4FIYqC/6yEFsEICU2SANNRLxyLxC/pzLa/03gbJtQ+R8IMTOPc
         4+AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VNwLqElMoNVz4I6lJ0Ng631u7U2KDL6Cz3pngMAQMGo=;
        b=5A/fnSJm7GtIxruIr/4XK2kx49pIIpkAVSdHUkf84Fglz6oJKNddVrMdryLhSNP6lM
         AUlJY7y0rdj/W/8NAv82Xov7imtiShYOdghq87LpENOUbw3165BBBpR5ylYWylXdDMvV
         VSWGIEd76UirxhcW1FfF1GjbmgtqEUGKyr27Nw5ur7jZUgQ5P3SEgWWTq8INhIyFdEGZ
         Yhho3MzK5GagNJRVvhMQDpc3lssYV6IG0LUIouxUBiwab8JdhCtQUYtO1wNc0bX3K2yf
         jlRpld0Oh/qIQV9JYQJFE+c2z1zb+zbCgr5/2jwZaQuTsPdWVM8tT+G+a9IlylQcxSVb
         JyjQ==
X-Gm-Message-State: AFqh2krs/hMfCNxc4ToU8QIxF1OJdU7/ISqmqaLRrk73ff6++eq29ot6
        wfUU8sHTvt0rSo2+OzW4+BtEHA==
X-Google-Smtp-Source: AMrXdXul0HllpaRq1bcPwQat99gWfYzMSrk0CEceFEvmNeffBpIwTAjzTU8Es2U58WrbBbNz8awprg==
X-Received: by 2002:a05:600c:4b16:b0:3d2:2830:b8bb with SMTP id i22-20020a05600c4b1600b003d22830b8bbmr28399526wmp.34.1674389114953;
        Sun, 22 Jan 2023 04:05:14 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id c14-20020adfa30e000000b002be50604c81sm6696996wrb.47.2023.01.22.04.05.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Jan 2023 04:05:14 -0800 (PST)
Message-ID: <fb2a6e85-42ad-8b17-4433-8d5e96c87a80@linaro.org>
Date:   Sun, 22 Jan 2023 13:05:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v2] memory: renesas-rpc-if: Fix PHYCNT.STRTIM setting
Content-Language: en-US
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-renesas-soc@vger.kernel.org
Cc:     Prabhakar <prabhakar.csengg@gmail.com>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        linux-kernel@vger.kernel.org
References: <20230118104656.67706-1-wsa+renesas@sang-engineering.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230118104656.67706-1-wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/01/2023 11:46, Wolfram Sang wrote:
> From: Cong Dang <cong.dang.xn@renesas.com>
> 
> According to the datasheets, the Strobe Timing Adjustment bit (STRTIM)
> setting is different on R-Car SoCs, i.e.
> 
> R-Car H3 ES1.*  : STRTIM[2:0] is set to 0x0
> R-Car M3 ES1.*  : STRTIM[2:0] is set to 0x6
> other R-Car Gen3: STRTIM[2:0] is set to 0x7
> other R-Car Gen4: STRTIM[3:0] is set to 0xf
> 
> To fix this issue, a DT match data was added to specify the setting
> for special use cases.
> 
> Signed-off-by: Cong Dang <cong.dang.xn@renesas.com>
> Signed-off-by: Hai Pham  <hai.pham.ud@renesas.com>
> [wsa: rebased, restructured a little, added Gen4 support]
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
> 
> Change since V1:
> 
> * use proper mask when updating STRTIM bits (thanks, Geert!)
> 
> look for 'RPCIF_PHYCNT_STRTIM', there is the change. Rest is the same.
> 
>  drivers/memory/renesas-rpc-if.c | 63 ++++++++++++++++++++++++++-------
>  include/memory/renesas-rpc-if.h |  6 ++++
>  2 files changed, 56 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/memory/renesas-rpc-if.c b/drivers/memory/renesas-rpc-if.c
> index c36b407851ff..845b535a5350 100644
> --- a/drivers/memory/renesas-rpc-if.c
> +++ b/drivers/memory/renesas-rpc-if.c
> @@ -7,6 +7,7 @@
>   * Copyright (C) 2019-2020 Cogent Embedded, Inc.
>   */
>  
> +#include <linux/bitops.h>
>  #include <linux/clk.h>
>  #include <linux/io.h>
>  #include <linux/module.h>
> @@ -15,6 +16,7 @@
>  #include <linux/of_device.h>
>  #include <linux/regmap.h>
>  #include <linux/reset.h>
> +#include <linux/sys_soc.h>
>  
>  #include <memory/renesas-rpc-if.h>
>  
> @@ -163,6 +165,36 @@ static const struct regmap_access_table rpcif_volatile_table = {
>  	.n_yes_ranges	= ARRAY_SIZE(rpcif_volatile_ranges),
>  };
>  
> +static const struct rpcif_info rpcif_info_r8a7795_es1 = {
> +	.type = RPCIF_RCAR_GEN3,
> +	.strtim = 0,
> +};
> +
> +static const struct rpcif_info rpcif_info_r8a7796_es1 = {
> +	.type = RPCIF_RCAR_GEN3,
> +	.strtim = 6,
> +};
> +
> +static const struct rpcif_info rpcif_info_gen3 = {
> +	.type = RPCIF_RCAR_GEN3,
> +	.strtim = 7,
> +};
> +
> +static const struct rpcif_info rpcif_info_rz_g2l = {
> +	.type = RPCIF_RZ_G2L,
> +	.strtim = 7,
> +};
> +
> +static const struct rpcif_info rpcif_info_gen4 = {
> +	.type = RPCIF_RCAR_GEN4,
> +	.strtim = 15,
> +};
> +
> +static const struct soc_device_attribute rpcif_info_match[]  = {
> +	{ .soc_id = "r8a7795", .revision = "ES1.*", .data = &rpcif_info_r8a7795_es1 },
> +	{ .soc_id = "r8a7796", .revision = "ES1.*", .data = &rpcif_info_r8a7796_es1 },

Why do you need soc match? Can't this be inferred from device
compatible? Maybe the device compatible is not specific enough? Devices
should not be interested in which SoC they are running - it does not
matter for them, because the device difference is in the device itself,
not in the SoC (different SoCs come with different devices).

Best regards,
Krzysztof


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC6F9637A0D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 14:36:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbiKXNgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 08:36:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbiKXNgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 08:36:52 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 057F96E552
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 05:36:51 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id x21so1996144ljg.10
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 05:36:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vs9L6vGU7gC9jaDFCTKoT90tKFWWGxX97DU2d9lHvF4=;
        b=d19D0fF+coPGhp8VVzw2altAjkhl/3oiBDfric6mOBmWmj87Pr9zJM3PGTekhD4sVt
         wFuj7kgQTet2qXYdXMRmPesUdIEJ0JsEVgcD+XCMFp0f8OXbShyiex8jAJ0a2igFi5fu
         TPQRHCg4eMdv5tXuoljajuukZ2/cQ2Jff4PonTZMrviDZ7fs65BOMKvaHrMcJp9Iq0tP
         v8UXM9n7u42WRUN4C4+C0Wx9cvefTWZ3wyVnYQeMEninGQId9i1yf9XD/FTwTbfeXSuh
         ow9tIMUjgfDMqWvtu6JLLqZbXmhNEjCeA4JbVVbExpxpU1NM64DdPMTV/7AlgXhXeN5h
         Wi5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vs9L6vGU7gC9jaDFCTKoT90tKFWWGxX97DU2d9lHvF4=;
        b=zSZcMN31yPTO8yoDsMJKwpl0JUyykTr4e+P47FdnNAJidD26caRMb8Ax0I0YZP9PNW
         glgCIVKTB3A6AOSKJ90v14tLwgLTK6Lh5sypzhzRLRfqt/DNNw5UEBCtBuA5fkBXWGzp
         YYkci93qUzKpgeyNJHqwk/kOxf9R6mGzv2YXRHnQ7k5TC9DcCqXAua4GH3luozn+6lDo
         E9Qm0skRV6Ola2UYYJ1pQHkb+ijprVd7ETGoOgkkjIjdo7+pgk0hlMoXkdAMP/rENLgK
         IylsUD5a6ISwfnP0Tz+odCYJMGByC+/TrgXIdZsJiSz68x8gvneEEudYbF0lY2mNhEGk
         dC+Q==
X-Gm-Message-State: ANoB5pm83ebAO/evG/t5GVSxC73dadIF9iz66Ebc1QmJb9Vq8wrY1szu
        Y56qYbdf6gDVe+Oz8vync0txjQ==
X-Google-Smtp-Source: AA0mqf6F/C4OYtDNr0WNh3JV00/TLQhx8VoEtP0tW4T703ElKtETYuElav0seRbBQaAaC7+ghamOjg==
X-Received: by 2002:a2e:a988:0:b0:276:de0b:ce2d with SMTP id x8-20020a2ea988000000b00276de0bce2dmr4270430ljq.212.1669297009323;
        Thu, 24 Nov 2022 05:36:49 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id q21-20020a0565123a9500b0049936272173sm123058lfu.204.2022.11.24.05.36.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Nov 2022 05:36:48 -0800 (PST)
Message-ID: <93cc4e4b-4135-8a1f-c7b4-62c5da87bd8b@linaro.org>
Date:   Thu, 24 Nov 2022 14:36:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v1 2/2] memory: renesas-rpc-if: Add Octal DTR mode support
Content-Language: en-US
To:     JaimeLiao <jaimeliao.tw@gmail.com>, broonie@kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jaimeliao@mxic.com.tw
References: <20221124073957.22471-1-jaimeliao.tw@gmail.com>
 <20221124073957.22471-3-jaimeliao.tw@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221124073957.22471-3-jaimeliao.tw@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/11/2022 08:39, JaimeLiao wrote:
> 1. Support Octal DTR manual mode (Program & Erase & register)
> 2. Support diramap read (enable external address space read mode)

If these are two separate features, you need two separate commits.

> 
> Signed-off-by: JaimeLiao <jaimeliao.tw@gmail.com>
> ---
>  drivers/memory/renesas-rpc-if.c | 56 +++++++++++++++++++++++++++++++++
>  1 file changed, 56 insertions(+)
> 
> diff --git a/drivers/memory/renesas-rpc-if.c b/drivers/memory/renesas-rpc-if.c
> index bdf0a7f68ff2..db5019a7190e 100644
> --- a/drivers/memory/renesas-rpc-if.c
> +++ b/drivers/memory/renesas-rpc-if.c
> @@ -462,6 +462,43 @@ void rpcif_prepare(struct rpcif *rpc, const struct rpcif_op *op, u64 *offs,
>  
>  		rpc->enable |= RPCIF_SMENR_SPIDB(rpcif_bit_size(op->data.buswidth));
>  	}
> +       /* Fixup in Octal DTR mode */
> +	if (op->cmd.buswidth == 8 && op->cmd.ddr) {
> +		rpc->bus_size = 2;
> +
> +		regmap_update_bits(rpc->regmap, RPCIF_PHYCNT,
> +				   RPCIF_PHYCNT_OCTA(0x2) | RPCIF_PHYCNT_OCT |
> +				   RPCIF_PHYCNT_PHYMEM(0x1) ,
> +				   RPCIF_PHYCNT_OCTA(0x2) | RPCIF_PHYCNT_OCT |
> +				   RPCIF_PHYCNT_PHYMEM(0x1));
> +		regmap_update_bits(rpc->regmap, RPCIF_CMNCR, RPCIF_CMNCR_BSZ(1),
> +				   RPCIF_CMNCR_BSZ(1));
> +
> +		regmap_update_bits(rpc->regmap, RPCIF_PHYOFFSET1,
> +				   RPCIF_PHYOFFSET1_DDRTMG(3),
> +				   RPCIF_PHYOFFSET1_DDRTMG(2));
> +		regmap_update_bits(rpc->regmap, RPCIF_PHYOFFSET2,
> +				   RPCIF_PHYOFFSET2_OCTTMG(7),
> +				   RPCIF_PHYOFFSET2_OCTTMG(3));
> +
> +		if (op->ocmd.buswidth == 8 && RPCIF_SMENR_OCDE)
> +			rpc->enable &= ~RPCIF_SMENR_OCDE;
> +
> +		if (op->addr.ddr)
> +			rpc->enable &= ~RPCIF_SMENR_ADE(0xF) |
> +					RPCIF_SMENR_ADE(0xc);
> +
> +		if (op->dummy.buswidth == 8)
> +			rpc->dummy =
> +				RPCIF_SMDMCR_DMCYC(op->dummy.ncycles / 2);
> +
> +		if (op->data.dir == RPCIF_DATA_IN)
> +			/* Set Extenal Address space Read mode */
> +			if (op->data.buswidth == 8 && op->data.ddr) {
> +				regmap_update_bits(rpc->regmap, RPCIF_PHYCNT,
> +					RPCIF_PHYCNT_EXDS, RPCIF_PHYCNT_EXDS);
> +			}

Wrap it in {}. It's quite error-prone in such syntax.


Best regards,
Krzysztof


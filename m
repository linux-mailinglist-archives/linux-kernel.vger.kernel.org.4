Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3378E729F03
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 17:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241673AbjFIPrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 11:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231981AbjFIPrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 11:47:23 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 196F63583;
        Fri,  9 Jun 2023 08:47:22 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4f62d93f38aso2496421e87.0;
        Fri, 09 Jun 2023 08:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686325640; x=1688917640;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MGV1/KZj3y1NtDF4P2EgVoQoL3mBQgMSttusFZRY2rg=;
        b=Rr/4ufWPoa8wgWRlZq2Fkr+hoJzIrHU2T+LsMdVY7LA2Ev/BYE8OvdrFhdTgnouvNr
         1qyZi8ndhP5CX9gFSSb2hUcRFOnxMIRg613Smk5fuwUXSGLTtEyfvfoTJMId4nq/GRu1
         PHWzZJ8uHgyQtZquJRP3YpptDQ/LqELZm3ITxcqPt+8B+L6Y9GnWjUkzrHljjFJtVGzb
         8O3sF244wYtNdwYMstvvf7P9jHOpr9TL2kk/g35UQXPvkq1IhpMI1H7YOrvVaU2gCYij
         fhL2uQVP/pGOLqHjswqIgwsJEBWPAK35Dd6vGuJeeBLAH0gTEBI9O59GU0VyIvaCcVKr
         Pb/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686325640; x=1688917640;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MGV1/KZj3y1NtDF4P2EgVoQoL3mBQgMSttusFZRY2rg=;
        b=II7fwB1oyvBKFmTUwbc8mlwcm8uqAxXUzDvMC4HWwGGQq2PPl3ZvkSH2TmqbGwhyyC
         8DVSP25kS4AFxrxCeEk2fDAnJ0+p0SPKq1+KUiAUTuoOhqxMo4uuZZ9KSSFjgxHjjwRO
         lU8EF8c8g785APSV3MyIueZBz4PelYokR3baZff2+ozHGIu7AhHmgTSHM40ES+vlu5Ng
         CYu72oz4xpTj2bIgvBc5nvKcRr6sFp7ud0K8fPg4isBb/x7bmBq39ROlxWzdT3DEAnYw
         NVFtDltc4CtN7xtHoV3BxlEC3bka27KVYKTasBzFf64bUfaIGr+QGqo+YQVOHDSNAZwR
         YvLw==
X-Gm-Message-State: AC+VfDzbxQHqX77thNCs9atEVYvYvJg67/Co8/WRf8gMw+7fcOCPtUm8
        tGifCt1cPh81i32M2PKM8O4=
X-Google-Smtp-Source: ACHHUZ48RU1kfrfHRKL1mD1wY5iK4OGXd91DaTeeFeqSsRfSvZjQrIpEigCoMa5h5reTQit5kWMgeA==
X-Received: by 2002:a05:6512:3119:b0:4ed:bdac:7a49 with SMTP id n25-20020a056512311900b004edbdac7a49mr1258532lfb.54.1686325639965;
        Fri, 09 Jun 2023 08:47:19 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id z10-20020a05600c114a00b003f7e60622f0sm3097418wmz.6.2023.06.09.08.47.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jun 2023 08:47:18 -0700 (PDT)
Message-ID: <973aaea4-8340-9c91-0bb9-4f611f9e7cae@gmail.com>
Date:   Fri, 9 Jun 2023 17:47:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 1/9] regulator: dt-bindings: mt6358: Merge ldo_vcn33_*
 regulators
Content-Language: en-US, ca-ES, es-ES
To:     Chen-Yu Tsai <wenst@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230609083009.2822259-1-wenst@chromium.org>
 <20230609083009.2822259-2-wenst@chromium.org>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230609083009.2822259-2-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/06/2023 10:29, Chen-Yu Tsai wrote:
> The ldo_vcn33_bt and ldo_vcn33_wifi regulators are actually the same
> regulator, having the same voltage setting and output pin. There are
> simply two enable bits that are ORed together to enable the regulator.
> 
> Having two regulators representing the same output pin is misleading
> from a design matching standpoint, and also error-prone in driver
> implementations.
> 
> Merge the two as ldo_vcn33. Neither vcn33 regulators are referenced
> in upstream device trees. As far as hardware designs go, none of the
> Chromebooks using MT8183 w/ MT6358 use this output.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>   .../bindings/regulator/mt6358-regulator.txt        | 14 +++-----------
>   1 file changed, 3 insertions(+), 11 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/regulator/mt6358-regulator.txt b/Documentation/devicetree/bindings/regulator/mt6358-regulator.txt
> index 7034cdca54e0..b22b956d1cbe 100644
> --- a/Documentation/devicetree/bindings/regulator/mt6358-regulator.txt
> +++ b/Documentation/devicetree/bindings/regulator/mt6358-regulator.txt
> @@ -15,8 +15,7 @@ LDO:
>     ldo_vcamd, ldo_vcn18, ldo_vfe28, ldo_vsram_proc11, ldo_vcn28, ldo_vsram_others,
>     ldo_vsram_others_sshub, ldo_vsram_gpu, ldo_vxo22, ldo_vefuse, ldo_vaux18,
>     ldo_vmch, ldo_vbif28, ldo_vsram_proc12, ldo_vcama1, ldo_vemc, ldo_vio28, ldo_va12,
> -  ldo_vrf18, ldo_vcn33_bt, ldo_vcn33_wifi, ldo_vcama2, ldo_vmc, ldo_vldo28, ldo_vaud28,
> -  ldo_vsim2
> +  ldo_vrf18, ldo_vcn33, ldo_vcama2, ldo_vmc, ldo_vldo28, ldo_vaud28, ldo_vsim2
>   
>   Example:
>   
> @@ -305,15 +304,8 @@ Example:
>   				regulator-enable-ramp-delay = <120>;
>   			};
>   
> -			mt6358_vcn33_bt_reg: ldo_vcn33_bt {
> -				regulator-name = "vcn33_bt";
> -				regulator-min-microvolt = <3300000>;
> -				regulator-max-microvolt = <3500000>;
> -				regulator-enable-ramp-delay = <270>;
> -			};
> -
> -			mt6358_vcn33_wifi_reg: ldo_vcn33_wifi {
> -				regulator-name = "vcn33_wifi";
> +			mt6358_vcn33_reg: ldo_vcn33 {
> +				regulator-name = "vcn33";
>   				regulator-min-microvolt = <3300000>;
>   				regulator-max-microvolt = <3500000>;
>   				regulator-enable-ramp-delay = <270>;

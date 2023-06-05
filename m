Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D585A72246B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 13:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232160AbjFELSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 07:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232129AbjFELSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 07:18:05 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47217DF
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 04:17:54 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3f7353993cbso11933145e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 04:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20221208.gappssmtp.com; s=20221208; t=1685963872; x=1688555872;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cE1s1SBRasCQ26tTjz3vS7kkfu8oXf1VV0juiyMiwK8=;
        b=m4HZI5EmdHgPw2WGHg9wxlsh0bqAzRSeSWrByjeIZHspybo++CFpucOhCtrbQtUODD
         9TBeM5JPTmg36p+B598Y2AbG7LEmYvEsYEp8wEUR+E63eUmw3eOzgjuLldwAF+E5/Szp
         Sp0cuf+F9OXFAmEJJ35HpkN1YXcPhUUOBzsZrx1ARJbFOMxti0vkHNUQRyqhzPsEvbeZ
         qcqbWjEdwx6pttTbEXm8StNP3/EEHdmfOS7lx+tCmT7aERdvtotUE53ADc6Qp5k+69Zj
         LLxkcmwD/CujrADXyXCEenYEtwNM+V5s3TKQe8eVKXTtghV2G8lTFmVKazMF52hLDVYW
         SdUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685963872; x=1688555872;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cE1s1SBRasCQ26tTjz3vS7kkfu8oXf1VV0juiyMiwK8=;
        b=F/dn2qrUIGCZV28qk19XJRf4rBS39tKVEQdI0r4tOfu2xd1I2j22riew381N7tQQC2
         3G2o13JM1W9D2WchNopogS5+apdGzBvu30ElUfMePLK2f11g31ow/NWVznzSl+RgkUKd
         YrBDihumZcpiZK5PZaFHyuFil/y76Zj49+2gvmxyaBzKEpsgnAXQbvjcNKq9ZC8feJzJ
         S4eNJY4qxLRVpI8dFC3dCORW8mvkseojaM+Hpvw1/jp5TpUbI5IXstsrUBQDvxtTP0ab
         1hAEJxO78yiiaXdVDPi17rnb0qk2XnrSfdrds0Dbdoi6uHXm3c7UwxKkiqAPAxTKtiEP
         /2RA==
X-Gm-Message-State: AC+VfDwx4T6n1+Tp30juh53x2n90k0OhevQfl126POISVVHOFFQWViyE
        E1Nk2+eewyJBcPn8ea4PbJhYyNJ8aVXN3l/jjwqBnA==
X-Google-Smtp-Source: ACHHUZ6aLiqxnvjM26ak+7OYnd6YE8gM65tnKeFRHFkgrmqIUL8IWqvKo9CzWSj59s0bV3Yu6lPdJg==
X-Received: by 2002:a1c:f305:0:b0:3f7:148b:c310 with SMTP id q5-20020a1cf305000000b003f7148bc310mr7496069wmq.13.1685963871878;
        Mon, 05 Jun 2023 04:17:51 -0700 (PDT)
Received: from [192.168.0.105] (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id o10-20020a1c750a000000b003f60101074dsm14129919wmc.33.2023.06.05.04.17.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 04:17:51 -0700 (PDT)
Message-ID: <54ee38d1-5924-8305-0da8-0a2d35ff80a7@monstr.eu>
Date:   Mon, 5 Jun 2023 13:17:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] dt-bindings: xilinx: Remove Rajan, Jolly and Manish
Content-Language: en-US
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Conor Dooley <conor+dt@kernel.org>,
        Krishna Potthuri <sai.krishna.potthuri@amd.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org
References: <9b252dd71c82593fa6b137eca2174d9ab6e57f7a.1684828606.git.michal.simek@amd.com>
From:   Michal Simek <monstr@monstr.eu>
In-Reply-To: <9b252dd71c82593fa6b137eca2174d9ab6e57f7a.1684828606.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/23/23 09:56, Michal Simek wrote:
> Rajan, Jolly and Manish are no longer work for AMD/Xilinx and there is no
> activity from them to continue to maintain bindings that's why remove them.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   Documentation/devicetree/bindings/clock/xlnx,versal-clk.yaml    | 2 --
>   .../bindings/memory-controllers/snps,dw-umctl2-ddrc.yaml        | 1 -
>   .../bindings/memory-controllers/xlnx,zynq-ddrc-a05.yaml         | 1 -
>   .../devicetree/bindings/pinctrl/xlnx,zynqmp-pinctrl.yaml        | 1 -
>   4 files changed, 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/clock/xlnx,versal-clk.yaml b/Documentation/devicetree/bindings/clock/xlnx,versal-clk.yaml
> index 93ae349cf9e9..5cbb34d0b61b 100644
> --- a/Documentation/devicetree/bindings/clock/xlnx,versal-clk.yaml
> +++ b/Documentation/devicetree/bindings/clock/xlnx,versal-clk.yaml
> @@ -8,8 +8,6 @@ title: Xilinx Versal clock controller
>   
>   maintainers:
>     - Michal Simek <michal.simek@amd.com>
> -  - Jolly Shah <jolly.shah@xilinx.com>
> -  - Rajan Vaja <rajan.vaja@xilinx.com>
>   
>   description: |
>     The clock controller is a hardware block of Xilinx versal clock tree. It
> diff --git a/Documentation/devicetree/bindings/memory-controllers/snps,dw-umctl2-ddrc.yaml b/Documentation/devicetree/bindings/memory-controllers/snps,dw-umctl2-ddrc.yaml
> index 6b62d5d83476..87ff9ee098f5 100644
> --- a/Documentation/devicetree/bindings/memory-controllers/snps,dw-umctl2-ddrc.yaml
> +++ b/Documentation/devicetree/bindings/memory-controllers/snps,dw-umctl2-ddrc.yaml
> @@ -8,7 +8,6 @@ title: Synopsys DesignWare Universal Multi-Protocol Memory Controller
>   
>   maintainers:
>     - Krzysztof Kozlowski <krzk@kernel.org>
> -  - Manish Narani <manish.narani@xilinx.com>
>     - Michal Simek <michal.simek@amd.com>
>   
>   description: |
> diff --git a/Documentation/devicetree/bindings/memory-controllers/xlnx,zynq-ddrc-a05.yaml b/Documentation/devicetree/bindings/memory-controllers/xlnx,zynq-ddrc-a05.yaml
> index 7864a1c994eb..75143db51411 100644
> --- a/Documentation/devicetree/bindings/memory-controllers/xlnx,zynq-ddrc-a05.yaml
> +++ b/Documentation/devicetree/bindings/memory-controllers/xlnx,zynq-ddrc-a05.yaml
> @@ -8,7 +8,6 @@ title: Zynq A05 DDR Memory Controller
>   
>   maintainers:
>     - Krzysztof Kozlowski <krzk@kernel.org>
> -  - Manish Narani <manish.narani@xilinx.com>
>     - Michal Simek <michal.simek@amd.com>
>   
>   description:
> diff --git a/Documentation/devicetree/bindings/pinctrl/xlnx,zynqmp-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/xlnx,zynqmp-pinctrl.yaml
> index cdebfa991e06..24ad0614e61b 100644
> --- a/Documentation/devicetree/bindings/pinctrl/xlnx,zynqmp-pinctrl.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/xlnx,zynqmp-pinctrl.yaml
> @@ -8,7 +8,6 @@ title: Xilinx ZynqMP Pinctrl
>   
>   maintainers:
>     - Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
> -  - Rajan Vaja <rajan.vaja@xilinx.com>
>   
>   description: |
>     Please refer to pinctrl-bindings.txt in this directory for details of the

Applied.
M

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP/Versal ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal/Versal NET SoCs
TF-A maintainer - Xilinx ZynqMP/Versal/Versal NET SoCs

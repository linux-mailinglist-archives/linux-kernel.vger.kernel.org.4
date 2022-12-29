Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA5A9658A9E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 09:43:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233239AbiL2InM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 03:43:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiL2InK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 03:43:10 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44D561004D
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 00:43:09 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id bn6so8901128ljb.13
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 00:43:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nw6Uct2xEoCrpgNOW52yhpC+6eWgh3FH1ea9ZVctRno=;
        b=pCEbAz0T1XglJBlSXuxTbjrwiv4wNCqyqHaBl1cOgxC10WIhJUx1XqILAymx7HuKL7
         YEirVgRe2/THfR1kO517BhOCIMS+PAEtVjBc4YNbFiofwma/9gT8KCWra1vU9uCvIC0n
         mXx0nvisliErqfV8PaeB9avYKzMt0Fb6GjUP1Oxh65vFUX40XpReTzIY3Dp41IFwmtDv
         Bu4MUCYmpUSGxfTOpb2UAgTtg/VBNJ6PS6XbPqMunEsBX0Sy8WoX5r0OnW22IupWT0Wm
         m+T9P+udIGI5H6sI4kE0k48FkYlopTBUBREA8rySzIwdMBgtRUOCbaDOc3ffNgts9p79
         DN1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nw6Uct2xEoCrpgNOW52yhpC+6eWgh3FH1ea9ZVctRno=;
        b=eMsk8mJ1oJDSKHvpqLEB0HNHGJuT/6Nfe43Ne/O0RsFj6jLVGteYmwqEaG9iNm/hyZ
         Eu9bEWeq2wNGwgr+HokGkuEXglictphzLdXcIiezEBTn35T26awDzup3MY7JYJEvLbLC
         SXkKMoqhQQrwyHNF6MfG/hxeODcBSnaYOvlQuGNfrZLol7r0BE4GqD9SIE7aboeSGqqm
         Oa6QAY690mQOfF3erQub182Y97omA2pzpKJt+NGs5TejaVaRF9QuMlhNLrQEzAOosBnm
         cuEyb7cyV4vHnJIiTX7F54hgYcBK8szSn5PcivB7ODps3GsHVBGaL/JS2g8sQALx3sSL
         h2Mg==
X-Gm-Message-State: AFqh2kothxoDbhAC8IFRiJRQ70zP1HEbCp/6SahvT9Apa0mQJW7l6rzE
        ErYlJjpje7eSjOf1sqVBHbsIxA==
X-Google-Smtp-Source: AMrXdXuuazk2ZVLVLqbx4q6boiXtVROmzLgnwiJeIj7jTd31t+WbE4I92u8Xfu1JSmorUwKMHbVB9Q==
X-Received: by 2002:a2e:a234:0:b0:27f:cdec:38be with SMTP id i20-20020a2ea234000000b0027fcdec38bemr1652357ljm.40.1672303387661;
        Thu, 29 Dec 2022 00:43:07 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id r8-20020ac252a8000000b004b54ca56cf9sm2984212lfm.303.2022.12.29.00.43.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Dec 2022 00:43:07 -0800 (PST)
Message-ID: <95068572-51c3-4caa-7df7-4d3303c5182c@linaro.org>
Date:   Thu, 29 Dec 2022 09:43:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v1 1/2] dt-bindings: phy: rockchip: convert
 rockchip-dp-phy.txt to yaml
Content-Language: en-US
To:     Johan Jonker <jbx6244@gmail.com>, heiko@sntech.de
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-phy@lists.infradead.org,
        vkoul@kernel.org, kishon@kernel.org
References: <5fa3aaca-4e49-8baa-68c4-2b3981400d3b@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <5fa3aaca-4e49-8baa-68c4-2b3981400d3b@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/12/2022 23:01, Johan Jonker wrote:
> Convert rockchip-dp-phy.txt to yaml.
> 
> Changed:
>   rename file name
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>  .../bindings/phy/rockchip,dp-phy.yaml         | 41 +++++++++++++++++++
>  .../bindings/phy/rockchip-dp-phy.txt          | 26 ------------
>  2 files changed, 41 insertions(+), 26 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/phy/rockchip,dp-phy.yaml
>  delete mode 100644 Documentation/devicetree/bindings/phy/rockchip-dp-phy.txt
> 
> diff --git a/Documentation/devicetree/bindings/phy/rockchip,dp-phy.yaml b/Documentation/devicetree/bindings/phy/rockchip,dp-phy.yaml
> new file mode 100644
> index 000000000..73f75ab1c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/rockchip,dp-phy.yaml
> @@ -0,0 +1,41 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/phy/rockchip,dp-phy.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Rockchip specific extensions to the Analogix Display Port PHY
> +
> +maintainers:
> +  - Heiko Stuebner <heiko@sntech.de>
> +
> +properties:
> +  compatible:
> +    const: rockchip,rk3288-dp-phy

No new compatibles were added here for the last 7 years, so it is safe
to assume none will appear in the future. Use the compatible as filename.

Best regards,
Krzysztof


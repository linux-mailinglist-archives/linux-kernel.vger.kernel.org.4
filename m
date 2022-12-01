Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F33063EBB8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 09:59:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbiLAI7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 03:59:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbiLAI7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 03:59:15 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E35332B87
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 00:59:12 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id r8so1111810ljn.8
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 00:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YzA0h0HeCzhQbuEXNVEK1IEwBkI53ORZC/BrEGK4iAA=;
        b=vBMlg0VN91KAcD+GtCGnGf3tyWtROnmvA5NBfbiiQrK08YBrYqX23nJTU9oqr0tkiJ
         9nNu/SoaZJbPmyD3Ki66/zCu2U8IWioSLnB02bl04Ydtlk2M4yjio3MemNlUX6/PhRL5
         Akl3jgLxIftYuSvm8RklXiy9J06merDU9td3vW20iSSZqA47sPrOdMKdNOBnoohc5Qff
         PT4wu4J/fHl5BrSOQuypNSGiPBwV6C9PMd4UR4H8FMrMi8ye501N82CP04z6PeJGiLiM
         FCFdGGh82uOhy4KPzSAzlZHrm5GfqnXQjArgqZAhf36+pG2LRUGnlPUzyF6sUaM0RswD
         ps9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YzA0h0HeCzhQbuEXNVEK1IEwBkI53ORZC/BrEGK4iAA=;
        b=tSsCDAkpisa9KNI/dxOTiqk1OIDNV+bzEWmFUPPDcDEdoyipZea4kgY1FqLJiS7dR5
         oS6EdapZNMC+xdOlvxLR0ltdqfaJmmk8wM8FU0e7pj9FUhHHP/+3Rf+OvztqN78lfUhT
         7mhT05chzJTfEaILdmB/uyjugy/yolgp709drzyvhP1re3N9RZiAfW6pyLDM81lfoEWE
         nQjkSOvNpV3/3Ccrjj2uzfPo1KHPQ08DHDXXHs9pBBs+vPeRnBAxIFR4gcA1Anp9+XoU
         aVm9e4oqMavRuJULkXMmph+rcVdrZ8IctgupkjAh/U1yuUzIUT6o2n1EjOKZ56gX71b7
         epmA==
X-Gm-Message-State: ANoB5pk1674sXuAUJhC/W7oAToPCnfaLkxYYsauLeEtJku5S36kKPSDH
        0a8BIon3grgvS0SGDFQcmfB11g==
X-Google-Smtp-Source: AA0mqf4tyBmoqQfAbuWfCETyt4C1MuN/qqYsbmU2e8WOS13FZVflIkFJVy8MOZ+pQV6Vhnq985CzKQ==
X-Received: by 2002:a05:651c:97:b0:279:c775:6dad with SMTP id 23-20020a05651c009700b00279c7756dadmr1941839ljq.118.1669885150910;
        Thu, 01 Dec 2022 00:59:10 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id 16-20020ac25f50000000b004b53eb60e3csm242001lfz.256.2022.12.01.00.59.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Dec 2022 00:59:09 -0800 (PST)
Message-ID: <e140fdfd-4d8b-7214-d264-0503e6fcc498@linaro.org>
Date:   Thu, 1 Dec 2022 09:59:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [RFC PATCH v1 1/2] dt-bindings: usb: samsung,exynos-xhci: support
 Samsung Exynos xHCI Controller
To:     Daehwan Jung <dh10.jung@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Colin Ian King <colin.i.king@gmail.com>,
        Artur Bujdoso <artur.bujdoso@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Tomer Maimon <tmaimon77@gmail.com>
Cc:     "open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/SAMSUNG S3C, S5P AND EXYNOS ARM ARCHITECTURES" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/SAMSUNG S3C, S5P AND EXYNOS ARM ARCHITECTURES" 
        <linux-samsung-soc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>, sc.suh@samsung.com,
        taehyun.cho@samsung.com, jh0801.jung@samsung.com,
        eomji.oh@samsung.com
References: <1669860811-171746-1-git-send-email-dh10.jung@samsung.com>
 <CGME20221201021941epcas2p4a536a9eb029a990fcb9f27f2b4668d07@epcas2p4.samsung.com>
 <1669860811-171746-2-git-send-email-dh10.jung@samsung.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1669860811-171746-2-git-send-email-dh10.jung@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/12/2022 03:13, Daehwan Jung wrote:
> Add the Samsung Exynos xHCI Controller bindings with DT schema format.
> 
> Signed-off-by: Daehwan Jung <dh10.jung@samsung.com>
> ---
>  .../bindings/usb/samsung,exynos-xhci.yaml     | 25 +++++++++++++++++++
>  1 file changed, 25 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/samsung,exynos-xhci.yaml
> 
> diff --git a/Documentation/devicetree/bindings/usb/samsung,exynos-xhci.yaml b/Documentation/devicetree/bindings/usb/samsung,exynos-xhci.yaml
> new file mode 100644
> index 000000000000..c5dde53b6491
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/samsung,exynos-xhci.yaml
> @@ -0,0 +1,25 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/usb/samsung,exynos-xhci.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Samsung Exynos xHCI
> +
> +maintainers:
> +  - Daehwan Jung <dh10.jung@samsung.com>
> +
> +properties:
> +  compatible:
> +    const: samsung,exynos-xhci
> +
> +required:
> +  - compatible
> +
> +additionalProperties: false
> +

These do not look like complete bindings... What type of device has no
resources at all, just compatible?

Best regards,
Krzysztof


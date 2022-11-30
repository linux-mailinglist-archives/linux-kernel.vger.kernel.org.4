Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DF7363D8C3
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 16:06:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbiK3PGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 10:06:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiK3PGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 10:06:41 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F453AC2D
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 07:06:38 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id g12so27422668lfh.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 07:06:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mD5gyl5+b2VI0JIPzsNKHhXJF/y5xF11ltR47Z8/CH8=;
        b=oSHSzMOkqi2ULxDEknrTYbZeynICh+gdMFA21eNeCDsPvbrobTAF2Y4OodCGyb18jZ
         IWMtFH/cUN+PWmzaUjxmHz6VDRWV+FUJX0XgsRis5qc/rmZVgiUZPdfnz9FkBAcix+gO
         SoIB0VU/tk5lt0Lwrn6TWFZTOJ6wNeY7XQvm2JHZGza7GP/QG5+UHpJ5KaWySoZ9amtl
         0895/ArT79dRg3NfgylLSNqg51XzcODqoUj7fAKFF/hj9Kxf76w3rrAYNRUh0AMbOmv0
         Kk4aztg2U2MPRpv44Jqvl3rjFuUlso/qdpKnQwhgmZLjM76KMSb14jjiB0T579LRP++r
         b/NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mD5gyl5+b2VI0JIPzsNKHhXJF/y5xF11ltR47Z8/CH8=;
        b=Vc/+BCkRsxi1Pj93tUfhTBrWU0KX/oelABaVCCJiUU/hHbjvF4dqf+dAArsuEBwJrm
         GdX6GTGxzvKEa4tYgWWRSF+EavDzOUG8WwG0s6YSyfjXW0i7c/raxaKrGRs5tMu5lPU/
         iEmrdSHjDzrJFDpfacAtNTh02BsEaHe0YWqj6LmlPxg8oqQ7T67sdNh2Ldhb7PPxW2xw
         k6Dh5avLQtDguaeRE+ywkBsGYG0UzdfkA8Tw154M/PJeoXHMS9fZvwRBDjZDD60Cxfgq
         x/kLlksAMY8XnYkSYqMjv99YJmGNxXwJOsrOGpFJXVIh6GTfq8BEyI/ZGDjQSLLcPXER
         chMg==
X-Gm-Message-State: ANoB5pkB3UPmr+Fn8qdPnJNXMGmt36Qpp1Ed/ao/Hx6e8acELqvdr48H
        hbt3yUAGfzwqFJr54huNZGtGMQ==
X-Google-Smtp-Source: AA0mqf4nL3MLFe+IlKOkDsmG5VgRiyNMxuwWch2f0SyPSpggGsXRm0nzcU+d/xz6z4J09NdlJKJMYg==
X-Received: by 2002:a05:6512:401f:b0:4b4:b78a:ad8a with SMTP id br31-20020a056512401f00b004b4b78aad8amr19178620lfb.249.1669820797086;
        Wed, 30 Nov 2022 07:06:37 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id s18-20020ac24652000000b004b0a1e77cb2sm286567lfo.137.2022.11.30.07.06.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Nov 2022 07:06:36 -0800 (PST)
Message-ID: <53a48f27-9eb9-ee9b-9dca-1911ea6e54a2@linaro.org>
Date:   Wed, 30 Nov 2022 16:06:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 1/3] dt-bindings: mmc: xenon: Add compatible string for
 AC5 SoC
Content-Language: en-US
To:     Vadym Kochan <vadym.kochan@plvision.eu>,
        Hu Ziji <huziji@marvell.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Elad Nachman <enachman@marvell.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
References: <20221130133747.3777340-1-vadym.kochan@plvision.eu>
 <20221130133747.3777340-2-vadym.kochan@plvision.eu>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221130133747.3777340-2-vadym.kochan@plvision.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/11/2022 14:37, Vadym Kochan wrote:
> AC5 SoC has Xenon SDHCI IP, but with a limitation of maximum
> 2G DMA address range.
> 
> Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>
> ---
>  Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml b/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml
> index 3ee758886558..e1178a49f264 100644
> --- a/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml
> +++ b/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml
> @@ -25,6 +25,7 @@ properties:
>        - enum:
>            - marvell,armada-cp110-sdhci
>            - marvell,armada-ap806-sdhci
> +          - marvell,ac5-sdhci

Don't drop entries at the end, it's easy to create conflicts which is
also easy to avoid by putting them in alphabetical order.

Best regards,
Krzysztof


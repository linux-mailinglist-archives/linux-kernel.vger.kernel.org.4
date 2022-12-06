Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3EB644A25
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 18:16:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233742AbiLFRQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 12:16:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235686AbiLFRQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 12:16:41 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60CA131EEF
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 09:16:40 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id h12so24410956wrv.10
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 09:16:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YROQFQEPWdBQIhB1n8gHD/kr10ieWa0trY98wElq/pc=;
        b=jhEJrHm2+Y6fhnfB8gQwOvXAWuM5bwEb2YzWwR5K7HQ3Lonzn2AOb31fX6mOuNd7Ar
         tMF+G6+I9QcXmIF4tjKQ2UUj7FVLLUWuvdf2T8h1gBO8MrLRae0grqUDHKNNTwGCjV0P
         ZzxM9JA9w1FQpR1/74tVbpiuciKwD4dRwS9v0MZciu3WhbG8PIctWytIbolS698ly4wV
         0hVDklgAYWfwNkPy+jfFl5gIJMGoueC40vz67x0WruDhrTCNXkPhrEG9wjQKz9N7I++n
         bEHOOt/pJRRwF7nsYfyQrdrYDfc9HDfTSiF87M4DI29qO2Qssdymxx3kDvmrVG7lmC1s
         zNqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YROQFQEPWdBQIhB1n8gHD/kr10ieWa0trY98wElq/pc=;
        b=62ipRuicZ/1cUTjAXo/CYZt52NYe263+iqzR1m6WcgCs03kcpj+FwRpdo5fflgEBit
         MJkJ9wXgAOQHYUjH/dnE6kKB+dmRN98Fz30EgbY0vau/7s2A8q2CKNSEOdiTzO2IT6hh
         sFsOrinLzeftYKOURELWXnOmf6FMrCfI9Cz6L/Pun4BwNKqOZn50PVamToY6Wn989iQP
         vG36zSfo9exwF2TaXmhxuY6gSeSEzXghPSDQWPzXaJ4Xi/w6XtalfSH8UEB6ue24fL/U
         XgJmybDC/LDqWgsUNi6BtO7vh9U+nlWJOsfiNa429JTRraeeF2cX5TGzEESTCC4YgR40
         7vyQ==
X-Gm-Message-State: ANoB5pl90kkCpCy+yky1Qz4pmEwLW4ky1zHPf+G4juiO6do8o6hiRWrY
        uuZxTysIN1oXe6g8fmycFcQE+Q==
X-Google-Smtp-Source: AA0mqf52MxkhhF+T1ebYV9lbdRoLZU3Xf4s/0EAmgmZvDSEXw/xIz0RpkpGEGRpktu+cAAj8q+zr/w==
X-Received: by 2002:adf:f1d2:0:b0:242:509a:ad49 with SMTP id z18-20020adff1d2000000b00242509aad49mr8804253wro.345.1670346998759;
        Tue, 06 Dec 2022 09:16:38 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id r20-20020a05600c35d400b003c6d21a19a0sm14941710wmq.29.2022.12.06.09.16.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Dec 2022 09:16:38 -0800 (PST)
Message-ID: <6760fd0c-bc83-4217-4e42-76850bb42b19@linaro.org>
Date:   Tue, 6 Dec 2022 18:16:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] dt-bindings: thermal: rzg2l-thermal: Document RZ/Five SoC
Content-Language: en-US
To:     Prabhakar <prabhakar.csengg@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Biju Das <biju.das.jz@bp.renesas.com>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20221115121629.1181667-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20221115121629.1181667-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/11/2022 13:16, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> The TSU block on the RZ/Five SoC is identical to one found on the RZ/G2UL
> SoC. "renesas,r9a07g043-tsu" compatible string will be used on the
> RZ/Five SoC so to make this clear, update the comment to include RZ/Five
> SoC.
> 
> No driver changes are required as generic compatible string
> "renesas,rzg2l-tsu" will be used as a fallback on RZ/Five SoC.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
>   Documentation/devicetree/bindings/thermal/rzg2l-thermal.yaml | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/rzg2l-thermal.yaml b/Documentation/devicetree/bindings/thermal/rzg2l-thermal.yaml
> index 1d8373397848..03f4b926e53c 100644
> --- a/Documentation/devicetree/bindings/thermal/rzg2l-thermal.yaml
> +++ b/Documentation/devicetree/bindings/thermal/rzg2l-thermal.yaml
> @@ -17,7 +17,7 @@ properties:
>     compatible:
>       items:
>         - enum:
> -          - renesas,r9a07g043-tsu # RZ/G2UL
> +          - renesas,r9a07g043-tsu # RZ/G2UL and RZ/Five
>             - renesas,r9a07g044-tsu # RZ/G2{L,LC}
>             - renesas,r9a07g054-tsu # RZ/V2L
>         - const: renesas,rzg2l-tsu

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


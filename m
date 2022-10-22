Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92EF9608E9B
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 18:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbiJVQlC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 12:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbiJVQk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 12:40:59 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14FB012A360
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 09:40:55 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-13b23e29e36so6518931fac.8
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 09:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QimVpA/xM2p/9j3XXOHUnzRFMhzXweEIX7clrlOcGUQ=;
        b=o+6YQHDqxfQ77fvo5cXuuxEeb5dlFfOxXjR6kMONmcT19bbfftY0EdoCunrFd3IiL5
         S++EQZf212jX8dkzq4URwqiy7j676j3qJXZIqqUTaxCT55a+c0JRLA7Awz2A3YKqLJJa
         G1rCq0Ixlvg4uCi/zDh0yGuFw5YivJRA+EwOIENc1Er8SQbJJIRqYEZPFNb6gW68TPl2
         IlIVHNg3eg/l4A1SixjNDgDWxRAOZv3PKTuzkvBWtZ1UF+cYSUivpiPtrix4Lr3qsIlY
         pMMe0sQukUMff4mJBuv3M9forRPewkx3LARIRXhHWZqqyvYLOJHBkKnbdpT1m0dsQG7R
         2u9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QimVpA/xM2p/9j3XXOHUnzRFMhzXweEIX7clrlOcGUQ=;
        b=ZeXVA9YG+WXDK2JyJZSEZeE6H2tiI02/HMUAt8EqbPZnOYSLPh2BZhAW0O6Rhld8Iu
         XfO6a9eCAOopfLfcKWggHXXsXEe0foPEYXfMajpB/rpIaHJm43D2NBZOqt/MGNZ5AfYG
         gxu6jx+qwJIwcKfWbA8uDns8RSK+17Gc//BhHSxCW+2hxONN+LkNwiREDSUZGZ+oQ9hJ
         QxPhrrAPSY14VC6hBDFpfj+vVyMFhEpO4is0UNEQoO+mzXYr3Abw1Hv01EyrJ7mU+v9I
         cQ3KoMuRFjcnovTphmsPLHjZSXxlXcob0j89Y1xQ/VCkWN4gWPcdzid8TnDCsRNgzp72
         KIoA==
X-Gm-Message-State: ACrzQf1rRgpgxSFW2p2SR7svafkN5UiEsi/BANhbX1C/7ne5SfGWaxkk
        bJ3mg3swWoP7Ald0KxhAzCqZNVaCfLAjCQ==
X-Google-Smtp-Source: AMsMyM7uIMiMDP9LIvFuHmFBJXp+2jG1Qk2DYO4TCJxIdkO8uJ5uHD/aqmm/eNbNn/XxFS6AjiXvrA==
X-Received: by 2002:a05:6870:d29f:b0:132:bd27:825d with SMTP id d31-20020a056870d29f00b00132bd27825dmr16079326oae.99.1666456854450;
        Sat, 22 Oct 2022 09:40:54 -0700 (PDT)
Received: from [10.203.8.70] ([205.153.95.177])
        by smtp.gmail.com with ESMTPSA id h24-20020a4abb98000000b00480816a5b8csm9723350oop.18.2022.10.22.09.40.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Oct 2022 09:40:53 -0700 (PDT)
Message-ID: <168e88f0-4e9c-36c6-6862-207a10239533@linaro.org>
Date:   Sat, 22 Oct 2022 12:40:48 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 2/3] ASoC: dt-bindings: realtek,rt5682s: Add AVDD and
 MICVDD supplies
Content-Language: en-US
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>, Mark Brown <broonie@kernel.org>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        Derek Fang <derek.fang@realtek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221021190908.1502026-1-nfraprado@collabora.com>
 <20221021190908.1502026-3-nfraprado@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221021190908.1502026-3-nfraprado@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/10/2022 15:09, Nícolas F. R. A. Prado wrote:
> The rt5682s codec can have two supplies: AVDD and MICVDD. Add properties
> for them.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> ---
> 
>  Documentation/devicetree/bindings/sound/realtek,rt5682s.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/realtek,rt5682s.yaml b/Documentation/devicetree/bindings/sound/realtek,rt5682s.yaml
> index ea53a55015c4..ca1037e76f96 100644
> --- a/Documentation/devicetree/bindings/sound/realtek,rt5682s.yaml
> +++ b/Documentation/devicetree/bindings/sound/realtek,rt5682s.yaml
> @@ -90,6 +90,10 @@ properties:
>    "#sound-dai-cells":
>      const: 0
>  
> +  AVDD-supply: true
> +
> +  MICVDD-supply: true

Ach, unacked. Please use lowercase names.

Best regards,
Krzysztof


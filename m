Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5ADD608E99
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 18:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbiJVQkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 12:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiJVQkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 12:40:07 -0400
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C941046217
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 09:40:02 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id s125-20020a4a5183000000b0047fbaf2fcbcso857926ooa.11
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 09:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=545rw8ScXkRjDM5w17g+rHUKHirulTTV6OR0mlcZkMs=;
        b=p+u1HMt1MNKQryUWQThPkAqfoWTsH6KmsVL86mKRXhiNbd4KYLYPNB0hITHRvsRwHd
         IzyR+zs/k4J1jE3/73NH7BNwkqjMeqBkbUwUWNeX3r0x9AhIYFWRT18rQ8egR+JYtQlm
         CYZtZNpi2/fY0NRcNBaXILQT++KyzeZOC1hSAZJbEOILAN05eCqvX8VPU7VJwqow+RNF
         n6C7bRH8NrUgu18S0Co7xxLWzfbLaDKYbfIZlIxs/fxHa+SBYh2Alj0L3CE0TjZ5IQ1a
         c+7CuO8asdutbJ/33v8k6WhBNNYbe2ZEF42iqdFl7tUVH2f/Nv8NhWT0RSgBsMAdjX2c
         Fa3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=545rw8ScXkRjDM5w17g+rHUKHirulTTV6OR0mlcZkMs=;
        b=QPGLQhCsw001Y8l9beif+hM346mXrwAlyy7n284/bVZoji7SJwg9W3pFL2y+XBiYuF
         IY7oDqQ+C6A/w/QGbOWCwpYq/G8//dxPi1hZWTYFb0XEX7m6kr9tD9NyCHW3mMQ5d0S3
         4ozDkW3alAggeck+QO2NU828DgxdTHVwBVN4nZNymX+iEGyezxoSVsF6WaXB+EC4h7Lj
         lSmCGwlej4b8k62HA5WoDyBUg/AxfZaGIIqOtKqmv0528TxD/0vo7xjsaSXANOIPWYio
         /d7jQb9n43jn2p4qpQm5FzJtEJJwNDrPhFZ/ITnq8KjALTBoz3L5Sbfc2P+I9RnnqT2a
         15OQ==
X-Gm-Message-State: ACrzQf1jIDITGuKCP7x3Ke5/SQUIfy7B/Q9l4H4T/xpYlmx0CuIPM1No
        eMyALjn6Dp532ble0RHZseWfeQ==
X-Google-Smtp-Source: AMsMyM6eeoBGEQ7JBoltsek43vEM0SoXcCAlJEyNNtk9IE/VktMJh0yypxZafDKXkKPpq5EWdnbosQ==
X-Received: by 2002:a05:6820:1608:b0:480:fa39:568b with SMTP id bb8-20020a056820160800b00480fa39568bmr5753643oob.43.1666456802183;
        Sat, 22 Oct 2022 09:40:02 -0700 (PDT)
Received: from [10.203.8.70] ([205.153.95.177])
        by smtp.gmail.com with ESMTPSA id d6-20020aca3606000000b0034d14c6ce3dsm2306957oia.16.2022.10.22.09.39.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Oct 2022 09:40:00 -0700 (PDT)
Message-ID: <ae460461-5c20-9180-456c-8c01a4b1a7f1@linaro.org>
Date:   Sat, 22 Oct 2022 12:39:56 -0400
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
> +

How about keeping some order in the list of properties?


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8714A6877DC
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 09:50:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232240AbjBBIuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 03:50:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232135AbjBBIt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 03:49:58 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5EB77D2AE
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 00:49:45 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id q5so1035934wrv.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 00:49:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XO/313PKa/quHlf1vA620KOMVC2M76VWbgj7duhxhyE=;
        b=Rbsl3oe4l4bVGMdUTuZGoX5JU97gNvdHWPI34C33xa7xz+LVLH67BGnrgqEXSew9DE
         No7MLwYQBriaRfx20PLce8VtOcuHMgcEiP0guUAgkykJpS0ajOm9ipZDqIOPlC4wCc7o
         gYju68XMMYyacjPB6L7f8OwFzFIAYPmhGIEWm04FQH9noAUYm7FtOGed9dwNEUBrmL/p
         vVk/S6PELt2+1T0+mg8fnKUW6bTYtEa9JwwGbQaDHrziIi162MQqvlICPF9fYkpUZtk4
         0EINzUsHMi2Wa2HWhcP2UFuTccAa8EilbZbXoIPpIB7iVUZU3i5ZxrSsgPSgL7P+dnQ6
         aPBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XO/313PKa/quHlf1vA620KOMVC2M76VWbgj7duhxhyE=;
        b=h0gBWjv5a+vJxkFYB8DGFOFXJ8HxfhxH3S3XwuYhYHm2u8Cks+GJzOZLq0Q8A84ImD
         yysyiIIDUW0SMDB/WDt0JwgVbyUwTKRqOXV5ApibrHwUpr0PdcNuf7GxZ3SVWL4vF85c
         vcnDQyJTOn5WRpkKjy4twqBAqz5kbM67dCCGY2qUmV8jh5aJQsDigSup7KHfxXbpaYgs
         YtkcnOXZaP5AJpzmypX5JwawwV5lCmIJ/3+USxAV8U5QDrytCglD0f26BLePGevclGvB
         UQERRh14en/QfHPosz7yiF14VRdwCAFNqzZNFlUCx0YuZoE9Jsxo+5a+X9neNPgaVETB
         xsoA==
X-Gm-Message-State: AO0yUKV4XD/DBvKOVkMCMAm2GTtqlnh+70QU/pHLnEaD8ImG41mJAPsN
        YY2gQThHXNQ6+33zot9MfbICjw==
X-Google-Smtp-Source: AK7set8C6EplC+GLPgeYrYpBCPc+kd3wgqHD+GEr9Z5HZ1vIjOAfGzXiYGB2G5h8OVwcGMkXRZHmlg==
X-Received: by 2002:a5d:5c09:0:b0:2be:5c4a:de6b with SMTP id cc9-20020a5d5c09000000b002be5c4ade6bmr5451330wrb.3.1675327784237;
        Thu, 02 Feb 2023 00:49:44 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id v14-20020adfe4ce000000b002bfafadb22asm19949727wrm.87.2023.02.02.00.49.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Feb 2023 00:49:43 -0800 (PST)
Message-ID: <4047db6e-80a5-b5f8-a736-d481f8a5127b@linaro.org>
Date:   Thu, 2 Feb 2023 09:49:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] dt-bindings: pwm: mediatek: add mediatek,mt7986
 compatible
Content-Language: en-US
To:     Daniel Golle <daniel@makrotopia.org>, devicetree@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
References: <70fe0b606d988958b87f89828b8728e2f68eaace.1675278958.git.daniel@makrotopia.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <70fe0b606d988958b87f89828b8728e2f68eaace.1675278958.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/02/2023 20:25, Daniel Golle wrote:
> Since commit 241eab76657f ("pwm: mediatek: Add support for MT7986")
> support for the 2 PWM channels implemented in MediaTek MT7986 SoCs has
> been added. Also add the compatible string to dt-bindings now that
> they have been converted to YAML.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


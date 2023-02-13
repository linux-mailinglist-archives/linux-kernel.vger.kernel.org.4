Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 683156943F9
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 12:11:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbjBMLLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 06:11:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbjBMLKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 06:10:45 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B14A16AC7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 03:10:40 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id bu23so11746022wrb.8
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 03:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cVEzDErkGs8aTILHLiSdJ8j9F2zNeVhSjqm2e8q+c6c=;
        b=fOYM2usrBNeVrTpdV7XsolDXYksfRKfcgcAD6euLWKbzLI6xFCQ8rS8lY6ipp3s+gz
         Hq5kN2CcxY9XFVg7KrdU2QJtpVceIwiMhnellWBuQ4n5PxJyyEGgBCoRSNVFxWAGf/LX
         LwMZ4wNrVTQ+oT3B9MJHiNAK3YI4bwshI3DV1zRueCEzoey/lkqNyWX2qV+DvNWtpJro
         dU4MMYmmvRnTKqIK/UbuSV8vycSqmZSkWLjWrJxldr+t1B3cIwuCW1VKEgQhD4+PUwbq
         5k0zvcyzBRrbNgtkmOOJi/JXZ5Ba7QRG/8S2FHjCuaZuO7lYKAOB3pqypIMJaOiqBH95
         mRrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cVEzDErkGs8aTILHLiSdJ8j9F2zNeVhSjqm2e8q+c6c=;
        b=WLAVj3JP8Sv1ZQ5OwAcvR7W00fjdaI5MUK+dDcOwCrxu6cDFkATXGsqCHIFsE27fHJ
         DxnA9Aby5h9IaWx1k3T5QSzh/hAVKP5cYCCFkDHAIbYO/EGBq8AuvKW8quhCyzFMX70P
         4iYSOMnDGG8cu76kaNP24zBEFAKupryakBgFWIdkmrdtdGKAaYBc89bktJ57dPN3fFp0
         xdl/P9qwyK8w2pmPZbBiTnv4IWDf/8DlELPa++im0f5GIluwfUmCbg12Le0pH8qTNZXE
         S8G4QIdrPqHB+mo6CIm8SxN6sXK+pe6IO31zvZeC4BTPS28rUuGMXHtul89fybkDYj81
         Imig==
X-Gm-Message-State: AO0yUKXuJURp9K8mHUn0BtQpegE2o0c9KtTddYq702cJkF2BZI88lPZl
        PSdYuReDkCswrDEIGpAJP5KD4w==
X-Google-Smtp-Source: AK7set+KKnE9xKeA2tucSimKaN7ngFjHASHAM/b0TR7GKIu5p6g2HG3YCSQ8j1of2dPbBBX7L1u1Kw==
X-Received: by 2002:a5d:4e4b:0:b0:2c3:e6b8:8cec with SMTP id r11-20020a5d4e4b000000b002c3e6b88cecmr19722503wrt.49.1676286638754;
        Mon, 13 Feb 2023 03:10:38 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id y13-20020a5d614d000000b002c5526234d2sm4663826wrt.8.2023.02.13.03.10.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 03:10:38 -0800 (PST)
Message-ID: <5ebf96d9-689a-f915-29b8-31af891fc63f@linaro.org>
Date:   Mon, 13 Feb 2023 12:10:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 02/17] dt-bindings: arm: apple: apple,pmgr: Add t8112-pmgr
 compatible
Content-Language: en-US
To:     Janne Grunau <j@jannau.net>, Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Kettenis <kettenis@openbsd.org>
Cc:     asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230202-asahi-t8112-dt-v1-0-cb5442d1c229@jannau.net>
 <20230202-asahi-t8112-dt-v1-2-cb5442d1c229@jannau.net>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230202-asahi-t8112-dt-v1-2-cb5442d1c229@jannau.net>
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

On 12/02/2023 16:41, Janne Grunau wrote:
> The block on Apple M2 SoCs is compatible with the existing driver so
> just add its per-SoC compatible.
> 
> Signed-off-by: Janne Grunau <j@jannau.net>
> 
> ---
> This trivial dt-bindings update should be merged through the asahi-soc
> tree to ensure validation of the Apple M2 (t8112) devicetrees in this
> series.

No, the bindings go via subsystem. Just because you want to validate
something is not really a reason - you can validate on next. Don't
create special rules for Asahi... or rather - why Asahi is special than
everyone else?

> ---
>  Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml | 1 +
>  1 file changed, 1 insertion(+)


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


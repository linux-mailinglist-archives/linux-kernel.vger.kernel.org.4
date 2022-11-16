Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2331662B479
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 09:03:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233024AbiKPIDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 03:03:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232966AbiKPIDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 03:03:35 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0221D3A0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 00:03:34 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id u2so20780079ljl.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 00:03:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h0SEv5+njF+NHP7in5GWyHvs6+61ZdhKoUhW5pFUx6k=;
        b=JU1gIejpkKuUWbOJmZBiobS407EzSG2JN6btj1k5B5e48yWLAXwm84GVv2d8W4iCZE
         kuKGaJWb+aTKp//7ft3khW0XVRwYMlFZZMOCdCuVesm3nYyBsrMeW4m8Te2/DIQbvP6U
         nQV3h5oqhDklhTK6HBHnPIvXA3MdMiAXdmS66UmhUVB3kb5ffCDupq7ergXreNJ5vVMO
         HHA10COZNV7xjmZUkKPrzSZ2ihSgA2RrSra0GUf2n+86/ao0Hhnk8PUsnWkgUcIqkcF3
         0TZW11CtAvL6MJUNxOcLlwCvAXM/3WGsNIP3/4PcGg+R6TFoUgMMtCTDXnuNSvEQ8Ky1
         MxnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h0SEv5+njF+NHP7in5GWyHvs6+61ZdhKoUhW5pFUx6k=;
        b=NJqaIyIfrxlBNFXPmj3crr/CxCkUjZl3UJ5f1ZofzkYKaTlhBAOPP9qVkjBasiYmxw
         d34NpuqMVNfxuXA+060C3An25udeqp3Ug1kasPKHSvRbJdLpRgEWTicKQVdT3zraD296
         VNE8bMpRFo6r5+GSpf1BTG+72+KfCV7ONdePFY6lLACygCBBNO6ypbKLAfBJvC49H15s
         o9M16oLMFnHhSkbAMRuEWi/q5i1FWwe66ZeXNQV2VK2bmE6AVe8jfgfPnNOHLw/9FQpt
         nyrK8y6G5n5ntAk70CBEzIJfDch8mCZqbaVKSz1CMExn3Y9WvuLGLoUf6RcR+6WM/dFH
         j3NQ==
X-Gm-Message-State: ANoB5pnBnOmXYwBo0L1NSLqFyETPJoVFrxMDwAReBE1CLoynO6MHQpOu
        WrhAWyT51qh5QXmCw42+IGVogg==
X-Google-Smtp-Source: AA0mqf5tzrv9NDMC+SYz6A93cuTjMOX8upQj3+hLyU1Z+1nYPCDI3NcXemsbgnBGl2BdqoI4g/3tig==
X-Received: by 2002:a2e:300c:0:b0:277:524c:f83d with SMTP id w12-20020a2e300c000000b00277524cf83dmr7704707ljw.217.1668585812252;
        Wed, 16 Nov 2022 00:03:32 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id f30-20020a05651c02de00b00277045dcb5bsm2860501ljo.97.2022.11.16.00.03.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Nov 2022 00:03:31 -0800 (PST)
Message-ID: <03e16d55-0110-bc3a-705f-a2a47d2876cc@linaro.org>
Date:   Wed, 16 Nov 2022 09:03:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] ASoC: dt-bindings: sun50i-dmic: Add D1 compatible string
Content-Language: en-US
To:     Samuel Holland <samuel@sholland.org>,
        Ban Tao <fengzheng923@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev
References: <20221116034621.37762-1-samuel@sholland.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221116034621.37762-1-samuel@sholland.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/11/2022 04:46, Samuel Holland wrote:
> The Allwinner D1 SoC has a DMIC codec like the one in the H6. It appears
> to be register-compatible with the H6 variant, and the existing Linux
> driver has been tested on a D1-based board, the Lichee RV 86 Panel.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


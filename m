Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0D79676D32
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 14:46:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbjAVNq2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 08:46:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjAVNq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 08:46:26 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 030BB17CF9
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 05:46:25 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id z5so8595002wrt.6
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 05:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mFFimDQzUT1PUoeHrXHw69cxuwe+XSqmYUr+SVIxlF4=;
        b=vQPJK9GFuxfc92n1GVN7YgZabgxrYsm9G+/j3rlPaQ+VnwW4W5IF9cZpQ8ETyHdmjD
         FULKS758vNRCthYOimn2dQv4CO1bpBGT4dZ32TLvC5MIOWwDBBJuZIxmyW9T2+KV6ntG
         s0lQQxZx/ECV5nLd7lAq//Q64KD6vuCw36+XTa2bFNItJfwQaiZ54/j/y6BW06ZFF/vg
         WbNhxuzQDc3+o+UwdNS2Lean2nfY5+pEN/b1mvaf+kgTInzFCgIaznnp+8gWnFF/1ocs
         XLFV7V/U4G8nRnLpyixRGhSJdPaT94FGlId85vS8/gf5Tc70iMGDBfQ8I19WvmggMXuB
         JJ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mFFimDQzUT1PUoeHrXHw69cxuwe+XSqmYUr+SVIxlF4=;
        b=iAxbnw6Yi48hIpTb2NYEbSIwFGeYWbm5lrwXihYGlxSqgpNqQwqRDpsQFTkxOOV8ie
         TSuLpzGe5DL0dkrAqs+P3FqKN3xgXR3VieBUNwW1Ue3pPydN7EYdFgCKC5UrCFc3Dv5x
         UiYjyxfVVgCfhVy+X703G2hoZDEHm+saSHIKJFseVQtd59YLrMafNs/KqkEud8KvZ71y
         gqRHgz1gbKcLW8m0DNpa4hPeGE0cFrD2/pFKRcvndvvq3nHy8vlXDdZQDcH8j6GYfyMx
         bFdtV8aqXZlqSKdVg1tYt3ii7S3tbShn6HW2Fqn3ipnyo0t9fMqdANNeoyiKNhFFy3Wr
         XVnQ==
X-Gm-Message-State: AFqh2kp5duS/iCFqIR4Nao/AffMJZQadSHu044mO1FBbLsej8fBrAq89
        Ht45twTIEi8R6rVmRCMD1VTEew==
X-Google-Smtp-Source: AMrXdXsmHGxxuzbOxrsyoftSwkYKBiSqeEBXUurIb/qV9nizgaB3FVmhg7YCwlBr64dr3O6+IzdBPg==
X-Received: by 2002:adf:dc81:0:b0:2a1:328f:23aa with SMTP id r1-20020adfdc81000000b002a1328f23aamr18765409wrj.6.1674395183571;
        Sun, 22 Jan 2023 05:46:23 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id m15-20020adffe4f000000b002bdd155ca4dsm26032092wrs.48.2023.01.22.05.46.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Jan 2023 05:46:23 -0800 (PST)
Message-ID: <443199bc-1188-f3a2-b842-a941d91e1dd1@linaro.org>
Date:   Sun, 22 Jan 2023 14:46:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v2 1/3] dt-bindings: sound: Add Renesas IDT821034 codec
Content-Language: en-US
To:     Herve Codina <herve.codina@bootlin.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20230120095036.514639-1-herve.codina@bootlin.com>
 <20230120095036.514639-2-herve.codina@bootlin.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230120095036.514639-2-herve.codina@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/01/2023 10:50, Herve Codina wrote:
> The Renesas IDT821034 codec is a quad PCM codec with programmable
> gain.
> 
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> ---

Thank you for your patch. There is something to discuss/improve.

> +  gpio-controller: true
> +
> +required:
> +  - compatible
> +  - reg
> +  - spi-cpha
> +  - '#sound-dai-cells'
> +  - gpio-controller
> +  - '#gpio-cells'
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    spi0 {

I didn't notice it earlier - this should be just "spi".

With above:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof


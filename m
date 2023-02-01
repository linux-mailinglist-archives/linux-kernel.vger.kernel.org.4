Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CDF5686675
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 14:13:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbjBANN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 08:13:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232068AbjBANNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 08:13:55 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F79F37F25
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 05:13:51 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id k16so12649489wms.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 05:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NBVSqHRFtG/oRQBhwtv4eQUlLsJwKfgYGxR//a3EtVY=;
        b=CawsGJou9VXLSTLiSbX94s6GV0QPhhZLeRf5TV1XVsktftepDsXJYJblOBAdRuQB9o
         rmE+KByzfmAVrZctCx3YP7a2gNbfNWKpVs5EfjJoYQxQOJV/kkBP465DkNhH0cS9+73E
         /LOxy8+De01bfA5Vp+5bTC9yeqs24OTuY1iFUivKuSkQAc1gegbgJdwpvw3WeOCg65k0
         DHUz+knydv1eaoUm0WZFLJYbpCwqQsq38571FXTWd86VI/y9fdgZBwCjX0kmTLzRLQeP
         ENbI4oAdMAh59CWpPwkevxfGUzsvMXRr5MSmwYRIh8EaUr1Lu55D4+SVdtLBa9K6ifTw
         XkTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NBVSqHRFtG/oRQBhwtv4eQUlLsJwKfgYGxR//a3EtVY=;
        b=GVAt2/oi6daUfqLFaMJyzuMr+6DNl44Ab0H4qsmLTrO7D64H8jnVFdIakqnfMV0RA/
         tQD3dZlBVbexUeuOJ6h5kYbqb9X+V5LrHKW/npNwdLT+Y4hWOAd6R5NaWNP+IBdPwF19
         6yyOReEUM1JjFk3jZG7G4f07OmKDBFr3n6V4KAsQs6XC33oDTTzMLGkiN6px8kmWnkUN
         KRwkjD37qo7DvRLEMcHDB9NcgsyO00TzTBTJTqncCjK5YDslbKWj+X4T+w114JJCNw22
         PewaV0mW3X3JBLQ3om4kyJjBUmQrMxW0xFAnkgvjv3mmUfk5Mgz8Qex00n3xQuulQBuu
         b3yQ==
X-Gm-Message-State: AO0yUKVTcqeDlavkGZG9Wr3VjIij6ZsALE76jM9J6N6oESZwsSDt25fD
        IR2JonxVK9XS2LLjnel1CE1G1A==
X-Google-Smtp-Source: AK7set+yf3Nsm5C9ZeM11L6U4K6PWqyZeCiqzJ6QeAuVfoj2t+QoDJCDauh2FgNVUvOi6P2O7Ttkww==
X-Received: by 2002:a05:600c:1c9b:b0:3dc:5240:53b6 with SMTP id k27-20020a05600c1c9b00b003dc524053b6mr2211877wms.6.1675257229667;
        Wed, 01 Feb 2023 05:13:49 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id o9-20020a05600c4fc900b003dc1300eab0sm1965656wmq.33.2023.02.01.05.13.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Feb 2023 05:13:49 -0800 (PST)
Message-ID: <1bcd61d6-810f-1239-1b6e-367e0fe87370@linaro.org>
Date:   Wed, 1 Feb 2023 14:13:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] ASoC: dt-bindings: Drop broken irondevice,sma1303 binding
Content-Language: en-US
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Kiseok Jo <kiseok.jo@irondevice.com>
References: <20230201131059.65527-1-krzysztof.kozlowski@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230201131059.65527-1-krzysztof.kozlowski@linaro.org>
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

On 01/02/2023 14:10, Krzysztof Kozlowski wrote:
> This reverts entire SMA1303 submission:
> 
> 1. commit 1c24d12b68fa ("ASoC: dt-bindings: irondevice,sma1303.yaml: Fix about breaking the checks")
> 2. commit dcf6d2ef0e82 ("ASoC: Modified the schema binding and added the vendor prefixes.")
> 3. commit 5b28c049ff53 ("ASoC: SMA1303: Fix spelling mistake "Invald" -> "Invalid"")
> 4. commit 68cd394efd0f ("ASoC: The Iron Device SMA1303 is a boosted Class-D audio amplifier.")
> 
> Because the binding:
> 1. Was never tested,
> 2. Was never sent to Devicetree maintainers,
> 3. Is entirely broken and wrong, so it would have to be almost rewritten
>    from scratch,
> 4. It does not match the driver, IOW, the binding is fake.
> 
> We cannot accept drivers with broken bindings and make it an ABI.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

I understand that in general we tend to fix, not just to revert. But the
poor quality of this binding and the next patch, which was suppose to
fix it, plus complete lack of testing, means I do not believe the author
will send correct binding.

More over, fixing binding might require dropping incorrect properties,
thus changing the driver. I am not willing to do that, I doubt that
anyone has the time for it.

It's the job of submitter to work on it.

Best regards,
Krzysztof


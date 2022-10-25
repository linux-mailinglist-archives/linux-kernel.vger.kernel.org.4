Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7DF60CBA5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 14:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbiJYMTJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 08:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbiJYMTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 08:19:06 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52BB9181CA2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 05:19:05 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id w29so231935qtv.9
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 05:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qKDSkNGJdreMgm3y1fnkqMMOtoJ4CwGZ1aA+ETdnP5M=;
        b=HMcCNMgIMtRibFlfaeFOC1TUxpXIRLqgkjuYOfbW0nQP1Mg0YUKXcGkFu4ff4vS1/u
         7hSPHlr0F3rKCnREdTn/8uLk3gQQIyo/RTeCrE5ZBndZLlc7DfJXXOZUUaq4px+0VCLa
         Cv+smwbwojc282ovhmlzY+/caN8iDoi643eGii2QDUNTZub2jYSM0JvLAf1lTV/8BGUZ
         g51ttsT1CZvYC7a+ckbuUN7gsaCvJYPG5seh+/HYx1gfN77Cf7SkOXtA4LohMQUQ15PV
         jUdfp3aASg/HT7frCeDgDOYO8KF0XomYyfu8vpq2n2XGDLPdnQmD7jkMyKiBRyWACwuI
         xfLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qKDSkNGJdreMgm3y1fnkqMMOtoJ4CwGZ1aA+ETdnP5M=;
        b=Gc37BtvJe43WabRjthz468L0p52xBpZmTFvnzpMyubyBqijtMKH9v/Y8bOcdNRbzQE
         e/9RKk5YrFrcsJiyj379xlzBN6zQm5vYfP1LhXFNSRc0ChQTOPQ93wefcjVwVBM5YaUn
         U5rf+Qi42RnnqOtT34wKN7ROKgW6SAU3AHj5h47Mvjqe4qNOr0XpZwZfuuTs3lmNVUSv
         BZsTUqygo/tQG3L8Zl7vpqplW2nEx9KWTIbGK67XyDU5/fZSNGCMdv5K3vv5NYkA3ngj
         diJXqBKSFAiAQw1+lCMwX2LTmn0Yz2b+KeYSuP1381w+9LQ+LBIPJl64n65xSyaYUGB7
         wmVQ==
X-Gm-Message-State: ACrzQf1OPgdYz3v4GkOTN9/20b0+z6rEDuhoTZxjRr7DWH6B4wkqUTVY
        E3I6nd8ZVJbRXQ+DN/INRs8MWTlOQwVNRw==
X-Google-Smtp-Source: AMsMyM6CmOT2i+snHgfCM1wCFxDmt74cMIkOkNAQxWTW3eEk0hFvMogIjQc/QEtbABWr5V5GhkSnng==
X-Received: by 2002:ac8:5f10:0:b0:39d:290:3f6e with SMTP id x16-20020ac85f10000000b0039d02903f6emr26321959qta.108.1666700344432;
        Tue, 25 Oct 2022 05:19:04 -0700 (PDT)
Received: from [192.168.1.11] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id l4-20020a05620a28c400b006ecf030ef15sm1956757qkp.65.2022.10.25.05.19.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Oct 2022 05:19:03 -0700 (PDT)
Message-ID: <38205667-d36f-e7a9-21b0-2e8597a662ff@linaro.org>
Date:   Tue, 25 Oct 2022 08:19:02 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v1 2/2] dt-bindings: ASoC: simple-card: Add
 system-clock-id property
Content-Language: en-US
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     broonie@kernel.org, lgirdwood@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        kuninori.morimoto.gx@renesas.com, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221022162742.21671-1-aidanmacdonald.0x0@gmail.com>
 <20221022162742.21671-2-aidanmacdonald.0x0@gmail.com>
 <ef6a326b-5c61-988b-2ec2-cd8e233e5d28@linaro.org>
 <GMvEU8xVTkjIoQ518XWAaLkhldSZHlk7@localhost>
 <4ef59d94-d045-55fc-d531-c84e7edb8333@linaro.org>
 <hXRpArckbrXUelDdaJ3Y2SErmKiuycXt@localhost>
 <66c1a100-922e-4a33-e80c-fc80866acf03@linaro.org>
 <jZCUALhj8PoqVkuWdtLf8LnPAj1wDakF@localhost>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <jZCUALhj8PoqVkuWdtLf8LnPAj1wDakF@localhost>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/10/2022 05:14, Aidan MacDonald wrote:
>> Krzysztof
> 
> Device trees already use standardized enumerations in other areas so it
> isn't a new idea. Look under include/dt-bindings/clock. Every header
> there contains an arbitrary enumeration of a device's clocks. In fact
> most of include/dt-bindings is exactly for this purpose, to define
> standard values that are not "just numbers" but an enum, a flag, etc,
> with a special meaning. It is not specific to clocks.
> 
> There is no dt-binding for system clock ID, because prior to this patch
> they were not exposed to DT in any way. But the enumerations themselves
> already exist, eg. the IDs for nau8821 codec:
> 
>     /* System Clock Source */
>     enum {
>         NAU8821_CLK_DIS,
>         NAU8821_CLK_MCLK,
>         NAU8821_CLK_INTERNAL,
>         NAU8821_CLK_FLL_MCLK,
>         NAU8821_CLK_FLL_BLK,
>         NAU8821_CLK_FLL_FS,
>     };

OK, this looks good.

> 
> We would just be moving these into dt-bindings if somebody wants to
> use a codec with simple-card. Future drivers would add the enum into
> dt-bindings from the start because that's where it belongs.

And the remaining piece I don't get is that these are not bindings for
codec, but for sound audio card. You want to set "system-clock-id"
property for audio card, while putting clock from codec, which will be
used to pass back to the codec... so it is a property of the codec, not
of the audio card. IOW, NAU8821_CLK_* does not configure here the clock
of the system, but only, only clock of the codec.



Best regards,
Krzysztof


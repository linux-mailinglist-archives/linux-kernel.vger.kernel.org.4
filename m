Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90F7D698397
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 19:40:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbjBOSiX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 13:38:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbjBOSiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 13:38:03 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A903E0B4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 10:37:02 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id s13so2392311wrw.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 10:37:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sJGpVnZwHexfDIAUSv5f9IjD3WQOM7IBSTvntQ8PaFw=;
        b=sBau1Tyc7v+7oi4Z/rbpVXMc0paiMMziTYatESS1DT5ohRO7dZKLupWb4vGOTeT676
         RZUCxr+CTwxuKY4Qrhg6z1UujWy05I6FGXZn3is7rv5HTJuxHpVjR1EGnzjhWok+YRLx
         8CjcfIuFF4NkUTrmnHQsG52rDk+OevIfxuzo9Czy5WuNjn68hcPxgzUmovQl7XmSDmhx
         9wmlr69o9ULnOhazSdgk1Ygy6Q2RgphzWo1MOipHYCNb/UBaeJT1eh3eE4xPTKNrlZnA
         QBw42I3LwkVt3f7ymxXpxfMyI+UfhAoi12++ImphwqUUStut/qiDcNXfIg834HigdFjZ
         0LnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sJGpVnZwHexfDIAUSv5f9IjD3WQOM7IBSTvntQ8PaFw=;
        b=5oOFXY7bnAV19Sl5cX7FdYELZsEfrYHqUBQNu2WUUTTakl02af4ArEpE37BYP3daBZ
         PUm8c+hfRcWmjsOH+dWZ6ccPS2PNIKqSYQuFFe0AOyuiI2L7yhN3Vaz2i5yIgYmPh//F
         a/diHz+aC3hSIc7QuMTbk+Xav0fECx5cZYdfrhChHQJiysJygfxaRhGGtHWcl+5HHTzE
         eV8ETgjVbSHrSCZQelk6efs58U0BLx6uRb+rTlG9O2xsZQijPnkdOM/y3fR3pyuJN+cL
         hQlwcIPiBbQCXQo90EGW+jOK0hvHSSHWi+OcPtYh8m+HpMFfpwoPRp6TXxyiygDI6mG0
         PeGQ==
X-Gm-Message-State: AO0yUKU9Rd9vtr0jUvcI9r0xSpzwCdbELKK/jQvLgHCjAhRI5S7ZPnXW
        eM4ymI7TBYMmrXEFS/6u+H5xyg==
X-Google-Smtp-Source: AK7set8mG2u98ECOZQb9+/nLQnDGuY+QpgjSeYr2eRmjoEzTGrhECERQhi8HdBnhJAZFL7twfx++vA==
X-Received: by 2002:a5d:564c:0:b0:2c3:fd2f:f7d2 with SMTP id j12-20020a5d564c000000b002c3fd2ff7d2mr2443592wrw.52.1676486126584;
        Wed, 15 Feb 2023 10:35:26 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id d13-20020adfe88d000000b002c54f4d0f71sm11092704wrm.38.2023.02.15.10.35.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Feb 2023 10:35:25 -0800 (PST)
Message-ID: <12f2d6a8-e16f-5bac-10ee-035c1b4b0356@linaro.org>
Date:   Wed, 15 Feb 2023 19:35:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 4/4] clocksource/drivers/timer-mediatek: Make
 timer-mediatek become loadable module
Content-Language: en-US
To:     John Stultz <jstultz@google.com>
Cc:     walter.chang@mediatek.com,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        "Maciej W . Rozycki" <macro@orcam.me.uk>,
        wsd_upstream@mediatek.com, stanley.chu@mediatek.com,
        Chun-hung.Wu@mediatek.com, Freddy.Hsin@mediatek.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230214105412.5856-1-walter.chang@mediatek.com>
 <20230214105412.5856-5-walter.chang@mediatek.com>
 <1726f1d2-7411-2b49-79cd-f5aecff2d19e@linaro.org>
 <CANDhNCrYaepM3d-xHybqc9n5j0q0iMfPiTGPZKskEWjqjD6nRA@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CANDhNCrYaepM3d-xHybqc9n5j0q0iMfPiTGPZKskEWjqjD6nRA@mail.gmail.com>
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

On 15/02/2023 00:20, John Stultz wrote:
> On Tue, Feb 14, 2023 at 3:09 AM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>> On 14/02/2023 11:53, walter.chang@mediatek.com wrote:
>>> From: Chun-Hung Wu <chun-hung.wu@mediatek.com>
>>>
>>> Make the timer-mediatek driver which can register
>>> an always-on timer as tick_broadcast_device on
>>> MediaTek SoCs become loadable module in GKI.
>>
>> Other questions are unanswered. Please do not ignore feedback and
>> respond to it.
>>
> 
> Apologies, I know it can be a pain to repeat yourself, but would you
> clarify which questions were unanswered?
> My initial skim made it seem like the items you raised were addressed
> in some form (though maybe not sufficiently?).

Questions were:

1. IOW, does the system boot fine? What's the impact of this being a module?

2. It is not the first time there is a proposal to convert the timers to
modules. After asking, nobody came with a real study regarding the
impact of the modularization of these drivers vs the time core framework
and the benefit.

3. We need to tests that involve loading and unloading of such
modules to see if the transition between this timer as broadcast and one
CPU itself as broadcast happens correctly and system survives across such
loading and unloading of the modules.


All these emails or comments were simply ignored.


Best regards,
Krzysztof


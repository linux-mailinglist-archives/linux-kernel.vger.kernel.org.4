Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C38BE695FDE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 10:54:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232067AbjBNJyk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 04:54:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232063AbjBNJya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 04:54:30 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA841E9DD
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 01:54:28 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id h16so14972330wrz.12
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 01:54:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RgvF89o6ZcBymJMWYMDUfo/mipTfyd/qv7ZfD7kB7f8=;
        b=LYqKURiyfJTPtTDUTgxztjHHTrcwpBdRJ8gWzviECue8nZDvONWw7gmmrgFge8NIol
         rSdfPI7maNIwe/51tu3oE/x5h5O2bVV1NmXoPrVOEjyRKJkUtwYcB61sYZRlnQ0l3kCz
         Ne1DAW2AoBUvxARiGm3vr4xOugiZaLYc5HJ+PSnva4dPk1PuEFnoOJey2rnUWSjEosVv
         2oq/WOBf2udzzqHejwzw2y6QuCagUnvTY7yauoynbnxl3V2yDkIVo/l85yF/xNDUg2G4
         VIqQN2cXRELU219cc4krQJgMvzY4KKH4BG+EeaYxymLbgWlL3SnpTbxJJ7x5tEm30vnA
         /Fpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RgvF89o6ZcBymJMWYMDUfo/mipTfyd/qv7ZfD7kB7f8=;
        b=bFYwq2dSB19fudXyzU2hNZyS9laCghIwQwNzhFQeaWZir0lzSDh+z+/0HRHu3uDtmM
         e4LzgFgh2N2o5zbXN2xlshqhMowM1HZzBJq3XFs5kbg6d9lCUBRWdEWo9wqqug64NiTA
         EvFR6YN1gO9wL4CXw5LrYVxlhDuxXounID9L5WmVTtI5xHOx7aug4hrNGAu/BVL/3H7t
         DM5h4g3XXl1ZexSb7yZyCJTrvGx3ihGkmGklG+NHiOczXlbOrDhtMyF5ZcEqEOkrGNK/
         0yE5W3FhRK2P1kXA50r1nk8kfhm2ux6sp/3FxG7R3yApnkeBPG0utRmz5ow5y+QjAYw5
         jRLA==
X-Gm-Message-State: AO0yUKUrY5hzz+5QO9DpPXC5FPKxqP+qpLw/BL8tdjw/NwWsBV9uPYpm
        C05NRktwRJsv/jYPf12yWWFvSw==
X-Google-Smtp-Source: AK7set/k8I3ls3Dk3K9u1Ly5QLY21zRXzjLQRRJQp+VJzwjjdN22mbPH9pkx/RgZgoS2yCOs60bxwQ==
X-Received: by 2002:adf:e6c5:0:b0:2bf:95d6:4789 with SMTP id y5-20020adfe6c5000000b002bf95d64789mr1117227wrm.2.1676368467087;
        Tue, 14 Feb 2023 01:54:27 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id u14-20020adff88e000000b002c56046a3b5sm2624973wrp.53.2023.02.14.01.54.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Feb 2023 01:54:26 -0800 (PST)
Message-ID: <f224fc29-4954-60f0-3eea-0973a94b29f4@linaro.org>
Date:   Tue, 14 Feb 2023 10:54:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v6 3/3] watchdog: mt7621-wdt: avoid ralink architecture
 dependent code
Content-Language: en-US
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     linux-watchdog@vger.kernel.org, wim@linux-watchdog.org,
        linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        arinc.unal@arinc9.com, tsbogend@alpha.franken.de,
        p.zabel@pengutronix.de, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org
References: <20230213200519.889503-1-sergio.paracuellos@gmail.com>
 <20230213200519.889503-4-sergio.paracuellos@gmail.com>
 <f105c7a8-8821-1e7b-af46-13a46971db63@linaro.org>
 <CAMhs-H_Cd9F+UWWe+dAA89r_huX_srtsgjh1qus93nGehQN1AQ@mail.gmail.com>
 <7f2e556c-ee11-fe4e-f4d6-94c761f976d0@linaro.org>
 <CAMhs-H8Ls2oTZ8LYguCdizNZN3cUC8kKA4e_L6BD3C3cFDP0tA@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAMhs-H8Ls2oTZ8LYguCdizNZN3cUC8kKA4e_L6BD3C3cFDP0tA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/02/2023 10:50, Sergio Paracuellos wrote:
> On Tue, Feb 14, 2023 at 10:33 AM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 14/02/2023 09:54, Sergio Paracuellos wrote:
>>>>>       return 0;
>>>>> @@ -143,6 +147,10 @@ static int mt7621_wdt_probe(struct platform_device *pdev)
>>>>>       if (!drvdata)
>>>>>               return -ENOMEM;
>>>>>
>>>>> +     drvdata->sysc = syscon_regmap_lookup_by_compatible("mediatek,mt7621-sysc");
>>>>> +     if (IS_ERR(drvdata->sysc))
>>>>> +             return PTR_ERR(drvdata->sysc);
>>>>
>>>> This should be the backup/error path for original code using syscon
>>>> property. Looking up by compatible is really not portable/re-usable.
>>>
>>> I can change the code in the way you are pointing out here but...
>>> Why is it not re-usable? Compatible is not supposed to be changed
>>> since in other cases the DTB ABI will be broken. I am totally lost
>>> about what is an ABI breakage, then.
>>
>> How do you use it on other platform?
> 
> I see, thanks.
> 
> So if I am understanding you correctly I have to maintain the
> 'mediatek,sysctl' phandle and use it in the first instance and if it
> fails I have to use regmap_loopup_by_compatible() stuff, right?
> Something like:
> 
> ...
> 
> drvdata->sysc = syscon_regmap_lookup_by_phandle(np, "mediatek,sysctl");
> if (IS_ERR(drvdata->sysc)) {
>          drvdata->sysc =
> syscon_regmap_lookup_by_compatible("mediatek,mt7621-sysc");
>          if (IS_ERR(drvdata->sysc))
>               return PTR_ERR(drvdata->sysc);
> }
> 
> ....
> 
> So in that case, we can add the new phandle to the bindings without
> any kind of ABI breakage and we can use old dtbs using new watchdog
> driver code.
> 

Yes.

Best regards,
Krzysztof


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33C8A6DBA48
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 12:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbjDHKzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 06:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231182AbjDHKyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 06:54:55 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35CCFD522
        for <linux-kernel@vger.kernel.org>; Sat,  8 Apr 2023 03:53:29 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id ud9so1943894ejc.7
        for <linux-kernel@vger.kernel.org>; Sat, 08 Apr 2023 03:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680951144;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xzlcPDdhLXiZUIT0eAmMiOCXXvUXvy1/5/KTBOdWAJA=;
        b=X5IMUAXYOYOQUvk4BIOf4N93LRNKbzaBZ2CCaJlIorV7qKi1LeZi04eJHS5Y3tWRI9
         T1rvvMAeehVALKOuMV6OQEPhffODCKMrenoUs52NodUA1kM/l0kCte3CQlnNtZlMyvpt
         R7bH9G53BVQzSYzTH3ZYx+wGWGaIb+7nT+CwrTXecydJqyoI0QeVm90bLpCVumFP551C
         mXJdQ8QLGFmKlQ++S7Uo0YSHpVnN2c1pAgF6dXtgA54YFCUO3pNQLmyAoLBYnGaqdCMn
         FELx3+JtWHumMo7a+70dX8wNMpcSZnOjh1fPf/AcWA8ACtrT4o5JA4tZNTdmQ2QS3s8r
         fPjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680951144;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xzlcPDdhLXiZUIT0eAmMiOCXXvUXvy1/5/KTBOdWAJA=;
        b=0WWXZPjdAh48xwLj1gHX2p4+Pm7+OVg49fkoHsMBCREVWvUwccONWZoYh2TwZqVfDR
         ciMe11y8V4r0Hd8gsg0ew8sRl9WYC1wN6yD/9P8eU4CueSuyDM5BROtBmeQgi49oaph1
         XQWiUQa5MO43FZjJYAT9zzKPJLCzgyaDKW0JwQ9/ou8qg0Lw/um8oTp7oqPtsZlQOhit
         aAQSqxZYrR2WiUVq8O6bFJi1gB22ohyYX43A/1AL9WeyjZo+I7vW35H3RF29JubdgwA9
         jodwChzNmKdMeLMQQKTa3Ry33xW21Q4SbY2l+kh1/9X8zbud6AhCXpaQFthhgZqyti5f
         cPsQ==
X-Gm-Message-State: AAQBX9eaH5m2irTFMHjkB0L401iDCm/APm7kdV3q7URRfWjR8KqllL7/
        4ypLCJjAeZfzaCSu3JuH73Jgiw==
X-Google-Smtp-Source: AKy350anWXnwjZ5u8PEeIytE4Zu/+haX07IcVOOwbe2BuzCnQbj9FO4aSCg0Qqbw/RWcoxWvWSjjqQ==
X-Received: by 2002:a17:906:c085:b0:949:7c05:71b6 with SMTP id f5-20020a170906c08500b009497c0571b6mr2242272ejz.44.1680951144449;
        Sat, 08 Apr 2023 03:52:24 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:4c06:aac9:100f:9d7f? ([2a02:810d:15c0:828:4c06:aac9:100f:9d7f])
        by smtp.gmail.com with ESMTPSA id i19-20020a170906091300b00923f05b2931sm3023452ejd.118.2023.04.08.03.52.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Apr 2023 03:52:24 -0700 (PDT)
Message-ID: <6127f21a-9101-9739-f798-0a181d8a5fcb@linaro.org>
Date:   Sat, 8 Apr 2023 12:52:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 12/14] arm64: dts: qcom: sc7180: Fix trogdor qspi pin
 config
Content-Language: en-US
To:     Doug Anderson <dianders@chromium.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-gpio@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org, Andy Gross <agross@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20230323173019.3706069-1-dianders@chromium.org>
 <20230323102605.12.I6f03f86546e6ce9abb1d24fd9ece663c3a5b950c@changeid>
 <43b74b3f-e607-ba55-a5fa-326fb4b5519d@linaro.org>
 <CAD=FV=VvgbPKQsOirMa-k0PE-KAvjWy+iMWd0TCbysYirwEH7w@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAD=FV=VvgbPKQsOirMa-k0PE-KAvjWy+iMWd0TCbysYirwEH7w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.3 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/04/2023 21:53, Doug Anderson wrote:
> Hi,
> 
> On Fri, Apr 7, 2023 at 11:11 AM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 23/03/2023 18:30, Douglas Anderson wrote:
>>> In commit 7ec3e67307f8 ("arm64: dts: qcom: sc7180-trogdor: add initial
>>> trogdor and lazor dt") we specified the pull settings on the boot SPI
>>> (the qspi) data lines as pullups to "park" the lines. This seemed like
>>> the right thing to do, but I never really probed the lines to confirm.
>>>
>>
>>
>>>  &qup_i2c2_default {
>>> @@ -1336,6 +1340,22 @@ p_sensor_int_l: p-sensor-int-l-state {
>>>               bias-disable;
>>>       };
>>>
>>> +     qspi_sleep: qspi-sleep-state {
>>> +             pins = "gpio63", "gpio64", "gpio65", "gpio68";
>>> +
>>> +             /*
>>> +              * When we're not actively transferring we want pins as GPIOs
>>> +              * with output disabled so that the quad SPI IP block stops
>>> +              * driving them. We rely on the normal pulls configured in
>>> +              * the active state and don't redefine them here. Also note
>>> +              * that we don't need the reverse (output-enable) in the
>>> +              * normal mode since the "output-enable" only matters for
>>> +              * GPIO function.
>>> +              */
>>> +             function = "gpio";
>>> +             output-disable;
>>
>> Doug,
>>
>> I acked some of your patches, but I assumed you tested all this. It
>> turns out you never run dtbs_check on the patches you sent.
> 
> I'm fairly certain that I ran dtbs_check and confirmed that no new
> errors were introduced on the device tree files that this patch series
> cleaned up. Did I miss one?

You missed everything.
Before the patchset almost all pinctrl bindings were passing on arm64
DTS. Just one or two things to fix.

After the patchset: many new warnings.

>  I did not try to go through and fix all
> examples of people using "input-enable" across all Qualcomm device
> trees, though. 

You introduced new warnings, so it is expected to do.

> Those old device trees still work even if they're using
> the now-deprecated bindings. When deprecating something my
> understanding is that it's not required to go back and immediately
> transition all old device tree files.

You did not deprecate anything. You disallowed property causing many new
warnings to pop up.

> 
> If having the "input-enable: false" in the bindings is causing huge
> problems we could do a blank search-and-replace to rename it to
> "output-disable", at least for places under "tlmm". Even if there are
> cases where it's superfluous it would at least make the bindings
> validate.

There are different ways to fix it, the point is that none of the ways
were used.

I fixed it up:
https://lore.kernel.org/linux-arm-msm/574d3aa5-21f4-014a-8cc7-7549df59ff3c@linaro.org/

https://lore.kernel.org/linux-arm-msm/20230407180655.128771-1-krzysztof.kozlowski@linaro.org/

https://lore.kernel.org/linux-arm-msm/20230407180045.126952-1-krzysztof.kozlowski@linaro.org/

https://lore.kernel.org/linux-arm-msm/20230407175807.124394-1-krzysztof.kozlowski@linaro.org/


Best regards,
Krzysztof


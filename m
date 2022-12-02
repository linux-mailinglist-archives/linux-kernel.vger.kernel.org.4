Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 693A06401D5
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 09:18:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232711AbiLBIR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 03:17:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232413AbiLBIRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 03:17:33 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB147BE4C1
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 00:15:29 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id n1so4596312ljg.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 00:15:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/px+LvYJzaoaf7RRQKWS3mp+8v8D/MKqP/mFZLMpENs=;
        b=mErH1q3uMcg41q+iFOJg66rz3zacepYi0JajAVUJhIySn2GC34kRmUj4E7uTlMbCpE
         hE0YZTGEpM+UNVMAZZlXr/fLt+dNn2xcJdzk/ajIDb/vpM4c2qPbXABhxfXNDHt+Q8vl
         /EuFkY7wm6YjUJLZtpN65hvH3wg5qBQwYJN1nZSNzC87l1dJ98uqRpqrI7/sQ1scoZR0
         OZlYzXiF18T2/VimwvXtmaLVUgxrEhQJSuzaihbSA77V64589OoZGEo7Y4PiMTQeL2wo
         0LWHzHbixxgKD7lC6I0cKD1Ze9c4ZWVJKF+jsc5gbZ+yRkU1F1rC7Pw6SFOghzZamOgs
         GqMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/px+LvYJzaoaf7RRQKWS3mp+8v8D/MKqP/mFZLMpENs=;
        b=4c1rNpO64La5DZZ/cbxcJsICO4p3mrf5/nSFBLPEhIe2WdeZvHBOst88Oj4i7ovt6M
         1e3jc9U/IBB6YuAmEfQUUHZp5oDHlnK6EL6Z8h4ZMYFwOwLPSEDSp6/F3j5h5znQq3D0
         pYsflnnpb0+L93tL2M+DnAElhTuErhYWjc1IaRgKOUqrhr/hRLfJdc4Aimnvz7p3NKDk
         GyUaxUCYkXop0nk2RM5jDSpElUJKLPVgujV9WI2XPg0gleNerSRbAqRIVxc6fBA+Xqra
         7lQvvGoCSllvL+2DpIQecSE/SS5sW1cnUy84b5asuEGSoN24RHqNGdK1kZI8wg10fjUY
         EDEg==
X-Gm-Message-State: ANoB5pmyfDREYcZgJ5h7NJT3BuISdExOa7wxnomahqv0flWKpCqn7MBA
        dsL+FFEhae6TC87jjymrXFPIcg==
X-Google-Smtp-Source: AA0mqf4XvBlOkqUGdKUZlk07Vazxmza9Y77vscbDeIcffVagSKwj/sVb7f58qGOa1zBhsuLgAbEYVA==
X-Received: by 2002:a2e:bf08:0:b0:279:7236:b80f with SMTP id c8-20020a2ebf08000000b002797236b80fmr15972659ljr.214.1669968928109;
        Fri, 02 Dec 2022 00:15:28 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id q12-20020a056512210c00b004b543f38b7csm479198lfr.21.2022.12.02.00.15.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Dec 2022 00:15:27 -0800 (PST)
Message-ID: <68bcdf25-e8e3-f817-f213-efb0bce3f43a@linaro.org>
Date:   Fri, 2 Dec 2022 09:15:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [RFT PATCH v2 2/2] arm64: dts: qcom: sdm845: align TLMM pin
 configuration with DT schema
Content-Language: en-US
To:     Doug Anderson <dianders@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Clark <robdclark@chromium.org>,
        Fritz Koenig <frkoenig@google.com>
References: <20221118164201.321147-1-krzysztof.kozlowski@linaro.org>
 <20221118164201.321147-2-krzysztof.kozlowski@linaro.org>
 <CAD=FV=XeaskcBRVRQDoha7Xiv9j57fuvtcSJUeN7HCZSGVJ8uQ@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAD=FV=XeaskcBRVRQDoha7Xiv9j57fuvtcSJUeN7HCZSGVJ8uQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/12/2022 01:50, Doug Anderson wrote:
> Hi,
> 
> On Fri, Nov 18, 2022 at 8:42 AM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> DT schema expects TLMM pin configuration nodes to be named with
>> '-state' suffix and their optional children with '-pins' suffix.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>
>> ---
>>
>> Cc: Doug Anderson <dianders@chromium.org>
>>
>> Tested on Qualcomm RB3. Please kndly test a bit more on other devices.
>> This should not have an functional impact.
> 
> Added Rob Clark and Fritz who are the only people I know that still do
> anything with cheza.
> 
> 
>> -       wcd_intr_default: wcd_intr_default {
>> +       wcd_intr_default: wcd-intr-default-state {
>>                 pins = <54>;
> 
> Not new to your patch, but I'm surprised it truly works to use an
> integer for a pin? How does it know that 54 is an integer and not a
> string???

Maybe it passes the checks as phandle...

Anyway, I'll fix it in separate patch, assuming this is GPIO54. On
schematics I see CODEC_INT1_N GPIO_54.

> 
> 
>>  &qup_uart3_default {
>> -       pinmux {
>> -               pins = "gpio41", "gpio42", "gpio43", "gpio44";
>> +       cts-rts-pins {
>> +               pins = "gpio41", "gpio42";
>>                 function = "qup3";
>>         };
>>  };
> 
> FWIW, I would have expected that the SoC dtsi file would get a "4-pin"
> definition (similar to what you did with qup_uart6_4pin) and then we'd
> use that here.

Sure.

> 
> 
>>                         qup_uart6_4pin: qup-uart6-4pin-state {
>> -
>> -                               cts-pins {
>> +                               qup_uart6_4pin_cts: cts-pins {
>>                                         pins = "gpio45";
>>                                         function = "qup6";
>> -                                       bias-pull-down;
> 
> After your patch, where is the above bias set for cheza, db845c,
> oneplus, shift-axolotl, ...?
> 
> 
>>                                 };
>>
>> -                               rts-tx-pins {
>> +                               qup_uart6_4pin_rts_tx: rts-tx-pins {
>>                                         pins = "gpio46", "gpio47";
>>                                         function = "qup6";
>> -                                       drive-strength = <2>;
>> -                                       bias-disable;
> 
> After your patch, where is the above bias / drive-strength set?

They don't use 4-pin setup. If they use, I would assume they will
override the entries just like sdm850 boards (where I override it to set
these).

Alternatively I can keep it in DTSI, but it is not really property of
the SoC.
> 
> 
>>                                 };
>>
>> -                               rx-pins {
>> +                               qup_uart6_4pin_rx: rx-pins {
>>                                         pins = "gpio48";
>>                                         function = "qup6";
>> -                                       bias-pull-up;
> 
> After your patch, where is the above bias set?

Best regards,
Krzysztof


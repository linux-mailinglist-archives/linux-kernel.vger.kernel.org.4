Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA7864884E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 19:16:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbiLISQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 13:16:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiLISQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 13:16:29 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CE19A6592
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 10:16:27 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id n1so5755576ljg.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 10:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JoijXwXZ/QMJ+MHmkZyk6ZNFTzCacwwN6Dw+3qiPXXU=;
        b=h+HpFt+vSKp8kV7WQ++6tCOuO+RtZ++ppnktlp1IbIk13aECw9XflFvc2XB5Yv+N09
         bgU57OdhcTCbne6b1N/EnY0OuW91EQgCes/7Xox9Z7prerMqRvKGVwpurPHkeX0B2Kvl
         9oRveEUnlks0l6TLSuDC4btGK/HyS1ZPam3qjzEVCOklNvgcJ2xojRD0bdHgBLPcycRR
         jukmzQ/cFEKEKSQI0DUGQ3WcQ8hsGCgI24lGieyDvzrvJGOl3CrONkYyAp9QFBfk2vpk
         jQabuwnUXPIQN3aAlsrIkqu6W2YLTVhtyJxwJbB5hYWBmwSkxErvRgNOXIsaHX0qJdHb
         kMFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JoijXwXZ/QMJ+MHmkZyk6ZNFTzCacwwN6Dw+3qiPXXU=;
        b=y3RO2TCpg5ifRf7O0grOzHd/4ymypGpLF9tgoEzWt5KpjZsSO4Te4OTYYJG3fHXC9S
         eq8ZvCII5fOVFqBz2QgB6vvufoZHWQ93qknk5A+TymXz+EVY+ztSLQKlQtxwPkpkAk19
         rsE9Ln5axyXzpJlKxN8NEmU+SupuG8eiJpZpfSZq8nJY4J6CCoaZmFL7ShKNF+nmL5Sy
         3qv8la0Bq/zP4aSSaxzrYI1vVdszyTVsXGmMjQsg7bMKhwOSeGPTEQZbclRTAUJbojT9
         F03nxe+iqYJGZ9lxfr2ypMeAQVnacY4pxYyW+mt6/m6mnPNGiOIu+PKlYeCduBNceSaU
         dx9g==
X-Gm-Message-State: ANoB5pk81l8RIJINnBjicZiBodFfGkVkjmufEYZMXQXkGxIqH5xEGxnz
        J5lIi/VRFYSlnh7R7jsrpTSIVA==
X-Google-Smtp-Source: AA0mqf5r3ZO5zIYlFZLUCjVtJaiX96hnOAEKv0jeiM/6xAWJJKHfLoffaNGAMOsEnOBRAEYra8d6lg==
X-Received: by 2002:a2e:9cce:0:b0:27a:1c5a:9faa with SMTP id g14-20020a2e9cce000000b0027a1c5a9faamr1898251ljj.24.1670609785903;
        Fri, 09 Dec 2022 10:16:25 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id i124-20020a2e2282000000b0027712379ec8sm302618lji.28.2022.12.09.10.16.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Dec 2022 10:16:25 -0800 (PST)
Message-ID: <0055a151-0f29-581f-f938-e7647105c3ec@linaro.org>
Date:   Fri, 9 Dec 2022 19:16:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v3 2/3] arm64: dts: qcom: sdm845: align TLMM pin
 configuration with DT schema
To:     Doug Anderson <dianders@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221202155738.383301-1-krzysztof.kozlowski@linaro.org>
 <20221202155738.383301-2-krzysztof.kozlowski@linaro.org>
 <CAD=FV=UPLssDromnt89RYbSEU9qq_t+CSyd5VhmD7b-9JkcMFA@mail.gmail.com>
 <c0b660bf-93c2-89b6-e704-17489efe6840@linaro.org>
 <CAD=FV=UjwDkgXXmVcV-XNsPKOGh=TVsQexC0YQoU-_fz==y+UQ@mail.gmail.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAD=FV=UjwDkgXXmVcV-XNsPKOGh=TVsQexC0YQoU-_fz==y+UQ@mail.gmail.com>
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

On 09/12/2022 18:53, Doug Anderson wrote:
> Hi,
> 
> On Fri, Dec 9, 2022 at 2:25 AM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 02/12/2022 17:53, Doug Anderson wrote:
>>> Hi,
>>>
>>> On Fri, Dec 2, 2022 at 7:57 AM Krzysztof Kozlowski
>>> <krzysztof.kozlowski@linaro.org> wrote:
>>>>
>>>> DT schema expects TLMM pin configuration nodes to be named with
>>>> '-state' suffix and their optional children with '-pins' suffix.
>>>>
>>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>>
>>>> ---
>>>>
>>>> Cc: Doug Anderson <dianders@chromium.org>
>>>>
>>>> Tested on Qualcomm RB3. Please kndly test a bit more on other devices.
>>>> This should not have an functional impact.
>>>>
>>>> Changes since v2:
>>>> 1. Bring back UART6 4-pin bias/drive strength to DTSI.
>>>
>>> Just to be clear, it doesn't actually belong in the DTSI, but it was
>>> there before your patch and it's fine if your patch series doesn't fix
>>> the whole world. I'm OK with this one staying in the DTSI for now just
>>> to keep things simpler.
>>>
>>> One change missing in v3 that I would have expected based on our
>>> discussion in the previous version would be to "Add UART3 4-pin mux
>>> settings for use in db845c." I think you said you would do this, but I
>>> don't see it done.
>>
>> Hm, I don't recall that. Changing db845c to usage of RTS/CTS is
>> independent problem, not related to fixes or aligning with DT schema.
> 
> It was in the message:
> 
> https://lore.kerne.org/r/68bcdf25-e8e3-f817-f213-efb0bce3f43a@linaro.org
> 
> I said:
> 
>> FWIW, I would have expected that the SoC dtsi file would get a "4-pin"
>> definition (similar to what you did with qup_uart6_4pin) and then we'd
>> use that here.
> 
> You said:
> 
>> Sure.
> 

Yes, indeed and it see now I still keep there cts-rts-pins. Somehow I
thought now we talk about UART6 or UART9...

However, the UART3 is disabled, so it will not have any effect, except
for some downstream users.

Best regards,
Krzysztof


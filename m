Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A55FF648E3E
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Dec 2022 11:58:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbiLJK6b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 05:58:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbiLJK62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 05:58:28 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68A73BCA4
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 02:58:27 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id x28so10909929lfn.6
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 02:58:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uLWU8UvLvUz+UPt+iZ/n8ZPOtKF07vffHOxQU5K8UgU=;
        b=i2HHBJe6E7SskkvjwwGFpNZwVVx0TRnRKxu8beDwoiGPo6OJeP6gATP0/RVtcEaJQ7
         zP8A3hYVq3BPi3KtNDi8sErXgidcrWNQkywjGheKVZdHIPVdnnpHlmx60i/xl4JwtsxZ
         eHwm8gvOvxY01n2flE4vZA5JyLYxMpBcH7Uy3j+u0dNSkORQ586JwnB2FOIbQ7Vdqbgm
         5g7napayHLM+VLqc5JTSI3h/8hEXGvtHZFiOdsRVrfkq3cun7nIOaPxIfSzFIHjAKdtp
         4JvdD+0RTSHLJkbAqCmbBkjZlXBfsvUmI/0tCIzUm2YrpCXTWVNpRdtY2D0alhOOPXFE
         4ZIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uLWU8UvLvUz+UPt+iZ/n8ZPOtKF07vffHOxQU5K8UgU=;
        b=nNwgoptahalD9fSQ/G+XyzRT9Z/JoTbMX+bjdx2HTXiOjtSCT5G54KM+tcZVZpC67D
         hBUsKdUimvNIFehOLxnF7OeBh8sgA3mN/0Fxb7Z0uB8mGfAH+NGaM7KbVrt4mCJ165nN
         KZja8XE5USWT13iFz5mA6akCYUt+hHsrAiSqiwbnxouB8j4ugznPkteBVVDibY946xm4
         qyZXh6SJC1xMVf+aaDvpTY5rJYhgmChP0m0AEGyFuxkymn4vMy1KEgK1u8+Y/qvS8Oo7
         SjG41QenzABjacGxJA8rctUb+slubiAg49ijthSAQOoz44SRHVdpUzNHjeCpBIP6ssA7
         JQBg==
X-Gm-Message-State: ANoB5pll/paCfgW/16Uplu2bW6iG3nz08EEBJwI+nlGFmcI4ybu9imsI
        udSjuQntKC4P9ByUB7yvG969yg==
X-Google-Smtp-Source: AA0mqf4fOIbUVu1NB5M9iRbvy7IONCEf0BukLaKFdJLcqL+0Ys3M22vqZKiOwMRi0e+4M9pHxMoMnQ==
X-Received: by 2002:a05:6512:224a:b0:4a4:68b9:19fc with SMTP id i10-20020a056512224a00b004a468b919fcmr3875677lfu.36.1670669905727;
        Sat, 10 Dec 2022 02:58:25 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id z26-20020a195e5a000000b004b55b404d36sm671211lfi.156.2022.12.10.02.58.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Dec 2022 02:58:25 -0800 (PST)
Message-ID: <4846bb5f-79a9-e199-6a1c-5021e975e7ee@linaro.org>
Date:   Sat, 10 Dec 2022 11:58:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v3 2/2] arm64: dts: qcom: Add configuration for PMI8950
 peripheral
Content-Language: en-US
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        Luca Weiss <luca@z3ntu.xyz>, linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        AngeloGioacchino Del Regno <kholk11@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>
References: <20221101161801.1058969-1-luca@z3ntu.xyz>
 <36eb03e8-aace-f7ce-edc8-53715021c0ea@linaro.org>
 <20221208112055.m7sqg3ysxzskqjp4@SoMainline.org> <5740737.DvuYhMxLoT@g550jk>
 <20221209203851.sy37qqzczoaruuyb@SoMainline.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221209203851.sy37qqzczoaruuyb@SoMainline.org>
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

On 09/12/2022 21:38, Marijn Suijten wrote:
> On 2022-12-09 17:54:50, Luca Weiss wrote:
>> On Donnerstag, 8. Dezember 2022 12:20:55 CET Marijn Suijten wrote:
>>> On 2022-12-08 11:23:17, Krzysztof Kozlowski wrote:
>>>> On 08/12/2022 11:12, Marijn Suijten wrote:
>>>>> On 2022-12-04 17:19:05, Luca Weiss wrote:
>>>>>> On Freitag, 2. Dezember 2022 10:36:58 CET Marijn Suijten wrote:
>>>>>> [..]
>>>>>>
>>>>>> So the way this patch does it is good or does it need changes?
>>>>>
>>>>> Except the typo(s?) pointed out in my first reply, this is good to go.
>>>>>
>>>>> If we stick with generic adc-chan node names that should be documented
>>>>> in the bindings IMO, as it is currently only captured implicitly in the
>>>>> examples.  Krzysztof, what is your thought on this?
>>>>
>>>> If I understand correctly, the outcome of other discussion [1] was to
>>>> use labels and generic node names.
>>>
>>> The outcome was to use labels in the driver and disregard node names as
>>> the new fwnode API clobbers those names by including the @xx register
>>> bit.
>>>
>>> (I'll follow up with Jonathan whether or not to remove the current
>>> fallback to node names, as [1] ended up discussing many different issues
>>> and nits)
>>>
>>>> In such case the patch was correct
>>>> (except other comments).
>>>
>>> As a consequence it _doesn't matter_ how nodes are named, and we _can_
>>> use generic node names.  My question for you is whether we should, and
>>> if we should lock that in via dt-bindings to guide everyone towards
>>> using labels (which i did _not_ do in the recently-landed PM8950 and
>>> PM6125, but will send followup for).
>>
>> FYI the patch has been merged already and is now in linux-next
>> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/arch/arm64/boot/dts/qcom/pmi8950.dtsi?id=0d97fdf380b478c358c94f50f1b942e87f407b9b
>>
>> If you have any changes that need to be done please send a follow-up patch.
> 
> Unfortunately saw that today as well, well after sending this reply.  I
> would've loved to correct the pmi8950_gpio label _gpios before someone

I don't understand what is there to correct. The "pmi8950_gpio" is a
correct label. There is no single rule saying label should have "s" at
the end. The only rules are: using underscores and having similar naming
(e.g. mdss_ for all display labels).

Best regards,
Krzysztof


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 050E1645D9B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 16:28:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbiLGP2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 10:28:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbiLGP2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 10:28:01 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EDC943867
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 07:27:59 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id bp15so29181143lfb.13
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 07:27:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TokEjNlXlL75+xEzHHcfrOtvGUeNpxpixbHN6tlln1o=;
        b=xZoAANYFUthrKrQWZ6Ci6dV24edG9wqHPi6R2TIHnGK70ZBmeBBMtRY+dHTIjC9yLD
         X22I1hEtbP+dxqo+eq50o/QAuervEYat50fozHnFCVRyS1oqT/Rns4LPv88Z0KUfbj7N
         dObCogEsL+cq8W1saACmHaxrUAOe+xr8PNLQdNKglVzJEnEbn78Rcr83cWzTK2YMmN85
         Re3N58OP0QvOZLrtx6jWJByX6X4/gFzNmGlJQfrCAdwBK5Q7jkU3fphWGsIufqCx6VgZ
         wjFWQZ/cQa8ds9qGRlSqBqxDJctnDgC6seOgWtciLCSeu1z0tjtn7zMx/dSN9V3eYrRn
         Kxdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TokEjNlXlL75+xEzHHcfrOtvGUeNpxpixbHN6tlln1o=;
        b=eNExP3T9ZeKj4b8wGsEActRKjLujwCrq44B5WV9vRpNFJQyBWeIxU3OdAI0Q5jAd3u
         Wgh6oIL0AaORUT/u4Q2nqd+tTDvFT7BeoiyIv6sF0GVdHAUiytxzORexlSmiWb1gKjf5
         ey+/Hg2x/EArgDOTGTL0NB/4Uoh1T14kk2RReJLo8Zs837vmypoPGZTRWT7RgsAsoLJ4
         o4NZVdwLK30qatUKTVrIvPhJf/SSWNS5yW/BWAEDdVgTJnzMyXyatfdQFkQ1oqL00Aco
         MstLrmjkyKf6NZCfHZXlXhRQUc18x0CenSvGYJmDrjNGz8chqF71R+eKDVSSWxCrFBNi
         Yfag==
X-Gm-Message-State: ANoB5pnknU1Zq4JJ2mWXvf4rUH7ggXLxVMRjpKtZvRVp7FzhphfaewP5
        nr4sGG20HAM4YjJ4OSop7qAe0g==
X-Google-Smtp-Source: AA0mqf5lFASv5Gt8Q+CtjFWyDlLlmnb/Ja3W9mhr64B6BAoDNOVmOlEhVOJQQAAb5p3q+sYnyzLLkw==
X-Received: by 2002:ac2:4149:0:b0:4a2:217:18bf with SMTP id c9-20020ac24149000000b004a2021718bfmr24820910lfi.146.1670426877825;
        Wed, 07 Dec 2022 07:27:57 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id b4-20020a056512024400b004a8b9c68735sm215425lfo.102.2022.12.07.07.27.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Dec 2022 07:27:57 -0800 (PST)
Message-ID: <30166f9d-ebfa-ed8b-c08b-ff8e2599161f@linaro.org>
Date:   Wed, 7 Dec 2022 16:27:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v11 5/6] dt-bindings: media: wave5: add yaml devicetree
 bindings
Content-Language: en-US
To:     Sebastian Fricke <sebastian.fricke@collabora.com>
Cc:     linux-media@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        kernel@collabora.com, bob.beckett@collabora.com,
        hverkuil-cisco@xs4all.nl, nicolas.dufresne@collabora.com,
        nas.chung@chipsnmedia.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221207121350.66217-1-sebastian.fricke@collabora.com>
 <20221207121350.66217-6-sebastian.fricke@collabora.com>
 <48d60bd0-4de1-4a5e-eca1-1f8a9303cce0@linaro.org>
 <20221207150925.frotwpm3ukwwlnig@basti-XPS-13-9310>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221207150925.frotwpm3ukwwlnig@basti-XPS-13-9310>
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

On 07/12/2022 16:09, Sebastian Fricke wrote:
> Hello Krzysztof, 
> 
> On 07.12.2022 13:31, Krzysztof Kozlowski wrote:
>> On 07/12/2022 13:13, Sebastian Fricke wrote:
>>> From: Robert Beckett <bob.beckett@collabora.com>
>>>
>>> Add bindings for the wave5 chips&media codec driver
>>>
>>> Signed-off-by: Robert Beckett <bob.beckett@collabora.com>
>>> Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
>>> Signed-off-by: Sebastian Fricke <sebastian.fricke@collabora.com>
>>
>> What's happening with this patch? Where is the changelog?
> 
> The changelog is located in the cover letter.
> https://lore.kernel.org/linux-media/20221207121350.66217-1-sebastian.fricke@collabora.com/


Which you did not sent to us... so? How does it help us?

> 
>> Why it is v11 and first time I see it?
> 
> You actually replied to V10:
> https://lore.kernel.org/linux-media/20221023085341.s23qinjuw4qls3dn@basti-XPS-13-9310/
> 
>> And why it is v11 with basic mistakes and lack of testing?!?
>> I would assume that v11 was already seen and tested...
> 
> Sorry I don't have a lot of experience with dt-bindings, thank you for
> highlighting the issues, I will correct them. And I forgot to build the
> documentation during my testing runs.
> I took over the patch set from another contributor and as no one
> complained about the dt-bindings for the last 10 versions, I concentrated
> my energy on other problems.

Because they were never sent to maintainers...

> 
>>
>>
>>> ---
>>>  .../devicetree/bindings/cnm,wave5.yml         | 72 +++++++++++++++++++
>>>  1 file changed, 72 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/cnm,wave5.yml
>>
>> Wrong directory. It wasn't here at all before, so I am really confused
>> how this could happen.
> 
> Thanks for the highlight.
> 
> I will move it to:
> Documentation/devicetree/bindings/media/cnm,wave5.yml
> 
>>
>> Subject: drop redundant pieces: yaml, devicetree and bindings.
> 
> I call it:
> 
> dt-bindings: media: chips-media: add wave5 bindings
> 
> in V12
> 
> Sincerely,
> Sebastian Fricke

And the rest questions? Lack of response means agreement, which is fine,
so in v12 questionable parts will be removed?

Best regards,
Krzysztof


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE5C64C49C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 09:06:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237408AbiLNIGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 03:06:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237394AbiLNIGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 03:06:14 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0E5D1DDF4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 00:06:12 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id s25so5898307lji.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 00:06:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ekJvCFBAUBvty7SAV1eGHEEOeCneFptl9FWN+37m0+U=;
        b=oNAidUI3eefQHODYG30eOAYutA+0TvIR7AXLlEC/P6qRMMNSMXBxu3e7Zr5u0PptcW
         eG3cDd/rQ/5dfCEeYjPkkrFN9aoA4ADlLIaIelAyjiQ1otiBHPH7M5quDEPxZRbGZKX2
         UnRVU3zNY7/51Z9M3V4mcV63tTV6CyUl3YPsGHS6ACwVr1SS5mJRv2+hEReTeULMbkdP
         pLJaR1tfvn0c15xt7vIlBN2J4WUaor3ZRzcTZevSOGpMSrCbrrXasonsli0OeoFgS9Ap
         UqADxAKuvgoubJdHgnQSZRK5CnNxPiXr8mf8eQonvjkru+ckxG6l3fLeDtriWJkacLI5
         C8Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ekJvCFBAUBvty7SAV1eGHEEOeCneFptl9FWN+37m0+U=;
        b=eZ7iCEg1Rh0sNsi3zdIGPyBdpH/CYdRzh3QrJnv5/v/pQ3nkHKrJPuSA994bTCTgaZ
         r7mtmpi68Z+Trd43lDSXvhaxPxBNjbuhLpmplF/bPeJfq7xSG8uoxhpFMsJoJOvmVl2F
         ocppDnwJWc7WZWup9lROK8JzUxAsC86IgFt9uqXwujNkmOLSvwHU9DbANcjEWZWhF6YE
         aMbXwPta062cslfJ76jJqjN35E/k0yObH5SURkwB7iQJF7hKlWmIMXQoRZCgUdm08XD7
         VLV20HYmowTUGTSk8CDvrdYiDbHjQ6ewQIVnho2dMC6KL8FugYb8/cOvnr+KymxHAAFB
         Sg0w==
X-Gm-Message-State: ANoB5pmSfzmCsCzRnDlsc+Bzu0QLToKEbz6/tOW9ijCvIYTvB46TFxI0
        p1PEm+B9pkkvAgO97Tgz2rM8sA==
X-Google-Smtp-Source: AA0mqf6nhE1kxI0HlUaXo15VVyULmxvNEfOIWIaUmc1dr89nTxvWpV/+lPf3GP1nc6kEzBHZILe9+Q==
X-Received: by 2002:a05:651c:50e:b0:26f:eac4:10ca with SMTP id o14-20020a05651c050e00b0026feac410camr7829713ljp.21.1671005171183;
        Wed, 14 Dec 2022 00:06:11 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id y15-20020a2e95cf000000b0027741daec09sm509910ljh.107.2022.12.14.00.06.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Dec 2022 00:06:10 -0800 (PST)
Message-ID: <49b6b5f0-02d5-5840-3d0b-f7eff1555133@linaro.org>
Date:   Wed, 14 Dec 2022 09:06:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2 1/4] dt-bindings: soc: samsung: exynos-sysreg: add
 dedicated SYSREG compatibles to Exynos850
To:     Sriranjani P <sriranjani.p@samsung.com>,
        'Rob Herring' <robh@kernel.org>
Cc:     krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        alim.akhtar@samsung.com, pankaj.dubey@samsung.com,
        ravi.patel@samsung.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
References: <20221207105032.103510-1-sriranjani.p@samsung.com>
 <CGME20221207105043epcas5p306086213835a5287f39de9016dcd43d2@epcas5p3.samsung.com>
 <20221207105032.103510-2-sriranjani.p@samsung.com>
 <20221209211004.GA3847427-robh@kernel.org>
 <051901d90f76$4e557040$eb0050c0$@samsung.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <051901d90f76$4e557040$eb0050c0$@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/12/2022 05:41, Sriranjani P wrote:
> 
> 
>> -----Original Message-----
>> From: Rob Herring [mailto:robh@kernel.org]
>> Sent: 10 December 2022 02:40
>> To: Sriranjani P <sriranjani.p@samsung.com>
>> Cc: krzysztof.kozlowski+dt@linaro.org; devicetree@vger.kernel.org;
>> alim.akhtar@samsung.com; pankaj.dubey@samsung.com;
>> ravi.patel@samsung.com; linux-kernel@vger.kernel.org; linux-arm-
>> kernel@lists.infradead.org; linux-samsung-soc@vger.kernel.org
>> Subject: Re: [PATCH v2 1/4] dt-bindings: soc: samsung: exynos-sysreg: add
>> dedicated SYSREG compatibles to Exynos850
>>
>> On Wed, Dec 07, 2022 at 04:20:29PM +0530, Sriranjani P wrote:
>>> Exynos850 has two different SYSREGs, hence add dedicated compatibles
>>> for them and deprecate usage of generic Exynos850 compatible alone.
>>>
>>> Signed-off-by: Sriranjani P <sriranjani.p@samsung.com>
>>> ---
>>>  .../soc/samsung/samsung,exynos-sysreg.yaml        | 15 ++++++++++++---
>>>  1 file changed, 12 insertions(+), 3 deletions(-)
>>>
>>> diff --git
>>> a/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-
>> sysreg.
>>> yaml
>>> b/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-
>> sysreg.
>>> yaml index 4954790eda6c..a37452965100 100644
>>> ---
>>> a/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-
>> sysreg.
>>> yaml
>>> +++
>> b/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-sys
>>> +++ reg.yaml
>>> @@ -17,7 +17,6 @@ properties:
>>>                - samsung,exynos3-sysreg
>>>                - samsung,exynos4-sysreg
>>>                - samsung,exynos5-sysreg
>>> -              - samsung,exynos850-sysreg
>>>                - samsung,exynosautov9-sysreg
>>>                - tesla,fsd-cam-sysreg
>>>                - tesla,fsd-fsys0-sysreg @@ -33,9 +32,17 @@ properties:
>>>            - const: samsung,exynos5433-sysreg
>>>            - const: syscon
>>>        - items:
>>> -          - const: samsung,exynos5433-sysreg
>>> +          - enum:
>>> +              - const: samsung,exynos5433-sysreg
>>
>> This says the compatible entry is "const: samsung,exynos5433-sysreg".
>>
>> That should be a schema warning. You did test this, right?
> Thanks for pointing it out, somehow dtbs check not showed any error. Will
> fix it in the next version.

To test binding please run dt_binding_check instead.

Best regards,
Krzysztof


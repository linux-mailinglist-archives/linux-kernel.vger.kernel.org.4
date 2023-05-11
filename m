Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C47766FEE30
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 11:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233923AbjEKJBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 05:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbjEKJBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 05:01:17 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22D5026B7
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 02:01:16 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-50bd37ca954so77119322a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 02:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683795674; x=1686387674;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0CisL2rUE4Hw6hlxlukZuowP2tixyFGxjkXdRANpN4o=;
        b=cWCRSOdDgP46O6T1hMKoF/8U0aNMUK8Rt1UUXmAgisr+nnDt24sRYnhmXSx0YMLi83
         Tv43KqVI7M8dGwOuXmp8wTGaoxcLPIwynVL4gr9HdgdeTAf+OQpE1waZuLzcsxy/sSFg
         TU91PqWhPY7irbdfC+m/heDD7O5PtIBYYnFatINeBL0Qq6zYPgNdp5yYmK8wLPzMZMeD
         t3E9QC3y6K9mud1kciwYf5qkS8vVkcXlbeRqutAixTGCkB532igmHdiKaoGRWdZCtOcM
         3KQQhkOh1Qb5OKi4Ud7op4c9SDpIuOj3br7U2WB85Ik+qmGm2UoSKohftY7lDJ0zsRSl
         D+/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683795674; x=1686387674;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0CisL2rUE4Hw6hlxlukZuowP2tixyFGxjkXdRANpN4o=;
        b=byGP2dM7PWtCx6wJ6fWXvWLFtAZYtzyH5+OgkR/Y8IMjhSuUHPiVtXjYLf5tmhgBke
         sMqUuPIXf/1J9B8SYs6SOiUyObDFR4wGLF024y9KlICdzUcRTLZ339mBvJJth/a/0wIL
         8GUOZNpxNwszCsMGeNSCsyGBlgEpESKJ65ElYwXr9hIkKy+pe4HrjYXzwcFX/tEplRMZ
         lcmS8qclvyP/lgSQCY29likWFWmWZSeWjCcMEqKDaTFdMK1wHEAfylDVZxAL+hW7n9H4
         l1JXyK36KIuOOy0eY89htPwNhQpm3LjKuViiN6Os9w8Orqd7aehJ2EAroGLwSzN66vRM
         Ufxw==
X-Gm-Message-State: AC+VfDz1Xoiq637HF7wYie1SvHyj3LU2TFTeCGkIby37RjW6UVwSuNEM
        ES56sEwm7n6gCkCZMlFciTZYdw==
X-Google-Smtp-Source: ACHHUZ6KOZWGlcRewxIzNr2yQQxjbZCIQpTw1t3mlu3ayU+bXuAyBCLXZ+Z5vsm6LCoN8NVEKftVCA==
X-Received: by 2002:a17:907:da4:b0:966:4e4c:a36d with SMTP id go36-20020a1709070da400b009664e4ca36dmr12121142ejc.20.1683795674367;
        Thu, 11 May 2023 02:01:14 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:7e61:f14a:c3a4:809e? ([2a02:810d:15c0:828:7e61:f14a:c3a4:809e])
        by smtp.gmail.com with ESMTPSA id w10-20020a170907270a00b00965e9a23f2bsm3679359ejk.134.2023.05.11.02.01.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 May 2023 02:01:13 -0700 (PDT)
Message-ID: <1959eb8a-d55f-5f62-2b41-0e7ea41b27b2@linaro.org>
Date:   Thu, 11 May 2023 11:01:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [EXTERNAL] Re: [PATCH v2 2/5] ASoC: dt-bindings: Add tas2781
 amplifier
Content-Language: en-US
To:     "Ding, Shenghao" <shenghao-ding@ti.com>
Cc:     "Lu, Kevin" <kevin-lu@ti.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Xu, Baojun" <x1077012@ti.com>, "Gupta, Peeyush" <peeyush@ti.com>,
        "Navada Kanyana, Mukund" <navada@ti.com>,
        "gentuser@gmail.com" <gentuser@gmail.com>,
        "Ryan_Chu@wistron.com" <Ryan_Chu@wistron.com>,
        "Sam_Wu@wistron.com" <Sam_Wu@wistron.com>,
        Shenghao Ding <13916275206@139.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "pierre-louis.bossart@linux.intel.com" 
        <pierre-louis.bossart@linux.intel.com>
References: <20230508054512.719-1-13916275206@139.com>
 <ca9d45cf-8a84-4fbc-e1dd-c96eef36fe25@linaro.org>
 <c088d7dce83a45168d0dc25fee4a9e35@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <c088d7dce83a45168d0dc25fee4a9e35@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/05/2023 16:03, Ding, Shenghao wrote:
> 
>> +    items:
>> +      minimum: 0x38
>> +      maximum: 0x3f
> 
> ... So these are fixed? No need to encode them in such case...
> 
> and anyway actually I agree with Rob here - these addresses should be put in reg.
> [DING] if all the put in reg, the i2c_probe will be called several time. The code don not want to register several codecs, but one codec including several tas2781s.

Eh? Why and what would call probe multiple times for one device? It's
the first time I hear... I don't know, maybe Linux I2C has some
specifics, but sounds surprising.

> 
>> +      description:
>> +        I2C address of the device for different audio slots,
>> +        useless in mono case.
>> +
>> +  ti,broadcast-addr:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description:
>> +      Generic I2C address for all the tas2781 devices in
>> +      purpose of I2C broadcast during the multi-device
>> +      writes, useless in mono case.
> 
> Probably you can figure it out from previous addresses and there is no need for this property.
> [Ding] this address is the common address for all the tas2781, it can be used for dsp firmware downloading to all the tas2781s in parallel, which can save more downloading time

So the answer is yes? Then please drop it... If not, say why it cannot
be deducted from other addresses (e.g. last address + 1).

Best regards,
Krzysztof


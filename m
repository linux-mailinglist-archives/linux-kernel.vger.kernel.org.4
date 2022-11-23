Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85AB56356FC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 10:38:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237954AbiKWJh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 04:37:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238002AbiKWJhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 04:37:03 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 882D210AD04
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 01:34:19 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id s8so27316179lfc.8
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 01:34:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u8s2q4f5w/4IPeNoebI+nh7g4r0oLg4pQUjqS5WFRYk=;
        b=FLRmBljcZFVd3iH3NW/n9fV3NPM5BxVX81sqR6LZ5RbeAjwAUUACbw7bpAZTUCkHbg
         UbLObKsVx6nYalwPse7wmcQC25HSwU38xJ//YSSuY3Vksu8EV5v5XbGXI6+cbOvQDyYx
         my4KGi161b0Pitcm7UZF0+yxoQ5eKEEisxE1HLR3Q47rHpGxWxJChp7fnH49Ey6Zrdyc
         Bh5td7XP54jj5mPNPbrbsqYpl0XmY5dugMm9p2q31pwT4wIbIGUCTMIvqfz7l4WUTJ8v
         ptI8vjj1FYlKgmvDZYPmWU+2/54FuurMfxTrl/VXOSfvxMVdeWLqu5m/SzeDXPJ+uy/R
         jQKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u8s2q4f5w/4IPeNoebI+nh7g4r0oLg4pQUjqS5WFRYk=;
        b=8EhivpKApH2GEhaMtK8NCBRRgUVdYTnWau0rjCKSsONsDNgvTVy8AaRoKffX2xTBPb
         tp6qiO1GddddEyAUFKfgPaTpRl4UkBNWrSEc+julySWkKeP/q6reO7fz8Xsf5AvwsE0t
         PHhjicXjpHFyzbeTp8v2adlE6XaL970FewahbG93pa8TrJJ19GtdV+dcfpyxoArL+9MF
         7Qyxst6jXJYJ3+EBaxpXQFGooY55wg9mYxUZ4QDGrg6P3JJ/tjn8QcIZbTzADPGIeOOt
         ObmNL1XSwjKhc2U6EqhxlL9JWLFsUo9ldDZFUpk0Z6lgx1BGd7AxF2aX29ZbwTz00rlH
         Z7Pw==
X-Gm-Message-State: ANoB5pl3RIIA+OsMJa1eYpokfyc+dn8gLAYAUtL3LzBqutZYsyV0SCmp
        NJ8nycBWx6SFD4LwCDWX8aIl5w==
X-Google-Smtp-Source: AA0mqf7D378yEUBmE+4xmSMMT7l3z+IL8SiWvdALDT0ayiY7awFjMZCumei8TeFsYJZZ0ZLkVaiH9g==
X-Received: by 2002:a05:6512:258a:b0:4a2:27f0:46a5 with SMTP id bf10-20020a056512258a00b004a227f046a5mr4360007lfb.611.1669196057899;
        Wed, 23 Nov 2022 01:34:17 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id s5-20020a056512314500b004a1e7216131sm2806605lfi.116.2022.11.23.01.34.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Nov 2022 01:34:17 -0800 (PST)
Message-ID: <e63e5377-f726-7c04-61d5-9e39ae5c2ad9@linaro.org>
Date:   Wed, 23 Nov 2022 10:34:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 07/14] dt-bindings: clock: Add StarFive JH7110 system
 and always-on clock definitions
Content-Language: en-US
To:     Hal Feng <hal.feng@starfivetech.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org
Cc:     Conor Dooley <conor@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        linux-kernel@vger.kernel.org
References: <20221118010627.70576-1-hal.feng@starfivetech.com>
 <20221118010627.70576-8-hal.feng@starfivetech.com>
 <4d1fbddc-ee8b-1ab3-d1a9-8496bda3f668@linaro.org>
 <1db979d5-1fb6-f3c9-8ce0-e3e2e23e5d14@starfivetech.com>
 <f59e53b0-0915-e8e9-7e49-05ca6a9eac95@linaro.org>
 <c0050210-0b87-3b30-913a-a2b1e757ba15@starfivetech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <c0050210-0b87-3b30-913a-a2b1e757ba15@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/11/2022 09:04, Hal Feng wrote:

>>>> Filename based / the same as compatible (or bindings filename).
>>>
>>> Should I split this file into two files for "SYSCRG" and "AONCRG", which
>>> maybe named as "starfive-jh7110-sys.h" and "starfive-jh7110-aon.h". Ditto
>>> for the patch 8.
>>
>> Does not have to be, but anyway naming must follow compatible naming, so
>> vendor,soc-device.
> 
> Can I name it "starfive,jh7110-crg.h"? This file is included in
> starfive,jh7110-syscrg.yaml and starfive,jh7110-aoncrg.yaml.

Sounds ok.

Best regards,
Krzysztof


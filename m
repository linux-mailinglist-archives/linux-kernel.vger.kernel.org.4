Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0C45633601
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 08:41:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbiKVHll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 02:41:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232440AbiKVHlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 02:41:31 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 495BD30550
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 23:41:30 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id j16so22305459lfe.12
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 23:41:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vZgEuShZPFvGmlrbVu6jnnJSD8pbk7ahYnQJQ5wn0pk=;
        b=Mk8EUJ3Sx3oXYHl0xM9T+/JmMikNxAA2Jrijsah9gHwhOsarE7+/7rCOMgRVdAi7he
         gaBKk2R37J1zzOGVATS8wpJjoOveMvsWH54RGMYWhoN2mFEyUG9pEy/E/HzTVTiMoY05
         vPYpwi0km37F0pHzCWXY8b9paAgeF87jdox71Tildp7I8n1GDimBZ6+Plo0ymvElmMTZ
         41zSo/Gxf44sC1e41wOXEVJchH/l7efH/9D5Fu3bwhbGkcNaDtwjTENM0u/iKV8XCDZA
         pC4osLGbF0ZX1vfmVE+/163BmTggGjlGrnLQneRP5jYptizwJgIjFy8wPtl9fv5UsuYS
         clig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vZgEuShZPFvGmlrbVu6jnnJSD8pbk7ahYnQJQ5wn0pk=;
        b=OwTYgea7F7S2YrC698DzD5ujp8Vz2UMbyg7MvpfbE8/V+oYkdA1O2s2QeWWcp+lHCt
         0rn48rB8y/YFWL+DYGW+RrvJlD3+Ops2c7Hsd8zaTv2RhMRte+/0dZllMiMK0KidJXUu
         ioF920SImLOgBgIfII0g69W07aqRX70emRdnP+65AfY57XfErOK9QmuYa/XBC5GSz2d7
         DvjFtuGTQVNgCJSatOcGo/xgb06XuFQsOB2hfeOQjXY65FvgKriZuNtVWH/nHjDeC7JP
         zB4YnTKyTv3RRTGEWpP/BjRDwJRGctrH4WKHQUI4q6TQEhXjcWq5bf49c0MxfUsZNMZ0
         Ue4w==
X-Gm-Message-State: ANoB5pkMp+SGsbL7JdCsaJhKVmo5UdEwdpqnk/BoBEASpv9hwAeE7InU
        lKlZqa6rIrRZA1NU6JGvQICqwQ==
X-Google-Smtp-Source: AA0mqf7TStaiGDTFZUcD6Pjywwt89ly9JYpeR/JJ6ptzRJUT6v6QpzUVC8GK8nCrwcmjKs0mJw01tw==
X-Received: by 2002:a19:4f52:0:b0:4a6:2ff5:ddd2 with SMTP id a18-20020a194f52000000b004a62ff5ddd2mr8167514lfk.166.1669102888604;
        Mon, 21 Nov 2022 23:41:28 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id y22-20020a2eb016000000b0026daf4fc0f7sm1758305ljk.92.2022.11.21.23.41.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 23:41:27 -0800 (PST)
Message-ID: <f59e53b0-0915-e8e9-7e49-05ca6a9eac95@linaro.org>
Date:   Tue, 22 Nov 2022 08:41:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1db979d5-1fb6-f3c9-8ce0-e3e2e23e5d14@starfivetech.com>
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

On 22/11/2022 02:02, Hal Feng wrote:
> On Mon, 21 Nov 2022 09:45:11 +0100, Krzysztof Kozlowski wrote:
>> On 18/11/2022 02:06, Hal Feng wrote:
>>> From: Emil Renner Berthing <kernel@esmil.dk>
>>>
>>> Add all clock outputs for the StarFive JH7110 system (SYS) and
>>> always-on (AON) clock generator.
>>>
>>> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
>>> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
>>> ---
>>>  MAINTAINERS                                 |   5 +-
>>>  include/dt-bindings/clock/starfive-jh7110.h | 234 ++++++++++++++++++++
>>>  2 files changed, 237 insertions(+), 2 deletions(-)
>>>  create mode 100644 include/dt-bindings/clock/starfive-jh7110.h
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index e6f1060e7964..e97dac9c0ee4 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -19598,12 +19598,13 @@ M:	Ion Badulescu <ionut@badula.org>
>>>  S:	Odd Fixes
>>>  F:	drivers/net/ethernet/adaptec/starfire*
>>>  
>>> -STARFIVE JH7100 CLOCK DRIVERS
>>> +STARFIVE CLOCK DRIVERS
>>>  M:	Emil Renner Berthing <kernel@esmil.dk>
>>> +M:	Hal Feng <hal.feng@starfivetech.com>
>>>  S:	Maintained
>>>  F:	Documentation/devicetree/bindings/clock/starfive,jh7100-*.yaml
>>>  F:	drivers/clk/starfive/
>>> -F:	include/dt-bindings/clock/starfive-jh7100*.h
>>> +F:	include/dt-bindings/clock/starfive*
>>>  
>>>  STARFIVE JH7100 PINCTRL DRIVER
>>>  M:	Emil Renner Berthing <kernel@esmil.dk>
>>> diff --git a/include/dt-bindings/clock/starfive-jh7110.h b/include/dt-bindings/clock/starfive-jh7110.h
>>
>> Filename based / the same as compatible (or bindings filename).
> 
> Should I split this file into two files for "SYSCRG" and "AONCRG", which
> maybe named as "starfive-jh7110-sys.h" and "starfive-jh7110-aon.h". Ditto
> for the patch 8.

Does not have to be, but anyway naming must follow compatible naming, so
vendor,soc-device.

Best regards,
Krzysztof


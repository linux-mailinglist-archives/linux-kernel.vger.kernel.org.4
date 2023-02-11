Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13C6269306E
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 12:42:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbjBKLmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 06:42:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjBKLmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 06:42:13 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4676C30192
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 03:42:12 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id a2so7655654wrd.6
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 03:42:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ikcY8Pm/yTY/JbPUBqfUjPlO6R9EeoJh3TYttTT10XE=;
        b=SXFy5RcvIzFQe1tsiULhSMLDWbeL4tdvhlCLh3stfIL2JuSSPqbTUVZXDim2EjigQE
         uWvW2aUwq/tNgpfNz5NdzzMfs4y+S0bnN86VqbIqAPFlvwUTLa65KeW9eYn3v907QhC3
         1oLgK4+yaNE9lsX8BHPMgJBsLbdRxA4NEo+tlo7TbpTnyazAV+mqjv9lE01C6y3ULkjX
         fdt1CM4esJ9jSqd9MjBlxJ7iB6KHgQpyoZSFyehdGhggNXAtX3QYImIngzS8l1gbqc1x
         tlmEbxlghk3YsxpTPEKiwTn8UnCHxmEPO7+QU7ytwjhrkX/d3GX4GZouHpoIujygeclb
         OR+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ikcY8Pm/yTY/JbPUBqfUjPlO6R9EeoJh3TYttTT10XE=;
        b=J61P5eSUFqiGaxhPCIiwp+UYiOzjDRxz5DmjzbwTOu3kmx6kUkbUh49Y7UBqNPOafH
         psv9K/SkOGj4SEKjD91X9GC6ItZqouwMI6i57LGjyhkkR1s4Q4ebUkWxWuRH9JVzUZCo
         iOq0Sg7zk8Lb4DMgHGzI3B77YT9qdHlCKs1VvB+YpGJldMziWmZvfpPEyYxQzkHIu/Ap
         Qm1cECaiFtiqZj8D7hzXGypyZ3Dv7dG3Xy1lh5dswsIyySXzc/ClV2DoZAD0ah/dfzaP
         qJNXCEpYQXWDT9hxuE7WBJilS0KNoPwwgZlXfSju+qWVZzHC2ev2tFNTt33hb2+jnmZQ
         MRbQ==
X-Gm-Message-State: AO0yUKU1ty9/TKOu/WFmvHM7Q3pteGg1jvTVe58EfXQO74YRukYgvWrh
        1puyn2Gluf8ci2UTu0Jye9qimA==
X-Google-Smtp-Source: AK7set8iZmjG9W+Y5cURJ9jueVn2aH2CjMKkFzSv6b4P4liPwwWHkouqoiCf8pcHXlew0lhDzTB9dA==
X-Received: by 2002:adf:dc04:0:b0:2c3:ea92:3494 with SMTP id t4-20020adfdc04000000b002c3ea923494mr15496544wri.55.1676115730845;
        Sat, 11 Feb 2023 03:42:10 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id y15-20020adfee0f000000b002c3efca57e1sm6064372wrn.110.2023.02.11.03.42.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Feb 2023 03:42:10 -0800 (PST)
Message-ID: <76353597-0170-e0d9-9f5d-f208a03e44e8@linaro.org>
Date:   Sat, 11 Feb 2023 12:42:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v4 1/5] dt-bindings: watchdog: mt7621-wdt: add phandle to
 access system controller registers
Content-Language: en-US
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc:     linux-watchdog@vger.kernel.org, wim@linux-watchdog.org,
        linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        tsbogend@alpha.franken.de, p.zabel@pengutronix.de,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org
References: <20230211073357.755893-1-sergio.paracuellos@gmail.com>
 <20230211073357.755893-2-sergio.paracuellos@gmail.com>
 <190b3135-82f3-4dfa-55ee-e048c5510e3c@arinc9.com>
 <CAMhs-H8tehOWvYKmFtW_LHNb62h5mnzVGN_bfGOtLgNE9qUxqw@mail.gmail.com>
 <d14f0065-e8d3-50ed-7ea4-ba57dbd18d51@arinc9.com>
 <CAMhs-H_1dtdAmeNW9arK9JxhdWaQJwcMU1Pk7TOW1f5MREzzug@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAMhs-H_1dtdAmeNW9arK9JxhdWaQJwcMU1Pk7TOW1f5MREzzug@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/02/2023 12:01, Sergio Paracuellos wrote:
> On Sat, Feb 11, 2023 at 11:47 AM Arınç ÜNAL <arinc.unal@arinc9.com> wrote:
>>
>> On 11.02.2023 13:41, Sergio Paracuellos wrote:
>>> On Sat, Feb 11, 2023 at 10:10 AM Arınç ÜNAL <arinc.unal@arinc9.com> wrote:
>>>>
>>>> Is this mediatek,sysctl property required after your changes on the
>>>> watchdog code?
>>>
>>> I don't really understand the question :-) Yes, it is. Since we have
>>> introduced a new phandle in the watchdog node to be able to access the
>>> reset status register through the 'sysc' syscon node.
>>> We need the bindings to be aligned with the mt7621.dtsi file and we
>>> are getting the syscon regmap handler via
>>> 'syscon_regmap_lookup_by_phandle()'. See PATCH 5 of the series, Arınç.
>>
>> I believe you need to put mediatek,sysctl under "required:".
> 
> Ah, I understood your question now :-). You meant 'required' property.
> I need more coffee, I guess :-). I am not sure if you can add
> properties as required after bindings are already mainlined for
> compatibility issues. The problem with this SoC is that drivers become
> mainlined before the device tree was so if things are properly fixed
> now this kind of issues appear.  Let's see Krzysztof and Rob comments
> for this.

If your driver fails to probe without mediatek,sysctl, you already made
it required (thus broke the ABI) regardless what dt-binding is saying.
In such case you should update dt-binding to reflect reality.

Now ABI break is different case. Usually you should not break it without
valid reasons (e.g. it was never working before). Your commit msg
suggests that you only improve the code, thus ABI break is not really
justified. In such case - binding is correct, driver should be reworked
to accept DTS without the new property.

Best regards,
Krzysztof


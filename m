Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3969698049
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 17:14:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbjBOQOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 11:14:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjBOQOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 11:14:10 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB9F39CC3;
        Wed, 15 Feb 2023 08:14:09 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id qw12so49490775ejc.2;
        Wed, 15 Feb 2023 08:14:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uC/SvFAaTgyOUT62qSZHz5/1ITvVZfonGrD1ssJwpVw=;
        b=O2unormQ4YLjFh1J9UYBKR0y+uFQ5K+/Pi5JPJrTjOqF41NoPgtIc1Sf7T+N6W7+pC
         xdk0UGF05SpKe5ERkALQXaZQ1t3rEr6GehU8r73Xs60EF1BStYZyOUIRsDzqTuek2gp6
         uY0dwwKhERyZ9r57VVQvmfPoXaJK4rPm5vhOnN3TcPcf8lA97JfEvatJrhXmxPYnqbZv
         5SwEYiChmS00daXbf5hoXMcauIFQ5ap2wAOE8w25QwvrAkuWkLATMor0ph4HPRK8a9dl
         fTeGlo1rHfqQ7ALcSEmZ9LREZNA6CshoTE+yTINzF1vvW9S4DyTXeXHR2M89zCZCagNv
         5ehQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uC/SvFAaTgyOUT62qSZHz5/1ITvVZfonGrD1ssJwpVw=;
        b=YpJ/6G08zFayYU46//cJyZfIsJgFB3BrT/NwspHV/d4jeop9UJ7oMqefGaWEF7sBL6
         M17IW++MOIGMAbbsmLL1pya0kqx5MyFzi+gnk7RPmNSLuhJ9KjxNHCCPJ6Q/b9nM9npn
         b5KgRmwdXyDUDS8pROqsssQ8TyY144103HiXnopA65Y87nih2KvRzQNCtkJBVbmOV+ck
         JzwC6vKPbrp/kJ8FlHxqKdpDUQQce6Gpl+v1qiYtYix/A0Q+a8ttI2U3tzlbnW65dkwY
         gzSKM7El6rBsLjZVrfKDn4Hag2rzz5ns5A/0uK1UCBMUhhmzsW/xPsONe4sll/+RX1Pn
         weSw==
X-Gm-Message-State: AO0yUKV79wDJqukiez5Moflvqj2DEYX6Zx/j9O16+pd85t5HXVN2qNSn
        0xlu0QWU2b7cizGqfDkDLG0=
X-Google-Smtp-Source: AK7set/gvuJ55M0r2BPZvJhlwvcq1chATR8smn/3mw5g1ugscCalkHUXm3FyAooLWsOIJtatUvGf+w==
X-Received: by 2002:a17:906:bced:b0:8af:2b80:a1a with SMTP id op13-20020a170906bced00b008af2b800a1amr3227603ejb.10.1676477647607;
        Wed, 15 Feb 2023 08:14:07 -0800 (PST)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id o13-20020a17090611cd00b008b12c368ba0sm2572509eja.45.2023.02.15.08.14.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Feb 2023 08:14:06 -0800 (PST)
Message-ID: <e0168826-2276-405e-2d31-4b396335d02a@gmail.com>
Date:   Wed, 15 Feb 2023 17:14:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 1/8] dt-bindings: gpio: rockchip,gpio-bank: add
 compatible string per SoC
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        heiko@sntech.de, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kever.yang@rock-chips.com, sjg@chromium.org,
        philipp.tomsich@vrull.eu, john@metanate.com,
        quentin.schulz@theobroma-systems.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <03627216-54b5-5d9b-f91d-adcd637819e3@gmail.com>
 <CACRpkdbmXri1vtRShm7a3N0sRA7Qg_ni5FpAtiEv+72a6g9Wng@mail.gmail.com>
 <CAMRc=MeKdb=xmidwXQiNxtJpb1xii1D-43m1z6cNtF1VxFwogg@mail.gmail.com>
 <e0bf4347-ec24-a4e2-0851-d5cdf850cc28@linaro.org>
 <CAMRc=MdZOmxSTvtKaPo7cnx6q+dg8ANQYuM8PeuN+KQ7fqV61g@mail.gmail.com>
Content-Language: en-US
From:   Johan Jonker <jbx6244@gmail.com>
In-Reply-To: <CAMRc=MdZOmxSTvtKaPo7cnx6q+dg8ANQYuM8PeuN+KQ7fqV61g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/15/23 16:02, Bartosz Golaszewski wrote:
> On Sun, Feb 12, 2023 at 5:14 PM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 10/02/2023 21:03, Bartosz Golaszewski wrote:
>>> On Wed, Feb 8, 2023 at 12:08 PM Linus Walleij <linus.walleij@linaro.org> wrote:
>>>>
>>>> On Sat, Jan 21, 2023 at 12:06 PM Johan Jonker <jbx6244@gmail.com> wrote:
>>>>
>>>>> Currently all Rockchip gpio nodes have the same compatible.
>>>>> Compatible strings should be SoC related.
>>>>>
>>>>> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
>>>>
>>>> Bartosz can you merge this one patch and keep the rest back
>>>> so we get a more defined DT binding baseline?
>>>>
>>>> Yours,
>>>> Linus Walleij
>>>
>>> Krzysztof, you left your ack but seem to also have pointed out an
>>> issue - do you want me to fix it up somehow before applying? Drop the
>>> oneOf and turn it back into an enum?
>>
>>
>> Sure, you can apply with my comment fixed but then just please check
>> with `make dt_binding_check DT_SCHEMA_FILES="xxx.yaml"`, that
>> indentation is not mixed up.
>>
>> Best regards,
>> Krzysztof
>>
> 
> I prefer to get your ack on the final version really.
> 

> Johan, please address the enum issue and resend just this patch.

I changed to oneOf, because with enum I didn't get it working.
With 2 enum's it complains about: is not of type 'string'.
I'm out of ideas...
Maybe it's something simple that I overlook.
Could Krzysztof give an example?

Johan


> 
> Bart

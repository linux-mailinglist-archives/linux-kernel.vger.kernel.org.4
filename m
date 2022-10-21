Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD0B2607290
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 10:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbiJUIjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 04:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbiJUIjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 04:39:08 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B3E246C38
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 01:38:51 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id n12so3655751wrp.10
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 01:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sbUO6Dk9wacjXHXZ2vzksSa8OSWDNuLkK+4lOLdOmPc=;
        b=NP/wWIdsBuvCI4fur1IEWKky461bIFRG7op7qLKecW2XkT8gvMZ2E0XgDk876FN01H
         lxSBW4R2JRWQLFq2AZwXQyQMSu53ExurT5Ye+oIQSdX3Nxa9ZC3haROrivTZVDSzcUq2
         TGF0AoTS+QXdfkmofuvn/CkNn6Kxs/xeiCDBLUDXMKOKlLS9dqtnqNmZIAtWjYdRW6WO
         PL0QwIA3BgtRNED6BpJunhlO8VwL7GB0J5q0kfElsbDqVrstIklgg2k9Ahdlo2hTvf61
         DhZb5IXpiBBEsnBu3cQuvJ2BJwXMrpSKANyDnxa3NZsolu6QgV6YhAlomRgIb1LNbJxd
         gKkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sbUO6Dk9wacjXHXZ2vzksSa8OSWDNuLkK+4lOLdOmPc=;
        b=BemC84K2BUVfyT8Z1bVjHBZ4PDRm1qR13bfLo0gL6ls3MBTIQ8sncNH7iCLchAnZT1
         OE0RwuyO/MygWZ6cdAyQ8Ns1xUtA4ZpXHDH5nDH78FzzjmDbfeQAB8t4nNSRbm/8QzrI
         IO16RbxVYEckYJgl36G7ToB5wL5ZBLe1ioO80jqq95Wka0CiRO4hgHxbr4Bu6vItIvcF
         dgJOmqULiQ46nQ3/kkouKMF8GaToDz/BWDt39fvmpNfne+QXIKP3CnrGaoOz99F3SsxV
         b7az9KJ6/DXqhBJNjznWm90xrFKP5fgm6y2RsdI63BJpPbFNBGwlRAqGLG1a2pXdCqmZ
         IZ4w==
X-Gm-Message-State: ACrzQf1qQQrqBIF5R/pG1c/hRimDGK0wyXcxW//dwn/aTGs5njCstSKL
        x7XUpjbUDypWxwenOPy+v/4kHw==
X-Google-Smtp-Source: AMsMyM7k1nPOKOFdlc7vwxPWLFbFhF4RxUJr5xqjxVc0GYiDzbCYzF2K9vcTPnLs/uYo92+HPlMnzg==
X-Received: by 2002:adf:d0c3:0:b0:22e:6ce8:f7a1 with SMTP id z3-20020adfd0c3000000b0022e6ce8f7a1mr11353672wrh.287.1666341529694;
        Fri, 21 Oct 2022 01:38:49 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:8104:adb4:5d77:2050? ([2a01:e0a:982:cbb0:8104:adb4:5d77:2050])
        by smtp.gmail.com with ESMTPSA id i18-20020a5d5232000000b00236576c8eddsm329556wra.12.2022.10.21.01.38.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Oct 2022 01:38:49 -0700 (PDT)
Message-ID: <fcdbf59d-0512-1e35-b4fd-3317782c6e34@linaro.org>
Date:   Fri, 21 Oct 2022 10:38:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
From:   neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] arm64: dts: meson: Enable active coling using gpio-fan on
 Odroid N2/N2+
To:     Anand Moon <linux.amoon@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221018195122.8877-1-linux.amoon@gmail.com>
 <CAFBinCCqXBk9Xq0k=NA3zGi8spwyPQN7dMVWcjE+pXkXYf+FKQ@mail.gmail.com>
 <CANAwSgSR6jHRQR6QgzUop_B4gcOsQnfc6LoUXrP0CSTasZkVfQ@mail.gmail.com>
 <CANAwSgRLZfon5qUFeKW9U9AbHvSa=uKVaVgqghVk554-H1LVKw@mail.gmail.com>
 <402500e8-b4fe-9b8f-d634-e329191af1b8@linaro.org>
 <CANAwSgQhWrzeRcpQSSAmfp+i3966dUQdtCLbcWwifQk=1ce=og@mail.gmail.com>
 <CAFBinCCyEVbc4N7TUEi=sbLFv7Rc-L=y-h8xBuZK446x1oLc2g@mail.gmail.com>
 <CANAwSgQ9gJvtdr_r1K0xxrDxQ6aBh5v=pR9aJSxRytia2PSbrg@mail.gmail.com>
Content-Language: en-US
Organization: Linaro Developer Services
In-Reply-To: <CANAwSgQ9gJvtdr_r1K0xxrDxQ6aBh5v=pR9aJSxRytia2PSbrg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/10/2022 07:07, Anand Moon wrote:
> Hi Martin / Neil,
> 
> On Thu, 20 Oct 2022 at 02:10, Martin Blumenstingl
> <martin.blumenstingl@googlemail.com> wrote:
>>
>> Hi Anand,
>>
>> On Wed, Oct 19, 2022 at 7:17 PM Anand Moon <linux.amoon@gmail.com> wrote:
>> [...]
>>>>> +&pwm_AO_ab {
>>>>
>>>> &pwm_AO_cd not _ab
>>>>
>>> No it has a conflict with CPU_B (vddcpu_b) PWM
>> Uh, you're right. That's probably why the Hardkernel team uses a
>> software based PWM implementation: [0]
>> In hindsight they should have used a different pad either for VDDCPU_B
>> or the fan.
>>
>> I think the most pragmatic approach (since the "GPIO PWM" driver is
>> not upstream and I don't know if something like that would be accepted
>> upstream) is to use a GPIO based fan as you did in your initial patch.
>> Not sure what others think though.
>>
> 
> When I use gpio-fan  I get the following output with gpioinfo
> Feature it woks as expected.
> 
> $ .sudo gpioinfo
> ....
> gpiochip1 - 15 lines:
>          line   0:      unnamed       unused   input  active-high
>          line   1:      unnamed       unused   input  active-high
>          line   2:      unnamed     "enable"  output  active-high [used]
>          line   3:      unnamed       unused   input  active-high
>          line   4:      unnamed       unused  output  active-high
>          line   5:      unnamed       unused   input  active-high
>          line   6:      unnamed       unused   input  active-high
>          line   7:      unnamed       unused   input  active-high
>          line   8:      unnamed "regulator-tflash_vdd" output active-high [used]
>          line   9:      unnamed      "TF_IO"  output  active-high [used]
>          line  10:      unnamed   "gpio-fan"  output  active-high [used]
>          line  11:      unnamed    "n2:blue"  output  active-high [used]
>          line  12:      unnamed       unused   input  active-high
>          line  13:      unnamed       unused   input  active-high
>          line  14:      unnamed       unused   input  active-high
> 
> When I am using pwm-fan using *pwm_ao_d_10_pins* pin is not getting
> registered below hence it is not working on my end.

It's expected because it's not used as a GPIO but another function, you should look
in the pinctrl debugfs files to see it.

> 
> $ .sudo gpioinfo
> ....
> gpiochip1 - 15 lines:
>          line   0:      unnamed       unused   input  active-high
>          line   1:      unnamed       unused   input  active-high
>          line   2:      unnamed     "enable"  output  active-high [used]
>          line   3:      unnamed       unused   input  active-high
>          line   4:      unnamed       unused  output  active-high
>          line   5:      unnamed       unused   input  active-high
>          line   6:      unnamed       unused   input  active-high
>          line   7:      unnamed       unused   input  active-high
>          line   8:      unnamed "regulator-tflash_vdd" output active-high [used]
>          line   9:      unnamed      "TF_IO"  output  active-high [used]
>          line  10:      unnamed       unused  output  active-high
>          line  11:      unnamed    "n2:blue"  output  active-high [used]
>          line  12:      unnamed       unused   input  active-high
>          line  13:      unnamed       unused   input  active-high
>          line  14:      unnamed       unused   input  active-high
> 
> Thanks
> -Anand
> 
> 
> 
> 
>>
>> Best regards,
>> Martin
>>
>>
>> [0] https://github.com/hardkernel/linux/blob/c109dec94e7e819554830acfac4b6ed96e230179/arch/arm64/boot/dts/amlogic/meson64_odroidn2.dtsi#L356-L359


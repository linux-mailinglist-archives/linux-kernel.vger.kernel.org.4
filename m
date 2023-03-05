Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8A206AB0F9
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Mar 2023 15:16:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjCEOQA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 09:16:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjCEOP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 09:15:58 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B53A6E3A9
        for <linux-kernel@vger.kernel.org>; Sun,  5 Mar 2023 06:15:56 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id f13so28412345edz.6
        for <linux-kernel@vger.kernel.org>; Sun, 05 Mar 2023 06:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678025755;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oaYWQsDCiMEerIaw7dOHXTP6aNCmcM9yYsYwMBjgWTo=;
        b=somdt7eCFBhFz4p5Fcw83vtP8kDwgksYd275RGqwFVBRz6Qgtoy4IhyFug/V02wYEH
         933pVJMdTKhTaNyNh2yUc8HdRzYAoECLeFeXmCDmqQtLgHXTT7/Hzhw5RyJk7EN/Qx6T
         Yt3JEuTZ+1s+yFO4LBpWjCg1/UVi/f45egBM5A+cL6kH8Cz/lmPqcF/wrU76TcuZoewz
         brjWrnAbbKGjaGfWz8MOoU7nnTVmVGnXNUDlehngOyY8/8yjXe1RK9TMhUUwRPAsC2JV
         rKIimdbE0emO94TyfAjRwEhBo6QBe7IKuXLCG+ALI19XWrlCUvQyEmcINv1hN4Ku7/6E
         IHNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678025755;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oaYWQsDCiMEerIaw7dOHXTP6aNCmcM9yYsYwMBjgWTo=;
        b=wFX1j3NA4ZUGNrDhAPIfmmkIuoSO4Mj8e3nh7pd+36DiVefs0E3Xpt1eDvcqORz4p+
         pLbJkUTMo1jloSmlMdOHHJjqG/7d8+eJ8yXDPO6YZARtRnvQiUKD8c4DUmA3bCkOMJMl
         lyZZYJjP4CDOCz3H4MfZWfydYNzDM/v08E9B6KvPJrBeR0Z5onNdBEfGi+y0cRQGE1fh
         DDRXAMBTHxS0Fdte9gaJ4OkmRCWTAVyv1AELz8AeX5Bv5h56sWizFDahekl+pb+AtDbt
         2M688D2fWDxMV8f0FdSNPnyAL61WiKSlPCnATztQ7iflT1IOdm90BbdZO7bttZSMgrt2
         jU1A==
X-Gm-Message-State: AO0yUKV3X/RWCDes1pX/EpxuprXBnfMMwQhtnI2i/YIum96nexz7Q99I
        S9myzSgpyTSiYWvspRXbRARCcA==
X-Google-Smtp-Source: AK7set+BgrmehdGCt23YQRzXQoQYxWkq2Jc6jPIS0i29bU4WQufydCFh3/GgV7ABlhrQjqtEnc+bDw==
X-Received: by 2002:a05:6402:3448:b0:4be:c6b:7436 with SMTP id l8-20020a056402344800b004be0c6b7436mr6291841edc.30.1678025755265;
        Sun, 05 Mar 2023 06:15:55 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:71e7:13d:1c29:505f? ([2a02:810d:15c0:828:71e7:13d:1c29:505f])
        by smtp.gmail.com with ESMTPSA id b30-20020a509f21000000b004a21263bbaasm3551737edf.49.2023.03.05.06.15.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Mar 2023 06:15:54 -0800 (PST)
Message-ID: <e52c4a1d-951e-8ce5-4aec-7f2b6d4c6c3a@linaro.org>
Date:   Sun, 5 Mar 2023 15:15:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 2/2] arm64: dts: meson: add support for BananaPi M2S
 variants
Content-Language: en-US
To:     Christian Hewitt <christianshewitt@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Linux Amlogic <linux-amlogic@lists.infradead.org>,
        linux-kernel@vger.kernel.org
References: <20230305132044.1596320-1-christianshewitt@gmail.com>
 <20230305132044.1596320-3-christianshewitt@gmail.com>
 <0d2184ee-679e-371e-8433-c38b22c97799@linaro.org>
 <9CC246C2-28A7-46DF-924F-8FBF5CDE16CA@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <9CC246C2-28A7-46DF-924F-8FBF5CDE16CA@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/03/2023 14:47, Christian Hewitt wrote:
> 
>> On 5 Mar 2023, at 5:30 pm, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 05/03/2023 14:20, Christian Hewitt wrote:
>>> BananaPi M2S ships in Amlogic S922X and A311D variants with the
>>> following common specifications:
>>>
>> (...)
>>
>>> +
>>> +	leds {
>>> +		compatible = "gpio-leds";
>>> +
>>> +		blue {
>>
>> led-0
>>
>> Does not look like you tested the DTS against bindings. Please run `make
>> dtbs_check` (see Documentation/devicetree/bindings/writing-schema.rst
>> for instructions).
> 
> I’m building everything in a cross-compile build system that doesn’t allow
> this to be done without a problem amount of hoop jumping. I need to work on
> another arrangement to do this testing (work-in-progress). Thanks for the

Cross compiling kernel and running this (also as cross compiled) is
trivial, so what exactly stops you? Packaging kernel for your system
(e.g. Yocto) is different topic, but that's final step, not necessary
for development of DTS.

Best regards,
Krzysztof


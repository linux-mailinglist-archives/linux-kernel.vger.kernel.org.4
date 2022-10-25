Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2852360D43B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 20:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231428AbiJYSz3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 14:55:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231629AbiJYSzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 14:55:24 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8237CB48BD
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 11:55:18 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id g11so8241911qts.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 11:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G81DT6Hk8wYmP7WAjsBWJ9EZ96OdD4msd3DYb7Rw10I=;
        b=U0RcXeku7aYi0pcT64JZBboG9fr7vw3aXYgZsMWU7ea2lypBlyHVQxhxoj6zWtl3tl
         86EQ3oi5n8mpfeq7nWAr3BA4q+3Nngb2BazcVGWQjieVBRvwnNUDXdFZgk3ntdkhEawf
         ZqcCAtNR7Ctwi/TvQ0spFASBVceaueAaOwzqax2W2WTucgfnOO/U2ZmKjEU0hkE10Psm
         h3UwkaTlL2p3G+bURSCzvZAVUdtW07fz56vbsG3/j3GGN9zLLMfHsISZWUI2JUlwZof2
         xk8zSL0QW8YDtvh7sZyKcovIiiJoZTrJMmRMfo/0KtBGzmwlHxpSei7dHMmcFPCL6nRg
         8XOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G81DT6Hk8wYmP7WAjsBWJ9EZ96OdD4msd3DYb7Rw10I=;
        b=645kEelMtOfxq3yVkUPsnuLJV9+g/fqoDfqbMntQ8tFfSoxyFMr3XFwgKuMmB5B1t/
         WIB4A82vrWKXdlMA2ZkA/VrWOcM6cqh8WIlCdi9FVQwkOl6RyAUVdvkBZCGge76yVRSK
         R/3RcXfZVytCoJLNDWjGEpPyp8rVwhJvRRSkeFI24SEuaUONHIx2bFBrO0xcCSzS3/c2
         MIfj+WzMjXo1bb/6BN2f6kf6Li90oQiuhl5HsIx5+JqFPOT1JdC56IRih7CYPQYbAuqG
         oY76Xh93esxJK0kVBAFcWu79Y+z4yxNzlfgXIuGtYO8UR8MtQvLY9cTujgHvpqGz4eqb
         uhcA==
X-Gm-Message-State: ACrzQf2TL8wdYjvGP/nYyrjr2xXCYubnTeQ+36NTF6qoi2/AIJwHuZVG
        GlKKVljOF95tXTIB/hxAL+gstw==
X-Google-Smtp-Source: AMsMyM5NIDOS7KIbPJZUP/D35kT6e+lka11hAh7FDVGSxXQfwXn8OuDa6So9K17F+L1XBGOs7nx65A==
X-Received: by 2002:a05:622a:1112:b0:39d:b11:19c2 with SMTP id e18-20020a05622a111200b0039d0b1119c2mr24737640qty.23.1666724117688;
        Tue, 25 Oct 2022 11:55:17 -0700 (PDT)
Received: from [192.168.1.11] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id ay17-20020a05622a229100b003436103df40sm2027204qtb.8.2022.10.25.11.55.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Oct 2022 11:55:16 -0700 (PDT)
Message-ID: <7c9e943a-4806-6339-cee1-9156e7792111@linaro.org>
Date:   Tue, 25 Oct 2022 14:55:15 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v1 2/5] dt-bindings: soc: hpe: Add hpe,gxp-plreg
Content-Language: en-US
To:     "Hawkins, Nick" <nick.hawkins@hpe.com>
Cc:     "Verdun, Jean-Marie" <verdun@hpe.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>
References: <20221011185525.94210-1-nick.hawkins@hpe.com>
 <20221011185525.94210-3-nick.hawkins@hpe.com>
 <CAL_Jsq+xb2Ltfne4mQMXQAde-eHS7TsO73YZ-vhE7nK1Z_M0gw@mail.gmail.com>
 <DM4PR84MB192795B45639710259E9B19D88229@DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM>
 <820095a2-3722-5c3a-77fb-5a6b6b44e1c3@linaro.org>
 <DM4PR84MB19275A47D7006BD5664E1AF488319@DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM>
 <d51b7f8d-3681-e19d-3ebb-7e021fc50403@linaro.org>
 <DM4PR84MB19275D8DB8B27CE0D1A05AA588319@DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <DM4PR84MB19275D8DB8B27CE0D1A05AA588319@DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
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

On 25/10/2022 14:44, Hawkins, Nick wrote:
>> I understand what you want to achieve, but Devicetree does not seem a tool for that. DT describes the hardware characteristics, but not is exact memory map.
> 
>> Although your goal differs than for example goal of some developer of I2C or MMIO device drivers, but essentially devices are similar. We do not describe memory map of MMIO or register map of I2C devices in DT.
> 
> 
>>> If this is not acceptable to do through the device tree, should we rely on having an include file for each platform instead?
> 
>> I would say use rather standard Linux subsystems and problem is gone.
>> You have fan? Sure, we have subsystem for fans. You have power supply or battery - we have stuff for this as well.
> 
> Greetings Krzysztof,
> 
> Thanks for your feedback. In this case for something like fans as you suggest above would it be acceptable for the fans to call into plreg(the proposed driver) just to read the fan related registers with the fan driver knowing what offset to use? Multiple drivers will need to access registers in this memory range so I am trying to determine if they all need to map this area or all goto one source to read/write to it.

I don't know exactly what type of devices you represent in that plreg,
but in general the fan device would be the respective plreg. The same
with other pieces like hwmon, power supply.

Best regards,
Krzysztof


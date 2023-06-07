Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74ADA7262C9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 16:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240328AbjFGO2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 10:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239550AbjFGO2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 10:28:42 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7480C1BEC
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 07:28:40 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9745c5fed21so955457066b.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 07:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686148119; x=1688740119;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KNzTFQxxF94FT5qrUmgwTkDFb3Tnf5DsuBjWNRQ43LI=;
        b=mLam/SsWo9zBv5qpN9FrWcMGO0LdWoogjmc+9m4s+CaL9TqAfdCUKw147UJ+6grKLp
         HTCB416A7kkiDhlFihM6DA4gin3IqrnPppVo2HzoQ3QmQfvrumYSwWIrbgsSdGauwkPy
         nK7oXvSGwDR62rWLu518NjIzEIniDpZmZTv+xtU+Exe6bPBlyhxCobzsusHqMDhpGwuH
         hGSSncGqDC8Kxwrld4uscMnwo74jlhnHQvQyhAMLmyC7IgG0NasXc1/d8WcrOnH//wVC
         VtUx0H6g9hwAYDQ9Yog7hl0nc4fJK7D+wuM6QUQ4QpEqqRIGV/jeucIIcTl9NKmbdOqE
         7hVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686148119; x=1688740119;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KNzTFQxxF94FT5qrUmgwTkDFb3Tnf5DsuBjWNRQ43LI=;
        b=KZJQ7D8HcW87177OHkTjL5vP00PdFCEWq2QZzdybhmcw45GPXSL6mCK0aliIDTci8C
         wR+njx3qiUCWxRPDGhX0UD/payKA2ap9Wjt71fVJ30ZP0rMpZ0LufKOkblyTqb77gU/w
         zETag6Af8GwThgdyq+hfz+4nLgPUKjr+XErV2xfQS2wVnoPrCL8ZGf+XLshuUabTII6Q
         +47BDIR2/H0XuD2vjaYOt+G1tmNaJELnRVPcKsPF0xd5KpVhq8SM1brJ+DNflu3GSSK4
         RijOUQgdB9Xtyb0M9ARvJEzzpMSPHHnvf8nMxbwu19IdAoZ5KmeDTsvuv2D/v0wceaiF
         /Ngw==
X-Gm-Message-State: AC+VfDwf4R4bL2nQ+V5ja5QdkHeA7D3naskMTZz4Gco3KPbaxlyFi4Ue
        KWaHB2f/7NrfETqZL97jFg/DBw==
X-Google-Smtp-Source: ACHHUZ4J+f2LLHLpnyQNG0mMzLhGs0Wb0TFE9kPtcaYuKcM+SQfMywkfzRPMYvbvr1nL0eiA6Bz1UA==
X-Received: by 2002:a17:907:3f9a:b0:96f:8666:5fc4 with SMTP id hr26-20020a1709073f9a00b0096f86665fc4mr7469463ejc.50.1686148118902;
        Wed, 07 Jun 2023 07:28:38 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id a22-20020a1709063e9600b0096637a19dccsm6911447ejj.210.2023.06.07.07.28.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 07:28:38 -0700 (PDT)
Message-ID: <6c6ffc8e-4c98-699e-ee63-d99880aea95f@linaro.org>
Date:   Wed, 7 Jun 2023 16:28:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 1/2] spi: dt-bindings: introduce linux,use-rt-queue flag
Content-Language: en-US
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux@ew.tq-group.com
References: <20230602115201.415718-1-matthias.schiffer@ew.tq-group.com>
 <628b7411-7d12-4915-80c8-cabb74ac6590@sirena.org.uk>
 <CACRpkdYhFmG-Cb-5+dt1Huktnm+tkOjSGO5ZFPjGeOXRott6Dw@mail.gmail.com>
 <a1a1bf95-6333-40a8-9f08-4c952cd070df@sirena.org.uk>
 <6a0abd6bba2f8f940e695dfa9fd0c5f8ee19064f.camel@ew.tq-group.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <6a0abd6bba2f8f940e695dfa9fd0c5f8ee19064f.camel@ew.tq-group.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/06/2023 14:55, Matthias Schiffer wrote:
> On Tue, 2023-06-06 at 15:44 +0100, Mark Brown wrote:
>> * PGP Signed by an unknown key
>>
>> On Tue, Jun 06, 2023 at 04:37:08PM +0200, Linus Walleij wrote:
>>> On Fri, Jun 2, 2023 at 2:22 PM Mark Brown <broonie@kernel.org> wrote:
>>>> On Fri, Jun 02, 2023 at 01:52:00PM +0200, Matthias Schiffer wrote:
>>
>>>>> We have seen a number of downstream patches that allow enabling the
>>>>> realtime feature of the SPI subsystem to reduce latency. These were
>>>>> usually implemented for a specific SPI driver, even though the actual
>>>>> handling of the rt flag is happening in the generic SPI controller code.
>>
>>>>> Introduce a generic linux,use-rt-queue flag that can be used with any
>>>>> controller driver. The now redundant driver-specific pl022,rt flag is
>>>>> marked as deprecated.
>>
>>>> This is clearly OS specific tuning so out of scope for DT...
>>
>>> In a sense, but to be fair anything prefixed linux,* is out of scope for DT,
>>> Documentation/devicetree/bindings/input/matrix-keymap.yaml being
>>> the most obvious offender.
>>
>> That's at least a description of hardware though.  This is a performance
>> tuning thing, if it needs to be configured at all it should be
>> configured at runtime.  Some applications might see things work better,
>> some might see performance reduced and new versions might have different
>> performance characteristics and need different configuration.
> 
> 
> It is not clear to me what alternative options we currently have if we
> want a setting to be effective from the very beginning, before
> userspace is running. Of course adding a cmdline option would work, but
> that seems worse than having it in the DT in every possible way.
> 
> I can understand not wanting such tuning in Device Trees in the kernel
> repo - I agree that these default DTs should only describe the hardware
> and it makes sense to keep OS-specific tuning out of them.

It is not about the sense. It's the rule and the policy. If you want to
change the existing practice, don't do it via one patch that sneaks
something in, but change entire practice for entire DT.

> 
> Requiring such tuning for specific drivers or driver instances is
> however a common issue for embedded systems, which is why we are seeing
> (and occasionally writing) such patches - setting things up from
> userspace may happen too late, or may not be possible at all if a
> setting needs to be available during probe. And even when deferring
> things to userspace is possible, making things configurable at runtime
> always adds some complexity, even though it is often not a requirement
> at all for embedded systems.
> 
> Just doing this through the DT is very convenient and robust. The
> settings could be inserted into the default DT as an overlay applied
> during build or by the bootloader.
> 
> Any alternative solution we could come up with would likely add more
> complexity on the driver side, and be less convenient to use for
> developers. Overall, the rationale for not supporting such bindings in
> drivers seems much weaker to me than that for not having such settings
> in default DTs...

It's not a hardware property. Do not put software choices or policies
specific to only one OS into the DT. The DTS is used by different users,
including other operating systems, firmwares and bootloaders.

Your convenience is not justification for misusing the DT. That's the
same argument community is using since ages for every wish from someone
there wanting something "convenient for him". Same answer for all the
weird ABIs, weird new user-space interfaces, weird duplicated
subsystems, many different schedulers (yeah, because why improve
existing solution in the kernel...) etc. It's always easier for
contributor to solve only their one problem. No, we are less interested
in solving only your one specific problem if such solution breaks
existing rules and consensus.

I think Mark was here quite explicit, but since discussion is still going:

NAK for the linux,rt property.

Best regards,
Krzysztof


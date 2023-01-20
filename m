Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38783674D2C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 07:20:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbjATGUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 01:20:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbjATGUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 01:20:07 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CD5C81990
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 22:20:05 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id r2so3900006wrv.7
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 22:20:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FukrqbXXpPIeLZ7eh5UCg7UdwZT9NdrUQheVraI0Y6A=;
        b=mCJVpnSrlIaebAaWmPNunZv+RiKZe0WBogdgeZmIZUzXada3jhEQDlgnNO9z0R2SVb
         Cdb3K+mrjMoE4gH+tfhQphOwo4dRCfvPNWLOfSloE/Ga0BBHshJdco74Br3bHPQzXoty
         mLuMshCyH14AoUTwGyHd6K78zu4K1Biw3CI6YCk/Rq8EZ2epbFa6UYOZJWwfVmI9paKM
         H+w6/DNW8ocuUxZHVIZmdsYR1zYLfIkA1kV5ON9Jni5XBVrFxSXSbChtVe6feZI1091Q
         0fm7F1LG7C3uiAA455xJ/KQrxUKK0j8oVOMZOFbK98sqqOxD27aHYbdldRj+kGS2d7Z2
         kO1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FukrqbXXpPIeLZ7eh5UCg7UdwZT9NdrUQheVraI0Y6A=;
        b=kk/UqjTYIG5bQ7PIHB531iBlcxeAe9G98oIY8wjuy/PL9ACTMLVEdeMLZLzp0msDY/
         O/FlOLSyL/g51RaGgT241dU3Gu9wG7vMl3uRIGkOFL/swe5DMZbPmEZHgmC6/iNRWaEQ
         df187XDJfrTMZOhbojBGx6m/+HB4owZ4hfCpu2k0nf9/Ptu0kxyiluzTIZCqdKW0YkQN
         lDEXiynL18+/pC4UE2WlKmQf0dPNmLrEv852YOZCZLnGENPKgUj34rpPdvAXI5VaTjsW
         1w8r7MeMIdwA0lmuJnEAAKj9U7sS524r6CMt+NgBdAm61S9RVJ2hNSFVT2gDMvLOurBb
         oUFg==
X-Gm-Message-State: AFqh2kpjyXTQVBjM7i82H3Gh228oYxwzuT8uh05Hs2+Amw/C97PN8q8j
        nS1jGDhw088r/29utlpYDAJtpA==
X-Google-Smtp-Source: AMrXdXu7rBnTkl+OzPYKhfSj+u/eHFubwwda5ssnkDeyEkNyJ/KtDWnEr+pRndShNdY9jdN3zDgxeQ==
X-Received: by 2002:a5d:457a:0:b0:2bb:e993:6c85 with SMTP id a26-20020a5d457a000000b002bbe9936c85mr11807886wrc.35.1674195603705;
        Thu, 19 Jan 2023 22:20:03 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id q17-20020adff511000000b002366553eca7sm12748428wro.83.2023.01.19.22.20.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jan 2023 22:20:03 -0800 (PST)
Message-ID: <cfb9b0f2-a8fa-9bee-a04d-d195d69e4918@linaro.org>
Date:   Fri, 20 Jan 2023 07:20:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v2] arm64: defconfig: Enable HDA INTEL config for ARM64
To:     Mohan Kumar D <mkumard@nvidia.com>, catalin.marinas@arm.com,
        will@kernel.org, dmitry.baryshkov@linaro.org, shawnguo@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        treding@nvidia.com, jonathanh@nvidia.com
References: <20230117181658.17010-1-mkumard@nvidia.com>
 <e871dae2-58ac-7ad9-c198-c4e90d26c69b@linaro.org>
 <1afa38ad-716f-49f8-efd1-ed37bd8dbf6e@nvidia.com>
 <ec440deb-2970-69b8-e54d-6519c95875a8@linaro.org>
 <35eb1396-b91b-8a7f-6585-30d2f2adcf85@nvidia.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <35eb1396-b91b-8a7f-6585-30d2f2adcf85@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/01/2023 06:48, Mohan Kumar D wrote:
> 
> On 18-01-2023 18:06, Krzysztof Kozlowski wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> On 18/01/2023 12:46, Mohan Kumar D wrote:
>>> On 18-01-2023 13:04, Krzysztof Kozlowski wrote:
>>>> External email: Use caution opening links or attachments
>>>>
>>>>
>>>> On 17/01/2023 19:16, Mohan Kumar wrote:
>>>>> Enable CONFIG_SND_HDA_INTEL for NVIDIA PCI based graphics sound card for
>>>>> ARM64 based platforms as Intel PCI driver was used for registering the
>>>>> sound card.
>>>> It's not a part of SoC, not a common device used during debugging or
>>>> development, so I don't think it is reasonable to enable it. We do not
>>>> enable driver just because someone uses them. Otherwise please clarify
>>>> which board has this device embedded (not pluggable by user, but embedded).
>>> This change is required for enabling HDA sound registration for Nvidia
>>> discrete GPU cards based on PCI and pluggable to Nvidia Jetson Platforms.
>> You can plug anything to PCI slot and we do not enable every such PCI
>> adapter.
> Without this config enabled, the Intel hda audio driver won't be built 
> and dGPU won't be able to register sound card. Do you have any 
> suggestion here?

Without hundreds of other drivers they also won't be built and won't be
usable. Anyway, this is just defconfig, so it does not matter. You can
always enable it in your setup, why is this a problem?

Again, we do not enable drivers for every PCI card.

Best regards,
Krzysztof


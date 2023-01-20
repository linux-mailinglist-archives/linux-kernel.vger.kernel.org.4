Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC70E675AA4
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 18:00:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbjATRAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 12:00:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbjATRAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 12:00:31 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A730AA24F
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 09:00:28 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id h16so5379746wrz.12
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 09:00:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7Go8SJlm+Nr46rrHAZu0ji9aqmGRIUcBGkn5jW3jA2I=;
        b=wi9Bqu8N25Igqk5xggAugbppJPp2HTSnEJKzc6vICmlzC4GSoxYMblgx+wjRfD2mKR
         6YHNsQcrhGuZFjUbszcSxAM6aYVtoee3SKh9QAzElpD0FsBu9PUZ0ZZZpEKZDSvtPsNp
         Pwb2J7pzK25w8kz9gQ5SCoRlfIf18VRLRIWJBsow9uBgBM2LYC8uxOWXkB+JtBqJGyAH
         qoM53IsNvBPfd+wgR9fvL4uwYSB8LTSEH1BAyznAYo7ohjdQL0siZtlTjTeaILolt0I4
         em8TET/XKHyR7l/Q1kY4pqMaFUrgf0pd1dTzvkbF6QkmFBOUyT3sDhTGEi5APxxIDrgT
         Mgnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Go8SJlm+Nr46rrHAZu0ji9aqmGRIUcBGkn5jW3jA2I=;
        b=wcpuSlS6kWZeSCuA+tV+6/dzBd/VdhWlUQML8nYjXB3yH4cqThKAN3vOxkeM5KjlQB
         MeMGLsKwdv/Xn0goVMCJU7MWqXX/5DkcXhZg5SXlpVzkg3qH99foccCSYMN3kUKMaNIP
         MawOCl43ebNYP4HI2OhScZS28gysMq5gN8NxfWrA5ZS/xA4GlQKNX5ejS4/EpKuXILG0
         kzbuqDITkBbu921gEsWCDsWoZknQa3tALCngy23n3f7VxZlwHbpvZJsv+x5EJ2m6BqH5
         acOkrHARpIEz+rbHQCUec5v1EsrOgGN87ZsTuTzl9iwLlYSYkLznZl3Byp4ylWSo/uKY
         t3Pw==
X-Gm-Message-State: AFqh2kqbgL5HTwG09DmzuRZp18HKK1QhDDLLwSogm95LESryguhSOscT
        F6P91WYknOwctv9fSH077AirPA==
X-Google-Smtp-Source: AMrXdXt3fHtxoKjvTDJKYtt5uhTlzlRQSsBaATSBRNBHVO3jvwXVDcCTc4mVWCnBG24Bq/xRciyRdg==
X-Received: by 2002:a5d:65d2:0:b0:2bb:6c04:4598 with SMTP id e18-20020a5d65d2000000b002bb6c044598mr13914924wrw.67.1674234027284;
        Fri, 20 Jan 2023 09:00:27 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id w10-20020a5d404a000000b00275970a85f4sm36240351wrp.74.2023.01.20.09.00.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Jan 2023 09:00:26 -0800 (PST)
Message-ID: <fbeff3da-e03b-aa82-1a53-d92f95b63770@linaro.org>
Date:   Fri, 20 Jan 2023 18:00:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v2] arm64: defconfig: Enable HDA INTEL config for ARM64
Content-Language: en-US
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Mohan Kumar D <mkumard@nvidia.com>, will@kernel.org,
        dmitry.baryshkov@linaro.org, shawnguo@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        treding@nvidia.com, jonathanh@nvidia.com
References: <20230117181658.17010-1-mkumard@nvidia.com>
 <e871dae2-58ac-7ad9-c198-c4e90d26c69b@linaro.org>
 <1afa38ad-716f-49f8-efd1-ed37bd8dbf6e@nvidia.com>
 <ec440deb-2970-69b8-e54d-6519c95875a8@linaro.org>
 <35eb1396-b91b-8a7f-6585-30d2f2adcf85@nvidia.com>
 <cfb9b0f2-a8fa-9bee-a04d-d195d69e4918@linaro.org> <Y8rHzJpEg7bMzYM6@arm.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <Y8rHzJpEg7bMzYM6@arm.com>
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

On 20/01/2023 17:56, Catalin Marinas wrote:
> On Fri, Jan 20, 2023 at 07:20:01AM +0100, Krzysztof Kozlowski wrote:
>> On 20/01/2023 06:48, Mohan Kumar D wrote:
>>> On 18-01-2023 18:06, Krzysztof Kozlowski wrote:
>>>> External email: Use caution opening links or attachments
>>>> On 18/01/2023 12:46, Mohan Kumar D wrote:
>>>>> On 18-01-2023 13:04, Krzysztof Kozlowski wrote:
>>>>>> External email: Use caution opening links or attachments
>>>>>> On 17/01/2023 19:16, Mohan Kumar wrote:
>>>>>>> Enable CONFIG_SND_HDA_INTEL for NVIDIA PCI based graphics sound card for
>>>>>>> ARM64 based platforms as Intel PCI driver was used for registering the
>>>>>>> sound card.
>>>>>> It's not a part of SoC, not a common device used during debugging or
>>>>>> development, so I don't think it is reasonable to enable it. We do not
>>>>>> enable driver just because someone uses them. Otherwise please clarify
>>>>>> which board has this device embedded (not pluggable by user, but embedded).
>>>>> This change is required for enabling HDA sound registration for Nvidia
>>>>> discrete GPU cards based on PCI and pluggable to Nvidia Jetson Platforms.
>>>> You can plug anything to PCI slot and we do not enable every such PCI
>>>> adapter.
>>> Without this config enabled, the Intel hda audio driver won't be built 
>>> and dGPU won't be able to register sound card. Do you have any 
>>> suggestion here?
>>
>> Without hundreds of other drivers they also won't be built and won't be
>> usable. Anyway, this is just defconfig, so it does not matter. You can
>> always enable it in your setup, why is this a problem?
>>
>> Again, we do not enable drivers for every PCI card.
> 
> I don't think we have any set rules for what goes in a defconfig. If one
> has a real use-case, we tend to enable stuff in defconfig, especially if
> it's a module.

There will be always an use case for every PCI and USB card. It's not
related to storage or networking which could justify device bringup
(rootfs). It's really not needed for any board operation. defconfig is
not for marketing products but for our development and reference platforms.

The only argument behind this change is "I have a PCI card and I want it
in defconfig", but why it has to be in defconfig in the first place?
There is no reason. This is not distro...

Best regards,
Krzysztof


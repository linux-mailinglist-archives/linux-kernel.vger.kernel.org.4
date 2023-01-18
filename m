Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2505D671D34
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 14:13:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229450AbjARNNC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 08:13:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbjARNMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 08:12:46 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82039BCE2D
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 04:36:09 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id r2so33777306wrv.7
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 04:36:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pHjTOdnVLBoNyB1kXwzzNWo58XgBKXwJzfx8LfTwZ0o=;
        b=divAzqnjrqLRt3q9YHFAqz/Zl3XVvJRVImgKuQ7W52El2dcuf+AM6A40udx0SF43fA
         nnjb4LiJ2cUo7Lb5kEuHaIOp0/P/b8QkOVqj8PW+XHdJcMUP9RxVWnj6JqBJUecK6Mun
         d8UlXFNscL6F/6xDlHTCgG0THWuN/dk2fOHnHGTkwRyznU8cpjLIkHNtUKBhE1XHD1lp
         hf1+n5AJGAkqOmwVxNX1a61Ws+RS7i6/ePIxlLVV5pjlgwLBa3BaRwgOuX+La2mtSzJu
         9EA8GfIOkdJzLI0nLPTuBgcn79CeOxWhpUq4sHPdtlX07OD0eIKJpA67Brk89WsoJ4IH
         VZUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pHjTOdnVLBoNyB1kXwzzNWo58XgBKXwJzfx8LfTwZ0o=;
        b=rl9CHeszn5DMUpXsUPXOWijgjiCx/zEiq9rpkjrdjX+iz35pAHviIEZafDlj3n2ySJ
         RFDzqnQSTwdDf2eqK8dzOkeS928MTSh4t2ZF2GS5WBAkVGUeZOPgaQPrHlRbJi9rizyI
         YE+D40Udhw4yDA74DFCWlLuDod6W8bom5EteAWRQMRllSKJSKnWBcRqpvl03v1uGSgYk
         gCBdEUfUsgSgovKbjeTc6+x9elgA9uuWiP7E+VHrzTK7s+5yJ2VacxGXxrCNLkpwqkk5
         /1ODec0oDwGO90N7OoQhCHRBHV6M1PvKtsv7gi73djJJS6+nr21uTUJD+D3KPHsb1MgY
         5OXQ==
X-Gm-Message-State: AFqh2ko6DTD/JCLX5EM/orGIv4Sbt1npyVmA4DZZbKx6YheVdWRtGArP
        Y6ZyU4zUOBSBw5BYfwJUwBk/oQ==
X-Google-Smtp-Source: AMrXdXv0uV2uTw9bHlHIg9lXwpJCPn2KQh5XftVvXlu7Lmi3K5r6iBaLg5j3eEJFGmhxTI8/o4gNVA==
X-Received: by 2002:adf:b606:0:b0:29a:375d:4c41 with SMTP id f6-20020adfb606000000b0029a375d4c41mr6057287wre.14.1674045364589;
        Wed, 18 Jan 2023 04:36:04 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id o14-20020a5d58ce000000b002879c013b8asm31020119wrf.42.2023.01.18.04.36.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 04:36:04 -0800 (PST)
Message-ID: <ec440deb-2970-69b8-e54d-6519c95875a8@linaro.org>
Date:   Wed, 18 Jan 2023 13:36:02 +0100
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
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1afa38ad-716f-49f8-efd1-ed37bd8dbf6e@nvidia.com>
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

On 18/01/2023 12:46, Mohan Kumar D wrote:
> 
> On 18-01-2023 13:04, Krzysztof Kozlowski wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> On 17/01/2023 19:16, Mohan Kumar wrote:
>>> Enable CONFIG_SND_HDA_INTEL for NVIDIA PCI based graphics sound card for
>>> ARM64 based platforms as Intel PCI driver was used for registering the
>>> sound card.
>> It's not a part of SoC, not a common device used during debugging or
>> development, so I don't think it is reasonable to enable it. We do not
>> enable driver just because someone uses them. Otherwise please clarify
>> which board has this device embedded (not pluggable by user, but embedded).
> This change is required for enabling HDA sound registration for Nvidia 
> discrete GPU cards based on PCI and pluggable to Nvidia Jetson Platforms.

You can plug anything to PCI slot and we do not enable every such PCI
adapter.

Best regards,
Krzysztof


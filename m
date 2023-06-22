Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5436373A131
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 14:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbjFVMtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 08:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjFVMtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 08:49:12 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A41A193
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 05:49:11 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9741caaf9d4so844911966b.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 05:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687438149; x=1690030149;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YhvgVoFM6FTq9AwoWanp3xrUukN1AJ5+EdyuAoktyjU=;
        b=RWw21UIA0cWmKVUVvY38FIClWEnq9pXNU/2G12Dh5g3ztYOHR18AyM3gof/Ic7qZxW
         aQ81VeBvV8X9rwPQ1hDszxfFzMnVHTgWLUwkU3AJezLO1dRBLHCG/WkeEVzjGCPnxzx1
         k7VT2Q6YeTlFvRc724KZwlbXyw5rB28snJKdKF12yj7gKwsucxitRufZsSPk+5c4m/Qu
         +tmFWSBxtK5z0yd0UhXq0PKVjgZFlBRvN0FWEpG9Ci14EkyhlhTr5zFE3+Vw6lUDbp0/
         qgufW+BiwQARHulz/jObcABSq33XITmhQSsceThzb+r20DrfB162/LQAjII2b88UjMst
         E7fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687438149; x=1690030149;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YhvgVoFM6FTq9AwoWanp3xrUukN1AJ5+EdyuAoktyjU=;
        b=aojkqfdlX8Ioqf2jzdcEmd6Dk6Ym/ct0Sz1n+yhIWCCf5JMBCeGa31vx9x/9wrS8DJ
         1dZKmZG2RMp/9gdYBtq8qngLpGyiEoyttxrqXdOSa7jpgRga0pgL6kUyyDF6XZt888cE
         yMYFjUzwOM1qmJArpi3G97hA0/AUAuB+4JBbSRchK3ZPtHhKOzA5RboKZiFWBu0fo5Ci
         MZq8F5QwN3K6hQ/0pN59GR6a3w699WQjMsSv4sQWTMBreKVZvM5SgMptbhm7HBplnRRJ
         RSKRfhsr6bzo2xqrOqJ9g0G7T92VCrB6cV5haZ3Y8kRuTuzxsKHnGZ/4gssyLzP6W7jO
         LA+g==
X-Gm-Message-State: AC+VfDyfpfSCycGjPGUODkRLmbmmMbqlA/hRi254gIu+8rliqp1u++dZ
        pmpW7Kl73QrU8NAZgi43AoaUrQ4ojCOZ3APxISM=
X-Google-Smtp-Source: ACHHUZ6+DbQzZ3m80BTWTc3NUMYeTxfE9rWT+/M+MMDDI9r4wD1K9u5wiJnAPvvTMK8FdQYFFkZgCA==
X-Received: by 2002:a17:907:3e08:b0:982:79fa:453d with SMTP id hp8-20020a1709073e0800b0098279fa453dmr18711830ejc.73.1687438149480;
        Thu, 22 Jun 2023 05:49:09 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id h7-20020a1709067cc700b00988b86d6c7csm4644020ejp.132.2023.06.22.05.49.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jun 2023 05:49:09 -0700 (PDT)
Message-ID: <25439c1e-c9ef-0dc6-8d91-883d7734d0fd@linaro.org>
Date:   Thu, 22 Jun 2023 14:49:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 2/2] arch: arm64: configs: Enable UBI and UBIFS
To:     kah.jing.lee@intel.com, Dinh Nguyen <dinguyen@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org
References: <0d1b3c55-4b11-9e63-e388-191d39d88df1@linaro.org>
 <20230622122114.592791-1-kah.jing.lee@intel.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230622122114.592791-1-kah.jing.lee@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/06/2023 14:21, kah.jing.lee@intel.com wrote:
> From: Lee, Kah Jing <kah.jing.lee@intel.com>
> 
>>

You missed my questions.

>>>
>>> Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@intel.com>
>>> Signed-off-by: Kah Jing Lee <kah.jing.lee@intel.com>
>>> ---
>>>  arch/arm64/configs/defconfig | 2 ++
>>>  1 file changed, 2 insertions(+)
>>>
>>> diff --git a/arch/arm64/configs/defconfig
>>> b/arch/arm64/configs/defconfig index a24609e14d50..23a6ebcb1a9e
>> 100644
>>> --- a/arch/arm64/configs/defconfig
>>> +++ b/arch/arm64/configs/defconfig
>>> @@ -470,6 +470,8 @@ CONFIG_IPMI_DEVICE_INTERFACE=m
>> CONFIG_IPMI_SI=m
>>> CONFIG_HW_RANDOM=y  CONFIG_HW_RANDOM_VIRTIO=y
>>> +CONFIG_MTD_UBI=y
>>> +CONFIG_UBIFS_FS=y
>>
>> Not modules?
> Yes, we need to boot with rootfs with UBIFS.

So you miss init ramdisk.



Best regards,
Krzysztof


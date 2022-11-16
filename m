Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EDDE62C78D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 19:22:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239129AbiKPSWd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 13:22:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239121AbiKPSWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 13:22:31 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82F1127CCE
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 10:22:30 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id b185so18223429pfb.9
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 10:22:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jhyFZgMuk5HqVXgVJposzO4j4v/wuHWnStnbDnBC0vA=;
        b=mfCqzVTfSFz4rvfJ37UgLOFCiKTdgD5r99Y1ofQXmBZ+7iPEuMaz6Dn9HVADqnHaxf
         yGP+cm7IuhrdotDT2DXUz9YciTca1/b1c+CUaR/6ovOI7SXqcB87Q5YsrC/b1Sq4o1YD
         nDeNDNjrJ4T8rA+qqQNHvlxT9aW/CivzQK9Hs95XkvIhkmRmXdI2HmRDZNe+//VKfq6J
         vN6Dx8FuEnavBTVVMgzyCkaHcuPYdEMyjg7ncc5Sm6pg486LZXenPhF1C8thMa/Gux63
         Jpa7e/jtCxADBR3dQhWJ+P9o8PrhywRlq48eyME0v5AcS+gR1C2vAZ8ZA+Bz9W1tqvOj
         XDGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jhyFZgMuk5HqVXgVJposzO4j4v/wuHWnStnbDnBC0vA=;
        b=qdBQ3nnyYahJmshYM0BThF+9eGnBl+49mQQtHhiFN0v5ncC+0qjongmDD/MihaCKaP
         1LW2f1+4KilNVgknxKL7dxhGFxneLm4ieUGBZBIR41/AIKaizYXSTqd3OvQgbjHX2LNa
         6nJD5Ylz7RJfm1a3ZESa3Gq8/5bnKdhfBLeK++mfFAI+B8m+dAiFhLRcpQ6BpKqWW8kX
         bm4lOYFwhf3OY82E8VIhEjBgcyuqI+3aEC5rUbfcBKbtdsodcWZyqjUgkyK9tx4487c/
         75mcu0bQq0CKZUmorYxU02fRnDFJiQqGF18YoijH1Z0b9eOOdQSGV3fPTUv9m+LTPQsl
         2BGA==
X-Gm-Message-State: ANoB5pkZa+hvjQxWwHIlMR5EYOR9v2pBIKUiGNO2ER3Zx/oePyjM2UV8
        qyKxr56OemeYPtT5YyMpbA0=
X-Google-Smtp-Source: AA0mqf6/1BY6SnnV6HdjCCP1NK3mlPBSzIMnXTOcF0a1bdJvy3Gf60HZyfGVuZ7lYdy5xgp2eV7wbQ==
X-Received: by 2002:a63:4d01:0:b0:474:d6fa:f568 with SMTP id a1-20020a634d01000000b00474d6faf568mr22034602pgb.54.1668622949864;
        Wed, 16 Nov 2022 10:22:29 -0800 (PST)
Received: from [10.230.29.214] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id y10-20020a17090322ca00b00186f81bb3f0sm12646052plg.122.2022.11.16.10.22.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Nov 2022 10:22:29 -0800 (PST)
Message-ID: <f5eea352-ae46-a2e9-f7ce-406cea557806@gmail.com>
Date:   Wed, 16 Nov 2022 10:22:27 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 06/23] arm64: dts: Update cache properties for broadcom
Content-Language: en-US
To:     Pierre Gondois <pierre.gondois@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        William Zhang <william.zhang@broadcom.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
References: <20221107155825.1644604-1-pierre.gondois@arm.com>
 <20221107155825.1644604-7-pierre.gondois@arm.com>
 <8ee17547-30ef-bc85-b163-f0d9efe70fcc@gmail.com>
 <e5fe39f3-d000-5c07-a76c-044a3ac8dda5@arm.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <e5fe39f3-d000-5c07-a76c-044a3ac8dda5@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/7/2022 9:58 AM, Pierre Gondois wrote:
> 
> 
> On 11/7/22 18:31, Florian Fainelli wrote:
>> (way too many recipients, gmail's SMTP server would not allow me to
>> respond unless I moved most people to BCC now done).
>>
>> On 11/7/22 07:56, Pierre Gondois wrote:
>>> The DeviceTree Specification v0.3 specifies that the cache node
>>> 'compatible' and 'cache-level' properties are 'required'. Cf.
>>> s3.8 Multi-level and Shared Cache Nodes
>>> The 'cache-unified' property should be present if one of the
>>> properties for unified cache is present ('cache-size', ...).
>>>
>>> Update the Device Trees accordingly.
>>>
>>> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
>>> Acked-by: William Zhang <william.zhang@broadcom.com>
>>
>> This looks fine, but incomplete, you seem to have missed:
>>
>> - adding 'cache-unified' to all of the cache nodes modified in this
>> patch set that did not have one already
>>
>> - bcm63148.dtsi, bcm63178.dtsi, bcm6756.dtsi, bcm6846.dtsi,
>> bcm6855.dtsi, bcm6878.dtsi, bcm47622.dtsi
>>
>> Thanks
> 
> I indeed forgot to update some platforms in the broadcom folder.
> The other folders should be complete.

Can I expect a resend in the next few days so we have a chance of 
getting that included in 6.2? Thanks
-- 
Florian

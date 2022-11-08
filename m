Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B927620E88
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 12:19:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234065AbiKHLTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 06:19:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233792AbiKHLTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 06:19:50 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A7DD2A267
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 03:19:47 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id fn7-20020a05600c688700b003b4fb113b86so8871315wmb.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 03:19:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0O5AFmFKbf5PYRm9R8MhyT7qt2cdChWTACvWuLcX95M=;
        b=OjCBz2IPywIkBv3uzNJP3UVKFlQjnWT+B+N3u6oyR0VareSpa8U138noJM8t3Qeiaf
         S5bz3+CvI8N2l4XLjBbeNFSl99/VtAlq/b1TNTDBkh7CN9TcWpWFAYwIuwY5cKLcP06s
         J94sWKfHire1QABTQN7tfixvGcQ/sIrRkr5zl1dJHvhqqQMduMIeb/biY/sIzYsO2HL2
         bdlb9N7s2EgPd80KVRx/70a4QZv8i0dd6E8S0LBMYF7InOO5yvykKbnTgoyToBwZ5C+c
         Ebg63ghNGuvYYCCnLU5EYpc1l+hfMPRX3EC+DQCB2LZCi4gJy9FTP2x/SGDkkx0RdCJV
         LDVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0O5AFmFKbf5PYRm9R8MhyT7qt2cdChWTACvWuLcX95M=;
        b=B2CP/FNWm6o7sLaZgRFDf6tzwKYcx0NLui7CRYgIM6nXAqig37z7CvHAjgoqkp3CKX
         pEbmR2si1QonsN08CuGDw90Rj6rPsXG5QVuWK2OymGL49PbAAj2FKOeZTY66XANe5bdy
         0AxvRU0xV5LxuXcALRAdkVurQeUgGd3HREzeh2d8a98o6weddkO+cKijK51xQTByQ7nj
         dLNFbmIQhHr4RXMjQbHD0d87L9ofbpxiZn8k+oSPZxXy3IwBg3N9n+n2TrHABd2058L+
         EzdHZDdO/SV9wgslNuqz60+KNrBXDUS5GlikW+AsIS213nAqlh0MnKJRjKxpzPWChJkR
         zqhg==
X-Gm-Message-State: ACrzQf12M//KPwwmpZvBbXdsPWw+U1W89ZhNZhEOkwj75O4SPwF9Cl3P
        l5SQ07fCiESQjjWrrQRl7YN4Bw==
X-Google-Smtp-Source: AMsMyM4eCr2wrpZvg4ZTSD7ggtb9LG/QUT1MpCMe+imumvbHfaiB1fw7DnYOlTIw9aKuY2jPvU/suw==
X-Received: by 2002:a7b:c2aa:0:b0:3cf:9d25:9d76 with SMTP id c10-20020a7bc2aa000000b003cf9d259d76mr12989404wmk.192.1667906385998;
        Tue, 08 Nov 2022 03:19:45 -0800 (PST)
Received: from [192.168.0.17] (cpc152649-stkp13-2-0-cust121.10-2.cable.virginm.net. [86.15.83.122])
        by smtp.gmail.com with ESMTPSA id h7-20020a05600c314700b003a1980d55c4sm15114174wmo.47.2022.11.08.03.19.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Nov 2022 03:19:45 -0800 (PST)
Message-ID: <bcd96d79-71b2-9d6a-6397-a47162e52acc@sifive.com>
Date:   Tue, 8 Nov 2022 11:19:44 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v6 00/10] Designware PWM driver updates for OF
Content-Language: en-GB
To:     Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        linux-pwm@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        u.kleine-koenig@pengutronix.de,
        Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        William Salmon <william.salmon@sifive.com>,
        Jude Onyenegecha <jude.onyenegecha@sifive.com>
References: <20221020151610.59443-1-ben.dooks@sifive.com>
 <623284c8-f4bb-1020-2f2e-a475f424c5b5@linux.intel.com>
From:   Ben Dooks <ben.dooks@sifive.com>
In-Reply-To: <623284c8-f4bb-1020-2f2e-a475f424c5b5@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/10/2022 09:39, Jarkko Nikula wrote:
> Hi
> 
> On 10/20/22 18:16, Ben Dooks wrote:
>> This is an updated version of the Designware PWM driver updates
>> for OF support, which now splits the driver into PCI and OF parts
>> as well as tries to sort out the review comments.
>>
>> Hopefully this can now be queued for the next kernel version.
>>
>> v6:
>>   - fix removal ordering of DWC_PERIOD_NS
> 
> I did a quick test on our HW and PWM was counting as before.
> 
> Tested-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>

Just to follow up on this, should I post a v7 of this (given
I think it is all just updates for review/tested) ?

-- 
Ben


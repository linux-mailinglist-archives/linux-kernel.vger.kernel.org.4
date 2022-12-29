Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F10676589EA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 08:28:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232981AbiL2H2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 02:28:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbiL2H2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 02:28:41 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7686E000
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 23:28:39 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id fm16-20020a05600c0c1000b003d96fb976efso10545784wmb.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 23:28:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f1QWVMM2NX3o6WxH6qM4OQUF7sevgU9Z4xZ9jOr8SKc=;
        b=rCyyThj5t9/NB71QfAxlzF377LGrE0+QQOfE5fSGGemPWnRoE+byXuzZlbqiT7AVlV
         ej4PDI5Q+xhQ2z0hiKf6Ih6UwSx4ZzFLPkn1/OhdmAPK9jFC+p5aH2Ds8YNXl0w2ang7
         077eUwgt70KNd6SpP4NEDp8tBQA6tMXodV4uTwaJpq4DgyHRBOpWcEscdiA+HrzxEfPJ
         88UgdSV/D0UCAS5k0gaC4maNhsofXQeM3Avy8abl+ZVdhkEzSunlrRy6T0ZgdwTmzN3f
         3N1H7TQMsFanYLf0s/rfZE5YFA+P940pbjNKPeyX7eapV3W108CaNIuCvbV5p315sv8B
         a1dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f1QWVMM2NX3o6WxH6qM4OQUF7sevgU9Z4xZ9jOr8SKc=;
        b=1V0mDKhM4aAVoiFdC05wDPUOCvF6QVUklbDrjlAkIjZK4ZbmceTwcnf5tBnpy4Adbw
         tmZ7dN8dudC8UHJZxzI2PW408orE6Dx0hTPLjuPsT4KFSmTt1eHsZFN100LojSM01CR4
         cxitKNV2+1nLYF94aXNDT+xK95SfDpYmHKdrCtIxq3uXn7TO2FJoImsQYhoAplQSprhy
         FaZLmB+b82iFo3kHExsBdbTHyjwKjvDz/Dzs5FmkoY9y42mFQ+lncUTZ3od2TunZsB3u
         Yeav384wbqWDbE90aq7RoedJyjmrH9IqKulSWJwHEt1zTBkuTWa1+HpfAS026+nQ8TzO
         6tRw==
X-Gm-Message-State: AFqh2koEg5v47zrc6FYmEi0xfchkePxXaUEfr8xaAMRnEh/54B0MtINW
        nQJvaxCHJHmGb5kv3LHRvfET5w==
X-Google-Smtp-Source: AMrXdXvYAR+zU5UWW0ZaRRqxesy5v+Um12IM1fAq7O+wwcAgHk7O2zG9qBU80aC7QVkmAjx5ktqMRg==
X-Received: by 2002:a05:600c:18a3:b0:3d1:fcac:3c95 with SMTP id x35-20020a05600c18a300b003d1fcac3c95mr19538355wmp.34.1672298918407;
        Wed, 28 Dec 2022 23:28:38 -0800 (PST)
Received: from [192.168.30.216] ([81.0.6.76])
        by smtp.gmail.com with ESMTPSA id l42-20020a05600c1d2a00b003cfbbd54178sm43302271wms.2.2022.12.28.23.28.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Dec 2022 23:28:37 -0800 (PST)
Message-ID: <0c7ea5cd-1623-ddec-91e5-9d576b079349@linaro.org>
Date:   Thu, 29 Dec 2022 08:28:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH qemu] x86: don't let decompressed kernel image clobber
 setup_data
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     pbonzini@redhat.com, ebiggers@kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, qemu-devel@nongnu.org,
        ardb@kernel.org, kraxel@redhat.com, bp@alien8.de
References: <20221228143831.396245-1-Jason@zx2c4.com>
 <6cab26b5-06ae-468d-ac79-ecdecb86ef07@linaro.org>
 <Y6xvJheSYC83voCZ@zx2c4.com> <Y6x1knb8udpSyMSp@zx2c4.com>
 <9188EEE9-2759-4389-B39E-0FEBBA3FA57D@zytor.com> <Y6z765zHrQ6Rl/0o@zx2c4.com>
Content-Language: en-US
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <Y6z765zHrQ6Rl/0o@zx2c4.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/12/22 03:31, Jason A. Donenfeld wrote:
> Hi,
> 
> Read this message in a fixed width text editor with a lot of columns.
> 
> On Wed, Dec 28, 2022 at 03:58:12PM -0800, H. Peter Anvin wrote:
>> Glad you asked.
>>
>> So the kernel load addresses are parameterized in the kernel image
>> setup header. One of the things that are so parameterized are the size
>> and possible realignment of the kernel image in memory.
>>
>> I'm very confused where you are getting the 64 MB number from. There
>> should not be any such limitation.

[...]

Thanks for the diagrams. Feel free to include them in the commit
description ;)

>> In general, setup_data should be able to go anywhere the initrd can
>> go, and so is subject to the same address cap (896 MB for old kernels,
>> 4 GB on newer ones; this address too is enumerated in the header.)
> 
> It would be theoretically possible to attach it to the initrd image
> instead of to the kernel image. As a last resort, I guess I can look
> into doing that. However, that's going to require some serious rework
> and plumbing of a lot of different components. So if I can make it work
> as is, that'd be ideal. However, I need to figure out this weird 62 meg
> limitation.
> 
> Any ideas on that?

Could it be a limitation (internal buffer) of the decompressor?

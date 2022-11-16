Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9E4462CE97
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 00:16:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233459AbiKPXQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 18:16:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233151AbiKPXQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 18:16:40 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 785A3BE29
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 15:16:39 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id c15so117479qtw.8
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 15:16:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E5ndd7ei1Io74IlQNCg2RVaEkTuSWT2qBGbUwsf9a6A=;
        b=qu9xX9JFKy5ec+Zn86JfnVrvTPOeTV6dVLitbqBNEV5H6OxO3M0ZkQrwKxLpYVE60d
         eh6dQbJmCtqv4299RJrP2Q4UVMtWv32gv5yIg4cwNS5IEd39y+miraEXBhsHgJjGLrQR
         yZEU6OEj32doL+QijPBX46ZSEkDtKBC0XVYkSGr5s+1yrSHp0IRU6s54ZJ80arhH17GA
         V1bttUa9WhFN1zSiIHm7Iphq3w1jQGOeVV+a9pAHqpGJ/Gddoj2EqgxAT5VOz6rjns3q
         eghi64+NCseYt02+rf7IYkPuyqMzDFdKdglbAXbpvdG2h8CSgvQc5E6Q7vMsLu+WF3nu
         /6vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E5ndd7ei1Io74IlQNCg2RVaEkTuSWT2qBGbUwsf9a6A=;
        b=pDRlceh5J0qG67qdyV5gkQFoDRagnjhG0DVRcCgY9aBANw8c9qSGg67XgOWBvx+7JG
         EHeN95PsX5Bsg8etB3ioqWjRA+BVjcbNIr7IQH7WVhn+4t+o5x9oqOsi6SwoHe5fCAr5
         fLZYODj827xEfRfJCqzYRXvaJfxtAGqPivlYdN8UuMHIz6BkDH0B6+vEoq3gZhKpUalT
         xS+VzUeqY/tMTVbQ0rTHfk+E3rT8bRiw8ODZgUGix2l5a+ipXY56yS7i+E2esyulAhv0
         vFBtrfDUHm0t/VGCnN46lPAtmlTV8W4uoND88nXbF7dCN8CMQVb1Nu+pEPIySmpyAXvs
         bS1g==
X-Gm-Message-State: ANoB5pkPVVL3lCCsZcF/ExrVCOe3djVtjGM5GYGOOLedW/GOsgfQui/L
        0EwGUMcUFnoMMR0UtY3EoqrRi1j9WSo=
X-Google-Smtp-Source: AA0mqf6NoC0bvV/GDfS29nJWFyzAeHkUloMtVDeDFqpmF9D05opjhaNqxB7WK5ftx8vvcDmG0BIz9w==
X-Received: by 2002:ac8:738b:0:b0:3a4:f6ab:6670 with SMTP id t11-20020ac8738b000000b003a4f6ab6670mr144692qtp.283.1668640598547;
        Wed, 16 Nov 2022 15:16:38 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id e7-20020ac84b47000000b0039953dcc480sm9430138qts.88.2022.11.16.15.16.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Nov 2022 15:16:38 -0800 (PST)
Message-ID: <15631f6a-dae6-b996-6e74-1bf7304b30a0@gmail.com>
Date:   Wed, 16 Nov 2022 15:16:32 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: kbuild: check the minimum compiler version in Kconfig
Content-Language: en-US
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Nathan Chancellor <natechancellor@gmail.com>, ojeda@kernel.org,
        sedat.dilek@gmail.com, clang-built-linux <llvm@lists.linux.dev>,
        Manoj Gupta <manojgupta@google.com>
References: <fe18ed06-12f1-1dcb-71ee-aec5a5d656ea@gmail.com>
 <CAKwvOdnx_hyf=3DZtU_P8icWa07jf1+baNgM9MBh_ojE-EK5=A@mail.gmail.com>
 <d7e0fbca-7e9d-fbe2-6f8c-6e60a78f56df@gmail.com>
 <CAKwvOdnNA7pFGNuord-yiArE55oPNCCwCOHdrVQiRiATtYC23g@mail.gmail.com>
 <CAKwvOdmP+VgjsJGuvuC9q3RbwpqUwoNg6cyv3f5SjAqLc2K3_Q@mail.gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <CAKwvOdmP+VgjsJGuvuC9q3RbwpqUwoNg6cyv3f5SjAqLc2K3_Q@mail.gmail.com>
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

On 11/16/22 15:11, Nick Desaulniers wrote:
> On Wed, Nov 16, 2022 at 3:10 PM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
>>
>> On Wed, Nov 16, 2022 at 2:56 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
>>>
>>> On 11/16/22 14:48, Nick Desaulniers wrote:
>>>> On Wed, Nov 16, 2022 at 1:48 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
>>>>>
>>>>> Hi Masahiro, Nick,
>>>>>
>>>>> The compiler version check performed with
>>>>> aec6c60a01d3a3170242d6a99372a388e1136dc6 ("kbuild: check the minimum
>>>>> compiler version in Kconfig") can be defeated and prevent running the
>>>>> *config targets if specifying LLVM=1 on the command line, in that way:
>>>>>
>>>>> BR_BINARIES_DIR=/local/users/fainelli/buildroot-llvm/output/arm64/images
>>>>> LLVM=1 LLVM_IAS=1 PKG_CONFIG_PATH="" /usr/bin/make -j49 -C
>>>>> /local/users/fainelli/buildroot-llvm/output/arm64/build/linux-custom
>>>>> HOSTCC="/usr/bin/gcc"
>>>>> HOSTCC="/local/users/fainelli/buildroot-llvm/output/arm64/host/bin/ccache
>>>>> /usr/bin/gcc -O2
>>>>> -I/local/users/fainelli/buildroot-llvm/output/arm64/host/include
>>>>> -DNDEBUG -L/local/users/fainelli/buildroot-llvm/output/arm64/host/lib
>>>>> -Wl,-rpath,/local/users/fainelli/buildroot-llvm/output/arm64/host/lib"
>>>>> ARCH=arm64
>>>>> INSTALL_MOD_PATH=/local/users/fainelli/buildroot-llvm/output/arm64/target
>>>>> CROSS_COMPILE="/local/users/fainelli/buildroot-llvm/output/arm64/host/bin/aarch64-linux-"
>>>>> WERROR=0
>>>>> DEPMOD=/local/users/fainelli/buildroot-llvm/output/arm64/host/sbin/depmod
>>>>> INSTALL_MOD_STRIP=1 HOSTCC="/usr/bin/gcc" menuconfig
>>>>>      UPD     scripts/kconfig/mconf-cfg
>>>>>      HOSTCC  scripts/kconfig/mconf.o
>>>>>      HOSTCC  scripts/kconfig/lxdialog/checklist.o
>>>>>      HOSTCC  scripts/kconfig/lxdialog/inputbox.o
>>>>>      HOSTCC  scripts/kconfig/lxdialog/menubox.o
>>>>>      HOSTCC  scripts/kconfig/lxdialog/textbox.o
>>>>>      HOSTCC  scripts/kconfig/lxdialog/util.o
>>>>>      HOSTCC  scripts/kconfig/lxdialog/yesno.o
>>>>>      HOSTLD  scripts/kconfig/mconf
>>>>> ***
>>>>> *** Compiler is too old.
>>>>> ***   Your Clang version:    10.0.0
>>>>> ***   Minimum Clang version: 10.0.1
>>>>> ***
>>>>> scripts/Kconfig.include:44: Sorry, this compiler is not supported.
>>>>>
>>>>> Here, the compiler check is actually checking the host compiler clang
>>>>> version installed on my Ubuntu 20.04 system, as opposed to the cross
>>>>> compiler clang version that is being used.
>>>>
>>>> LLVM=1 will use `clang` as found by your $PATH.  Where did you express
>>>> to make what the "cross compiler clang version" is? (And why do you
>>>> set HOSTCC three times)
>>>
>>> We are setting CROSS_COMPILE to express the cross compiler clang prefix
>>> to use.
>>
>> Can you try setting CLANG_PREFIX rather than CROSS_COMPILE (to the same value)?
>>
>> CLANG_PREFIX=/local/users/fainelli/buildroot-llvm/output/arm64/host/bin/aarch64-linux-
> 
> sorry, I meant LLVM_PREFIX

Same results unfortunately.
-- 
Florian


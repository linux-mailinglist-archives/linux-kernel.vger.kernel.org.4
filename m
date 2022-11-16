Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE21362CE20
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 23:56:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234644AbiKPW43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 17:56:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233768AbiKPW4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 17:56:25 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3684686AA
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 14:56:19 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id fz10so107154qtb.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 14:56:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xfJlQEP92YS0NjB+oiA9kJdEe5qCUh9YYGHpqPj8MjM=;
        b=nCSIfsrQAH8URAmi8RFfSGAc8apobHnTfmK+fXKbMMfCClpw/Vj2pQzbZtDBMv42qv
         fOz44o+5Z65e2g/Lr4gqrOBmKBKFdYHVm4nYCASgZpEZh0wLZRja6gxQZjjt14P0BXx6
         TL3VHei1XqvBQ5DBledoy5/XplxbVDBX+fq68Xf2uaSo/jr+hzRPDJ7x9Bzy3xQaOLv4
         arOjMYJ/SerbYrZc0DEkvAW8R/nlOiePwP6EUCGllCKu6eio9O4yhitvyMXGLBlJJzyV
         +Z2CAzc1Yilcmg/xgmLhvAWatg0zjMxZhvpY3DUjONF1NO4Yn9NPsGKjOQ2/+tA+QRRI
         F9cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xfJlQEP92YS0NjB+oiA9kJdEe5qCUh9YYGHpqPj8MjM=;
        b=CI6+w4cxEg6rNElATyf5g0KZq9fdsxQGHG/GZZyl3ZYRV1vO7Bu0eronNVLpBBQScP
         5ttkxWL8h58JdEkGqLR0YfYFsNHgyzXoIayxXBMRa6E+iksDH75unH5NdooSnlYFg3pB
         8CrcM2gDlHUKMc35dZSqumoEAldcsiPeduVHfN3qwerVga/v0p0s79MHIE1Aefp/jKWN
         hAKQG+XdQrusD6LMcXVvEhA9JGiZ/KHTzaHPPItiPN4fkiINoz+RbVJWA8qBKRtMNHlx
         kcGS7A68UtNd3bqt2v8nc2kJxjW8o8bVGOMaBJ1d9NMqpm5VfPrdIG/WiDwHUHHfW542
         dzTw==
X-Gm-Message-State: ANoB5plpP+x/At3vHuDUWnv7pe3wPK6e/pagzAvNDuAF3CxuMHvKGWiq
        tp4hEvxdhir3mHtdBfxGcUire9YyL6w=
X-Google-Smtp-Source: AA0mqf5nOIxbWkeDwItY8A3xDUQLM6sH8Fhas8OiclyrwSw13jgyz3v1Cqno0R0jiWeBygj723uQUg==
X-Received: by 2002:a05:622a:1dca:b0:3a4:f2b7:6e5 with SMTP id bn10-20020a05622a1dca00b003a4f2b706e5mr98682qtb.183.1668639378546;
        Wed, 16 Nov 2022 14:56:18 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id ay42-20020a05622a22aa00b0039a08c0a594sm9395822qtb.82.2022.11.16.14.56.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Nov 2022 14:56:17 -0800 (PST)
Message-ID: <d7e0fbca-7e9d-fbe2-6f8c-6e60a78f56df@gmail.com>
Date:   Wed, 16 Nov 2022 14:56:09 -0800
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
        sedat.dilek@gmail.com
References: <fe18ed06-12f1-1dcb-71ee-aec5a5d656ea@gmail.com>
 <CAKwvOdnx_hyf=3DZtU_P8icWa07jf1+baNgM9MBh_ojE-EK5=A@mail.gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <CAKwvOdnx_hyf=3DZtU_P8icWa07jf1+baNgM9MBh_ojE-EK5=A@mail.gmail.com>
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

On 11/16/22 14:48, Nick Desaulniers wrote:
> On Wed, Nov 16, 2022 at 1:48 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
>>
>> Hi Masahiro, Nick,
>>
>> The compiler version check performed with
>> aec6c60a01d3a3170242d6a99372a388e1136dc6 ("kbuild: check the minimum
>> compiler version in Kconfig") can be defeated and prevent running the
>> *config targets if specifying LLVM=1 on the command line, in that way:
>>
>> BR_BINARIES_DIR=/local/users/fainelli/buildroot-llvm/output/arm64/images
>> LLVM=1 LLVM_IAS=1 PKG_CONFIG_PATH="" /usr/bin/make -j49 -C
>> /local/users/fainelli/buildroot-llvm/output/arm64/build/linux-custom
>> HOSTCC="/usr/bin/gcc"
>> HOSTCC="/local/users/fainelli/buildroot-llvm/output/arm64/host/bin/ccache
>> /usr/bin/gcc -O2
>> -I/local/users/fainelli/buildroot-llvm/output/arm64/host/include
>> -DNDEBUG -L/local/users/fainelli/buildroot-llvm/output/arm64/host/lib
>> -Wl,-rpath,/local/users/fainelli/buildroot-llvm/output/arm64/host/lib"
>> ARCH=arm64
>> INSTALL_MOD_PATH=/local/users/fainelli/buildroot-llvm/output/arm64/target
>> CROSS_COMPILE="/local/users/fainelli/buildroot-llvm/output/arm64/host/bin/aarch64-linux-"
>> WERROR=0
>> DEPMOD=/local/users/fainelli/buildroot-llvm/output/arm64/host/sbin/depmod
>> INSTALL_MOD_STRIP=1 HOSTCC="/usr/bin/gcc" menuconfig
>>     UPD     scripts/kconfig/mconf-cfg
>>     HOSTCC  scripts/kconfig/mconf.o
>>     HOSTCC  scripts/kconfig/lxdialog/checklist.o
>>     HOSTCC  scripts/kconfig/lxdialog/inputbox.o
>>     HOSTCC  scripts/kconfig/lxdialog/menubox.o
>>     HOSTCC  scripts/kconfig/lxdialog/textbox.o
>>     HOSTCC  scripts/kconfig/lxdialog/util.o
>>     HOSTCC  scripts/kconfig/lxdialog/yesno.o
>>     HOSTLD  scripts/kconfig/mconf
>> ***
>> *** Compiler is too old.
>> ***   Your Clang version:    10.0.0
>> ***   Minimum Clang version: 10.0.1
>> ***
>> scripts/Kconfig.include:44: Sorry, this compiler is not supported.
>>
>> Here, the compiler check is actually checking the host compiler clang
>> version installed on my Ubuntu 20.04 system, as opposed to the cross
>> compiler clang version that is being used.
> 
> LLVM=1 will use `clang` as found by your $PATH.  Where did you express
> to make what the "cross compiler clang version" is? (And why do you
> set HOSTCC three times)

We are setting CROSS_COMPILE to express the cross compiler clang prefix 
to use.

Setting HOSTCC three times is done by buildroot, it does it through make 
flags, and then variables passed to make etc. clearly we could change 
that, but that's out of scope is not it?
-- 
Florian


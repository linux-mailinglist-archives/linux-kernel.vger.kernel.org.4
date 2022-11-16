Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B14CA62CCFA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 22:49:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234852AbiKPVtj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 16:49:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234379AbiKPVtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 16:49:18 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8692427B0A
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 13:48:35 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id k7so17676445pll.6
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 13:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bLDVzacsp5WUVnn/fUxAK3n5BZ6pZUKtQ8LTVvJ8eu4=;
        b=cb58RpNMwEz6ZoBaRnpesyUZGx3Ix6kEKUp+mwPXcZUnfwcHlbPCFKw5VrP4jWPtbn
         aTfXfgsYb3fhCpOMSNk2218Ontd8Z1HodFvP4KlBDysmOS4Md6j8y//Qs1ri7g0Ej0kC
         l+xbe+MTHBn25DMAzr1bXE3835j1eDdf4LLPdOIzqlXELXO5vAfkPGVXwMb6b3iU04OQ
         gNXXttgafiNIEUrux/XLlJ6AhE5M16Tc21wTlyKa+MgXVxNGUrHFPph7gzXlrCsb08YC
         yw1j2LXZDOaKrDju09Hf2W+FJGPE5KZUropkv8Zwr0nvp3kwUVmNKvt5q/boh7JYbNAp
         Zd5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bLDVzacsp5WUVnn/fUxAK3n5BZ6pZUKtQ8LTVvJ8eu4=;
        b=w86hykjx2nHXyubJuy+n/+zAyyWIPs88na7T0ZB6rV3VPjM54zSoDkKz8DWIt1ZF4y
         Yui3H0CoaLsQbYQXt3UvTAA3DQgz9y7RdCJiUr/QZes1M5lDwHobyPu5NmFADPzEbTkr
         U0G1U0PUN17YmKoKSthJUM3QJFebUkrfvso9zDNuEgy4YfA2hP2cjFHGy4MHy9CfoXL6
         6E06paNvA7/hzEUCaQoQ5nxdYy3FsJIMKGPvlEmPEjllL88WSPxVq5MQ2DtjST7NR2dW
         qwTF1Hdmm9wqPtRosg49VlIKgu/f2UK/38qz9HJWz5lo54x87VM/Qbie7bIx2ud6M3pg
         PZng==
X-Gm-Message-State: ANoB5pkOr80rvFLdIS+Fcl3i50nn30V8s4rc/7uPUvz97K+3hfb+Cw+Q
        LT9vFZX0hJkWE5AoNYL19a6yJvPg0Brg1A==
X-Google-Smtp-Source: AA0mqf4mJDrqKOCVXdv6icsZVqfuN6+g5yOMMyUYoWuDMP1SflKJVDIsdApXgd+ULVBTe0ruYY5fBA==
X-Received: by 2002:a17:902:6a8c:b0:188:b840:deec with SMTP id n12-20020a1709026a8c00b00188b840deecmr11044412plk.15.1668635314939;
        Wed, 16 Nov 2022 13:48:34 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id c1-20020a170902d48100b00178a9b193cfsm12910372plg.140.2022.11.16.13.48.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Nov 2022 13:48:34 -0800 (PST)
Message-ID: <fe18ed06-12f1-1dcb-71ee-aec5a5d656ea@gmail.com>
Date:   Wed, 16 Nov 2022 13:48:28 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Content-Language: en-US
To:     Masahiro Yamada <masahiroy@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: kbuild: check the minimum compiler version in Kconfig
Cc:     Paul Gortmaker <paul.gortmaker@windriver.com>,
        Nathan Chancellor <natechancellor@gmail.com>, ojeda@kernel.org,
        sedat.dilek@gmail.com
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahiro, Nick,

The compiler version check performed with 
aec6c60a01d3a3170242d6a99372a388e1136dc6 ("kbuild: check the minimum 
compiler version in Kconfig") can be defeated and prevent running the 
*config targets if specifying LLVM=1 on the command line, in that way:

BR_BINARIES_DIR=/local/users/fainelli/buildroot-llvm/output/arm64/images 
LLVM=1 LLVM_IAS=1 PKG_CONFIG_PATH="" /usr/bin/make -j49 -C 
/local/users/fainelli/buildroot-llvm/output/arm64/build/linux-custom 
HOSTCC="/usr/bin/gcc" 
HOSTCC="/local/users/fainelli/buildroot-llvm/output/arm64/host/bin/ccache 
/usr/bin/gcc -O2 
-I/local/users/fainelli/buildroot-llvm/output/arm64/host/include 
-DNDEBUG -L/local/users/fainelli/buildroot-llvm/output/arm64/host/lib 
-Wl,-rpath,/local/users/fainelli/buildroot-llvm/output/arm64/host/lib" 
ARCH=arm64 
INSTALL_MOD_PATH=/local/users/fainelli/buildroot-llvm/output/arm64/target 
CROSS_COMPILE="/local/users/fainelli/buildroot-llvm/output/arm64/host/bin/aarch64-linux-" 
WERROR=0 
DEPMOD=/local/users/fainelli/buildroot-llvm/output/arm64/host/sbin/depmod 
INSTALL_MOD_STRIP=1 HOSTCC="/usr/bin/gcc" menuconfig
   UPD     scripts/kconfig/mconf-cfg
   HOSTCC  scripts/kconfig/mconf.o
   HOSTCC  scripts/kconfig/lxdialog/checklist.o
   HOSTCC  scripts/kconfig/lxdialog/inputbox.o
   HOSTCC  scripts/kconfig/lxdialog/menubox.o
   HOSTCC  scripts/kconfig/lxdialog/textbox.o
   HOSTCC  scripts/kconfig/lxdialog/util.o
   HOSTCC  scripts/kconfig/lxdialog/yesno.o
   HOSTLD  scripts/kconfig/mconf
***
*** Compiler is too old.
***   Your Clang version:    10.0.0
***   Minimum Clang version: 10.0.1
***
scripts/Kconfig.include:44: Sorry, this compiler is not supported.

Here, the compiler check is actually checking the host compiler clang 
version installed on my Ubuntu 20.04 system, as opposed to the cross 
compiler clang version that is being used.

It is not clear to me how to best address that, short of not specifying 
LLVM=1 on the kernel *config targets, but IMHO there is still an actual 
issue where we do not check the compiler that we would want to check.

Thanks!
-- 
Florian

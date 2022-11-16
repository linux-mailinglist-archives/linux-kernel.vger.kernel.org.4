Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D01162CE87
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 00:11:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233702AbiKPXLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 18:11:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233551AbiKPXLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 18:11:12 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F0AF48759
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 15:11:11 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id b11so67915pjp.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 15:11:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6/uZ+ThofFLV0o5Tr1f+GtX311JSydF+TNhDZdXxL+Y=;
        b=sw25RevSzPxyBTlqYrV7fZBs1zlbP4R/PRdnjJiozTdyYdVEgfjiN6sq3QvpQnKmYb
         A9KrAmO8LUSsUg9QWILrOJIZQgbJD3EVfVq/OTKCiRW+0hMAAfGBQS+8d8bOwO5P86A9
         cQ+ULosSAcn8mGQ7oWXdMyc5kh+hHkbH5qY/aMafHKvBy6BYXeV7TWVZ0YbdBFnu8PKV
         7mBB3IvjzV9Xx6ODVxqv8/Lhkl55Bke5K7MmTUJUiC8vbHuU/oqeWqf+TjU6T/zkzr3e
         ztN78L8GLBHOc2ZDEo2a2Vhq0gUVbwv0fiQChVobCObCzPTMp+YcuufmUN0GBPORipUS
         /1pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6/uZ+ThofFLV0o5Tr1f+GtX311JSydF+TNhDZdXxL+Y=;
        b=loCKSqrnI87H/RuA5nXgdQC39yad6eYgHgPHqyXsPXkk6uZuMNhZPSR+OiJJa3MzIf
         4V6xkbuwvmUHHecjubttfci35twNaXfXJXs2r+IDjUO/NkmCrR/Gq1YPiyAI4YL/3Qwm
         eIBldvn23ywH00bV5WO5WdG8QhunT7QJCQKgyWuNshDf3rO8dMIbBcE1wRSii679FxjH
         AAeEBfge7wtLH/g/pESzNVDAdMj0Qc+LZIjQjr5gV3U+QSqDbGYVcoR4fuj40t9wknFT
         /VIabnOEAJrn8VIhApWPI6VXXeDt0ajuWCoXvVL05v8/fN5LAzeg2dKJNkWU/rOA0INm
         iPLQ==
X-Gm-Message-State: ANoB5pmK4u3EZVRNuxtKIxocipR6hx9WrsGCMtumQR8Js7zksNfsB65v
        mJcP956iaEAyAAi3fpxFX4xk/e2H0apIYC2bOi3Kd1RzMktHYw==
X-Google-Smtp-Source: AA0mqf48zuVhwaeoLsQEIGf5w3oJzTf0ujy22FczYj0b6cnG2AKtGbnjwBM+ICv/7pf79Sub2eMPb5g2VP+rcm7A7SY=
X-Received: by 2002:a17:902:7086:b0:186:de87:7ffd with SMTP id
 z6-20020a170902708600b00186de877ffdmr34381plk.94.1668640270546; Wed, 16 Nov
 2022 15:11:10 -0800 (PST)
MIME-Version: 1.0
References: <fe18ed06-12f1-1dcb-71ee-aec5a5d656ea@gmail.com>
 <CAKwvOdnx_hyf=3DZtU_P8icWa07jf1+baNgM9MBh_ojE-EK5=A@mail.gmail.com> <d7e0fbca-7e9d-fbe2-6f8c-6e60a78f56df@gmail.com>
In-Reply-To: <d7e0fbca-7e9d-fbe2-6f8c-6e60a78f56df@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 16 Nov 2022 15:10:59 -0800
Message-ID: <CAKwvOdnNA7pFGNuord-yiArE55oPNCCwCOHdrVQiRiATtYC23g@mail.gmail.com>
Subject: Re: kbuild: check the minimum compiler version in Kconfig
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Nathan Chancellor <natechancellor@gmail.com>, ojeda@kernel.org,
        sedat.dilek@gmail.com, clang-built-linux <llvm@lists.linux.dev>,
        Manoj Gupta <manojgupta@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2022 at 2:56 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
>
> On 11/16/22 14:48, Nick Desaulniers wrote:
> > On Wed, Nov 16, 2022 at 1:48 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
> >>
> >> Hi Masahiro, Nick,
> >>
> >> The compiler version check performed with
> >> aec6c60a01d3a3170242d6a99372a388e1136dc6 ("kbuild: check the minimum
> >> compiler version in Kconfig") can be defeated and prevent running the
> >> *config targets if specifying LLVM=1 on the command line, in that way:
> >>
> >> BR_BINARIES_DIR=/local/users/fainelli/buildroot-llvm/output/arm64/images
> >> LLVM=1 LLVM_IAS=1 PKG_CONFIG_PATH="" /usr/bin/make -j49 -C
> >> /local/users/fainelli/buildroot-llvm/output/arm64/build/linux-custom
> >> HOSTCC="/usr/bin/gcc"
> >> HOSTCC="/local/users/fainelli/buildroot-llvm/output/arm64/host/bin/ccache
> >> /usr/bin/gcc -O2
> >> -I/local/users/fainelli/buildroot-llvm/output/arm64/host/include
> >> -DNDEBUG -L/local/users/fainelli/buildroot-llvm/output/arm64/host/lib
> >> -Wl,-rpath,/local/users/fainelli/buildroot-llvm/output/arm64/host/lib"
> >> ARCH=arm64
> >> INSTALL_MOD_PATH=/local/users/fainelli/buildroot-llvm/output/arm64/target
> >> CROSS_COMPILE="/local/users/fainelli/buildroot-llvm/output/arm64/host/bin/aarch64-linux-"
> >> WERROR=0
> >> DEPMOD=/local/users/fainelli/buildroot-llvm/output/arm64/host/sbin/depmod
> >> INSTALL_MOD_STRIP=1 HOSTCC="/usr/bin/gcc" menuconfig
> >>     UPD     scripts/kconfig/mconf-cfg
> >>     HOSTCC  scripts/kconfig/mconf.o
> >>     HOSTCC  scripts/kconfig/lxdialog/checklist.o
> >>     HOSTCC  scripts/kconfig/lxdialog/inputbox.o
> >>     HOSTCC  scripts/kconfig/lxdialog/menubox.o
> >>     HOSTCC  scripts/kconfig/lxdialog/textbox.o
> >>     HOSTCC  scripts/kconfig/lxdialog/util.o
> >>     HOSTCC  scripts/kconfig/lxdialog/yesno.o
> >>     HOSTLD  scripts/kconfig/mconf
> >> ***
> >> *** Compiler is too old.
> >> ***   Your Clang version:    10.0.0
> >> ***   Minimum Clang version: 10.0.1
> >> ***
> >> scripts/Kconfig.include:44: Sorry, this compiler is not supported.
> >>
> >> Here, the compiler check is actually checking the host compiler clang
> >> version installed on my Ubuntu 20.04 system, as opposed to the cross
> >> compiler clang version that is being used.
> >
> > LLVM=1 will use `clang` as found by your $PATH.  Where did you express
> > to make what the "cross compiler clang version" is? (And why do you
> > set HOSTCC three times)
>
> We are setting CROSS_COMPILE to express the cross compiler clang prefix
> to use.

Can you try setting CLANG_PREFIX rather than CROSS_COMPILE (to the same value)?

CLANG_PREFIX=/local/users/fainelli/buildroot-llvm/output/arm64/host/bin/aarch64-linux-


>
> Setting HOSTCC three times is done by buildroot, it does it through make
> flags, and then variables passed to make etc. clearly we could change
> that, but that's out of scope is not it?
> --
> Florian
>


--
Thanks,
~Nick Desaulniers

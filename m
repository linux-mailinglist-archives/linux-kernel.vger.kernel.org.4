Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27CD362CE89
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 00:12:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233933AbiKPXMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 18:12:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiKPXMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 18:12:10 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43F4948759
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 15:12:09 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id n17so345543pgh.9
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 15:12:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lOpUt4MEJD12Cx7f2vbHFt5WAvFTf2t/WiLzrqLvSWE=;
        b=DIlI543KOUa7IEfy+QPTu5triJKIlMWH2SLf+ZUpGlw7Cbt+AtaIPQ6401eYKCACSq
         M/orPGBoXiCcalGNKWlsY7xgn5CPX1tqN+bw2DtWJtQC2Zy0xii7b3bkJiL00eqA3y+l
         uNcLndMqQtdewduelBatcW1vbHZM2aw+vE19i4sFnzegEnA0xxRmuUkifWwASF7NILHB
         9nh631rIt8XQMdlB0DjEazJzWrlp9qheZyCXOYHusv8eYqvdarIrQubBVI4A1SagTKk9
         GRKPAZtfcy7WRE4C/X9mf6pNGEFEl4chz9AhjQTl6zFz1j+U6o6XGgd9foKWvLsBFbQT
         edkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lOpUt4MEJD12Cx7f2vbHFt5WAvFTf2t/WiLzrqLvSWE=;
        b=q5Jco7nma2LTI81DtJiOgv+Xkx4iwOh/dIuZEnEOghe01D47FTYYZGzDPo7UsrQM6w
         SVLOd1Q0QRAteCkR3+FryzpAi/ci2hFM6kwx0PYGLoDphbY+nVieQq3nM7AURYzStEdN
         BVfV+54xVa2Y7+5xQ+J4MM3IjeLGLvHnm+iMnSZhmZsqkpJrXOloQpipCZ8dvl7sIXqj
         ZzG9E8p5knt75ljnEwrn+zZTKuZ/FmAT1w1yPOEuRHm+H1f1n4gOvD+7Aq0gZlFJ81gQ
         Ysc3ucfmqI+fRnpLQMJXbSrx/+2rosz+WGzYBrWqvVoZ9YWJuW5Ey5e5DDmvH4B1YEUG
         CMNg==
X-Gm-Message-State: ANoB5pkyKS81MF1essYP3fwbH8XLe91CyVXaohAJL1x8KjbVx/uWOOD0
        HBXvLHc2IkeryRxTiKzjTC0Xfn3fgDvzHcaxgiaozQ==
X-Google-Smtp-Source: AA0mqf43ki7XjbQ2ZiztfxEjqkL5NoA1N+7JHmbpV5rb8PW1UOPdvdRwzl+zbjSFf1fz965IGQwQwJlG5HJ9Yak2ZFY=
X-Received: by 2002:a62:1a05:0:b0:56c:1277:d056 with SMTP id
 a5-20020a621a05000000b0056c1277d056mr295541pfa.23.1668640328441; Wed, 16 Nov
 2022 15:12:08 -0800 (PST)
MIME-Version: 1.0
References: <fe18ed06-12f1-1dcb-71ee-aec5a5d656ea@gmail.com>
 <CAKwvOdnx_hyf=3DZtU_P8icWa07jf1+baNgM9MBh_ojE-EK5=A@mail.gmail.com>
 <d7e0fbca-7e9d-fbe2-6f8c-6e60a78f56df@gmail.com> <CAKwvOdnNA7pFGNuord-yiArE55oPNCCwCOHdrVQiRiATtYC23g@mail.gmail.com>
In-Reply-To: <CAKwvOdnNA7pFGNuord-yiArE55oPNCCwCOHdrVQiRiATtYC23g@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 16 Nov 2022 15:11:57 -0800
Message-ID: <CAKwvOdmP+VgjsJGuvuC9q3RbwpqUwoNg6cyv3f5SjAqLc2K3_Q@mail.gmail.com>
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

On Wed, Nov 16, 2022 at 3:10 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Wed, Nov 16, 2022 at 2:56 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
> >
> > On 11/16/22 14:48, Nick Desaulniers wrote:
> > > On Wed, Nov 16, 2022 at 1:48 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
> > >>
> > >> Hi Masahiro, Nick,
> > >>
> > >> The compiler version check performed with
> > >> aec6c60a01d3a3170242d6a99372a388e1136dc6 ("kbuild: check the minimum
> > >> compiler version in Kconfig") can be defeated and prevent running the
> > >> *config targets if specifying LLVM=1 on the command line, in that way:
> > >>
> > >> BR_BINARIES_DIR=/local/users/fainelli/buildroot-llvm/output/arm64/images
> > >> LLVM=1 LLVM_IAS=1 PKG_CONFIG_PATH="" /usr/bin/make -j49 -C
> > >> /local/users/fainelli/buildroot-llvm/output/arm64/build/linux-custom
> > >> HOSTCC="/usr/bin/gcc"
> > >> HOSTCC="/local/users/fainelli/buildroot-llvm/output/arm64/host/bin/ccache
> > >> /usr/bin/gcc -O2
> > >> -I/local/users/fainelli/buildroot-llvm/output/arm64/host/include
> > >> -DNDEBUG -L/local/users/fainelli/buildroot-llvm/output/arm64/host/lib
> > >> -Wl,-rpath,/local/users/fainelli/buildroot-llvm/output/arm64/host/lib"
> > >> ARCH=arm64
> > >> INSTALL_MOD_PATH=/local/users/fainelli/buildroot-llvm/output/arm64/target
> > >> CROSS_COMPILE="/local/users/fainelli/buildroot-llvm/output/arm64/host/bin/aarch64-linux-"
> > >> WERROR=0
> > >> DEPMOD=/local/users/fainelli/buildroot-llvm/output/arm64/host/sbin/depmod
> > >> INSTALL_MOD_STRIP=1 HOSTCC="/usr/bin/gcc" menuconfig
> > >>     UPD     scripts/kconfig/mconf-cfg
> > >>     HOSTCC  scripts/kconfig/mconf.o
> > >>     HOSTCC  scripts/kconfig/lxdialog/checklist.o
> > >>     HOSTCC  scripts/kconfig/lxdialog/inputbox.o
> > >>     HOSTCC  scripts/kconfig/lxdialog/menubox.o
> > >>     HOSTCC  scripts/kconfig/lxdialog/textbox.o
> > >>     HOSTCC  scripts/kconfig/lxdialog/util.o
> > >>     HOSTCC  scripts/kconfig/lxdialog/yesno.o
> > >>     HOSTLD  scripts/kconfig/mconf
> > >> ***
> > >> *** Compiler is too old.
> > >> ***   Your Clang version:    10.0.0
> > >> ***   Minimum Clang version: 10.0.1
> > >> ***
> > >> scripts/Kconfig.include:44: Sorry, this compiler is not supported.
> > >>
> > >> Here, the compiler check is actually checking the host compiler clang
> > >> version installed on my Ubuntu 20.04 system, as opposed to the cross
> > >> compiler clang version that is being used.
> > >
> > > LLVM=1 will use `clang` as found by your $PATH.  Where did you express
> > > to make what the "cross compiler clang version" is? (And why do you
> > > set HOSTCC three times)
> >
> > We are setting CROSS_COMPILE to express the cross compiler clang prefix
> > to use.
>
> Can you try setting CLANG_PREFIX rather than CROSS_COMPILE (to the same value)?
>
> CLANG_PREFIX=/local/users/fainelli/buildroot-llvm/output/arm64/host/bin/aarch64-linux-

sorry, I meant LLVM_PREFIX

>
>
> >
> > Setting HOSTCC three times is done by buildroot, it does it through make
> > flags, and then variables passed to make etc. clearly we could change
> > that, but that's out of scope is not it?
> > --
> > Florian
> >
>
>
> --
> Thanks,
> ~Nick Desaulniers



-- 
Thanks,
~Nick Desaulniers

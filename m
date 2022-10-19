Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A855E6041FD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 12:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234561AbiJSKvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 06:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234547AbiJSKt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 06:49:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9558615B115
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 03:22:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 52B29B824C4
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 09:11:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14814C433D6
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 09:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666170679;
        bh=qBDK8q9sMyVco39xeVSA4ZqVXTJBQ82bpATEHApwii8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Lis+X6+xGbkrSyj6N8R6x6QeUwj0MGdasQvxhzjKA79+ysF5GykvVfBWK0+1WdYLY
         FQVsC4gP6RMMgkKn1R73SpLAt9s7BhlZr9nJDcjAA8U85MCLYFVM3Bv+0COPAQOl0L
         bDYSOr+fkNpj2e61EKjzpiLDjjrbDJkGk3rmmQrVE9hnckiJkhYVgcP7XuhKPiFCXm
         ZJjRGE9t4Nn+MB+8tmb/o93asvNa/JFcpJVdtyc2eXCqm8kGnYYF4bgp8ry98tOb+F
         yzH14uM1ZgGVFgvLxicK8C5iM7kjnxOegx4Eq0wA2IcjjbPuZ9vIHnINmNAAmhwf0F
         Fx4nHewuINe6g==
Received: by mail-lf1-f48.google.com with SMTP id bp15so27031375lfb.13
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 02:11:18 -0700 (PDT)
X-Gm-Message-State: ACrzQf3HhtFwX0Qw5S/lV69Rd9NBxstJPp3zbJLJ6VcpaexEKOF3XnQc
        phLHvh06+mEYoL17sPKUiSEK+m/fjJQhdXbaaUk=
X-Google-Smtp-Source: AMsMyM4ZWXW/XsG8t8NwKKPDUmu4iw8/FTD94SMO7Cl9fRh+IaYWRF8bYmvUHBd8UztnBxrBsu8GIu0nZZuRIzCqbzs=
X-Received: by 2002:a05:6512:150e:b0:492:d9fd:9bdf with SMTP id
 bq14-20020a056512150e00b00492d9fd9bdfmr2372375lfb.583.1666170677074; Wed, 19
 Oct 2022 02:11:17 -0700 (PDT)
MIME-Version: 1.0
References: <202210190351.b33PaxC4-lkp@intel.com> <CAMj1kXEUs-CTpM2LJ_9+yH3Gy+N+dm51M7VvNpKNAsRBTDCRaw@mail.gmail.com>
 <def83285-af62-f0c4-dcaa-f9e54aaba768@intel.com>
In-Reply-To: <def83285-af62-f0c4-dcaa-f9e54aaba768@intel.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 19 Oct 2022 11:11:05 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFG243S0awWUHD4xWidG8nsRamVBk9CC8QYz2hbkgBWxQ@mail.gmail.com>
Message-ID: <CAMj1kXFG243S0awWUHD4xWidG8nsRamVBk9CC8QYz2hbkgBWxQ@mail.gmail.com>
Subject: Re: [kbuild-all] Re: drivers/firmware/efi/libstub/zboot.c:163:1:
 sparse: sparse: symbol 'efi_zboot_entry' was not declared. Should it be static?
To:     "Chen, Rong A" <rong.a.chen@intel.com>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Oct 2022 at 11:10, Chen, Rong A <rong.a.chen@intel.com> wrote:
>
>
>
> On 10/19/2022 3:50 AM, Ard Biesheuvel wrote:
> > This is another spurious report of an asmlinkage symbol.
>
> Hi Ard,
>
> Thanks for your reply, we'll add this warning to the ignore list.
>

Thank you Rong.

Wouldn't it be easier to detect the asmlinkage and never warn on it?
Maybe this should be sparse's job instead ...


>
> >
> > On Tue, 18 Oct 2022 at 21:49, kernel test robot <lkp@intel.com> wrote:
> >>
> >> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> >> head:   bb1a1146467ad812bb65440696df0782e2bc63c8
> >> commit: a050910972bb25152b42ad2e544652117c5ad915 efi/libstub: implement generic EFI zboot
> >> date:   4 weeks ago
> >> config: riscv-randconfig-s043-20221018
> >> compiler: riscv64-linux-gcc (GCC) 12.1.0
> >> reproduce:
> >>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >>          chmod +x ~/bin/make.cross
> >>          # apt-get install sparse
> >>          # sparse version: v0.6.4-39-gce1a6720-dirty
> >>          # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a050910972bb25152b42ad2e544652117c5ad915
> >>          git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> >>          git fetch --no-tags linus master
> >>          git checkout a050910972bb25152b42ad2e544652117c5ad915
> >>          # save the config file
> >>          mkdir build_dir && cp config build_dir/.config
> >>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=riscv SHELL=/bin/bash drivers/firmware/efi/libstub/ lib/xz/
> >>
> >> If you fix the issue, kindly add following tag where applicable
> >> | Reported-by: kernel test robot <lkp@intel.com>
> >>
> >> sparse warnings: (new ones prefixed by >>)
> >>     WARNING: invalid argument to '-march': '_zihintpause'
> >>     drivers/firmware/efi/libstub/zboot.c: note: in included file (through drivers/firmware/efi/libstub/../../../../lib/decompress_unxz.c):
> >>>> drivers/firmware/efi/libstub/../../../../lib/xz/xz_dec_stream.c:393:28: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted __le32 const [usertype] *p @@     got unsigned int const [usertype] * @@
> >>     drivers/firmware/efi/libstub/../../../../lib/xz/xz_dec_stream.c:393:28: sparse:     expected restricted __le32 const [usertype] *p
> >>     drivers/firmware/efi/libstub/../../../../lib/xz/xz_dec_stream.c:393:28: sparse:     got unsigned int const [usertype] *
> >>     drivers/firmware/efi/libstub/../../../../lib/xz/xz_dec_stream.c:427:48: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted __le32 const [usertype] *p @@     got unsigned int const [usertype] * @@
> >>     drivers/firmware/efi/libstub/../../../../lib/xz/xz_dec_stream.c:427:48: sparse:     expected restricted __le32 const [usertype] *p
> >>     drivers/firmware/efi/libstub/../../../../lib/xz/xz_dec_stream.c:427:48: sparse:     got unsigned int const [usertype] *
> >>     drivers/firmware/efi/libstub/../../../../lib/xz/xz_dec_stream.c:435:37: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted __le32 const [usertype] *p @@     got unsigned int const [usertype] * @@
> >>     drivers/firmware/efi/libstub/../../../../lib/xz/xz_dec_stream.c:435:37: sparse:     expected restricted __le32 const [usertype] *p
> >>     drivers/firmware/efi/libstub/../../../../lib/xz/xz_dec_stream.c:435:37: sparse:     got unsigned int const [usertype] *
> >>     drivers/firmware/efi/libstub/../../../../lib/xz/xz_dec_stream.c:459:28: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted __le32 const [usertype] *p @@     got unsigned int const [usertype] * @@
> >>     drivers/firmware/efi/libstub/../../../../lib/xz/xz_dec_stream.c:459:28: sparse:     expected restricted __le32 const [usertype] *p
> >>     drivers/firmware/efi/libstub/../../../../lib/xz/xz_dec_stream.c:459:28: sparse:     got unsigned int const [usertype] *
> >>>> drivers/firmware/efi/libstub/zboot.c:163:1: sparse: sparse: symbol 'efi_zboot_entry' was not declared. Should it be static?
> >>
> >> vim +/efi_zboot_entry +163 drivers/firmware/efi/libstub/zboot.c
> >>
> >>     161
> >>     162  asmlinkage efi_status_t __efiapi
> >>   > 163  efi_zboot_entry(efi_handle_t handle, efi_system_table_t *systab)
> >>
> >> --
> >> 0-DAY CI Kernel Test Service
> >> https://01.org/lkp
> > _______________________________________________
> > kbuild-all mailing list -- kbuild-all@lists.01.org
> > To unsubscribe send an email to kbuild-all-leave@lists.01.org
> >

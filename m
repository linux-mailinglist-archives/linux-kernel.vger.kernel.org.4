Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF0460337A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 21:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbiJRTvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 15:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbiJRTvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 15:51:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 279F984E73
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 12:51:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BF46861582
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 19:51:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2306EC433B5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 19:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666122669;
        bh=2Og0stXapohJI4Rh8V8tiiq2k+6aDJA3vqGHbFeNLug=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VWa0HuSq0R/ly8S95vLHke8QlCTVtTiWV/arEgn4pAjZrqbk1jap6yfn9gR3rfBzm
         VZmewWxIiW5lZ45B117u3V+shSdE25bsnGq5KjUMh6rrTjsEFYsxF2LxIl770sFGBZ
         o5o9dQARAGguMc2UXAdaC8GygV7g7fya/Q31g/v0ksi7xrmblol9h+7hMR5TVs0q1I
         UF4basKiulf1gfWTSD4kauPc/9CLnbqwQlRt3DmlRgy5N8aYHmmnnmeRUTfDvRQTvr
         ZxhRjDOuBPfbHLUx/V5yQAQb6Cw/Fyj2lTfShSKkYzr1+4stlTulVX+NQOPgUibmYX
         WYFzSyEGvIVtA==
Received: by mail-lf1-f41.google.com with SMTP id g7so19371349lfv.5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 12:51:09 -0700 (PDT)
X-Gm-Message-State: ACrzQf15Y5iv91kS6k46WT9IKiffU8j3z9u79TEHCLtqjgU41C44JXJa
        Plq6aQf/Sgqp+anMgw9QNoHY/1NVlvsfUUEMw74=
X-Google-Smtp-Source: AMsMyM5ZA95jm8WFNArBX7ktZAqUUFFKHGul6fHtGTMjnkRkizkdHXzWQF193EM1IC6ryAPlmwWOI0bYW1km4jCZXLs=
X-Received: by 2002:a05:6512:314a:b0:4a2:d0b9:aa20 with SMTP id
 s10-20020a056512314a00b004a2d0b9aa20mr1753620lfi.110.1666122667047; Tue, 18
 Oct 2022 12:51:07 -0700 (PDT)
MIME-Version: 1.0
References: <202210190351.b33PaxC4-lkp@intel.com>
In-Reply-To: <202210190351.b33PaxC4-lkp@intel.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 18 Oct 2022 21:50:55 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEUs-CTpM2LJ_9+yH3Gy+N+dm51M7VvNpKNAsRBTDCRaw@mail.gmail.com>
Message-ID: <CAMj1kXEUs-CTpM2LJ_9+yH3Gy+N+dm51M7VvNpKNAsRBTDCRaw@mail.gmail.com>
Subject: Re: drivers/firmware/efi/libstub/zboot.c:163:1: sparse: sparse:
 symbol 'efi_zboot_entry' was not declared. Should it be static?
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is another spurious report of an asmlinkage symbol.

On Tue, 18 Oct 2022 at 21:49, kernel test robot <lkp@intel.com> wrote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   bb1a1146467ad812bb65440696df0782e2bc63c8
> commit: a050910972bb25152b42ad2e544652117c5ad915 efi/libstub: implement generic EFI zboot
> date:   4 weeks ago
> config: riscv-randconfig-s043-20221018
> compiler: riscv64-linux-gcc (GCC) 12.1.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # apt-get install sparse
>         # sparse version: v0.6.4-39-gce1a6720-dirty
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a050910972bb25152b42ad2e544652117c5ad915
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout a050910972bb25152b42ad2e544652117c5ad915
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=riscv SHELL=/bin/bash drivers/firmware/efi/libstub/ lib/xz/
>
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
>
> sparse warnings: (new ones prefixed by >>)
>    WARNING: invalid argument to '-march': '_zihintpause'
>    drivers/firmware/efi/libstub/zboot.c: note: in included file (through drivers/firmware/efi/libstub/../../../../lib/decompress_unxz.c):
> >> drivers/firmware/efi/libstub/../../../../lib/xz/xz_dec_stream.c:393:28: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted __le32 const [usertype] *p @@     got unsigned int const [usertype] * @@
>    drivers/firmware/efi/libstub/../../../../lib/xz/xz_dec_stream.c:393:28: sparse:     expected restricted __le32 const [usertype] *p
>    drivers/firmware/efi/libstub/../../../../lib/xz/xz_dec_stream.c:393:28: sparse:     got unsigned int const [usertype] *
>    drivers/firmware/efi/libstub/../../../../lib/xz/xz_dec_stream.c:427:48: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted __le32 const [usertype] *p @@     got unsigned int const [usertype] * @@
>    drivers/firmware/efi/libstub/../../../../lib/xz/xz_dec_stream.c:427:48: sparse:     expected restricted __le32 const [usertype] *p
>    drivers/firmware/efi/libstub/../../../../lib/xz/xz_dec_stream.c:427:48: sparse:     got unsigned int const [usertype] *
>    drivers/firmware/efi/libstub/../../../../lib/xz/xz_dec_stream.c:435:37: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted __le32 const [usertype] *p @@     got unsigned int const [usertype] * @@
>    drivers/firmware/efi/libstub/../../../../lib/xz/xz_dec_stream.c:435:37: sparse:     expected restricted __le32 const [usertype] *p
>    drivers/firmware/efi/libstub/../../../../lib/xz/xz_dec_stream.c:435:37: sparse:     got unsigned int const [usertype] *
>    drivers/firmware/efi/libstub/../../../../lib/xz/xz_dec_stream.c:459:28: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted __le32 const [usertype] *p @@     got unsigned int const [usertype] * @@
>    drivers/firmware/efi/libstub/../../../../lib/xz/xz_dec_stream.c:459:28: sparse:     expected restricted __le32 const [usertype] *p
>    drivers/firmware/efi/libstub/../../../../lib/xz/xz_dec_stream.c:459:28: sparse:     got unsigned int const [usertype] *
> >> drivers/firmware/efi/libstub/zboot.c:163:1: sparse: sparse: symbol 'efi_zboot_entry' was not declared. Should it be static?
>
> vim +/efi_zboot_entry +163 drivers/firmware/efi/libstub/zboot.c
>
>    161
>    162  asmlinkage efi_status_t __efiapi
>  > 163  efi_zboot_entry(efi_handle_t handle, efi_system_table_t *systab)
>
> --
> 0-DAY CI Kernel Test Service
> https://01.org/lkp

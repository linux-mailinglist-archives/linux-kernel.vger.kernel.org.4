Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B31D16D3FC0
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 11:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbjDCJLC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 05:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjDCJLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 05:11:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E1A57687
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 02:10:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 02911B8160F
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 09:10:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3B65C433D2
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 09:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680513056;
        bh=48iR4u3n9K+PxbeYtFKNqoB1PmouHufH/K/8+z+ltr8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pUGoU8xlrNs3oUKWY+kDKvp9UpHs4QBaem8JXHsfGokdM2T4QTY29gJ9TDTHrep3/
         Y2knv+wWrmNDa76wQ4u5ZHNWRZhjg83gvM1SaRRzhmcQcwitQCYTGKVKBWA4X52JYO
         D/5aIiEKJO3jn07tL6ulp9irWcv1E99FIgAgCsM/BLrNRDUNzOqIqcLmZgK18zsJEn
         Jo+/2f4ykvqGpOc5o3Fm9fqdspFdqr/JxxNt4eWYCVxu0KNTr/b7+X7kll+vBX2TD4
         LL9Z994hqzKpiowsVXHtzEc6ctKl1xnsmmkVR59e/XaLsl88+mW8+5eGUO/kfklDfu
         ftk4n4AP3u8Dw==
Received: by mail-lj1-f173.google.com with SMTP id s20so9256748ljp.7
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 02:10:56 -0700 (PDT)
X-Gm-Message-State: AAQBX9dw0Az/QExB8bOJEsp6czb2fkNJM/+fuV7Df/6jrHs4ZTjyblTh
        jHJG7uoPwpDxofLKQv6sn9yb8sn5O9t5NoGgwww=
X-Google-Smtp-Source: AKy350ZdPxupau2M0boOo8L/biMnTQ28Uw5714Q1j9LnHphUuB820PcFcQKHnoJuw+9n+/rHb4SXmrSpy1SeWBP4Sug=
X-Received: by 2002:a2e:9d99:0:b0:2a5:fd80:fa6d with SMTP id
 c25-20020a2e9d99000000b002a5fd80fa6dmr7519010ljj.2.1680513054754; Mon, 03 Apr
 2023 02:10:54 -0700 (PDT)
MIME-Version: 1.0
References: <be46d0ab-8553-4a5d-af46-6fa909c45213@kili.mountain>
 <CAMj1kXEbaWNNp98GRACR_JUt7JOowU=3BaRKs0ZoOvibnbN_LA@mail.gmail.com> <589c4ea1-95e0-4e3e-9567-a4278860d256@kili.mountain>
In-Reply-To: <589c4ea1-95e0-4e3e-9567-a4278860d256@kili.mountain>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 3 Apr 2023 11:10:43 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEDbpwQSk1pmBR1MkeXcuiRb=ns0BSA6oh2D9UngV8OjA@mail.gmail.com>
Message-ID: <CAMj1kXEDbpwQSk1pmBR1MkeXcuiRb=ns0BSA6oh2D9UngV8OjA@mail.gmail.com>
Subject: Re: arch/arm64/kernel/compat_alignment.c:333 do_compat_alignment_fixup()
 error: uninitialized symbol 'tinst2'.
To:     Dan Carpenter <error27@gmail.com>
Cc:     oe-kbuild@lists.linux.dev, lkp@intel.com,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Apr 2023 at 10:34, Dan Carpenter <error27@gmail.com> wrote:
>
> On Mon, Apr 03, 2023 at 10:03:15AM +0200, Ard Biesheuvel wrote:
> > On Mon, 3 Apr 2023 at 08:29, Dan Carpenter <error27@gmail.com> wrote:
> > >
> > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > > head:   00c7b5f4ddc5b346df62b757ec73f9357bb452af
> > > commit: 3fc24ef32d3b9368f4c103dcd21d6a3f959b4870 arm64: compat: Implement misalignment fixups for multiword loads
> > > config: arm64-randconfig-m041-20230329 (https://download.01.org/0day-ci/archive/20230402/202304021214.gekJ8yRc-lkp@intel.com/config)
> > > compiler: aarch64-linux-gcc (GCC) 12.1.0
> > >
> > > If you fix the issue, kindly add following tag where applicable
> > > | Reported-by: kernel test robot <lkp@intel.com>
> > > | Reported-by: Dan Carpenter <error27@gmail.com>
> > > | Link: https://lore.kernel.org/r/202304021214.gekJ8yRc-lkp@intel.com/
> > >
> > > smatch warnings:
> > > arch/arm64/kernel/compat_alignment.c:333 do_compat_alignment_fixup() error: uninitialized symbol 'tinst2'.
> > >
> > > vim +/tinst2 +333 arch/arm64/kernel/compat_alignment.c
> > >
> > > 3fc24ef32d3b93 Ard Biesheuvel 2022-07-01  310  int do_compat_alignment_fixup(unsigned long addr, struct pt_regs *regs)
> > > 3fc24ef32d3b93 Ard Biesheuvel 2022-07-01  311  {
> > > 3fc24ef32d3b93 Ard Biesheuvel 2022-07-01  312   union offset_union offset;
> > > 3fc24ef32d3b93 Ard Biesheuvel 2022-07-01  313   unsigned long instrptr;
> > > 3fc24ef32d3b93 Ard Biesheuvel 2022-07-01  314   int (*handler)(unsigned long addr, u32 instr, struct pt_regs *regs);
> > > 3fc24ef32d3b93 Ard Biesheuvel 2022-07-01  315   unsigned int type;
> > > 3fc24ef32d3b93 Ard Biesheuvel 2022-07-01  316   u32 instr = 0;
> > > 3fc24ef32d3b93 Ard Biesheuvel 2022-07-01  317   u16 tinstr = 0;
> > > 3fc24ef32d3b93 Ard Biesheuvel 2022-07-01  318   int isize = 4;
> > > 3fc24ef32d3b93 Ard Biesheuvel 2022-07-01  319   int thumb2_32b = 0;
> > > 3fc24ef32d3b93 Ard Biesheuvel 2022-07-01  320   int fault;
> > > 3fc24ef32d3b93 Ard Biesheuvel 2022-07-01  321
> > > 3fc24ef32d3b93 Ard Biesheuvel 2022-07-01  322   instrptr = instruction_pointer(regs);
> > > 3fc24ef32d3b93 Ard Biesheuvel 2022-07-01  323
> > > 3fc24ef32d3b93 Ard Biesheuvel 2022-07-01  324   if (compat_thumb_mode(regs)) {
> > > 3fc24ef32d3b93 Ard Biesheuvel 2022-07-01  325           __le16 __user *ptr = (__le16 __user *)(instrptr & ~1);
> > > 3fc24ef32d3b93 Ard Biesheuvel 2022-07-01  326
> > > 3fc24ef32d3b93 Ard Biesheuvel 2022-07-01  327           fault = alignment_get_thumb(regs, ptr, &tinstr);
> > > 3fc24ef32d3b93 Ard Biesheuvel 2022-07-01  328           if (!fault) {
> > > 3fc24ef32d3b93 Ard Biesheuvel 2022-07-01  329                   if (IS_T32(tinstr)) {
> > > 3fc24ef32d3b93 Ard Biesheuvel 2022-07-01  330                           /* Thumb-2 32-bit */
> > > 3fc24ef32d3b93 Ard Biesheuvel 2022-07-01  331                           u16 tinst2;
> > > 3fc24ef32d3b93 Ard Biesheuvel 2022-07-01  332                           fault = alignment_get_thumb(regs, ptr + 1, &tinst2);
> > > 3fc24ef32d3b93 Ard Biesheuvel 2022-07-01 @333                           instr = ((u32)tinstr << 16) | tinst2;
> > >
> > > Smatch is complaining that there is no error checking to see if the
> > > copy_from_user() fails in alignment_get_thumb.  Eventually the syzbot
> > > will learn to detect this as well.
> > >
> >
> > That shouldn't matter.
> >
> >         u16 instr = 0;
> >         int fault;
> >
> >         if (user_mode(regs))
> >                 fault = get_user(instr, ip);
> >         else
> >                 fault = get_kernel_nofault(instr, ip);
> >
> >         *inst = __mem_to_opcode_thumb16(instr);
> >
> > So the *inst assignment is never ambiguous here, regardless of whether
> > get_user() fails. The value could be wrong (i.e., get_user may have
> > failed after reading only one byte) but the value is never
> > uninitialized. Then, the fault value is always propagated so the
> > calling function will not succeed spuriously when this happens.
> >
>
> I don't know what code that is...  We are looking at different code.
> For me on linux-next it looks like this:
>

My bad (and this illustrates my point about not deviating from the
original when there is a need for two copies of the code to exist in
the same tree, only not in the way I thought)

So the ARM code is correct, and the arm64 version deviates from it,
and introduces the issue you are reporting.

I agree that initializing tinst2 to 0 is the appropriate course of action here.

Thanks,
Ard.


> arch/arm64/kernel/compat_alignment.c
>    297  static int alignment_get_thumb(struct pt_regs *regs, __le16 __user *ip, u16 *inst)
>    298  {
>    299          __le16 instr = 0;
>    300          int fault;
>    301
>    302          fault = get_user(instr, ip);
>    303          if (fault)
>    304                  return fault;
>
> *inst not initialized.
>
>    305
>    306          *inst = __le16_to_cpu(instr);
>    307          return 0;
>    308  }
>    309
>    310  int do_compat_alignment_fixup(unsigned long addr, struct pt_regs *regs)
>    311  {
>    312          union offset_union offset;
>    313          unsigned long instrptr;
>    314          int (*handler)(unsigned long addr, u32 instr, struct pt_regs *regs);
>    315          unsigned int type;
>    316          u32 instr = 0;
>    317          u16 tinstr = 0;
>    318          int isize = 4;
>    319          int thumb2_32b = 0;
>    320          int fault;
>    321
>    322          instrptr = instruction_pointer(regs);
>    323
>    324          if (compat_thumb_mode(regs)) {
>    325                  __le16 __user *ptr = (__le16 __user *)(instrptr & ~1);
>    326
>    327                  fault = alignment_get_thumb(regs, ptr, &tinstr);
>    328                  if (!fault) {
>    329                          if (IS_T32(tinstr)) {
>    330                                  /* Thumb-2 32-bit */
>    331                                  u16 tinst2;
>    332                                  fault = alignment_get_thumb(regs, ptr + 1, &tinst2);
>    333                                  instr = ((u32)tinstr << 16) | tinst2;
>                                                                       ^^^^^^
> Uninitialized variable here.
>
>    334                                  thumb2_32b = 1;
>    335                          } else {
>    336                                  isize = 2;
>    337                                  instr = thumb2arm(tinstr);
>    338                          }
>    339                  }
>    340          } else {
>
> regards,
> dan carpenter
>

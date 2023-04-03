Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 083EB6D3F12
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 10:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231492AbjDCIek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 04:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbjDCIef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 04:34:35 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B3149C2
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 01:34:33 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id i5so114257499eda.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 01:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680510872;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uFBcj649F1IzeRI1uWw25EwSYVuuiyxx6zAlaJgRii8=;
        b=nq1CZsegBgMBDpd+gUx4NBKLjrOSqM08YoTc883yWkS4QiEzygfTXrLXi2iQ7QdaEa
         LS5UG2Ymz4UQ/2dJkxV5njj7NctSxbPAVWxeCsKy+H6TBWYMCW8hBxp6kZTdsmep1wUM
         +1f+k8fHnlmukSUgxKDVnjiSD3qOW1Fg7dSw8stOHrbvraNo1vHKTH587sbWvjnmLanJ
         Z6K1jMkH5gKECLlZZjAVxB1M8E+TguWucR8YDuQfPjiP1m1Lpusllo/bGrk3PlAq9Sej
         vSBSbpfSqAimEA/UL+Cz1yU6l7a+kZJfcO+5QbsJSKyrBVKrgGzxwhGdG5Vg25LdkGB+
         xqEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680510872;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uFBcj649F1IzeRI1uWw25EwSYVuuiyxx6zAlaJgRii8=;
        b=DRLGIEb+7aZz7Xh7U34LhpcF9nDAwP8roPHYYR//Ket0hMjLPkxFzJ2GeZx0LaqYsB
         sd6QcYzqq5j49kxOjx5Y7rBwQqCc7LIrLZdBGu6ml0hv3GxnCcPNN1QcZ1x5c1BCHsVL
         neE5AXy+kqHO5pdNTD4LtbHHFAbKG8AVd9OSY6ZOAU2wP9ZfsEpbdamMxkKthQuGVDRA
         PJtCIgne8lfRHv80QANP13EOMZk5o2lzXU13Rm7vvMzBVvjSnp4PVej8lJjV1shOFUO0
         SMc5KKm2fIANTQlAnwE11iP+fkunBS/CU1vhgPJAYVNnI2PYvxHOsUaZyoDkUjbRJtf9
         MaRA==
X-Gm-Message-State: AAQBX9cda2fnp69i3g7CNbRALMojd622IvCUSePKoccPs8x16wdxa1/k
        Fo2BcBwxQzOCTdpUfEHpBv8=
X-Google-Smtp-Source: AKy350ahuOtaPCW0A94HRm6u8LxaRrKFd7ZcyqXQIJkuwkXSEipkLhvHNsupd2jWXIdEcJ9Wm4DEwA==
X-Received: by 2002:aa7:c448:0:b0:4fb:86c8:e9cc with SMTP id n8-20020aa7c448000000b004fb86c8e9ccmr33345752edr.40.1680510871698;
        Mon, 03 Apr 2023 01:34:31 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id x3-20020a50d603000000b004c06f786602sm4213292edi.85.2023.04.03.01.34.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 01:34:31 -0700 (PDT)
Date:   Mon, 3 Apr 2023 11:34:27 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     oe-kbuild@lists.linux.dev, lkp@intel.com,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: arch/arm64/kernel/compat_alignment.c:333
 do_compat_alignment_fixup() error: uninitialized symbol 'tinst2'.
Message-ID: <589c4ea1-95e0-4e3e-9567-a4278860d256@kili.mountain>
References: <be46d0ab-8553-4a5d-af46-6fa909c45213@kili.mountain>
 <CAMj1kXEbaWNNp98GRACR_JUt7JOowU=3BaRKs0ZoOvibnbN_LA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXEbaWNNp98GRACR_JUt7JOowU=3BaRKs0ZoOvibnbN_LA@mail.gmail.com>
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 03, 2023 at 10:03:15AM +0200, Ard Biesheuvel wrote:
> On Mon, 3 Apr 2023 at 08:29, Dan Carpenter <error27@gmail.com> wrote:
> >
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   00c7b5f4ddc5b346df62b757ec73f9357bb452af
> > commit: 3fc24ef32d3b9368f4c103dcd21d6a3f959b4870 arm64: compat: Implement misalignment fixups for multiword loads
> > config: arm64-randconfig-m041-20230329 (https://download.01.org/0day-ci/archive/20230402/202304021214.gekJ8yRc-lkp@intel.com/config)
> > compiler: aarch64-linux-gcc (GCC) 12.1.0
> >
> > If you fix the issue, kindly add following tag where applicable
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Reported-by: Dan Carpenter <error27@gmail.com>
> > | Link: https://lore.kernel.org/r/202304021214.gekJ8yRc-lkp@intel.com/
> >
> > smatch warnings:
> > arch/arm64/kernel/compat_alignment.c:333 do_compat_alignment_fixup() error: uninitialized symbol 'tinst2'.
> >
> > vim +/tinst2 +333 arch/arm64/kernel/compat_alignment.c
> >
> > 3fc24ef32d3b93 Ard Biesheuvel 2022-07-01  310  int do_compat_alignment_fixup(unsigned long addr, struct pt_regs *regs)
> > 3fc24ef32d3b93 Ard Biesheuvel 2022-07-01  311  {
> > 3fc24ef32d3b93 Ard Biesheuvel 2022-07-01  312   union offset_union offset;
> > 3fc24ef32d3b93 Ard Biesheuvel 2022-07-01  313   unsigned long instrptr;
> > 3fc24ef32d3b93 Ard Biesheuvel 2022-07-01  314   int (*handler)(unsigned long addr, u32 instr, struct pt_regs *regs);
> > 3fc24ef32d3b93 Ard Biesheuvel 2022-07-01  315   unsigned int type;
> > 3fc24ef32d3b93 Ard Biesheuvel 2022-07-01  316   u32 instr = 0;
> > 3fc24ef32d3b93 Ard Biesheuvel 2022-07-01  317   u16 tinstr = 0;
> > 3fc24ef32d3b93 Ard Biesheuvel 2022-07-01  318   int isize = 4;
> > 3fc24ef32d3b93 Ard Biesheuvel 2022-07-01  319   int thumb2_32b = 0;
> > 3fc24ef32d3b93 Ard Biesheuvel 2022-07-01  320   int fault;
> > 3fc24ef32d3b93 Ard Biesheuvel 2022-07-01  321
> > 3fc24ef32d3b93 Ard Biesheuvel 2022-07-01  322   instrptr = instruction_pointer(regs);
> > 3fc24ef32d3b93 Ard Biesheuvel 2022-07-01  323
> > 3fc24ef32d3b93 Ard Biesheuvel 2022-07-01  324   if (compat_thumb_mode(regs)) {
> > 3fc24ef32d3b93 Ard Biesheuvel 2022-07-01  325           __le16 __user *ptr = (__le16 __user *)(instrptr & ~1);
> > 3fc24ef32d3b93 Ard Biesheuvel 2022-07-01  326
> > 3fc24ef32d3b93 Ard Biesheuvel 2022-07-01  327           fault = alignment_get_thumb(regs, ptr, &tinstr);
> > 3fc24ef32d3b93 Ard Biesheuvel 2022-07-01  328           if (!fault) {
> > 3fc24ef32d3b93 Ard Biesheuvel 2022-07-01  329                   if (IS_T32(tinstr)) {
> > 3fc24ef32d3b93 Ard Biesheuvel 2022-07-01  330                           /* Thumb-2 32-bit */
> > 3fc24ef32d3b93 Ard Biesheuvel 2022-07-01  331                           u16 tinst2;
> > 3fc24ef32d3b93 Ard Biesheuvel 2022-07-01  332                           fault = alignment_get_thumb(regs, ptr + 1, &tinst2);
> > 3fc24ef32d3b93 Ard Biesheuvel 2022-07-01 @333                           instr = ((u32)tinstr << 16) | tinst2;
> >
> > Smatch is complaining that there is no error checking to see if the
> > copy_from_user() fails in alignment_get_thumb.  Eventually the syzbot
> > will learn to detect this as well.
> >
> 
> That shouldn't matter.
> 
>         u16 instr = 0;
>         int fault;
> 
>         if (user_mode(regs))
>                 fault = get_user(instr, ip);
>         else
>                 fault = get_kernel_nofault(instr, ip);
> 
>         *inst = __mem_to_opcode_thumb16(instr);
> 
> So the *inst assignment is never ambiguous here, regardless of whether
> get_user() fails. The value could be wrong (i.e., get_user may have
> failed after reading only one byte) but the value is never
> uninitialized. Then, the fault value is always propagated so the
> calling function will not succeed spuriously when this happens.
> 

I don't know what code that is...  We are looking at different code.
For me on linux-next it looks like this:

arch/arm64/kernel/compat_alignment.c
   297  static int alignment_get_thumb(struct pt_regs *regs, __le16 __user *ip, u16 *inst)
   298  {
   299          __le16 instr = 0;
   300          int fault;
   301  
   302          fault = get_user(instr, ip);
   303          if (fault)
   304                  return fault;

*inst not initialized.

   305  
   306          *inst = __le16_to_cpu(instr);
   307          return 0;
   308  }
   309  
   310  int do_compat_alignment_fixup(unsigned long addr, struct pt_regs *regs)
   311  {
   312          union offset_union offset;
   313          unsigned long instrptr;
   314          int (*handler)(unsigned long addr, u32 instr, struct pt_regs *regs);
   315          unsigned int type;
   316          u32 instr = 0;
   317          u16 tinstr = 0;
   318          int isize = 4;
   319          int thumb2_32b = 0;
   320          int fault;
   321  
   322          instrptr = instruction_pointer(regs);
   323  
   324          if (compat_thumb_mode(regs)) {
   325                  __le16 __user *ptr = (__le16 __user *)(instrptr & ~1);
   326  
   327                  fault = alignment_get_thumb(regs, ptr, &tinstr);
   328                  if (!fault) {
   329                          if (IS_T32(tinstr)) {
   330                                  /* Thumb-2 32-bit */
   331                                  u16 tinst2;
   332                                  fault = alignment_get_thumb(regs, ptr + 1, &tinst2);
   333                                  instr = ((u32)tinstr << 16) | tinst2;
                                                                      ^^^^^^
Uninitialized variable here.

   334                                  thumb2_32b = 1;
   335                          } else {
   336                                  isize = 2;
   337                                  instr = thumb2arm(tinstr);
   338                          }
   339                  }
   340          } else {

regards,
dan carpenter


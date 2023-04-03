Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2906F6D3D57
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 08:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbjDCG3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 02:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbjDCG3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 02:29:02 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E73172B
        for <linux-kernel@vger.kernel.org>; Sun,  2 Apr 2023 23:29:01 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id w9so112841944edc.3
        for <linux-kernel@vger.kernel.org>; Sun, 02 Apr 2023 23:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680503340;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Yu12iafjoarKx+r5oMuQ8ttdUsEmu43myMm/b7fl7pY=;
        b=Tx20nZjz7rsjTbrp6uMtx8K0Lu+gEvc8r171iqDYAMI18dhV5uGUQf2D5tHBsDUj9m
         6if3HkokMaAmNJherVLk2PCHwnSx7xn7gKOnH0lPwLiH7LGSQZYCSD8puekzQeBbN+ll
         PdoNvchqdtirBGgCRX0QYgkTSeT8yuhszKoyEyMCVtXoWWtYDK2yOv6le69hfRWgZ+bJ
         0ORUwAe9/a7c6K5XMc+6BLCvPrpV/wCIvLOIBMJQfMYnPgqju93+sGH9ESAlh9RKrNbk
         dl4SdQVY/tWpH2BvyRS0PPqdIC4z0JWyXTdcONG058eUMoTv5HdG9oiRUalZ8TjLcnMW
         P8cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680503340;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yu12iafjoarKx+r5oMuQ8ttdUsEmu43myMm/b7fl7pY=;
        b=MeLM+ZZbgeJjOs693iB4ypLbvgbxsVX14gwoPPzjtpkveHLgqioEsn4fjI9TqbQgcA
         f90t2KLMODndGIXlrDUv0YVkr8E/gmZhhX3lyAHEno1Mxldwj3XLlxJ/O0C6doajo1r+
         46etBhS+X0QjJVJfjnjPIguxpsWJqohHzoXl5UdhSj3DQTdl/uJPZoSzyzHJkDFzYmIw
         MHPhEBW3WldF+NFCeJYfpHcDVxx3GCPZjgNTlf25xWykNCCkpkZCnxRedhivldB8UTr7
         chOfocWNSiwnonOUko3x5T21j2tRtD01CGvaID/9vBQMAlTqPqLe+bdsRVxIjQnQ4kJK
         QOXA==
X-Gm-Message-State: AAQBX9eYY1Ukp546Aab/qn5K0134EGqzatJZxLR/9jbzFRT6oqpt53Ej
        YZXuyUEHg4O4IhP326QNXm0=
X-Google-Smtp-Source: AKy350bpT1MVuxA99ZQxxFa6juIF47/zUlGeNo5pzKjHo11lDy1+DhQRzR0E36WyjBo76h/fawwgew==
X-Received: by 2002:a17:906:2009:b0:933:4184:f0d7 with SMTP id 9-20020a170906200900b009334184f0d7mr35255820ejo.69.1680503340059;
        Sun, 02 Apr 2023 23:29:00 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id g3-20020a056402090300b005024459f431sm4047813edz.70.2023.04.02.23.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Apr 2023 23:28:59 -0700 (PDT)
Date:   Mon, 3 Apr 2023 09:28:55 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     oe-kbuild@lists.linux.dev, Ard Biesheuvel <ardb@kernel.org>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: arch/arm64/kernel/compat_alignment.c:333 do_compat_alignment_fixup()
 error: uninitialized symbol 'tinst2'.
Message-ID: <be46d0ab-8553-4a5d-af46-6fa909c45213@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   00c7b5f4ddc5b346df62b757ec73f9357bb452af
commit: 3fc24ef32d3b9368f4c103dcd21d6a3f959b4870 arm64: compat: Implement misalignment fixups for multiword loads
config: arm64-randconfig-m041-20230329 (https://download.01.org/0day-ci/archive/20230402/202304021214.gekJ8yRc-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>
| Link: https://lore.kernel.org/r/202304021214.gekJ8yRc-lkp@intel.com/

smatch warnings:
arch/arm64/kernel/compat_alignment.c:333 do_compat_alignment_fixup() error: uninitialized symbol 'tinst2'.

vim +/tinst2 +333 arch/arm64/kernel/compat_alignment.c

3fc24ef32d3b93 Ard Biesheuvel 2022-07-01  310  int do_compat_alignment_fixup(unsigned long addr, struct pt_regs *regs)
3fc24ef32d3b93 Ard Biesheuvel 2022-07-01  311  {
3fc24ef32d3b93 Ard Biesheuvel 2022-07-01  312  	union offset_union offset;
3fc24ef32d3b93 Ard Biesheuvel 2022-07-01  313  	unsigned long instrptr;
3fc24ef32d3b93 Ard Biesheuvel 2022-07-01  314  	int (*handler)(unsigned long addr, u32 instr, struct pt_regs *regs);
3fc24ef32d3b93 Ard Biesheuvel 2022-07-01  315  	unsigned int type;
3fc24ef32d3b93 Ard Biesheuvel 2022-07-01  316  	u32 instr = 0;
3fc24ef32d3b93 Ard Biesheuvel 2022-07-01  317  	u16 tinstr = 0;
3fc24ef32d3b93 Ard Biesheuvel 2022-07-01  318  	int isize = 4;
3fc24ef32d3b93 Ard Biesheuvel 2022-07-01  319  	int thumb2_32b = 0;
3fc24ef32d3b93 Ard Biesheuvel 2022-07-01  320  	int fault;
3fc24ef32d3b93 Ard Biesheuvel 2022-07-01  321  
3fc24ef32d3b93 Ard Biesheuvel 2022-07-01  322  	instrptr = instruction_pointer(regs);
3fc24ef32d3b93 Ard Biesheuvel 2022-07-01  323  
3fc24ef32d3b93 Ard Biesheuvel 2022-07-01  324  	if (compat_thumb_mode(regs)) {
3fc24ef32d3b93 Ard Biesheuvel 2022-07-01  325  		__le16 __user *ptr = (__le16 __user *)(instrptr & ~1);
3fc24ef32d3b93 Ard Biesheuvel 2022-07-01  326  
3fc24ef32d3b93 Ard Biesheuvel 2022-07-01  327  		fault = alignment_get_thumb(regs, ptr, &tinstr);
3fc24ef32d3b93 Ard Biesheuvel 2022-07-01  328  		if (!fault) {
3fc24ef32d3b93 Ard Biesheuvel 2022-07-01  329  			if (IS_T32(tinstr)) {
3fc24ef32d3b93 Ard Biesheuvel 2022-07-01  330  				/* Thumb-2 32-bit */
3fc24ef32d3b93 Ard Biesheuvel 2022-07-01  331  				u16 tinst2;
3fc24ef32d3b93 Ard Biesheuvel 2022-07-01  332  				fault = alignment_get_thumb(regs, ptr + 1, &tinst2);
3fc24ef32d3b93 Ard Biesheuvel 2022-07-01 @333  				instr = ((u32)tinstr << 16) | tinst2;

Smatch is complaining that there is no error checking to see if the
copy_from_user() fails in alignment_get_thumb.  Eventually the syzbot
will learn to detect this as well.

Most distro kernels are going to automatically zero out stack variables
like tinst2 to prevent undefined behavior.

Presumably this is a fast path.  So setting "u16 tinst2 = 0;" does not
affect runtime speed for distro kernels and it might be the best
solution.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests


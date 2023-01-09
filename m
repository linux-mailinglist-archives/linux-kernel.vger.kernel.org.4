Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81295662DAB
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 18:52:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236723AbjAIRvy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 12:51:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237571AbjAIRve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 12:51:34 -0500
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E22A2
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 09:47:55 -0800 (PST)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-1441d7d40c6so9422484fac.8
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 09:47:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PPkG6xZm5p4VExQwIB/kMPObdqayUl69iL6eCmWVCEE=;
        b=I8WLFmaqIYxvqFRQMIWOrBV3zyS6ier9PIE+oYrGCrRiofdAoug3Y1ZH6xTdgeQLCp
         YEPlpdk9jOxlzoRFPJ+5M5p2JboNfHVWAGnhsdh2DmRiHEQ3sLS1B1KjlApZW4HpqZPi
         uwGyKeWZbxv2Kp63kYYsEDIZ6tdzPT8R3MPCGtL1JapOj3PbG6B2hCMzyPH7BZk2qMHc
         mARl3nUZe+W2QtLmx6nO6DRhxeqsRwZduvV+Gr5SwGOoEJ1mOtE2B02iZyElSrQHKM8f
         x7muhqV8yN4c2kcOHKigLHkVWNWuIrnJl+hhaTl9OAEBYtIU00qHeD6CXzdBx9j0G8KN
         NH2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PPkG6xZm5p4VExQwIB/kMPObdqayUl69iL6eCmWVCEE=;
        b=7MVYwuYI+N9uGKm+izdoSCuaUkMzEZOjJnPEbJa7sVsIsfVZ3KKwCLzi1gTwr1PblQ
         xsFnpf323/zOlHySX9/lDjJS6OJIHm2/008BlCP8TVjrhzyG1XXg7wOeldQnhIIaCN1t
         99un3YWH3ydL9VPEQktSTqwB1n2UAjKrvd8JSecIb0tl12R4tUOhjzuL+Q1pHjLK9LO1
         E3fEEsgvM3ttTB6UUextcBvVqocXHTYpY/dy9OyU9285MIaAEmnbiLn99q9uLhe7JEpn
         p1s2W/6zmVeVWzMB6T+GQx3MpSnUcXNsT30VboVYoV4u80SCQbwOy+s5XqAN3NKzl0Sl
         2M5g==
X-Gm-Message-State: AFqh2krZG3ouRqTz6xCTZlUVWwXTLAWZz9EHv6giTJYqpPFJmo9ptmOE
        RY9vmMMdJE9UEoB4Jfeh9N4ZMBCkRRY=
X-Google-Smtp-Source: AMrXdXsULBgFCL1p04YYYFVCPPOTYM3gXxjE2iXSGq1DwGQ/nDf5yGg1emLCx2mPhYHCMhUtGXAt9A==
X-Received: by 2002:a05:6870:e753:b0:14b:922f:6fd8 with SMTP id t19-20020a056870e75300b0014b922f6fd8mr35583850oak.13.1673286464733;
        Mon, 09 Jan 2023 09:47:44 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f3-20020a4ab643000000b004d7363cdddfsm4545938ooo.19.2023.01.09.09.47.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 09:47:44 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 9 Jan 2023 09:47:42 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 6.2-rc3
Message-ID: <20230109174742.GA1191249@roeck-us.net>
References: <CAHk-=wjwrqFcC9-KkfboqATYwLfJHi_8Z5mTrJh=nf8KT_SjUA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjwrqFcC9-KkfboqATYwLfJHi_8Z5mTrJh=nf8KT_SjUA@mail.gmail.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 08, 2023 at 12:06:47PM -0600, Linus Torvalds wrote:
> Here we are, another week done, and things are starting to look a lot
> more normal after that very quiet holiday week that made rc2 so very
> small.
> 
> Nothing in particular here stands out: the bulk of this is driver
> fixes (networking, gpu, block, virtio - but also usb, fbdev, rdma etc,
> so a little bit of everything).  That is as should be, and just
> matches where the bulk of the code is.
> 
> Outside of the various driver fixes, we've got core networking, some
> filesystem fixes (btrfs, cifs, f2fs and nfs), and some perf tooling
> work.
> 
> With the rest being mostly selftests and documentation.
> 
> The shortlog is below, plase do give it a good test, and holler if you
> find anything.
> 

Build results:
	total: 155 pass: 151 fail: 4
Failed builds:
	powerpc:allmodconfig
	sh:defconfig
	sh:shx3_defconfig
	xtensa:allmodconfig
Qemu test results:
	total: 500 pass: 500 fail: 0

No change with compile tests (included again below for reference).
The good news is that the runtime/boot tests now all pass.

Guenter

---
Build errors
============

Building powerpc:allmodconfig ... failed
--------------
Error log:
In file included from include/linux/string.h:253,
                 from arch/powerpc/include/asm/paca.h:16,
                 from arch/powerpc/include/asm/current.h:13,
                 from include/linux/thread_info.h:23,
                 from include/asm-generic/preempt.h:5,
                 from ./arch/powerpc/include/generated/asm/preempt.h:1,
                 from include/linux/preempt.h:78,
                 from include/linux/spinlock.h:56,
                 from include/linux/wait.h:9,
                 from include/linux/wait_bit.h:8,
                 from include/linux/fs.h:6,
                 from fs/f2fs/inline.c:9:
fs/f2fs/inline.c: In function 'f2fs_move_inline_dirents':
include/linux/fortify-string.h:59:33: error: '__builtin_memset' pointer overflow between offset [28, 898293814] and size [-898293787, -1] [-Werror=array-bounds]
   59 | #define __underlying_memset     __builtin_memset
      |                                 ^
include/linux/fortify-string.h:337:9: note: in expansion of macro '__underlying_memset'
  337 |         __underlying_memset(p, c, __fortify_size);                      \
      |         ^~~~~~~~~~~~~~~~~~~
include/linux/fortify-string.h:345:25: note: in expansion of macro '__fortify_memset_chk'
  345 | #define memset(p, c, s) __fortify_memset_chk(p, c, s,                   \
      |                         ^~~~~~~~~~~~~~~~~~~~
fs/f2fs/inline.c:430:9: note: in expansion of macro 'memset'
  430 |         memset(dst.bitmap + src.nr_bitmap, 0, dst.nr_bitmap - src.nr_bitmap);
      |         ^~~~~~
cc1: all warnings being treated as errors

xtensa:allmodconfig

Building xtensa:allmodconfig ... failed
--------------
Error log:
kernel/kcsan/kcsan_test.c: In function '__report_matches':
kernel/kcsan/kcsan_test.c:257:1: error: the frame size of 1680 bytes is larger than 1536 bytes

Bisect for both points to commit e240e53ae0abb08 ("mm, slub: add
CONFIG_SLUB_TINY").  Reverting it on its own is not possible, but
reverting the following two patches fixes the problem.

149b6fa228ed mm, slob: rename CONFIG_SLOB to CONFIG_SLOB_DEPRECATED
e240e53ae0ab mm, slub: add CONFIG_SLUB_TINY

Context: CONFIG_SLUB_TINY is enabled with allmodconfig builds.
This enables some previously disabled configurations and disables
some previously enabled configurations.

---
sh:defconfig
sh:shx3_defconfig

Building sh:defconfig ... failed
--------------
Error log:
In file included from <command-line>:
In function 'follow_pmd_mask',
    inlined from 'follow_pud_mask' at mm/gup.c:735:9,
    inlined from 'follow_p4d_mask' at mm/gup.c:752:9,
    inlined from 'follow_page_mask' at mm/gup.c:809:9:
include/linux/compiler_types.h:358:45: error: call to '__compiletime_assert_263' declared with attribute error: Unsupported access size for {READ,WRITE}_ONCE().
  358 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)

Bisect points to commit 0862ff059c9e ("sh/mm: Make pmd_t similar to pte_t").
This commit introduces

-typedef struct { unsigned long long pmd; } pmd_t;
+typedef struct {
+       struct {
+               unsigned long pmd_low;
+               unsigned long pmd_high;
+       };
+       unsigned long long pmd;
+} pmd_t;

That should probably be "typedef union", not "typedef struct".

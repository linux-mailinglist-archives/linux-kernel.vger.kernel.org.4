Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADA2B5E9C96
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 10:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234565AbiIZIzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 04:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234567AbiIZIzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 04:55:37 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3933C3C17F
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 01:55:31 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id t14so9076185wrx.8
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 01:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date;
        bh=RPGb704O3Bne5Y0UDhxFzj56eq4BOkDrW8rdj0cFxk4=;
        b=CqX+VBGfBXp/8y3OsL5mmBRTzQ/gqge2jlgfxI2WfNDlKUfLT7hzoHcGhmHU4nXHkD
         eE96W4LQwIHsBEOUEIWcPhnDNGnhSwtx6HOUYuizQi6ags76Yb5V7lprDlCqV1SX0oLT
         wSQTfHyFbzZblumxxOLIzJMIjneffXwS7i5rJZ4x9sunKDuWYEj9AKai6t0JHwD058CE
         vz0GQI7U/Hz7HkODfhSH4DvyzLQDSeBBLJQTf2UBKefsS03onvcbVIHRJvyLR9zUNCRW
         Ih+vXFlcp/QqhI1t91XcpJQEu6QZdgEdoEiDZgzH7ua6VxCAKEqpM7t0a8YFKe2d6kpZ
         vrlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=RPGb704O3Bne5Y0UDhxFzj56eq4BOkDrW8rdj0cFxk4=;
        b=r1QvZ6dvEioYl4OA0Mo+6LUrGpqJT4FPiTTZgDwy1VrXb6qUThSrFq9qSOrD45YLy3
         x6WQMWpx52H6pUM4bFUGWakOsmAp5JD8GJ7lnpNZ+NF3vOjpiEgLMDH3D/TUaDHRblAS
         bBLF1tpmQAJPcTsAOwNGtVt6EsCTvIvEwnFQt1L1l8xtLcTBa0VdtODikp+4vqBlQf7k
         cig8+I8YBn+b695Y6ZeiA6VCUiVebjULoXjUaZmjt4ouykM02vUFTujapJ031KhR8bIw
         sy5DObOQviFlaCg5clUhoTsrIyXA/t+bwJfbXNSw/XSia6l2RBq+HWFh0zPo1qEmrpty
         IlmA==
X-Gm-Message-State: ACrzQf34Zv9cRVvbKQb/H5obWvB8YH6+M5P947WZtqxlD7Wuw3jv34BR
        WUcB3dAcvpuSCD6uVijQyTo=
X-Google-Smtp-Source: AMsMyM7Q6ghS34g3/envwAUDHV+tFvaUN83njjBhlCE46x9SHw6GkbOe0qXVnHV/iIwgbBV03o9AdQ==
X-Received: by 2002:adf:fe08:0:b0:22b:311:afcd with SMTP id n8-20020adffe08000000b0022b0311afcdmr12704761wrr.629.1664182529596;
        Mon, 26 Sep 2022 01:55:29 -0700 (PDT)
Received: from debian ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id c3-20020a5d63c3000000b0021e51c039c5sm13606592wrw.80.2022.09.26.01.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 01:55:28 -0700 (PDT)
Date:   Mon, 26 Sep 2022 09:55:27 +0100
From:   "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
To:     nathan@kernel.org, ndesaulniers@google.com
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: mainline build failure for x86_64 and arm64 with clang
Message-ID: <YzFo/+uF1jJ7gMIN@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Yesterday I updated my clang to:
clang version 16.0.0 (https://github.com/llvm/llvm-project.git bcb1397bda667e75200ae0be9a65fd17dd0763d4)

And with that I see new build failures of mainline.

I am not copying all the errors but others look similar to these.
From x86_64 almodconfig:

In file included from scripts/mod/devicetable-offsets.c:3:
In file included from ./include/linux/mod_devicetable.h:13:
In file included from ./include/linux/uuid.h:12:
In file included from ./include/linux/string.h:253:
./include/linux/fortify-string.h:159:10: error: ISO C does not allow indirection on operand of type 'void *' [-Werror,-Wvoid-ptr-dereference]
        q_len = strlen(q);
                ^~~~~~~~~

From x86_64 defconfig:

In file included from arch/x86/kernel/asm-offsets.c:9:
In file included from ./include/linux/crypto.h:20:
In file included from ./include/linux/slab.h:15:
In file included from ./include/linux/gfp.h:7:
In file included from ./include/linux/mmzone.h:8:
In file included from ./include/linux/spinlock.h:55:
In file included from ./include/linux/preempt.h:78:
In file included from ./arch/x86/include/asm/preempt.h:7:
In file included from ./include/linux/thread_info.h:60:
In file included from ./arch/x86/include/asm/thread_info.h:53:
In file included from ./arch/x86/include/asm/cpufeature.h:5:
In file included from ./arch/x86/include/asm/processor.h:22:
In file included from ./arch/x86/include/asm/msr.h:11:
In file included from ./arch/x86/include/asm/cpumask.h:5:
In file included from ./include/linux/cpumask.h:12:
In file included from ./include/linux/bitmap.h:9:
./include/linux/find.h:119:31: error: ISO C does not allow indirection on operand of type 'void *' [-Werror,-Wvoid-ptr-dereference]
                unsigned long val = *addr & GENMASK(size - 1, 0);
                                            ^~~~~~~~~~~~~~~~~~~~
./include/linux/bits.h:38:3: note: expanded from macro 'GENMASK'
        (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         ^~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/bits.h:25:3: note: expanded from macro 'GENMASK_INPUT_CHECK'
                __is_constexpr((l) > (h)), (l) > (h), 0)))
                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/const.h:12:25: note: expanded from macro '__is_constexpr'
        (sizeof(int) == sizeof(*(8 ? ((void *)((long)(x) * 0l)) : (int *)8)))
                               ^
./include/linux/build_bug.h:16:62: note: expanded from macro 'BUILD_BUG_ON_ZERO'
#define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))


From arm64 allmodconfig:

In file included from scripts/mod/devicetable-offsets.c:3:
In file included from ./include/linux/mod_devicetable.h:13:
In file included from ./include/linux/uuid.h:12:
In file included from ./include/linux/string.h:253:
./include/linux/fortify-string.h:159:10: error: ISO C does not allow indirection on operand of type 'void *' [-Werror,-Wvoid-ptr-dereference]
        q_len = strlen(q);
                ^~~~~~~~~
./include/linux/fortify-string.h:131:24: note: expanded from macro 'strlen'
        __builtin_choose_expr(__is_constexpr(__builtin_strlen(p)),      \
                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/const.h:12:25: note: expanded from macro '__is_constexpr'
        (sizeof(int) == sizeof(*(8 ? ((void *)((long)(x) * 0l)) : (int *)8)))
                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

I dont know if its some regression introduced in clang, or really a kernel issue.

I will go back to my previous clang version (329b972d416a) for now untill I know more.

-- 
Regards
Sudip

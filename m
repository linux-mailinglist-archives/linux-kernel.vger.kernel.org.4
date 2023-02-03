Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43B91689E49
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 16:27:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233645AbjBCP1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 10:27:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233642AbjBCP1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 10:27:24 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC89F25955
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 07:26:55 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id eq11so5512405edb.6
        for <linux-kernel@vger.kernel.org>; Fri, 03 Feb 2023 07:26:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:to:from:cc:subject:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U5uDPgAaf4ltN96KHtMmav9HkWvirs487cQ2TnF9AIk=;
        b=nzWIF3/SiSCoHY1v6pr5O4taT20s+lp/mcMrRtFljH9KnL49+fN3owg4C3Yf0O3vjp
         fejqKHXjKio77esdW2UFOTBCpVtbcToz51dN7TT3F20gZIFTK69a8iOP/2sGBKIGz1vj
         frnwkYxjvKc1WQ1kSjsgQE9zX0TQEgj0qdbKg4YSVh7K3f02ntP/ktB0Xapc06PLhhMO
         VCjxe7wyRi9xducSpbuAkOf1+n5Xeaq7pCh/id8/keFmnuVAxuKBMTlhlqMtCB/mf2qP
         8DClM+ZkJkMw+I7BqD3FfPEiWwJsLlknMYhM0L3SULZyv3+LwVD8usJd6qqOi7VP4WPY
         IwKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:to:from:cc:subject:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U5uDPgAaf4ltN96KHtMmav9HkWvirs487cQ2TnF9AIk=;
        b=h0Odn1X/b079/1DMDV66qJSUqrerpJiA2A60jKXUtXCrT/u9h+Vl0ZjyE6JcdRuU9e
         CahUxSrjWm8tpjx5dEyV92RzRQNHsPGaLsQHPeyPY5bo+3ZzGCKt0MR23qLXM+5BaRBj
         jvRIgdiONmPgWTkfADEUNUr7UJcN7uiNJPkcKLcWgwDn0sEYqBsdNZ+lhPaJH/PRrelO
         f0OqaWNXpJYUsvkcp5oJw+/hDNYVK8FUMoAIsQVTKId8s+qFLl5AXC59kA7f3ayhZOCr
         9Rys32C32EdVNraYzJO4F+LwmmS85BcqCxscbK7BkTZ7RqFLJqmYNBWA8vwgADcpk/9H
         abaQ==
X-Gm-Message-State: AO0yUKUARBRrWv9QnUETcOcD14Y8hbb8StNV7jdO/qaRyE419S6PTj60
        nqeeFHoUeWuvbaBjn/B+u+UtnKzZj3JmGDilkI4=
X-Google-Smtp-Source: AK7set+Oei4hyhCjqAK610RXJB1B0hyEmArCMKw5t0HmluF/GfL3jcwtWaeRT0nJVWwUSlCr2x/XGA==
X-Received: by 2002:a05:6402:1909:b0:497:43ec:9e1d with SMTP id e9-20020a056402190900b0049743ec9e1dmr13375305edz.0.1675438014207;
        Fri, 03 Feb 2023 07:26:54 -0800 (PST)
Received: from localhost ([194.182.8.81])
        by smtp.gmail.com with ESMTPSA id z2-20020a1709064e0200b00887a23bab85sm1487965eju.220.2023.02.03.07.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 07:26:53 -0800 (PST)
Date:   Fri, 03 Feb 2023 07:26:53 -0800 (PST)
X-Google-Original-Date: Fri, 03 Feb 2023 07:26:44 PST (-0800)
Subject: [GIT PULL] RISC-V Fixes for 6.2-rc7
CC:         linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-6f088575-34c6-4eb6-a52b-5d23500cff6e@palmer-ri-x1c9>
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit c1d6105869464635d8a2bcf87a43c05f4c0cfca4:

  riscv: Move call to init_cpu_topology() to later initialization stage (2023-01-25 07:20:00 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.2-rc7

for you to fetch changes up to 2f394c0e7d1129a35156e492bc8f445fb20f43ac:

  riscv: disable generation of unwind tables (2023-02-01 20:51:57 -0800)

----------------------------------------------------------------
RISC-V Fixes for 6.2-rc7

* A build fix to avoid static branches in cpu_relax(), which greatly
  inflates the jump tables and breaks at least
  CONFIG_CC_OPTIMIZE_FOR_SIZE=y.
* A fix for a kernel panic when probing impossible instruction
  positions.
* A fix to disable unwind tables, which are enabled by default for
  GCC-13 and result in unhandled relocations in modules.

----------------------------------------------------------------
Andreas Schwab (1):
      riscv: disable generation of unwind tables

Guo Ren (1):
      riscv: kprobe: Fixup kernel panic when probing an illegal position

Palmer Dabbelt (1):
      Merge patch "riscv: Fix build with CONFIG_CC_OPTIMIZE_FOR_SIZE=y"

Samuel Holland (1):
      riscv: Fix build with CONFIG_CC_OPTIMIZE_FOR_SIZE=y

 arch/riscv/Makefile                     |  3 +++
 arch/riscv/include/asm/hwcap.h          |  3 ---
 arch/riscv/include/asm/vdso/processor.h | 28 ++++++++++++----------------
 arch/riscv/kernel/probes/kprobes.c      | 18 ++++++++++++++++++
 4 files changed, 33 insertions(+), 19 deletions(-)

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD40E5FFB46
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 18:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbiJOQtA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Oct 2022 12:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiJOQs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Oct 2022 12:48:57 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64ED446D9E
        for <linux-kernel@vger.kernel.org>; Sat, 15 Oct 2022 09:48:54 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id bv10so12043127wrb.4
        for <linux-kernel@vger.kernel.org>; Sat, 15 Oct 2022 09:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=loly9KUFB8PbWChec+LUQaUzF19XotFqi6Pac7eROaY=;
        b=cSTN13HhqgcpUCpxdosHHpbI6WH5HDFkdZs46rV+CMeOu7ARjBH9VX1oBoJmfhnpux
         E4hno/c15Al6ICFYko16J9EGNb4VOsbtsnr5f6BWF5FCQsol5y4M4K/dtX8PePAWSaWb
         tGiY9em9PuvhDgdrrYeVg7Vv3eQU9fqFZhXfB4MWiJEo51Uvt6eUYUdIbccf7S3iziV6
         5gLou6h1ZRBASy/L540SW/htQJlX8XqlHa7ZbGyxO5iIw+cDqf+11eB12G4q+8hyNkNe
         CROGPXNG9Os9PdVeNyfuwrhpDlNwizbqF6kswhoJ2DiNojsgNjlXGYERQAjRJWsGm4+r
         J7lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=loly9KUFB8PbWChec+LUQaUzF19XotFqi6Pac7eROaY=;
        b=DOFZt7jX0UlxjRdg3ThlbkwiOshIrd7bvrvhPV/vxIyWQ2uAin4VNWouH5yp5jMgQf
         GtQ4vkC0rXBSPC5dnTqlwWPB8pD9OhvEE0XjJEjIl2Hi76epAYHeSbOSSjmIo4Ad/nW8
         46MB6m0ew8/XoZjfgQ3aXRATUt/EldH8SvL+ssKtEKmfxEkpC3S8dJx0dEUEsyq5pezy
         cg72CYnqL0HKVOZnfgdnJvjpwzoc6jM4QHk5ty7rLd92jE8ZZmRZSaKTqg+RDANUNRLk
         obwFolyjMK6pAocPlOfYghQ+fb/hF0lgCyWfEEBfGmKODFEMy+BsKzRyIMdO6LzyxiiK
         9sLQ==
X-Gm-Message-State: ACrzQf2TwNhXm56H+R77Q0hrILVrRXeQu4HSXRl896CtjrCZRz+Yx4R3
        5erXVXGVb0os2//Hzc3sCzq6Jtgoiio=
X-Google-Smtp-Source: AMsMyM7rGH7ib6DeJF8OPZaegYPVhejKtD203z3/7LfRYBYoSymh37dlFVeLh2o5IlPMiVxTk2EyFQ==
X-Received: by 2002:a05:6000:1688:b0:22e:58cd:5a2b with SMTP id y8-20020a056000168800b0022e58cd5a2bmr1872892wrd.365.1665852532647;
        Sat, 15 Oct 2022 09:48:52 -0700 (PDT)
Received: from localhost ([88.83.123.243])
        by smtp.gmail.com with ESMTPSA id bz13-20020a056000090d00b00228cd9f6349sm4541568wrb.106.2022.10.15.09.48.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Oct 2022 09:48:50 -0700 (PDT)
Date:   Sat, 15 Oct 2022 17:48:50 +0100
From:   Stafford Horne <shorne@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Openrisc <openrisc@lists.librecores.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] OpenRISC updates for v6.1-rc1
Message-ID: <Y0rkcqBr6Wan4ueU@stafford-asahi>
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

Hello Linus,

Please consider for pull,

The following changes since commit f76349cf41451c5c42a99f18a9163377e4b364ff:

  Linux 6.0-rc7 (2022-09-25 14:01:02 -0700)

are available in the Git repository at:

  https://github.com/openrisc/linux.git tags/for-linus

for you to fetch changes up to 34a0bac084e49324c29e6d0984d24096e02c6314:

  MAINTAINERS: git://github -> https://github.com for openrisc (2022-10-15 17:26:51 +0100)

----------------------------------------------------------------
OpenRISC 6.1 Updates

I have relocated to London so not much work from me while I get settled.

Still, OpenRISC picked up two patches in this window:
 - Fix for kernel page table walking from Jann Horn
 - MAINTAINER entry cleanup from Palmer Dabbelt

----------------------------------------------------------------
Jann Horn (1):
      openrisc: Fix pagewalk usage in arch_dma_{clear, set}_uncached

Palmer Dabbelt (1):
      MAINTAINERS: git://github -> https://github.com for openrisc

 MAINTAINERS                |  2 +-
 arch/openrisc/kernel/dma.c | 16 ++++++++--------
 2 files changed, 9 insertions(+), 9 deletions(-)

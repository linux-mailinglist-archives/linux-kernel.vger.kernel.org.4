Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBF79660636
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 19:13:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231690AbjAFSNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 13:13:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjAFSNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 13:13:12 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD0E75D0F
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 10:13:11 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id g16so2416804plq.12
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jan 2023 10:13:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:to:from:cc:subject:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6hDoZANBTNDNXKHRfQT835o0/wxRKpaQa8h7cG3GL/I=;
        b=HpjIMHcBeuTexqS2iEUlRTJtstviTWvrYux58Oe7sSVYKSsf8XLttXnje1jWEiI+RH
         lpVVdi6QgNKudvhxlav2zAtefm/YAQAUlaGrnfxmM8nNR4O9Un7adDztJtLbebJOhMu+
         sR0RnQ2OhAtl8SxMify2tJxr0rFg4rrM1ohv6/1wicoDOyMWzBadR47ewwDJiQBRDqbC
         +cbdgO9hKvnaBINC5sxCA17HaxzDRorlUH0VMmT8Ep2X5i5yGTUi+A2w/AduOyUY1E8J
         qABf2cxNhaHH+ZWBaEv1yXAUKXZnJ4OinSSHjhU1kjUs4j6m48qqoh/R6ekQg7c3iKSx
         TVAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:to:from:cc:subject:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6hDoZANBTNDNXKHRfQT835o0/wxRKpaQa8h7cG3GL/I=;
        b=WkEZm067zk1qNhwhbOFupI9y4IdLdvQ2ze3OETNCqQOKxwrd0w3lDI4joVpyQpdSt2
         ODcQxIsMquiX0oWTwLTP5eNXuk9S08hhu5rNq25n4FjvcGyC33+bnn9oiqWn4dhAvwyf
         7TjG3II+raLTFsDUSoqEvSCXPUucqqyYXKDMVL6yWgJpUfSmk8wXfNXyHmvnvu1Q+0+H
         Ai7GYw8mHyFP7iAfVr2T7ZUWbt11B0N3EQfTSFPS+RbTju93qM9z8QHYm4HpjE2U/OEs
         48+Pgg7s7O1ygpXt7B2FhZynuySVq/EIPsKBF0cn1CrrFQ0KVxtDGVGED2P3BYZF1zUJ
         vSfg==
X-Gm-Message-State: AFqh2koSTnqnTs8a0xFlplWpdQf9BKB103h7iEkqn2oOwHMhQxISOpQ7
        5eYo3CjBx/MlPLSjYtHUZDkjDwp9/uXK4wWl
X-Google-Smtp-Source: AMrXdXtL7dEzbBeZBTDGsfdqX7GT2hNOR4M+KwHHWAdzB2yvEwA2LC0r4975u/7an5Qm82ZxvgGaqg==
X-Received: by 2002:a17:903:2404:b0:18d:61f6:e254 with SMTP id e4-20020a170903240400b0018d61f6e254mr74183365plo.33.1673028790203;
        Fri, 06 Jan 2023 10:13:10 -0800 (PST)
Received: from localhost ([135.180.226.51])
        by smtp.gmail.com with ESMTPSA id e18-20020a170902ef5200b00187033cac81sm1235942plx.145.2023.01.06.10.13.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jan 2023 10:13:09 -0800 (PST)
Date:   Fri, 06 Jan 2023 10:13:09 -0800 (PST)
X-Google-Original-Date: Fri, 06 Jan 2023 10:11:53 PST (-0800)
Subject: [GIT PULL] RISC-V Fixes for 6.2-rc3
CC:        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-96b62708-327b-4721-a0ef-49ef52a1b3c2@palmer-ri-x1c9>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,PP_MIME_FAKE_ASCII_TEXT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 1b929c02afd37871d5afb9d498426f83432e71c2:

  Linux 6.2-rc1 (2022-12-25 13:41:39 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.2-rc3

for you to fetch changes up to b9b916aee6715cd7f3318af6dc360c4729417b94:

  riscv: uaccess: fix type of 0 variable on error in get_user() (2023-01-05 12:30:41 -0800)

----------------------------------------------------------------
RISC-V Fixes for 6.2-rc3

* A fix to use the correct mask for c.jr/c.jalr when decoding
  instructions.
* A compile-time fix for get_user(), to avoid an sparse warning.

----------------------------------------------------------------
Ben Dooks (1):
      riscv: uaccess: fix type of 0 variable on error in get_user()

Björn Töpel (1):
      riscv, kprobes: Stricter c.jr/c.jalr decoding

 arch/riscv/include/asm/uaccess.h         | 2 +-
 arch/riscv/kernel/probes/simulate-insn.h | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D82F6F2A78
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Apr 2023 21:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbjD3TgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Apr 2023 15:36:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjD3TgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Apr 2023 15:36:06 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DD081727;
        Sun, 30 Apr 2023 12:36:04 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3f19323259dso17446825e9.3;
        Sun, 30 Apr 2023 12:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682883362; x=1685475362;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1J2jQ9+lq4TOl9tphTK7qKIAnf9XqLDi4AFAEJnPurs=;
        b=qTaidfkl+CmBsir26oIfY+GlOoCIDMDqQULWWGVusqk75BMsrL9zlsEoZzkHnbTg5v
         dqd9f0qNrDHSESo3qrJUJFt5mrCtqw7WydqK2mMT16m93S0RjRg6G0xL7nCgdwyFN5VL
         2BhETey5WMwlkI3JgiWQhYoPa/3xdVYSBnG7UbZbQfkQu1WKt0K9fk4Wn3fkTMR8x21m
         5VeC6vxPzCcs7jKXAK88ieqaO9oPCCafy8c7POTTvIfTtlS3ZCnEjJIx1nHj6Ncc/Hsh
         aJdVr97shzqsKNiKM01Fxs4rn0D91nxUq+jd0EquLWNQXA8wDPpta13jq14g3iQDKi5P
         lMLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682883362; x=1685475362;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1J2jQ9+lq4TOl9tphTK7qKIAnf9XqLDi4AFAEJnPurs=;
        b=WvWbdbu24tzLYdPjwdwXEPiJcj+EQAr++yX6zhIdRHXdHBb086uJuxcHKzPxXkwZbT
         y3LEfu8dvaZffKusjzOAGRdZYxIDmgV6PgYlOQKhJGaDrDiKfJx3pUIbizQDX1x+JTWy
         5seYzrcx7q0Mn+SFrGZFLmGgxYOIFmymoMm1JBfc4v01CFfj5V65HrvJm1hjfVgm8Mr7
         ediVK6t1ZZOmhANdZaeXI7tt0RpbBWq0ZVjccM/fPjH1eCZoZ4iMdQ1sZr4aKDNUq2+3
         Kiz7J8SqPZxOiHtnE157UfYVJoKv2XBse2/6FGUaMZdKY2TixHLO1flObkJyvNMvDV0g
         Cj0g==
X-Gm-Message-State: AC+VfDyGVWFP6OoHwVn3DVpSCv2zUTnCpa2jCoY8JfQyYzHb9KBKPt06
        PxKtyg+I18xBN3MBoABRKc2nu+u3Cdw=
X-Google-Smtp-Source: ACHHUZ6dcjpPSfPA/otb0NVB0t+NBDEXY7lStYzHJ6K/QBKvm4/wTRZdTw6wWtY+k3w8IEweUtlJAw==
X-Received: by 2002:a05:600c:2242:b0:3eb:39e0:3530 with SMTP id a2-20020a05600c224200b003eb39e03530mr8302296wmm.41.1682883362221;
        Sun, 30 Apr 2023 12:36:02 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id 13-20020a05600c230d00b003f31da39b62sm9578361wmo.18.2023.04.30.12.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Apr 2023 12:36:01 -0700 (PDT)
Date:   Sun, 30 Apr 2023 20:36:00 +0100
From:   Stafford Horne <shorne@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux OpenRISC <linux-openrisc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] OpenRISC update for 6.4
Message-ID: <ZE7DIL5TkeLZrOB+@antec>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

Please consider for pull,

The following changes since commit 197b6b60ae7bc51dd0814953c562833143b292aa:

  Linux 6.3-rc4 (2023-03-26 14:40:20 -0700)

are available in the Git repository at:

  https://github.com/openrisc/linux.git tags/for-linus

for you to fetch changes up to c91b4a07655d5ba67962a08dfac8bd7f45ad049c:

  openrisc: Add floating point regset (2023-04-26 15:08:06 +0100)

----------------------------------------------------------------
OpenRISC update for 6.4

Two things for OpenRISC this cycle.

 - Small cleanup for device tree cpu iteration from Rob Herring
 - Add support for storing, restoring and accessing user space FPU state, to
   allow for libc to support the FPU on OpenRISC.

----------------------------------------------------------------
Rob Herring (1):
      openrisc: Use common of_get_cpu_node() instead of open-coding

Stafford Horne (4):
      openrisc: Properly store r31 to pt_regs on unhandled exceptions
      openrisc: Support storing and restoring fpu state
      openrisc: Support floating point user api
      openrisc: Add floating point regset

 arch/openrisc/include/asm/ptrace.h          |  4 ++--
 arch/openrisc/include/uapi/asm/elf.h        |  3 +--
 arch/openrisc/include/uapi/asm/ptrace.h     |  4 ++++
 arch/openrisc/include/uapi/asm/sigcontext.h |  1 +
 arch/openrisc/kernel/entry.S                | 31 +++++++++++++++++++-----
 arch/openrisc/kernel/head.S                 |  4 ++--
 arch/openrisc/kernel/ptrace.c               | 37 +++++++++++++++++++++++++++++
 arch/openrisc/kernel/setup.c                | 19 ++-------------
 arch/openrisc/kernel/signal.c               |  2 ++
 arch/openrisc/kernel/traps.c                | 27 +++++++++++++++++++--
 10 files changed, 101 insertions(+), 31 deletions(-)

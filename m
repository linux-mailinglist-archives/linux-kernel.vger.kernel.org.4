Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7F866488D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 19:12:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239052AbjAJSM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 13:12:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238822AbjAJSL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 13:11:57 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2909C15FC8
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 10:10:23 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id s8so5731074plk.5
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 10:10:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8ADtwUNrGyLn4codYaeaierOrox8boS9Muk7qnG/LE0=;
        b=O7PnZWc3rVvKxGBPuRO9z7r/5IprWDEFEZvj+/2CLLOzYN6qldfqU60FDxeCCkvbzh
         HKfo/E2aAr45M0OxNMXa/xhGmNfVz3EaKDfOPIDbmn+MWn0+0RSY0+zBGsm8CTdLWQYU
         ieihuWKlqYf2yvrkOkEWpL6N5vkterDTsJyl1TJoIfQ1KzuLFQ6Z+3YxQsIJauzT8y/0
         CpbmiWQmthu2fbIO8NESZHHJWWFtCijlBYmQqEc4rXoF+X7tPTgjcEaHQae9FP1FbYvT
         NDMb44c8/FxVHSP7t8u6FrLke9DS05w3Fx2nBGU42BaRl4hHR+YgvUQC3IfAHdtWCA+X
         bMJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8ADtwUNrGyLn4codYaeaierOrox8boS9Muk7qnG/LE0=;
        b=CU5Q+tnHBkw+jdjl0bfxQW6A58S5W+Vgj4nvdn333Np61+lAi3rnnMXerudXjlF5v1
         SWblc8HUx1mnSf2pU3CyPeiyKNHxzB80KHeDMFy0XQp2wSfUgQn/b6kWCugMG/tcVnfx
         15NGYWkEz+plgl4z2sWzGHL/r7tc94i1zr8HPtZAGUqeZrcfG2+osqDPtAbWZwoh/0ee
         zougn87af2v2PzIcswRHkYEMvnzSLiHJN9SeFF+IemnPZ4xGCs8Wya5Whr6Gb9cnS5o1
         Bl/DAEhPBlne6JXxwfzMEByHsey2KITY4oXY+A+zAKqDp8WK9kufdCl68Cp6WkdnS/OT
         krTQ==
X-Gm-Message-State: AFqh2krUFQrhjUc0bjclmdwF9jeZK7Xi8Fde+xoHwd4fG175Za3u8mHT
        vzOMeuBjYusqNQdaG7cDdUQ=
X-Google-Smtp-Source: AMrXdXv4wFQml41RC+bQapqRk3cxvR/e2fus7cV8JkzmQLAbrgod/i8QHS9z6mpRgKU12gxW1SjoCA==
X-Received: by 2002:a17:902:e84c:b0:189:340c:20d2 with SMTP id t12-20020a170902e84c00b00189340c20d2mr105768935plg.23.1673374222652;
        Tue, 10 Jan 2023 10:10:22 -0800 (PST)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:401:1d20:2952:cdb6:accd:18e7])
        by smtp.gmail.com with ESMTPSA id m7-20020a170902db0700b00192b0a07891sm8469617plx.101.2023.01.10.10.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 10:10:22 -0800 (PST)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PULL 0/2] Xtensa fixes for v6.2
Date:   Tue, 10 Jan 2023 10:09:40 -0800
Message-Id: <20230110180940.128858-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the following fixes for the Xtensa architecture.

The following changes since commit 88603b6dc419445847923fcb7fe5080067a30f98:

  Linux 6.2-rc2 (2023-01-01 13:53:16 -0800)

are available in the Git repository at:

  https://github.com/jcmvbkbc/linux-xtensa.git tags/xtensa-20230110

for you to fetch changes up to 4414c1f5c7a375eaa108676a56e12cc8234eb647:

  xtensa: drop unused members of struct thread_struct (2023-01-06 23:33:11 -0800)

----------------------------------------------------------------
Xtensa fixes for v6.2:

- fix xtensa allmodconfig build broken by the kcsan test
- drop unused members of struct thread_struct

----------------------------------------------------------------
Max Filippov (2):
      kcsan: test: don't put the expect array on the stack
      xtensa: drop unused members of struct thread_struct

 arch/xtensa/include/asm/processor.h | 9 ---------
 arch/xtensa/kernel/traps.c          | 2 --
 arch/xtensa/mm/fault.c              | 4 ----
 kernel/kcsan/kcsan_test.c           | 7 ++++++-
 4 files changed, 6 insertions(+), 16 deletions(-)

-- 
Thanks.
-- Max

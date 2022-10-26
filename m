Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE2760E454
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 17:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234512AbiJZPSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 11:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234485AbiJZPSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 11:18:05 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D229127BFA;
        Wed, 26 Oct 2022 08:18:04 -0700 (PDT)
Date:   Wed, 26 Oct 2022 17:18:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666797482;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=TQTK4JJTsg9QsJ/M2GeZgy9I/7bCrsUV6/GQLB4bkIo=;
        b=y/pSMUneKUVgoTQY7o9MIpk1u3AnFY+matZ6f7f4bBsAY1xJULEkST2SmuvTN5o59cwZyC
        jXlbJyHgWgBhjNkv4sirmhvmCurUjcHCbiH/r9TS1n8X2kweIK38dv+yuKgek4FVbAm6m5
        QuoyUxV1ZilCR854cY/DCvPaHI19Xh3vWWTrCmXVrEOCwYaS+8TvY9FfCnYzdsOlbtwYgM
        YzLjxK+XwkPZ6KVsCOJ12YRJJTovc9m/Gja9duyzdcdzppCt8WdXbVaJPjbOYO3JDJ0g4u
        Lwv5eqoXLqPaBR+AlSUBT5VlMdQh3taHmlgKSkUASj4I80q1OtbfrPJ8pU5MQA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666797482;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=TQTK4JJTsg9QsJ/M2GeZgy9I/7bCrsUV6/GQLB4bkIo=;
        b=OQ97oGDd90OU65YTrkTtr68Z5xAehwhDCmbWXvWaDrLZjvCT9OZREJLN0yB7qiRdNANiFk
        URqfidPk8v32N4AQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v6.1-rc2-rt1
Message-ID: <Y1lPqHjmytaSEnHn@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v6.1-rc2-rt1 patch set. 

Changes since v6.0.3-rt12:

  - Update to v6.1-rc2.

Known issues
     - Valentin Schneider reported a few splats on ARM64, see
          https://lkml.kernel.org/r/20210810134127.1394269-1-valentin.schneider@arm.com

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v6.1-rc2-rt1

The RT patch against v6.1-rc2 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.1/older/patch-6.1-rc2-rt1.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.1/older/patches-6.1-rc2-rt1.tar.xz

Sebastian

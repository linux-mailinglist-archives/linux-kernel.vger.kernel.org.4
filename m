Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C24A64AE09
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 04:05:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234361AbiLMDFX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 22:05:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234078AbiLMDFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 22:05:20 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B491929B
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 19:05:19 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id gt4so1960405pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 19:05:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Rtk5TESQhMYupkDzAnSZrsExO2w9BU3bH6jn+cnUrr8=;
        b=rNzlSEczqbuMhCJ1agNhaPGM7TfzPbAOeK8ceeOXoeNvqFY7bOWqogpFW+DVv6HRJT
         NxWUl4raP5ShCDLQr0DYojsasNxd0A8cnO5hcu7WZH8PQvOOqEUAig0ZZ4ac+6SnHVs5
         nMr3iQ2z2zXM6f9sgxMA8uhAzl3qBCp0rZHtnfEnsDM0eoloYEQH6bgXwarYe7+jtcK7
         Q0d9Tyyxd5m1h4i+oQ2PO3RustYjWcvSWGFP15grikuDQ6rriR8rMFXY5xEnLpVgASz6
         OfnlqWgLF/ok2viGY1yp3xMfOIeXFypcpzgS1sLZw1o1oTAiG9sEJZbcEQb5EBo4ugJE
         XsuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Rtk5TESQhMYupkDzAnSZrsExO2w9BU3bH6jn+cnUrr8=;
        b=3QchrhLkwVBPs7q3Eb3UdcFkPiiEpgtgjGTfK8u04OtPacQmFj2u2U8znuHojcoTEh
         er0F7f79H+UcpRI3BLSHeBla6F+HIo2oGsLEqry5GfNjG/3RoPRiLmUVXiOqvPia7RT4
         fYbbrCBxyTi8m7cbmPsy51OlrKEPksAGKFUEvEqywTNCwohOLhcp2wgxN0RxfE21XiO4
         +lYLaqqI0wLFKyFrmCfQ8AHPnbODBoTPuGqxJlEWKnTemxbXQ5jYqpOowHX058VPQ89T
         2dN1/BfLyemYKBnsYzTRVMuP3qVna2LShv3Oec9X+quGY9bCwLHG3I6BxJIoUL3Pp26y
         ng5A==
X-Gm-Message-State: ANoB5pnQsQO+Hr6EcoIpmH6qcukuM0T03DAL7f8ZcCXTPZ1NkatwECO1
        OC289+ZyNVTVOj3rNORORXJJ7LWG0Rq/TJxaiJQVVYQPYor5YWs=
X-Google-Smtp-Source: AA0mqf5sXJfXq2xGHZuYJPucP5KXbmggjMQNiek+xwBIGByocsKl0BeOS+vBkTTEqug5rGt2mm4t5tq2wg7cxJagQKk=
X-Received: by 2002:a17:902:a70b:b0:189:b0a3:cf4f with SMTP id
 w11-20020a170902a70b00b00189b0a3cf4fmr37216824plq.56.1670900718781; Mon, 12
 Dec 2022 19:05:18 -0800 (PST)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 12 Dec 2022 22:05:07 -0500
Message-ID: <CAHC9VhTiYVO5SV6-P6gPcqR1chzwpEvwnDZaYEQACcU1kgvugw@mail.gmail.com>
Subject: [GIT PULL] Audit patches for v6.2
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-audit@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Two performance oriented patches for the audit subsystem: one
consolidates similar code to gain some caching advantages, while the
other stores a value in a stack variable to avoid repeated lookups in
a loop.  The commit descriptions have more information, including some
before/after performance measurements.  Please merge for v6.2.

-Paul

--
The following changes since commit 9abf2313adc1ca1b6180c508c25f22f9395cc780:

 Linux 6.1-rc1 (2022-10-16 15:36:24 -0700)

are available in the Git repository at:

 https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git
   tags/audit-pr-20221212

for you to fetch changes up to 50979953c0c41e929e5f955800da68e1bb24c7ab:

 audit: unify audit_filter_{uring(), inode_name(), syscall()}
   (2022-10-17 14:24:42 -0400)

----------------------------------------------------------------
audit/stable-6.2 PR 20221212

----------------------------------------------------------------
Ankur Arora (2):
     audit: cache ctx->major in audit_filter_syscall()
     audit: unify audit_filter_{uring(), inode_name(), syscall()}

kernel/auditsc.c | 75 ++++++++++++++++++++++++++------------------------
1 file changed, 39 insertions(+), 36 deletions(-)

-- 
paul-moore.com

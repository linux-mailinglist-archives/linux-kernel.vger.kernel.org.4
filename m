Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75ED27400C0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 18:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbjF0QUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 12:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232106AbjF0QTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 12:19:36 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64C1F30EE;
        Tue, 27 Jun 2023 09:19:32 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id E84B055A;
        Tue, 27 Jun 2023 16:19:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net E84B055A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1687882772; bh=NHwPKxL+x5snvxpcGltS1di1yS+9ZamOSPRd0uqGUNo=;
        h=From:To:Cc:Subject:Date:From;
        b=chluDPMkr47yB3ZCHuYIp4vBhf8QJ6T1QHl9fKpxjg/9poLBVwLYDNpNBIrB0GXdy
         6mKlIWTexqdLIAMglnjIq7bxA/NY1KI5/JxejP+0NChkDgjCn3krgrz41WRDgwuyKo
         GZwtIGQUpFkIqLnrxlDQruWvOSynsRZEZ2Z+O1Xw5+7Z/BhY4ZG4liaOk1JKjFbSsu
         29x4mZe5IrJdcbw/1RIsQbh4aTDjY7/YTr9oZ2/LmiTSeF3R9yYJ6dp7Chqsv4PlXV
         UEIlK0DAlNvi8Ij52cpSZY0F06X9mg8pwh2fs6ptErHBR1E+Gb+xKWKVed6HHuMOmy
         IjRQrD6gOuuxQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [GIT PULL] Documentation for 6.5
Date:   Tue, 27 Jun 2023 10:19:31 -0600
Message-ID: <87h6qsev3g.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit bd415b5c9552d44069d4e7c1e018b6d42f25af9e:

  Documentation/filesystems: ramfs-rootfs-initramfs: use :Author: (2023-05-16 12:55:35 -0600)

are available in the Git repository at:

  git://git.lwn.net/linux.git tags/docs-6.5

for you to fetch changes up to a1e72bb00a48687a1dc1c2e549eaf4ba09e802be:

  docs: consolidate storage interfaces (2023-06-21 09:18:06 -0600)

----------------------------------------------------------------
It's been a relatively calm cycle in docsland.  We do have:

- Some initial page-table documentation from Linus (the other Linus)

- Regression-handling documentation improvements from Thorsten

- Addition of kerneldoc documentation for the ERR_PTR() and related
  macros from James Seo

...and the usual collection of fixes and updates.

----------------------------------------------------------------
Baruch Siach (1):
      docs: crypto: async-tx-api: fix typo in struct name

Costa Shulyupin (2):
      docs: consolidate human interface subsystems
      docs: consolidate storage interfaces

Jakub Kicinski (1):
      MAINTAINERS: direct process doc changes to a dedicated ML

James Seo (3):
      Documentation: conf.py: Add __force to c_id_attributes
      err.h: Add missing kerneldocs for error pointer functions
      Documentation: core-api: Add error pointer functions to kernel-api

Joe Stringer (1):
      docs/doc-guide: Clarify how to write tables

Johannes Berg (1):
      Documentation: update git configuration for Link: tag

Jonathan Corbet (1):
      docs: process: fix a typoed cross-reference

Kees Cook (1):
      docs: submitting-patches: Discuss interleaved replies

Linus Walleij (1):
      Documentation/mm: Initial page table documentation

Natesh Sharma (1):
      docs: admin-guide: Add information about intel_pstate active mode

Randy Dunlap (5):
      Documentation: virt: correct location of haltpoll module params
      Documentation: KVM: make corrections to halt-polling.rst
      Documentation: KVM: make corrections to locking.rst
      Documentation: KVM: make corrections to ppc-pv.rst
      Documentation: KVM: make corrections to vcpu-requests.rst

Thorsten Leemhuis (1):
      docs: handling-regressions: rework section about fixing procedures

Yan-Jie Wang (1):
      docs: clarify KVM related kernel parameters' descriptions

 Documentation/admin-guide/kernel-parameters.txt |  63 ++++---
 Documentation/conf.py                           |   1 +
 Documentation/core-api/kernel-api.rst           |   6 +
 Documentation/crypto/async-tx-api.rst           |   2 +-
 Documentation/doc-guide/sphinx.rst              |  11 +-
 Documentation/maintainer/configure-git.rst      |   2 +-
 Documentation/mm/page_tables.rst                | 149 +++++++++++++++++
 Documentation/process/2.Process.rst             |   7 +-
 Documentation/process/handling-regressions.rst  | 208 ++++++++++++++----------
 Documentation/process/submitting-patches.rst    |  25 +++
 Documentation/subsystem-apis.rst                |  34 ++--
 Documentation/virt/guest-halt-polling.rst       |   2 +-
 Documentation/virt/kvm/halt-polling.rst         |  10 +-
 Documentation/virt/kvm/locking.rst              |  18 +-
 Documentation/virt/kvm/ppc-pv.rst               |   8 +-
 Documentation/virt/kvm/vcpu-requests.rst        |   6 +-
 MAINTAINERS                                     |   6 +
 include/linux/err.h                             |  48 ++++++
 18 files changed, 462 insertions(+), 144 deletions(-)

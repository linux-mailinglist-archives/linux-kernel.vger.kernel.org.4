Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E74B74A763
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 01:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbjGFXEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 19:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjGFXEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 19:04:42 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E9F81723;
        Thu,  6 Jul 2023 16:04:37 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 65251734;
        Thu,  6 Jul 2023 23:04:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 65251734
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1688684671; bh=3XoiQaoFKrIsLJsEKfTtCBzXCd+bzMaIdu4uwXks2kc=;
        h=From:To:Cc:Subject:Date:From;
        b=mdv2hCyIPcGA2pji6VqfG1YNixgZLnBCfDxrIzpmBQGWZ/7vS56X7iPTXYpgBGuyX
         yvVbLqBBuV7VzR/fb7o4M3L/y13sWDrtnS5vdNsq6VzkewSCuLsd+8Uon3thexdGgj
         kinY8lGb1tcYUNZYHnWUqFpR9gl3xAW8SMvwhfEDTx+lPwEA4D8u/MT5Hnpl8yFFV1
         NkhFO05hl+7NYsA6fBFoQSjQxQ153clgE9sp17nKGeE9J2RV0zXioreWl5SF3eBc3a
         v1Jx+AkC/sLNc0RmVzzA/LvAeo5XpyioUOpMT9skp0Gdm50siY5pywocmY+z0t6xJj
         9uPZG3ZlsC7jA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Linus Torvalds <torvalds@linuxfoundation.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] A few more documentation changes for 6.5
Date:   Thu, 06 Jul 2023 17:04:30 -0600
Message-ID: <87cz14d4ld.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,NO_DNS_FOR_FROM,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR,
        T_SPF_TEMPERROR autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit a1e72bb00a48687a1dc1c2e549eaf4ba09e802be:

  docs: consolidate storage interfaces (2023-06-21 09:18:06 -0600)

are available in the Git repository at:

  git://git.lwn.net/linux.git tags/docs-6.5-2

for you to fetch changes up to e27cb89a22ada4e3e7bee1567a8daa1fb2260b78:

  scripts: kernel-doc: support private / public marking for enums (2023-07-04 08:30:49 -0600)

----------------------------------------------------------------
A half-dozen late arriving docs patches.  They are mostly fixes, but we
also have a kernel-doc tweak for enums and the long-overdue removal of the
outdated and redundant patch-submission comments at the top of the
MAINTAINERS file.

----------------------------------------------------------------
Changyuan Lyu (1):
      Documentation: KVM: SEV: add a missing backtick

David Heidelberg (1):
      Documentation: ACPI: fix typo in ssdt-overlays.rst

Jakub Kicinski (2):
      docs: remove the tips on how to submit patches from MAINTAINERS
      scripts: kernel-doc: support private / public marking for enums

Olaf Hering (1):
      Fix documentation of panic_on_warn

Xueshi Hu (1):
      docs: fix typo in zh_TW and zh_CN translation

 Documentation/admin-guide/acpi/ssdt-overlays.rst   |  2 +-
 Documentation/admin-guide/kernel-parameters.txt    |  2 +-
 Documentation/process/6.Followthrough.rst          |  7 ++
 .../translations/zh_CN/process/2.Process.rst       |  2 +-
 .../translations/zh_CN/process/3.Early-stage.rst   |  2 +-
 .../translations/zh_CN/process/4.Coding.rst        |  2 +-
 .../zh_CN/process/7.AdvancedTopics.rst             |  2 +-
 .../translations/zh_TW/process/2.Process.rst       |  2 +-
 .../translations/zh_TW/process/3.Early-stage.rst   |  2 +-
 .../translations/zh_TW/process/4.Coding.rst        |  2 +-
 .../zh_TW/process/7.AdvancedTopics.rst             |  2 +-
 .../virt/kvm/x86/amd-memory-encryption.rst         |  2 +-
 MAINTAINERS                                        | 80 +---------------------
 scripts/kernel-doc                                 |  3 +
 tools/testing/selftests/rcutorture/bin/kvm.sh      |  2 +-
 15 files changed, 24 insertions(+), 90 deletions(-)

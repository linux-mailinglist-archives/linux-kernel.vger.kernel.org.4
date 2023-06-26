Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99C2B73DFD6
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 14:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbjFZMwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 08:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230518AbjFZMwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 08:52:21 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C87EE79
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 05:51:16 -0700 (PDT)
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B1AE11EC01E0;
        Mon, 26 Jun 2023 14:51:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1687783874;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=x8sWLUn1esx81Ae/lSnNaWqO1f0nktwyDABKRxCkHgg=;
        b=Ta0QfG+mYI8+qaBufj24FHs/Oef4WxsgHBuEAD2RWgJ2bs3jv3mCjpdlyoaX4f9LlJb23X
        oTh3nRDf6rYUeo2zTM3QCwRBqsUOKIVrWLuvvE3Cn5BZYH9ToZY9Ere1Z25/jtrrNEHDcb
        HPAQyL+u85VEfZgZwrLIPGRwhRUEgPg=
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id OKw8GdOWfQln; Mon, 26 Jun 2023 12:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1687783871; bh=x8sWLUn1esx81Ae/lSnNaWqO1f0nktwyDABKRxCkHgg=;
        h=Date:From:To:Cc:Subject:From;
        b=f4AUlRV8/tCz7tGN528Fzoh0tMPeP4qIhMCT6GYTo4eEm38+eWvattYOlzhiTiQkb
         qBCGegfJZfXUMdqd9oTsa3tRaoIq99ClNWPW25/qZrZY5O1i61/BDH8f6bDx88LiNJ
         7L4AceAU8XalzTPSuGXsRP2/wDdGy7BNO1Mqblstdvs6x2CrNIQxja1fX16LcTOc02
         LyonG4/H0A5sQEE7F9fY0OcewdaHcQkVrVYHppAjrpmHGIV5UDb0VZPz5O8C28Rgde
         LrWokyumJdK1rYRf/t1GCzPNq+LaEfeAuxY0LKo8OTBE96YC9W/O7tCVUXIyPo1pnZ
         BEmAAh4jbQsCrxU+fRvrUKewnYyX4dgl3zpBaOLX5OJFditfTpm+N1B/2asD7z13N8
         2jsa82JBMSPRRCdUCZjWFRBZy/zo0K65jx0XaZvD6Z+KZ6O/VGZ75C7vTMZRjiW6Es
         VWN/lTsZuk25hFv4N/SZGCxbMpDyP4DhQmwVoSvzDFBwqkdDYHLG3P4334tqQXG8ZP
         +jNDKRusWs0yP81M215UzJzddWM1c69eVJTJY1G943Ae85bkLXeWXQXI+zQPLJeKsh
         7nbgJBm9lESMuxxqWixRrzx/qITurFCoH3baW13Nbpml1IXWi7x8eTtXg3cHC0QwIa
         ES+Y0Pv69efXQCfwo0qh0IhA=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 88F8D40E019B;
        Mon, 26 Jun 2023 12:51:08 +0000 (UTC)
Date:   Mon, 26 Jun 2023 14:51:03 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] RAS updates for 6.5
Message-ID: <20230626125103.GBZJmJtwLDs7j3GSJw@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the set of RAS updates for 6.5.

Thx.

---

The following changes since commit f1fcbaa18b28dec10281551dfe6ed3a3ed80e3d6:

  Linux 6.4-rc2 (2023-05-14 12:51:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/ras_core_for_v6.5

for you to fetch changes up to 4251566ebc1cf95ae26a1e5a24cdac1ac25e942f:

  EDAC/amd64: Cache and use GPU node map (2023-06-19 13:01:44 +0200)

----------------------------------------------------------------
- Add initial support for RAS hardware found on AMD server GPUs (MI200).
  Those GPUs and CPUs are connected together through the coherent fabric
  and the GPU memory controllers report errors through x86's MCA so EDAC
  needs to support them. The amd64_edac driver supports now HBM (High
  Bandwidth Memory) and thus such heterogeneous memory controller
  systems

- Other small cleanups and improvements

----------------------------------------------------------------
Borislav Petkov (AMD) (1):
      x86/amd_nb: Re-sort and re-indent PCI defines

Muralidhara M K (2):
      EDAC/amd64: Document heterogeneous system enumeration
      EDAC/amd64: Add support for AMD heterogeneous Family 19h Model 30h-3Fh

Osama Muhammad (1):
      ras/debugfs: Fix error checking for debugfs_create_dir()

Yazen Ghannam (4):
      x86/MCE: Check a hw error's address to determine proper recovery action
      x86/amd_nb: Add MI200 PCI IDs
      x86/MCE/AMD, EDAC/mce_amd: Decode UMC_V2 ECC errors
      EDAC/amd64: Cache and use GPU node map

 Documentation/driver-api/edac.rst | 120 ++++++++++++
 arch/x86/kernel/amd_nb.c          |  50 ++---
 arch/x86/kernel/cpu/mce/amd.c     |   6 +-
 arch/x86/kernel/cpu/mce/core.c    |   2 +-
 drivers/edac/amd64_edac.c         | 386 +++++++++++++++++++++++++++++++++++---
 drivers/edac/amd64_edac.h         |   1 +
 drivers/edac/mce_amd.c            |   3 +-
 drivers/ras/debugfs.c             |   2 +-
 include/linux/pci_ids.h           |   1 +
 9 files changed, 513 insertions(+), 58 deletions(-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

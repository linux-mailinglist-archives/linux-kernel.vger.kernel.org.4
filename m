Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF3D65AA48
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Jan 2023 16:07:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbjAAPHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Jan 2023 10:07:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjAAPH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jan 2023 10:07:28 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86BDEC77
        for <linux-kernel@vger.kernel.org>; Sun,  1 Jan 2023 07:07:27 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2184A1EC0104;
        Sun,  1 Jan 2023 16:07:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1672585646;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=zwqSK+qKJQo4Xxph7azln3No/eyO2tHuCZH+tvEnbQQ=;
        b=eUJRUmaNNGixVXpfQY6pel8LQvU33VW2+tZEHzH+QdvqcyRVzlnxKvbOspjcDNu3eJuwFm
        BKMirWq3awOq7MkBPfdxLR4ge6g8ORLCq+BJ6A9s01wr0zCUCMnHnH/1vnBtXAKM6lf8+s
        jtLmy8s2Z8rQGvyfJjcz5jrh6GNZsxk=
Date:   Sun, 1 Jan 2023 16:07:25 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/urgent for v6.2-rc2
Message-ID: <Y7GhrV4YgFGdiHFP@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

pls pull a couple of urgent x86 fixes for 6.2.

Thx.

---

The following changes since commit 1b929c02afd37871d5afb9d498426f83432e71c2:

  Linux 6.2-rc1 (2022-12-25 13:41:39 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v6.2_rc2

for you to fetch changes up to 63dc6325ff41ee9e570bde705ac34a39c5dbeb44:

  x86/kprobes: Fix optprobe optimization check with CONFIG_RETHUNK (2022-12-27 12:51:58 +0100)

----------------------------------------------------------------
- Two fixes to correct how kprobes handles INT3 now that they're added by other
  functionality like the rethunks and not only kgdb

- Remove __init section markings of two functions which are referenced by a
  function in the .text section

----------------------------------------------------------------
Arnd Bergmann (1):
      x86/calldepth: Fix incorrect init section references

Masami Hiramatsu (Google) (2):
      x86/kprobes: Fix kprobes instruction boudary check with CONFIG_RETHUNK
      x86/kprobes: Fix optprobe optimization check with CONFIG_RETHUNK

 arch/x86/kernel/callthunks.c   |  4 ++--
 arch/x86/kernel/kprobes/core.c | 10 +++++++---
 arch/x86/kernel/kprobes/opt.c  | 28 ++++++++--------------------
 3 files changed, 17 insertions(+), 25 deletions(-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

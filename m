Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73ABE72EF83
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 00:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240691AbjFMWfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 18:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241437AbjFMWfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 18:35:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 729F3129
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 15:35:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E133663BAB
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 22:35:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E92E8C433C9;
        Tue, 13 Jun 2023 22:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686695713;
        bh=lbFTxvf/BgMwN9xLbUYWvuAtkG4XKrStckUVBT2xSX8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YsY384hpFWwf8WkQMsmdgGEjRx7YzEM5ho8lmMZwBund+keGWufeIYJnCPM2e1GJb
         6nJCi7oGKrQeP1fDldBDSCT/KqfSD7kip73AmHruRoK/8uI4A5fbUGycICbDb2aZzJ
         EJUGH1BOE59GAVGh28c5QhqngS8nfWW0/6M4q2sA6XwBgLuRJvI3fSVrf50FIappAd
         qeidyw4TTLs1lpUdUgL5KB6I4yHtbtRtnJAim0lfq4GFIQNkgVs71a7oZ4HrDwmJna
         ALqtqOPvkRynLOw1FOtK2FDh3kWkCA6SxG9EHIkFw25yyFGsfcglzLMV/XCo11GAVq
         HiYWGaa1Vyb7g==
From:   Dinh Nguyen <dinguyen@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     dinguyen@kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] nios2: updates for v6.5
Date:   Tue, 13 Jun 2023 17:35:10 -0500
Message-Id: <20230613223510.20803-2-dinguyen@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230613223510.20803-1-dinguyen@kernel.org>
References: <20230613223510.20803-1-dinguyen@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit ac9a78681b921877518763ba0e89202254349d1b:

  Linux 6.4-rc1 (2023-05-07 13:34:35 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git tags/nios2_updates_for_v6.5

for you to fetch changes up to 6a22e017f952ecaf4bb510cd0939259470a27b06:

  nios2: Replace all non-returning strlcpy with strscpy (2023-06-13 16:51:49 -0500)

----------------------------------------------------------------
NIOS2 updates for v6.5
- Convert pgtable constructor/destructors to ptdesc
- Replace strlcpy with strscpy

----------------------------------------------------------------
Azeem Shaikh (1):
      nios2: Replace all non-returning strlcpy with strscpy

Vishal Moola (Oracle) (1):
      nios2: Convert __pte_free_tlb() to use ptdescs

 arch/nios2/include/asm/pgalloc.h | 8 ++++----
 arch/nios2/kernel/cpuinfo.c      | 2 +-
 arch/nios2/kernel/setup.c        | 6 +++---
 3 files changed, 8 insertions(+), 8 deletions(-)

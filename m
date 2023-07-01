Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D797744A7B
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 18:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbjGAQPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 12:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjGAQPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 12:15:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C429D270E
        for <linux-kernel@vger.kernel.org>; Sat,  1 Jul 2023 09:15:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 524FD60B0A
        for <linux-kernel@vger.kernel.org>; Sat,  1 Jul 2023 16:15:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1963C433C7;
        Sat,  1 Jul 2023 16:15:10 +0000 (UTC)
Date:   Sat, 1 Jul 2023 17:15:08 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] arm64 fix for 6.5-rc1
Message-ID: <ZKBRDMx96q25piLr@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here's an unplanned second pull request for -rc1 with a fix from Will
for the SVE registers saving corrupting memory. I'll be on holiday from
tomorrow for three weeks, checking the lists occasionally. If there's
anything urgent, Will should be around. Thanks.

The following changes since commit abc17128c81ae8d6a091f24348c63cbe8fe59724:

  Merge branch 'for-next/feat_s1pie' into for-next/core (2023-06-23 18:34:16 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

for you to fetch changes up to 893b24181b4c4bf1fa2841b1ed192e5413a97cb1:

  arm64: sme: Use STR P to clear FFR context field in streaming SVE mode (2023-06-29 11:29:31 +0100)

----------------------------------------------------------------
Fix memory corruption (overwriting the kmalloc redzone) when saving the
SVE state while in SVE streaming mode.

----------------------------------------------------------------
Will Deacon (1):
      arm64: sme: Use STR P to clear FFR context field in streaming SVE mode

 arch/arm64/include/asm/fpsimdmacros.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

-- 
Catalin

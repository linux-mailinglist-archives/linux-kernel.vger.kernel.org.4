Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7A2C5F623F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 10:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbiJFIFX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 04:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbiJFIFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 04:05:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 602972A97F
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 01:05:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE8046188D
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 08:05:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 359E2C433C1;
        Thu,  6 Oct 2022 08:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665043516;
        bh=0KOBtdhLR3vaBI7Tt443ulwJnuPhBUCBnEJAPysvfKM=;
        h=From:To:Cc:Subject:Date:From;
        b=gpfKXE8earfNfX6V6NEU37qO8P+KSvXSckP5JsWHGFW0jZaFYBuiB6kohSfZVKqUf
         HwUmu1tNaR0ofem1dNVbWALoPuo5YgLQmU1pwDuYF7csUj0dhyjQJmoKjPgm7aiwn4
         4u3m70E/4BXiGhK3JJzpR87xoonuSp8PLq12UH5loIJudOeKzQM6dGHRWE4TvVCAHL
         HiUuF6obgPzI5Iy2o1p8sVYfrFwPe1iCo4lhtRY1uUHifIXq22lKSgqYEeF4KsF9ww
         G9QeYinODavigG8AitcvPFAWea9lhdN8GyM4oabHYQH52aYixsqjvy0j2tlrRFH79/
         uVPJvntotZTfQ==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Jason Baron <jbaron@akamai.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] arm64: constify arguments to satisfy asm constraints
Date:   Thu,  6 Oct 2022 15:55:40 +0800
Message-Id: <20221006075542.2658-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Constify arguments of arch_static_branch(), arch_static_branch_jump()
and alternative_has_feature_* to satisfy asm constraints.

Jisheng Zhang (2):
  arm64: jump_label: mark arguments as const to satisfy asm constraints
  arm64: alternative: constify alternative_has_feature_* argument

 arch/arm64/include/asm/alternative-macros.h | 4 ++--
 arch/arm64/include/asm/jump_label.h         | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

-- 
2.37.2


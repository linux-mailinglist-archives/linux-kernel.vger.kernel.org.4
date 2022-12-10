Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE44648E13
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Dec 2022 11:09:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbiLJKJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 05:09:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbiLJKJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 05:09:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C74920195
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 02:09:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D40C960A24
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 10:09:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86AFDC433EF;
        Sat, 10 Dec 2022 10:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670666980;
        bh=1e2h9zWuPvDzwbS9hi7jKUTtgujclYOSSbW661pCXiI=;
        h=From:To:Cc:Subject:Date:From;
        b=F2WFGkX+L68hGFT8r0tbzCbbKPi1IbeTDR5vTXt8Nl5/vISzWc7CGR5/8b5XdsIvD
         P+U6QojelTpZGb91ZdDPgEvO1H1YtNYfNBiPdfA0p0WA6MVat5FW34nsACGCCooqRj
         mNq2+VlNygT6Buns3kgPLj2MS95YzUC8zpelRY0OOdTyub43ueTg/TATsLJ7G8uTQc
         J/jiGSaaXJVf1NXSNDsgR0lnXHz3npDaYq+cSe+alx7Lq47liDw3y2/oXtSfn0XFYs
         LHPS4XL/fHYM/cMukTzwYRCNX/i9g4M6EpebCGnT+rC8OFwmGuhYP/5ql9C/iZ2OW6
         K0UKhGSl4TNyw==
From:   guoren@kernel.org
To:     palmer@rivosinc.com, conor.Dooley@microchip.com, guoren@kernel.org,
        andy.chiu@sifive.com, greentime.hu@sifive.com,
        paul.walmsley@sifive.com, peterz@infradead.org,
        rostedt@goodmis.org, jrtc27@jrtc27.com
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH -next V2 0/2] riscv: jump_label: Fixup & Optimization
Date:   Sat, 10 Dec 2022 05:09:25 -0500
Message-Id: <20221210100927.835145-1-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
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

From: Guo Ren <guoren@linux.alibaba.com>

Patch 1 is the fixup patch should be merged into stable-tree.
Patch 2 is the for-next patch.

The series is based on riscv for-next-20221210.

Andy Chiu (1):
  riscv: jump_label: Fixup unaligned arch_static_branch function

Guo Ren (1):
  riscv: jump_label: Using c.j for CONFIG_RISCV_ISA_C

 arch/riscv/include/asm/jump_label.h | 14 ++++++++++++--
 arch/riscv/kernel/jump_label.c      | 30 +++++++++++++++++++++++++++--
 2 files changed, 40 insertions(+), 4 deletions(-)

-- 
2.36.1


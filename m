Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6ABC66A6F9
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 00:22:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231389AbjAMXWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 18:22:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231245AbjAMXWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 18:22:13 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25DBF5E082;
        Fri, 13 Jan 2023 15:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=vYlWrOT2wbl+1XrOQHwKvxZ0eERdfUj+qHqDYknHSZY=; b=pzOKZixl6ev/B7z+3tiPyMwTP1
        F8Un0V34b8EUDeblpIVIJOZbT4/p2b7fSczn/ptaLA9A9t+bQfvweJal42xCfaywwwFQOs4CfCtbM
        OuIy1D6ugIvj85maZwDEBzJR8unxCqOTdR6dOGC/+Rc0WeTAF6wQtgfN4HkIjXmmzoOPD2idok20m
        tX8o6Ns4N8ZOyoXgtu9bd9fKovuOdsAzZlmCU/n7sDYOPv2KS0j+R4Sw4RggzvURAgGDJKKmdhdzA
        4SbdiAHhuysTv/+ssMKR41hNrabVNZQyBHRs0wqTyrcVIAur1jnosWtcunViEpt3eLcutMw75kpUU
        z7LWDG4w==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pGTN3-004oMs-H4; Fri, 13 Jan 2023 23:22:01 +0000
Date:   Fri, 13 Jan 2023 15:22:01 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     thunder.leizhen@huawei.com, swboyd@chromium.org,
        yang.lee@linux.alibaba.com, linux@rasmusvillemoes.dk,
        petr.pavlu@suse.com, mwilck@suse.com, pmladek@suse.com,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        mcgrof@kernel.org
Subject: [GIT PULL] modules changes for v6.2-rc4
Message-ID: <Y8HnmbSvgli7fbQI@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 88603b6dc419445847923fcb7fe5080067a30f98:

  Linux 6.2-rc2 (2023-01-01 13:53:16 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/ tags/modules-6.2-rc4

for you to fetch changes up to da35048f2600633a7f9ba5fa7d6e3b1d0195938b:

  kallsyms: Fix scheduling with interrupts disabled in self-test (2023-01-13 15:09:08 -0800)

----------------------------------------------------------------
modules-6.2-rc4

Just one fix for modules by Nick.

----------------------------------------------------------------
Nicholas Piggin (1):
      kallsyms: Fix scheduling with interrupts disabled in self-test

 kernel/kallsyms_selftest.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

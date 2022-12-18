Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDD6164FD9F
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Dec 2022 05:37:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbiLREhh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Dec 2022 23:37:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiLREhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Dec 2022 23:37:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EBB7C75C;
        Sat, 17 Dec 2022 20:37:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9550760C80;
        Sun, 18 Dec 2022 04:37:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C74FAC433D2;
        Sun, 18 Dec 2022 04:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1671338251;
        bh=+CuWc946jgB5O+bxlzR6p1QlodFvr3W5Io30D9js1kA=;
        h=Date:From:To:Cc:Subject:From;
        b=rzLTmTrIrGnuJKWG0EQcJ2ByWFqO+biyapYUZyVLeu2XvTSOGjgieUzkFAj2u1kdg
         c7xEeiZwkvPKQeNbZEEBh0gAFnEFiKPxT0O0y+6x63Qu4PVTbymHM1hiksqeNdRkOH
         3zW+L4SI4rcQTDk4bWPpr4ERDwIpIl/6o5PqjKKA=
Date:   Sat, 17 Dec 2022 20:37:30 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     mm-commits@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] final non-MM updates for 6.2-rc1
Message-Id: <20221217203730.f48e5345841a57dd6e713faf@linux-foundation.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus, please merge this fault-injection patchset.

Thanks.


The following changes since commit 8fa590bf344816c925810331eea8387627bbeb40:

  Merge tag 'for-linus' of git://git.kernel.org/pub/scm/virt/kvm/kvm (2022-12-15 11:12:21 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-nonmm-stable-2022-12-17-20-32

for you to fetch changes up to f9eeef5918bbe1f2545d36280330dced25d6cf97:

  fault-injection: make stacktrace filter works as expected (2022-12-15 16:40:44 -0800)

----------------------------------------------------------------
Some fault-injection improvements from Wei Yongjun which enable stacktrace
filtering on x86_64.

----------------------------------------------------------------
Wei Yongjun (4):
      fault-injection: allow stacktrace filter for x86-64
      fault-injection: skip stacktrace filtering by default
      fault-injection: make some stack filter attrs more readable
      fault-injection: make stacktrace filter works as expected

 lib/Kconfig.debug  |  1 -
 lib/fault-inject.c | 22 ++++++++++++++--------
 2 files changed, 14 insertions(+), 9 deletions(-)


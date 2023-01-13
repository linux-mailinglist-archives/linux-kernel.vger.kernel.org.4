Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC26F669E28
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 17:31:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbjAMQbc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 11:31:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbjAMQa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 11:30:59 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF3138CBFA;
        Fri, 13 Jan 2023 08:25:03 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 32561733;
        Fri, 13 Jan 2023 16:25:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 32561733
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1673627103; bh=Z48ylUZQFZkafGo/+DHs66tWwdi6CGogaUiWFURqDlI=;
        h=From:To:Cc:Subject:Date:From;
        b=g23PxuEekEno7RcFANneDf6TenhIIcnipCWnInNOd2swjkZOH5wtbGH3vNGVOq9Wj
         /pt63pXUWnJURSnFr2OSz+hkUHnGdHx3DTMVpOfK+S0/p9VlfZ14xphlDR85f4/yIE
         6+veoRemaN9AnImXfe9x9CJzLQvEgvTUs6lbhZohPkR9Bkf+TSeQwLhy5cg/dq6d88
         EUyHxfXT1Z7TOCGYa2PjB1Y6poBNehZM/m3ADTwi5JD7wQkjrmtwX4W9E6kDQ4WSzD
         0eRDqIQEaMvJs07ymAI5h76AeL4CU1cDf0ULz+zwBsvUZvslqaCwDlaziq5qR0hG8R
         70c0MpzHtx0PQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Linus Torvalds <torvalds@linuxfoundation.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Documentation fixes for 6.2
Date:   Fri, 13 Jan 2023 09:25:02 -0700
Message-ID: <877cxqs8pt.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 1b929c02afd37871d5afb9d498426f83432e71c2:

  Linux 6.2-rc1 (2022-12-25 13:41:39 -0800)

are available in the Git repository at:

  git://git.lwn.net/linux.git tags/docs-6.2-fixes

for you to fetch changes up to a33ae832bf3f2ac33e2e44b99f76130d3be848c5:

  docs/conf.py: Use about.html only in sidebar of alabaster theme (2023-01-11 15:06:50 -0700)

----------------------------------------------------------------
Three documentation fixes (or rather two and one warning):

 - Sphinx 6.0 broke our configuration mechanism, so fix it.
 - I broke our configuration for non-Alabaster themes; Akira fixed it.
 - Deprecate Sphinx < 2.4 with an eye toward future removal

----------------------------------------------------------------
Akira Yokosawa (1):
      docs/conf.py: Use about.html only in sidebar of alabaster theme

Jonathan Corbet (2):
      docs: Fix the docs build with Sphinx 6.0
      docs: Deprecate use of Sphinx < 2.4.x

 Documentation/conf.py               | 12 +++++++++++-
 Documentation/sphinx/load_config.py |  6 ++++--
 2 files changed, 15 insertions(+), 3 deletions(-)

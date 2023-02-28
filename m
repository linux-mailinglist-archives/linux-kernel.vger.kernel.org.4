Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 686116A62C7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 23:47:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbjB1WrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 17:47:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjB1WrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 17:47:07 -0500
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E73B132CE2;
        Tue, 28 Feb 2023 14:47:04 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 53D69377;
        Tue, 28 Feb 2023 22:47:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 53D69377
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1677624424; bh=7MOTi1s0b6wiBYLHjM9LPAN2VSq4alK+pt/BAj3Oh5s=;
        h=From:To:Cc:Subject:Date:From;
        b=SZfsWHTYodVesLpkkDor5aNKlAkkcj88wZexFryLzKj3tSXRc5KonSWXxJbfjJmdN
         6a0D+iNZCde9EXh3NxmVY3RzaGYTebdNe+Buc+42ycsRE5vJH0I9y5O8cEnsVFfvSr
         p/wYiJPH1k9A1Oi8zCmocqhBvNsZzIB2nuZupgIVMLGejzA2soCJfA+2ReOLRGtfmd
         uQJ6mPerZnpI+eubIJvQglyATKCel6aIsyoUnIZeOUWMGDcg3+at4lbECCuBM/3YJ5
         Dy/L2CMGK0h7nRhbsbCluBUVgRqd6VxpwZceW5qJ1tWqmJ4Asn6hxJSr55Z0Fuxpq0
         WNhxqVFcG35XA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Linus Torvalds <torvalds@linuxfoundation.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Documentation stragglers for 6.3
Date:   Tue, 28 Feb 2023 15:47:03 -0700
Message-ID: <87sfepwgpk.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit cc29eadef921fe52aa58f32536a93d9ea0ca3eb7:

  Documentation/watchdog/hpwdt: Fix Format (2023-02-16 17:31:29 -0700)

are available in the Git repository at:

  git://git.lwn.net/linux.git tags/docs-6.3-2

for you to fetch changes up to 901578a45950bcc4d5055a24e9016d61b84dc1a2:

  docs: recommend using Link: whenever using Reported-by: (2023-02-23 12:47:46 -0700)

----------------------------------------------------------------
A handful of documentation patches that were ready before the merge window,
but which I didn't get merged for the first round:

- A recommendation from Thorsten (also akpm) on use of Link tags to point
  out problem reports.

- Some front-page formatting tweaks

- Another Spanish translation

- One typo(ish) fix.

----------------------------------------------------------------
Carlos Bilbao (1):
      docs/sp_SP: Add process programming-language translation

Lukas Bulwahn (1):
      docs: locking: refer to the actual existing config names

Randy Dunlap (1):
      Documentation: front page: use recommended heading adornments

Thorsten Leemhuis (1):
      docs: recommend using Link: whenever using Reported-by:

 Documentation/index.rst                            | 17 +++----
 Documentation/locking/locktorture.rst              |  4 +-
 Documentation/process/5.Posting.rst                |  3 +-
 Documentation/process/submitting-patches.rst       |  9 ++--
 Documentation/translations/sp_SP/process/index.rst |  1 +
 .../sp_SP/process/programming-language.rst         | 53 ++++++++++++++++++++++
 6 files changed, 72 insertions(+), 15 deletions(-)
 create mode 100644 Documentation/translations/sp_SP/process/programming-language.rst

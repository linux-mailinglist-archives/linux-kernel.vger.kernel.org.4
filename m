Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE2FC6F88B1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 20:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233205AbjEESin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 14:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231730AbjEESil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 14:38:41 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82A551436C;
        Fri,  5 May 2023 11:38:39 -0700 (PDT)
Received: from localhost (mdns.lwn.net [45.79.72.68])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 124E62E0;
        Fri,  5 May 2023 18:38:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 124E62E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1683311919; bh=1ijoFgRvMyacNsF79Evr4UVIPMu4V4s6jcDs2K3BimA=;
        h=From:To:Cc:Subject:Date:From;
        b=OtLEjBv6Vo6w1VY56OH8dDUhWdylc7Xc0jdTav7xGwonZywFh52km0E+pfSzxJHul
         aZlvuyRWJaPDbMqEAAcFG1+iWsHwxV8fa1gogv6cnxfoIzc2fIgv6nf0QzudtjPwah
         JJqDnTz8Zulc4uYKj/FC60fAL8jO0CnvhcGD1rhtbzpQLMzH3eyKnFJRTUwuwqB5f3
         NiO/IvWP44ST/s0JhLpWRk2sJ77o52GhMVPen+hNYbqn20Bb+oqs4KA+ffCbhXG/LO
         71AcffbN3Yntpz3x0csFvwjruXm3izJT6w8KWnXnvGRnbCDIeIdAgDo/gE23M7QT8W
         48OmXykOyoJFA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Linus Torvalds <torvalds@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [GIT PULL] Documentation stragglers for 6.4
Date:   Fri, 05 May 2023 12:38:38 -0600
Message-ID: <874joqmxn5.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 7e8472c820f04517ae5d5a27c1aecfa2263a0aa5:

  media: Adjust column width for pdfdocs (2023-04-23 09:25:52 -0600)

are available in the Git repository at:

  git://git.lwn.net/linux.git tags/docs-6.4-2

for you to fetch changes up to cdc822dda6f82269b94d5fa60ddc71d98c160fa0:

  docs/sp_SP: Add translation of process/adding-syscalls (2023-05-02 11:09:=
53 -0600)

----------------------------------------------------------------
A handful of late-arriving documentation fixes, plus one Spanish
translation that has been ready for some time but got applied late.

----------------------------------------------------------------
Carlos Bilbao (1):
      docs/sp_SP: Add translation of process/adding-syscalls

Deming Wang (1):
      docs: fix "Reviewd" typo

Donald Hunter (1):
      docs/admin-guide/mm/ksm.rst fix intraface -> interface typo

Fabio Fantoni (1):
      doc:it_IT: fix some typos

Geert Uytterhoeven (1):
      Documentation: timers: hrtimers: Make hybrid union historical

Mat Martineau (1):
      CREDITS: Update email address for Mat Martineau

Tao Liu (1):
      docs: Remove unnecessary unicode character

=E6=99=8F=E8=89=B3(=E9=87=87=E8=8B=93) (1):
      Documentation: update kernel stack for x86_64

 CREDITS                                            |   4 +-
 Documentation/admin-guide/mm/ksm.rst               |   2 +-
 Documentation/arch/x86/kernel-stacks.rst           |   2 +-
 Documentation/timers/hrtimers.rst                  |  19 +-
 .../translations/it_IT/kernel-hacking/locking.rst  |   2 +-
 .../translations/it_IT/process/deprecated.rst      |   2 +-
 .../it_IT/process/submitting-patches.rst           |   6 +-
 Documentation/translations/ja_JP/SubmittingPatches |   2 +-
 .../translations/sp_SP/process/adding-syscalls.rst | 632 +++++++++++++++++=
++++
 Documentation/translations/sp_SP/process/index.rst |   1 +
 .../translations/zh_CN/process/magic-number.rst    |   2 +-
 .../translations/zh_TW/process/magic-number.rst    |   2 +-
 12 files changed, 652 insertions(+), 24 deletions(-)
 create mode 100644 Documentation/translations/sp_SP/process/adding-syscall=
s.rst

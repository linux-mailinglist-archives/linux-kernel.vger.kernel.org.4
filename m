Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 003116154AC
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 23:04:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbiKAWEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 18:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231279AbiKAWEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 18:04:04 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B8C114D1D;
        Tue,  1 Nov 2022 15:03:52 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73:8b7:7001:c8aa:b65f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id A0B9E365;
        Tue,  1 Nov 2022 22:03:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net A0B9E365
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1667340232; bh=jO4gD8L1wTs5nUFcj9QOQgNbI5MHAgFzoSQUT7ySAcM=;
        h=From:To:Cc:Subject:Date:From;
        b=X1KQlosYNXLoLfZHv3lS97Fe1ZomyCv0MFy3ue/hsMuYghD1SXNZ+joW1nSp3IUYd
         MdJVfDSVGSwmAk9tPilFubDwyzP1HWfaUKs9gYf2bMz5ekoqIGcPeQI40f/o0+WkQE
         qyz5x/X+2u0UGpo/j1EBei6+ARC98bfe8BnHrYOPYmLeXWJxoiKSku97pUWw6Bd/NV
         MEbCHoW9+EbTaAveF0mevSh+yPqW5yK/zQ7vDBcUT+T06k7FXJ5zyYsbcuzGRoFWyN
         2EZxiIuB+V2wzYO/pMAi89rreVPsAxXft0KF08NjohPNvqzhlq4e2vdVhY6rbkVcLj
         9PZUwBYfAZNgA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Linus Torvalds <torvalds@linuxfoundation.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] A handful of documentation fixes
Date:   Tue, 01 Nov 2022 16:03:52 -0600
Message-ID: <87o7tqxrg7.fsf@meer.lwn.net>
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

The following changes since commit 9abf2313adc1ca1b6180c508c25f22f9395cc780:

  Linux 6.1-rc1 (2022-10-16 15:36:24 -0700)

are available in the Git repository at:

  git://git.lwn.net/linux.git tags/docs-6.1-fixes

for you to fetch changes up to 2f3f53d62307262f0086804ea7cea99b0e085450:

  docs/process/howto: Replace C89 with C11 (2022-10-24 11:27:51 -0600)

----------------------------------------------------------------
Four small fixes for the docs tree.

----------------------------------------------------------------
Akira Yokosawa (1):
      docs/process/howto: Replace C89 with C11

Mushahid Hussain (1):
      Documentation: Fix spelling mistake in hacking.rst

Nick Desaulniers (1):
      Documentation: process: replace outdated LTS table w/ link

Zheng Yejian (1):
      tracing/histogram: Update document for KEYS_MAX size

 Documentation/kernel-hacking/hacking.rst           |  2 +-
 Documentation/process/2.Process.rst                | 15 ++++-----------
 Documentation/process/howto.rst                    |  2 +-
 Documentation/trace/histogram.rst                  |  2 +-
 Documentation/translations/it_IT/process/howto.rst |  2 +-
 Documentation/translations/ja_JP/howto.rst         |  2 +-
 Documentation/translations/ko_KR/howto.rst         |  2 +-
 Documentation/translations/zh_CN/process/howto.rst |  2 +-
 Documentation/translations/zh_TW/process/howto.rst |  2 +-
 9 files changed, 12 insertions(+), 19 deletions(-)

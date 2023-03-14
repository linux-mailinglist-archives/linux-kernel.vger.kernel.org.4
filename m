Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3849C6B9D2E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 18:37:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbjCNRhz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 13:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjCNRhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 13:37:53 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A84BAB8BB;
        Tue, 14 Mar 2023 10:37:53 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id A1096823;
        Tue, 14 Mar 2023 17:37:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net A1096823
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1678815472; bh=UQ1CnYegaWSgM1hdGDGmxG7geI5GvTNGnjX2faKrlGg=;
        h=From:To:Cc:Subject:Date:From;
        b=cm+RL8NIsC7CAb7q7Hgl/tm+e7X/wiXnguqshTeMDvfgsZMpfZ0u6L52Y5d0FHzOF
         Xs9W4y705LfHpymnB1dqhreEx4qH5ah1HV3QK46/9Btek4OqbEwj48LLsVtuOCENyP
         UU/5GUcu/OzUcnZFmV9lyWd8Qcfb6JCEmJWyaCwUw3HOf5cT2wUgsi1zda6y6lPXHW
         Y+6iE0h7M1A8mIjDPjayZpFM+XAH12auRFyC7ixZy3jstq7ICQVIF7H74fGHrQRBgw
         670EqPTYRGMcbyIvNgCRTLLX5XTMuHvj0Wxup73qLEYX7v4Nr8O9wO3ZVDx6aJt2bS
         ac7v7VFl6iiZg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Linus Torvalds <torvalds@linuxfoundation.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Documentation fixes for 6.3
Date:   Tue, 14 Mar 2023 11:37:51 -0600
Message-ID: <874jqntes0.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit fe15c26ee26efa11741a7b632e9f23b01aca4cc6:

  Linux 6.3-rc1 (2023-03-05 14:52:03 -0800)

are available in the Git repository at:

  git://git.lwn.net/linux.git tags/docs-6.3-fixes

for you to fetch changes up to d7ba3657d5162bd551e5c653f67f941c94a7dc0a:

  docs: vfio: fix header path (2023-03-14 11:31:57 -0600)

----------------------------------------------------------------
A handful of fixes and minor documentation updates.

----------------------------------------------------------------
Glenn Washburn (1):
      docs: Correct missing "d_" prefix for dentry_operations member d_weak=
_revalidate

Jiri Pirko (1):
      docs: vfio: fix header path

Miguel Ojeda (2):
      docs: programming-language: remove mention of the Intel compiler
      docs: programming-language: add Rust programming language section

Mike Rapoport (IBM) (2):
      docs/mm: Physical Memory: fix a reference to a file that doesn't exist
      docs/mm: hugetlbfs_reserv: fix a reference to a file that doesn't exi=
st

Song Shuai (1):
      sched/doc: supplement CPU capacity with RISC-V

Uwe Kleine-K=C3=B6nig (1):
      docs: rebasing-and-merging: Drop wrong statement about git

Xujun Leng (1):
      docs: process: typo fix

 Documentation/driver-api/vfio.rst                  |  2 +-
 Documentation/filesystems/vfs.rst                  |  2 +-
 Documentation/maintainer/rebasing-and-merging.rst  |  6 +-----
 Documentation/mm/hugetlbfs_reserv.rst              |  8 ++++----
 Documentation/mm/physical_memory.rst               |  2 +-
 Documentation/process/programming-language.rst     | 24 ++++++++++++++++--=
----
 Documentation/process/submitting-patches.rst       |  2 +-
 Documentation/scheduler/sched-capacity.rst         |  2 +-
 .../translations/zh_CN/mm/hugetlbfs_reserv.rst     |  3 ++-
 .../zh_CN/scheduler/sched-capacity.rst             |  2 +-
 10 files changed, 31 insertions(+), 22 deletions(-)

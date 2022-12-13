Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF30664B0AF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 09:01:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234509AbiLMIA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 03:00:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233935AbiLMIAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 03:00:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF2617AB4
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 00:00:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D29EA61357
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 08:00:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1533EC433EF;
        Tue, 13 Dec 2022 08:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670918434;
        bh=wmrczL6i5ek8KNk4nUN6DX8sToyA18W4TB1erQFFwS8=;
        h=Date:From:To:Cc:Subject:From;
        b=X76ygUxJV/hOD6HsMNAizo2p+sOy8X9im7UmLQFTuwSETKhAJrbNkIQ+GYd/axDDM
         SbGOgNlvNWoS3Pfmz2Dl1mZxkxb7LJdo0gVmQjHG2E6ZYBdnpF8lsuOshbKkXPmzkW
         IgaAWXRDqoPKv3DI+7Xi0Ej4ZKAtKW3S0pel+KEUUZZ50WsMiFHLPLg+J3riOC7BnN
         d2l23PimpVAHzX5HuR3QbkasIb0U8c6hZeOtRPNwDVBpeKMVF4a/r7SpGggmXK/4uE
         FZSXvR5/6oLbDGSoo/+vSUtKxz7HPKP0ifbwzN/o8a92sWQFuEBus5u1Fk0eG70Zba
         2xod5zv4jDqrg==
Date:   Tue, 13 Dec 2022 10:00:18 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Rebecca Mckeever <remckee0@gmail.com>,
        Shaoqin Huang <shaoqin.huang@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] memblock updates for v6.2
Message-ID: <Y5gxEtdyZuqp6hZd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit 30a0b95b1335e12efef89dd78518ed3e4a71a763:

  Linux 6.1-rc3 (2022-10-30 15:19:28 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock tags/memblock-v6.2-rc1

for you to fetch changes up to 80c2fe022ef5d29f3bafee90c37dbcff18cab57a:

  memblock tests: remove completed TODO item (2022-11-08 09:50:24 +0200)

----------------------------------------------------------------
memblock: extend test coverage

* add tests that trigger reallocation of memblock structures from
  memblock itself via memblock_double_array()
* add tests for memblock_alloc_exact_nid_raw() that verify that requested
  node and memory range constraints are respected.

----------------------------------------------------------------
Rebecca Mckeever (5):
      memblock tests: introduce range tests for memblock_alloc_exact_nid_raw
      memblock tests: add top-down NUMA tests for memblock_alloc_exact_nid_raw
      memblock tests: add bottom-up NUMA tests for memblock_alloc_exact_nid_raw
      memblock tests: add generic NUMA tests for memblock_alloc_exact_nid_raw
      memblock tests: remove completed TODO item

Shaoqin Huang (3):
      memblock test: Add test to memblock_add() 129th region
      memblock test: Add test to memblock_reserve() 129th region
      memblock test: Update TODO list

 tools/testing/memblock/Makefile                    |    2 +-
 tools/testing/memblock/TODO                        |   14 +-
 tools/testing/memblock/main.c                      |    2 +
 tools/testing/memblock/tests/alloc_exact_nid_api.c | 1113 ++++++++++++++++++++
 tools/testing/memblock/tests/alloc_exact_nid_api.h |   25 +
 tools/testing/memblock/tests/alloc_nid_api.c       |  546 +++++-----
 tools/testing/memblock/tests/alloc_nid_api.h       |    1 +
 tools/testing/memblock/tests/basic_api.c           |  184 ++++
 tools/testing/memblock/tests/common.c              |    7 +-
 tools/testing/memblock/tests/common.h              |    8 +-
 10 files changed, 1622 insertions(+), 280 deletions(-)
 create mode 100644 tools/testing/memblock/tests/alloc_exact_nid_api.c
 create mode 100644 tools/testing/memblock/tests/alloc_exact_nid_api.h

-- 
Sincerely yours,
Mike.

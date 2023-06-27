Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED76C73F798
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 10:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbjF0ImJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 04:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231476AbjF0ImC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 04:42:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A4A10D7
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 01:41:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D223F6104F
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 08:41:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2B2CC433C8;
        Tue, 27 Jun 2023 08:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687855315;
        bh=CNvVf0CW9zYR+RPLZwjcn4zfHDWpIun9htkTMtA7UeE=;
        h=Date:From:To:Cc:Subject:From;
        b=ujAkgVWnE9vlOctMQ8bg7nbHy7a+78JOiG+v/bB30j2UiM5d1zIcFitl3KrMKuaBZ
         +OaazkSXYNCzO089SebZXOeE3kO39tj4xdDeplKy21bZVBm16xNTsKIY4OmtEAugVn
         AXSmiYkpBecwvw9LQqLdis1232nnWIqAYSh4ZeOd4532y6eUnFT4d9+VPh8EXgNn1l
         Q8tlY7TxmmJiCT8FFGWwgyVbXrLVKV16/LVErA/kuiYCTnpVrqsDa5ACLtZy/biyO5
         AdxCOava3nBcmv3CBkeUuO6Am9NGxY14noWxHre3F3DLZyHeUADQjHA3K8gru9osnI
         qm6koZQNiqcHw==
Date:   Tue, 27 Jun 2023 11:40:58 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Claudio Migliorelli <claudio.migliorelli@mail.polimi.it>,
        Yuwei Guan <ssawgyw@gmail.com>,
        Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] memblock: small updates for v6.5-rc1
Message-ID: <20230627084058.GM52412@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit 44c026a73be8038f03dbdeef028b642880cf1511:

  Linux 6.4-rc3 (2023-05-21 14:05:48 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock memblock-v6.5-rc1

for you to fetch changes up to de649e7f5edb2e61dbd3d64deae44cb165e657ad:

  memblock: Update nid info in memblock debugfs (2023-06-02 08:23:41 +0300)

----------------------------------------------------------------
memblock: small updates for 6.5-rc1

* add test for memblock_alloc_node()
* minor coding style fixes
* add flags and nid info in memblock debugfs

----------------------------------------------------------------
Claudio Migliorelli (2):
      Add tests for memblock_alloc_node()
      Fix some coding style errors in memblock.c

Yuwei Guan (2):
      memblock: Add flags and nid info in memblock debugfs
      memblock: Update nid info in memblock debugfs

 mm/memblock.c                                | 34 +++++++++++++++++++----
 tools/testing/memblock/tests/alloc_nid_api.c | 40 ++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+), 5 deletions(-)

-- 
Sincerely yours,
Mike.

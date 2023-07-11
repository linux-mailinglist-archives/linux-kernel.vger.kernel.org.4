Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89DF574E622
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 06:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbjGKE4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 00:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbjGKEyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 00:54:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A635FB;
        Mon, 10 Jul 2023 21:54:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BA384612DD;
        Tue, 11 Jul 2023 04:54:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB8AEC433C7;
        Tue, 11 Jul 2023 04:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689051249;
        bh=+bXBwyBbK7nsw/mlMRkPULbaj1P6QJJNDVWLQ1idiJ8=;
        h=From:To:Cc:Subject:Date:From;
        b=aoP8/Jd2QFbSrS5CvK9sOApT6A0kIlDwYCHtMtKBF9VYEwNzmLPHCtIyvVf81lPjF
         zBUlu8xX1J1urjHKsPt+43SoWE3R7matY3lUBmPFOWEAwHAhxcEpvcJf5DUDzCTy+U
         FSYTLbzBeGRcEzwhS+ILIk+L0DA20H1eB5fy6AYw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.4.3
Date:   Tue, 11 Jul 2023 06:53:59 +0200
Message-ID: <2023071100-studied-state-715a@gregkh>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm announcing the release of the 6.4.3 kernel.

All users of the 6.4 kernel series must upgrade.

The updated 6.4.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.4.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                     |    2 +-
 include/linux/bootmem_info.h |    2 ++
 kernel/fork.c                |    1 +
 mm/memory.c                  |    7 +++++++
 mm/mmap.c                    |    6 ++++++
 5 files changed, 17 insertions(+), 1 deletion(-)

Greg Kroah-Hartman (1):
      Linux 6.4.3

Hugh Dickins (1):
      mm: lock newly mapped VMA with corrected ordering

Liu Shixin (1):
      bootmem: remove the vmemmap pages from kmemleak in free_bootmem_page

Peter Collingbourne (1):
      mm: call arch_swap_restore() from do_swap_page()

Suren Baghdasaryan (3):
      mm: lock a vma before stack expansion
      mm: lock newly mapped VMA which can be modified after it becomes visible
      fork: lock VMAs of the parent process when forking


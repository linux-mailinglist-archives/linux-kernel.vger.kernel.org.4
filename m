Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 876AD6E508B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 21:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbjDQTE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 15:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjDQTE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 15:04:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E8861FF3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 12:04:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A8A1E62115
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 19:04:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 575FBC433D2;
        Mon, 17 Apr 2023 19:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681758294;
        bh=36k7ZHV7THElv6BYEiOboGGyVznhxk9OHTRtqn1QgQo=;
        h=From:To:Cc:Subject:Date:From;
        b=sOkt741rD3wSiLsDPSvg0sFaEi4jC6NWWhTAJaMhCfdVw3EW9B2fRy4JUrbnS9HAY
         cuqyoyWgCDK3GMzoRNJyohejJREWRzrQrgYCIrf08r8a7UuZ8RNIzj70igLXDEgkey
         JiPVU045OLF3kU/V/UXAZ1c0UaEoOjyeN5LIyHXr3rZATn1xB64fLEOOIeC8ZoaH2y
         EE80ipuDfUZar/Wu7kqLPscnN8hzn4AuaKNgG9FCdPWTPDIo4xvmFPreqa8ZnJKzOx
         3tjhsDsYuV31AW01+QGo3ViHFKM6F0l1aDIC32xRd30wIjE/eZ4GpaBPUJoU89Gwoh
         GxTF46iNM+KgA==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     SeongJae Park <sj@kernel.org>, vbabka@suse.cz, willy@infradead.org,
        paulmck@kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/2] mm/slab: trivial fixup for SLAB_TYPESAFE_BY_RCU example code snippet
Date:   Mon, 17 Apr 2023 19:04:48 +0000
Message-Id: <20230417190450.1682-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes from v3
(https://lore.kernel.org/linux-mm/20230417173238.22237-1-sj@kernel.org/)
- Yet more wordsmith of the second patch's commit message
  (Matthew Wilcox)

Changes from v2
(https://lore.kernel.org/linux-mm/20230415033159.4249-1-sj@kernel.org/)
- Wordsmith commit message of the second patch (Valstimil Babka)

Changes from v1
(https://lore.kernel.org/linux-mm/20230415003754.1852-1-sj@kernel.org/)
- Update label (s/again/begin/) correctly (Matthew Wilcox)
- Add missed rcu_read_unlock()

This patchset is for trivial fixup for SLAB_TYPESAFE_BY_RCU example code
snippet, namely adding missed semicolon and breaking RCU read-side
critical section into smaller ones.

SeongJae Park (2):
  mm/slab: add a missing semicolon on SLAB_TYPESAFE_BY_RCU example code
  mm/slab: break up RCU readers on SLAB_TYPESAFE_BY_RCU example code

 include/linux/slab.h | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

-- 
2.25.1


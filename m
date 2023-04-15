Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF606E2ED1
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 05:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbjDODcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 23:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjDODcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 23:32:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1179C1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 20:32:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 47D1161668
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 03:32:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28A74C433D2;
        Sat, 15 Apr 2023 03:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681529527;
        bh=zrnvQbJRP8KwMbeuQm8RWrnctmmFuomVwOxEtlAx9+0=;
        h=From:To:Cc:Subject:Date:From;
        b=sAuxz+bqsaq3Lcyk6nrqJOaWRl1tZH3oAvW+Cx9n+oaNMxHuEsyJx3aPNUk1MCrvU
         LwaN03xeJ/c+zk1lasxCANxXAP+QFg/yVcB/r3H5oYBCKW6f5ZE57lwZ+lyQRgSgvt
         3cRlce2K4BgdBScr3zLej2/+bhL8xBCun5T5gCmFpSsge2lIzeKpvENC1dBxGM5lw4
         /kfcKXkHrkNnZ3FCAO5gN49+CHMtf/FXBz/hp8JJtBLD2dXz+rFQeEiWOJEWPCNcx+
         rfEQ5jEnwEfBhIPyqbnoYtnowxuqnQsfP6qLxCKnC7xSAdCNKIojMfZ2RQLr9cmdtA
         vBoImLo2TLJKw==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     vbabka@suse.cz, willy@infradead.org, paulmck@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        SeongJae Park <sj@kernel.org>
Subject: [PATCH v2 0/2] mm/slab: trivial fixup for SLAB_TYPESAFE_BY_RCU example code snippet
Date:   Sat, 15 Apr 2023 03:31:57 +0000
Message-Id: <20230415033159.4249-1-sj@kernel.org>
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


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 430546E4F3D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 19:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbjDQRcr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 13:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjDQRco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 13:32:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74ACB268A
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 10:32:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4F7286234B
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 17:32:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0164CC433EF;
        Mon, 17 Apr 2023 17:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681752762;
        bh=cS2RFs4XMe0xw2oUFdlh9ED73FpVzzv+cYgwOzfeKs4=;
        h=From:To:Cc:Subject:Date:From;
        b=WAB9sLbnY4Gys4zfBKBSFUuRBA0NSqtwZVxeBbn5t3RXcLpUGoo8uzemVUJirU7LP
         uc+86KL+i1KvLpscvoD4f/G3cBjANnmKn1gYPT4V6/WrxKSxX/RfdROz0x9V+pkGJu
         7zrkxf9+DH1BEv2y7zxnZfEV16xQ16qwhjZF1TDbD6dCX8AH/zs8n/+afTaBkMR8OQ
         wwOYDJzO0CPpWdXwB4lzwZ0+6WGygwcW+xoyJjU4H5NDbKduNJ5JPXsvxDhvOM8hBM
         S/oyXLRGWGAk2CtkoVeyS8l2IvVnjnTS/vjD9aCYlyYbTh3fQ5PlyzWT4JM9++q1zx
         s6Sbu9J/02Avg==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     SeongJae Park <sj@kernel.org>, vbabka@suse.cz, willy@infradead.org,
        paulmck@kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] mm/slab: trivial fixup for SLAB_TYPESAFE_BY_RCU example code snippet
Date:   Mon, 17 Apr 2023 17:32:36 +0000
Message-Id: <20230417173238.22237-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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


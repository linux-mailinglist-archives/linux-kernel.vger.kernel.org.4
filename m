Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64B8B67BADB
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 20:29:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235093AbjAYT3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 14:29:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjAYT3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 14:29:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3579116ACF;
        Wed, 25 Jan 2023 11:28:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AFB01615CC;
        Wed, 25 Jan 2023 19:28:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63D90C433D2;
        Wed, 25 Jan 2023 19:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674674935;
        bh=6X73NX5j0pdKQCjWu91w+LH3cNHmhTzci/Tjxm01REM=;
        h=From:To:Cc:Subject:Date:From;
        b=h4IbjAXcQ07Ul7kUysKKrLB0Kxw2pdwQkCaWH1crC0sedx4zxq3OoFUKwb1B2Wc2+
         rCAxszh7hp/QXGXrnbo2u+LPTDkWOQYSyN7WozhN4sgabiGhVDvWcWMTcWPy4L9N9v
         Jut/5DBukorM5pygJGEUd7IjJ235CPQnCq1UBm2q/73/n6V/koO2ppmOofTUpb7ccr
         Com1WR94iqb+QeEqBdKv8jgiOGJEkQ+ZOOfD3DWb+sl+doC2VLtS8EBeIob2shzQin
         c6GdZB0dULFNVcObs13TQAntv/2dXeWLm0JfhhHHtnncWDX4P2FJ3IeBKGhKVqfq9w
         qYuArwzATRSVA==
From:   Mike Rapoport <rppt@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v5 0/1] docs/mm: start filling out new structure
Date:   Wed, 25 Jan 2023 21:28:40 +0200
Message-Id: <20230125192841.25342-1-rppt@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Mike Rapoport (IBM)" <rppt@kernel.org>

Hi,

Last year at LSF/MM Matthew promptly created the new structure for MM
documentation, but there still was no patches with content.

I've started to work on it a while ago and I wanted to send it out in a
more complete form, but I've got distracted and didn't have time to work
on this.

With fast changes around struct page and the threat of Lorenzo's book,
I've decided to send out what I have till now with a hope that we can
really make this a collaborative effort with people filling paragraph
here and there.

If somebody does not feel like sending formal patches, just send me the
"raw" text my way and I'll deal with the rest.

The text is relatively heavily formatted because I believe the target
audience will prefer html version.

v5:
* fix node_states[] example (Vlastimil)

v4: https://lore.kernel.org/all/20230115184212.996298-1-rppt@kernel.org
* squash commits into one (Bagas)
* fix references formatting (kbuild)
* add Reviewed-by and Acked-by tags

v3: https://lore.kernel.org/all/20230112091616.824565-1-rppt@kernel.org
* rephrase ZONE_DMA(32) and ZONE_MOVABLE description (Michal)
* add cross-reference to DMA API

v2: https://lore.kernel.org/all/20230110152358.2641910-1-rppt@kernel.org
* rephrase the paragraph inroducing zones (Lorenzo)
* update formatting (Bagas)
* add section stubs (Bagas)
* small fixes here and there

v1: https://lore.kernel.org/all/20230101094523.1522109-1-rppt@kernel.org

Mike Rapoport (IBM) (1):
  docs/mm: Physical Memory: add structure, introduction and nodes
    description

 Documentation/core-api/dma-api.rst   |   2 +
 Documentation/mm/page_reclaim.rst    |   2 +
 Documentation/mm/physical_memory.rst | 346 +++++++++++++++++++++++++++
 3 files changed, 350 insertions(+)

-- 
2.35.1


*** BLURB HERE ***

Mike Rapoport (IBM) (1):
  docs/mm: Physical Memory: add structure, introduction and nodes
    description

 Documentation/core-api/dma-api.rst   |   2 +
 Documentation/mm/page_reclaim.rst    |   2 +
 Documentation/mm/physical_memory.rst | 347 +++++++++++++++++++++++++++
 3 files changed, 351 insertions(+)


base-commit: b7bfaa761d760e72a969d116517eaa12e404c262
-- 
2.35.1


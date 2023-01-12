Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53805666E0E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 10:27:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240098AbjALJ1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 04:27:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239884AbjALJ0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 04:26:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC6381AA34;
        Thu, 12 Jan 2023 01:16:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 738A1B81DBE;
        Thu, 12 Jan 2023 09:16:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E2DDC433F0;
        Thu, 12 Jan 2023 09:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673514990;
        bh=DjSUWLCCoHmwa2yENKF2bU4H10yE7Rv4+InOgRsZT5c=;
        h=From:To:Cc:Subject:Date:From;
        b=s5TvrV2ioxMpkk8qDko5R4U19/d6DJDQLJIZmFaNXAYEw4lmNVOqcnKweILqD5aer
         sO/DOVreeS8mQoVqizHAOUCCA7fMF+NdkKHTV08DuKMd44QdE4DWLf4JhMlqw+56OH
         PiXc7EuO4CjPuMnUbcMKz/6QZKAJO7j3dD3psfAfDM5fknzyeaP/prVReJeSqpRuoA
         SJ7zMHg6LkC8dM19htGJXRPmBQxjKI/TU+MSSpPtmPWMKQflS75nv8wKrHzVhGHWOt
         UTOEISTO0gk8YFvMxN+YIYrUu1RPeRCYMuvChIpW5XOUnZZfJfQ9P14DiX8VtrsKRx
         o4bTgJ3vDtkIQ==
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
Subject: [PATCH v3 0/3] docs/mm: start filling out new structure
Date:   Thu, 12 Jan 2023 11:16:13 +0200
Message-Id: <20230112091616.824565-1-rppt@kernel.org>
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

v3:
* rephrase ZONE_DMA(32) and ZONE_MOVABLE description (Michal)
* add cross-reference to DMA API

v2: https://lore.kernel.org/all/20230110152358.2641910-1-rppt@kernel.org
* rephrase the paragraph inroducing zones (Lorenzo)
* update formatting (Bagas)
* add section stubs (Bagas)
* small fixes here and there

v1: https://lore.kernel.org/all/20230101094523.1522109-1-rppt@kernel.org

Mike Rapoport (IBM) (3):
  docs/core-api: DMA API: add page label to allow external references
  docs/mm: Page Reclaim: add page label to allow external references
  docs/mm: Physical Memory: add structure, introduction and nodes
    description

 Documentation/core-api/dma-api.rst   |   2 +
 Documentation/mm/page_reclaim.rst    |   2 +
 Documentation/mm/physical_memory.rst | 346 +++++++++++++++++++++++++++
 3 files changed, 350 insertions(+)

-- 
2.35.1


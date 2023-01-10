Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06D68664497
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 16:25:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238774AbjAJPYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 10:24:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238716AbjAJPYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 10:24:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7224552764;
        Tue, 10 Jan 2023 07:24:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C2F25B817B0;
        Tue, 10 Jan 2023 15:24:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BB81C43392;
        Tue, 10 Jan 2023 15:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673364252;
        bh=ZJZT5HMkLBDdezP+PeNaN4naT5cL/7k7KeuSmZUBoX8=;
        h=From:To:Cc:Subject:Date:From;
        b=p7pjYsR6NPUiuaUyNxM7xiZITkB/crsoDpHE8uYitsQyUTe66MO0xNQsbKbxmWdCO
         M3A7YYbLJPTe2HXTc00dYav5c+Q1+Kg93YBq8quZBWSiEn2+fLcB5wzDqezV221Skz
         cW2WtHrH4f0PcJK3IKxJV+nFPKJ+o94t9O3kPewcUt+fYUZ3B2qYLgTKoyUwRH8Z5z
         TlxrByGORD5eAOblGPKEzIJHD+v6F/bEzTyGlV1xTBQKG/UFHVbN6XtJuMYL8Rhl6M
         g2TwdMk/kwnq7Al87lqnOFptUvztfCSeIfewHSu2dMMWl2QCuwC5KQ4E1WgveWAPyd
         ZUvWJL5jX+pJA==
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
Subject: [PATCH v2 0/2] docs/mm: start filling out new structure
Date:   Tue, 10 Jan 2023 17:23:56 +0200
Message-Id: <20230110152358.2641910-1-rppt@kernel.org>
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

v2:
* rephrase the paragraph inroducing zones (Lorenzo)
* update formatting (Bagas)
* add section stubs (Bagas)
* small fixes here and there

v1: https://lore.kernel.org/all/20230101094523.1522109-1-rppt@kernel.org


Mike Rapoport (IBM) (2):
  docs/mm: Page Reclaim: add page label to allow external references
  docs/mm: Physical Memory: add structure, introduction and nodes
    description

 Documentation/mm/page_reclaim.rst    |   2 +
 Documentation/mm/physical_memory.rst | 340 +++++++++++++++++++++++++++
 2 files changed, 342 insertions(+)

-- 
2.35.1


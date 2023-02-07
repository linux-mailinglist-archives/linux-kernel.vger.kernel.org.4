Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0057368CF78
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 07:27:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbjBGG1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 01:27:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjBGG1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 01:27:21 -0500
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com [195.245.231.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 545761CF69
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 22:27:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1675751238; i=@fujitsu.com;
        bh=d/AU+u8+/6O7qciSFfGQtwH7sy/4II9G2h8l6YbI+N8=;
        h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=U1jpnN9XvuE4O1SEH+Y7QtDfDZ+BM2f0WiPYf5VfIQ84WIWO5O9jXSEkMtvvBXAPP
         1/UfCFs7ri+7ZDGIPa6lgWdjZLAzqifspIt/rhk1bkcuNZkutqrAOqN+0HPOyhSwC3
         Qis2Dr2fUhcBKHAbsQpdzvnsNo6PUJZ6x/X4SRW6TM1oxwTldY/BMOnbNs+i8ng/q+
         hpm65rrUuZSudwhai7LOd3a0DmM5ZvB5pUnStpCH1OUUjzkJ7jNABIEQ29IvfIu/xH
         Uay/SNdknLEiqRBVBVmfTl9FOJmPJ6p9FmrPF8iNmRz15pdEY0vrWPYznCmbtiJHXf
         lU4M5+t6jRrMg==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJIsWRWlGSWpSXmKPExsViZ8MxSdf1/cN
  kg5534hZz1q9hs5g+9QKjxeVdc9gs7q35z+rA4rF4z0smj02fJrF7nJjxm8Xj8ya5AJYo1sy8
  pPyKBNaML3ueMxUsZ6vYvWQBUwPjbNYuRi4OIYEtjBIrznxkhHBWMElM2TYdKnOAUeLwulMsX
  YycHGwCGhL3Wm4ygtgiAtYSWyc0s3UxcnAwC8RKXPmoCRIWFvCW2PXzPlgJi4CKxL3168BsXg
  FHibPT1zKB2BICChJTHr5nhogLSpyc+QRsPLOAhMTBFy+YQUZKCChJzOyOhyivlGj98IsFwla
  TuHpuE/MERv5ZSLpnIelewMi0itG0OLWoLLVI10wvqSgzPaMkNzEzRy+xSjdRL7VUtzy1uETX
  SC+xvFgvtbhYr7gyNzknRS8vtWQTIzCEU4rVf+1gnNn3V+8QoyQHk5Iob9HBh8lCfEn5KZUZi
  cUZ8UWlOanFhxhlODiUJHhjXwLlBItS01Mr0jJzgPEEk5bg4FES4S2+B5TmLS5IzC3OTIdInW
  JUlBLndXwHlBAASWSU5sG1wWL4EqOslDAvIwMDgxBPQWpRbmYJqvwrRnEORiVh3jNvgKbwZOa
  VwE1/BbSYCWhxiCrY4pJEhJRUA1PBXsOASx9W2up47OUW6VlRHT0/RuVqzKbv3l0ml07Lz3/V
  c2Dp6S9/q25sdtya5h8x94Jn/AMG7w1t06alc/D83r+f52Oz6Rm+f3Lzlv/9pW5UdFztCccdn
  Z6dcXd5+fLetXyS/aUny/ib6ccNdtfPPnK8f0tnz54aOFv8R/LqpZlFyy5+dSoS79nap/Jth8
  srYTEO7vclMyddmJq7pT051v6ux4SVznGdsq/nh0hIXHc6Of36PSH5x+Wchr/XZl+65pEnu8Z
  Sle3Ql+wcZk3vnBR1RaFvbr2e32o9nJ9tyn165+NU7fbWnfkXi5d/M7z85qb62ppDxb8uMUmE
  e3OZMXTdO6C1YJ2PkD/vV2klluKMREMt5qLiRABbfFlzXAMAAA==
X-Env-Sender: lizhijian@fujitsu.com
X-Msg-Ref: server-17.tower-565.messagelabs.com!1675751237!514590!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.102.2; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 18441 invoked from network); 7 Feb 2023 06:27:17 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
  by server-17.tower-565.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 7 Feb 2023 06:27:17 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id 1A5D91000D2;
        Tue,  7 Feb 2023 06:27:17 +0000 (GMT)
Received: from R01UKEXCASM223.r01.fujitsu.local (R01UKEXCASM223 [10.182.185.121])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id 0EAF01000C1;
        Tue,  7 Feb 2023 06:27:17 +0000 (GMT)
Received: from 167394c7bb87.localdomain (10.167.225.141) by
 R01UKEXCASM223.r01.fujitsu.local (10.182.185.121) with Microsoft SMTP Server
 (TLS) id 15.0.1497.42; Tue, 7 Feb 2023 06:27:14 +0000
From:   Li Zhijian <lizhijian@fujitsu.com>
To:     <akpm@linux-foundation.org>, <dan.j.williams@intel.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH] mm/memremap.c: Fix outdated comment in devm_memremap_pages
Date:   Tue, 7 Feb 2023 06:27:00 +0000
Message-ID: <1675751220-2-1-git-send-email-lizhijian@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.225.141]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM223.r01.fujitsu.local (10.182.185.121)
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit a4574f63edc6 ("mm/memremap_pages: convert to 'struct range'")
converted res to range, update the comment correspondingly.

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 mm/memremap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memremap.c b/mm/memremap.c
index 08cbf54fe037..38eca62e176c 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -385,7 +385,7 @@ void *memremap_pages(struct dev_pagemap *pgmap, int nid)
  * @pgmap: pointer to a struct dev_pagemap
  *
  * Notes:
- * 1/ At a minimum the res and type members of @pgmap must be initialized
+ * 1/ At a minimum the range and type members of @pgmap must be initialized
  *    by the caller before passing it to this function
  *
  * 2/ The altmap field may optionally be initialized, in which case
-- 
1.8.3.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27A9369888A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 00:03:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbjBOXDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 18:03:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjBOXDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 18:03:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD2C2A256
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 15:03:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ADF59B82436
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 23:03:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02F31C433D2;
        Wed, 15 Feb 2023 23:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676502185;
        bh=1fRnYhVnNIjn8JovKRry8izCjgQIpsfEwNzfXj5M8Kw=;
        h=From:To:Cc:Subject:Date:From;
        b=sUWhGnvybVG3yko93FDXga/kN8/c0bHWVgaKWGtIwjzR5h5HVfm49Erw3CVDiRmOl
         bbyOCBsK8/U8uEgFsmeu0xumIW3TSPO7CQCO9n+3fm811qvkrxxNneqAolj3PKBkgc
         OdLNs1xti2ljr/1VAqDfLJmM+EAUs31SCtSqTQjJ3ky2T9rmR3xNitJf/f6S1pV1P+
         L7imGNXlkYYl7feVUZpy9FzXIiG/jCwXx7HZ9iOfI0q3NG1pI915IqMXvLE9oJut0P
         CjsyOPpXxtG/ev+9wynfRR16thNzM25r+zhG9i9iO/o2hT6CKlcQL12siFwxCsb27v
         cxtu8JhfThjlg==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] mm/memory_hotplug: cleanup do_migrate_range()
Date:   Wed, 15 Feb 2023 23:02:58 +0000
Message-Id: <20230215230300.61125-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
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

Make do_migrate_range() return value mechanism simple.

Changes from v1
(https://lore.kernel.org/linux-mm/20230214223236.58430-1-sj@kernel.org/)
- Simply return nothing from do_migrate_range() (David Hildenbrand)
- Add a cleanup for 'ret' variable

SeongJae Park (2):
  mm/memory_hotplug: return nothing from do_migrate_range()
  mm/memory_hotplug: cleanup 'ret' variable usage in do_migrate_range()

 mm/memory_hotplug.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

-- 
2.25.1


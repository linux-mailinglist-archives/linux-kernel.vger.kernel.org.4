Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7613F672E7A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 02:50:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbjASBts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 20:49:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbjASBpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 20:45:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 040ED689E5
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 17:38:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8623261637
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 01:38:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92019C433D2;
        Thu, 19 Jan 2023 01:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674092317;
        bh=YSrUgOMNa6VEvPshW9zUYk9PGjoMPkLxN4z0PDRGl6w=;
        h=From:To:Cc:Subject:Date:From;
        b=mmuheqesR2ZHMapnmu9F199l1IvLDUXk9rtrPODb8esM0NnViLLSUklsTLSgqXX2y
         79IC3QKmvRflsansNhE1IPIj3kLwvLjuPzPFA8TMeNQqHKR6i6pAF7ViIL5cv4HYp6
         fnBAQ3m2SEKPGm1NxD74K57Tv68Wcw2RcugDTbCM59arjxST1nhraEXSwb2SEd2qo1
         UvyQWjw6REG4JGy00dYN7BibRmR8hQSma10HY3jxUpjPhVB4WZBTu+cRB6GB2l1+uo
         QJfZu23GG8hTtD0/QCqMLRuptlBy7o9CAAUFIGLB8VfUdinPDqCvrinwss1Q7+cDWd
         w65QKcVQzAeRQ==
From:   SeongJae Park <sj@kernel.org>
Cc:     SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] mm/damon: misc fixes
Date:   Thu, 19 Jan 2023 01:38:28 +0000
Message-Id: <20230119013831.1911-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset contains three miscellaneous simple fixes for DAMON online
tuning.

SeongJae Park (3):
  mm/damon: update comments in damon.h for damon_attrs
  mm/damon/core: update monitoring results for new monitoring attributes
  mm/damon/core-test: add a test for damon_update_monitoring_results()

 include/linux/damon.h |  6 ++--
 mm/damon/core-test.h  | 30 ++++++++++++++++++
 mm/damon/core.c       | 71 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 104 insertions(+), 3 deletions(-)

-- 
2.25.1


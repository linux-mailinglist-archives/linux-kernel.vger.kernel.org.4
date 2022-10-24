Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B563D60B794
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 21:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbiJXT0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 15:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233428AbiJXTYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 15:24:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F02757E14;
        Mon, 24 Oct 2022 10:58:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 53906614D8;
        Mon, 24 Oct 2022 17:46:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33B9CC433C1;
        Mon, 24 Oct 2022 17:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666633586;
        bh=PjLDsGG9crxmIrge5tQBGVpiRonP33a0QfLWaQ4qI7g=;
        h=From:To:Cc:Subject:Date:From;
        b=gYX/LiZ3Lr73zV1e42zxKeoHgEJozqNpnu0/FNcvnWjQXOJC/ktCQ7CAw2B6FiX1K
         5Wo3sWhxuwPA6cfpC613ATo3GVxyr2R9QS4+TTRDVss65kqyekDlbd7DJfCWgira4l
         4juhnvqPp5G8f5/updbTtJM6oy6e3xc51HNfE+BGptjs8aRW2vIZ5yLQ0xDaqmnRX0
         wBFxvsh60IK72PhwMuaxNOJtsBcL9qHM/y8TFLB6Zwd6rgAZs9m+T6ShWDLh+LVGuF
         0omlIHd+7/3e/6J8NL8Gs/7lWwjVrCW3wR89V1AJ96gMwKeRU1PoPjj9ZsL07pbT4+
         UyW5sGDWO0iXg==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        damon@lists.linux.dev, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 0/2] Docs/admin-buide/mm/damon/usage: minor fixes
Date:   Mon, 24 Oct 2022 17:46:17 +0000
Message-Id: <20221024174619.15600-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DAMON usage document contains an unclear description and a wrong usage
example.  This patchset fixes the two minor problems.

SeongJae Park (2):
  Docs/admin-guide/mm/damon/usage: describe the rules of sysfs region
    directories
  Docs/admin-guide/mm/damon/usage: Fix wrong usage example of
    init_regions file

 Documentation/admin-guide/mm/damon/usage.rst | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

-- 
2.25.1


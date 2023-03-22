Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32D326C4D70
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 15:22:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231449AbjCVOWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 10:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231336AbjCVOWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 10:22:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 006174219
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 07:21:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8BC32B81B6A
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 14:21:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23317C433D2;
        Wed, 22 Mar 2023 14:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679494894;
        bh=t6pMlrPvTPUCfynznLcXs8ec1wO6rySha37i0Y/Gffs=;
        h=Date:From:To:Cc:Subject:From;
        b=Z8FaWF+flcibskpLVlbps22SnXJUb6u4jCZmjde/QWWHCrD+qooJNbgayqy/9KsTZ
         k01RJ0KQxfL1Mlkh2Y3cl63wHAS4mPnm5cJP9ZDqMYONVL+0J220jNXXxlho+ZelgG
         liiCQh4rv00JUgyHFKDCzl9CkxZ3ufPXBk6OIplXHI5r8EzyPHMxiLwTkinypOeklK
         orsLJKAYX6IN6pAtzHAROL9kPUL36UjytwuNfpavKVy/GjUxut6zFIreU705fsNAhr
         bAsajA/UzRYEoreJ0bVYsU3Wf1ZuzLvVs1J1DL5feliVWdFsLgaUqRMZqkkPfuANy3
         tqQikDWhtXzHA==
Date:   Wed, 22 Mar 2023 23:21:31 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [GIT PULL] bootconfig: Fixes for v6.3-rc3
Message-Id: <20230322232131.ffb3f973dea6dd9a195e9a08@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus,

Bootconfig fixes v6.3

- Fix bootconfig test script to test increased maximum number (8192) node
  correctly.

- Change the console message if there is no bootconfig data and the
  kernel is compiled with CONFIG_BOOT_CONFIG_FORCE=y.


Please pull the latest bootconfig-fixes-v6.3-rc3 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
bootconfig-fixes-v6.3-rc3

Tag SHA1: b54d1aa707e28cd1749c48258119ad6794cfbae7
Head SHA1: caa0708a81d6a2217c942959ef40d515ec1d3108


Masami Hiramatsu (Google) (2):
      bootconfig: Fix testcase to increase max node
      bootconfig: Change message if no bootconfig with CONFIG_BOOT_CONFIG_FORCE=y

----
 init/main.c                         | 10 +++++++---
 tools/bootconfig/test-bootconfig.sh | 12 ++++++++----
 2 files changed, 15 insertions(+), 7 deletions(-)
---------------------------

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

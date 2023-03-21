Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C30A46C26A0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 01:59:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbjCUA7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 20:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjCUA7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 20:59:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F198B16330
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 17:59:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9EACDB811B6
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 00:59:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D85FC433EF;
        Tue, 21 Mar 2023 00:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679360349;
        bh=+M93ZsE5GNFpgqi4RiVQCpvkboJDpOpYOXQJbah3rlc=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=E/6GlHGwOF0HQ6mcVEnXfOWuMPp5HH84gQHDe6iRE2/0HDDZ3bfAJQMWGOr1j743S
         +kd51mv1JiXiWv4lIghCNNaOD9BmETUwaXdrZxlWF6WE5CRgVXhOxCVF1DWD/TLiIq
         yA+OCR7TKkUaICYf5EFO2bf6AoDNzigQZlm2Q0THI9Orhyu+Bylby0SutBJ+drsgsR
         ZnJt7JFSTs0RhALgoMJlo652oy24O/5zr6J+3vRPxqtwSOtEfKLq2fXIC3ne7/lqVz
         63ZajJX1ztdE07vLzU/muWOUehMiWfiAssI+Iy7+zPR660Xekw9uytRAS2GLFahAwH
         azLNR7HE4v2kw==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id D67C71540395; Mon, 20 Mar 2023 17:59:08 -0700 (PDT)
Date:   Mon, 20 Mar 2023 17:59:08 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kernel-team@meta.com, mingo@kernel.org
Cc:     elver@google.com, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, cai@lca.pw, boqun.feng@gmail.com
Subject: [PATCH kcsan 0/2] KCSAN updates for v6.4
Message-ID: <a26f2bdb-1504-487b-8ec8-001adafc5491@paulmck-laptop>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This series provides KCSAN updates:

1.	instrumented.h: Fix all kernel-doc format warnings, courtesy of
	Randy Dunlap.

2.	Avoid READ_ONCE() in read_instrumented_memory(), courtesy of
	Marco Elver.

						Thanx, Paul

------------------------------------------------------------------------

 include/linux/instrumented.h |   63 +++++++++++++++++--------------------------
 kernel/kcsan/core.c          |   17 ++++++++---
 2 files changed, 39 insertions(+), 41 deletions(-)

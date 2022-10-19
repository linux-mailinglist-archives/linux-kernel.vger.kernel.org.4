Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA4AA6053AE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 01:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbiJSXEu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 19:04:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231679AbiJSXEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 19:04:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 251633F1E8
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 16:04:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A57096199F
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 23:03:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 031B2C433D6;
        Wed, 19 Oct 2022 23:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666220637;
        bh=MNtLMMQNlGJhYhL8lw+CUbjIkgEeskmzgIF1tAizh3M=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=RnuegenODqghLdWHnmOiwoKKK87QrUK5MetnPTSqowo4Vz70L9Sp3oCZurimgXStg
         ICHTrr7vxBfMi27AQpLN2XcJpu8KiZEeBBi+HBj2mXZBwDGnoekufAAtTxe5zLs30H
         yVjc+l8loVlCsYv8fuNjxGVHQWQkpzJ1c4hQMxCvQqRO66NJochugK8kjGjspfuJNC
         bwa4n1CdufRSQW7w/RZuYl3MgntBDir66PC1esQV/YXr/waVNvGVKcbZR+kTkk/4L3
         GpWaHIutAHks1++6OxyVaVvA+EbBmHq37QyD+u4+9qPjz6vadxzKIdyZ3Ghp5eUyoh
         cb4N8zs9idwmw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id A43B55C06B4; Wed, 19 Oct 2022 16:03:56 -0700 (PDT)
Date:   Wed, 19 Oct 2022 16:03:56 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kernel-team@fb.com, mingo@kernel.org
Cc:     elver@google.com, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, cai@lca.pw, boqun.feng@gmail.com
Subject: [PATCH kcsan 0/3] KCSAN updates for v6.2
Message-ID: <20221019230356.GA2501950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This series provides KCSAN updates:

1.	Instrument memcpy/memset/memmove with newer Clang, courtesy of
	Marco Elver.

2.	objtool, kcsan: Add volatile read/write instrumentation to
	whitelist, courtesy of Marco Elver.

3.	Fix trivial typo in Kconfig help comments, courtesy of Ryosuke
	Yasuoka.

						Thanx, Paul

------------------------------------------------------------------------

 kernel/kcsan/core.c   |   50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 lib/Kconfig.kcsan     |    6 +++---
 tools/objtool/check.c |   10 ++++++++++
 3 files changed, 63 insertions(+), 3 deletions(-)

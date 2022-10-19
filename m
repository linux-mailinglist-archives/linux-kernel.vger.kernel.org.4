Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D631D605397
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 01:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231624AbiJSXBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 19:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231576AbiJSXA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 19:00:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70DE695ADB;
        Wed, 19 Oct 2022 16:00:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 99B7B61962;
        Wed, 19 Oct 2022 22:59:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04FB2C433C1;
        Wed, 19 Oct 2022 22:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666220387;
        bh=vfSueAo3BlHeD2wR3NQtHwa3/QrbTlESJP55Ls7QQgw=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=AnuDOR9esbug6D5334isXg9m598p/UGDf46s6VOIwKqAHt3hJyvWGU0LjEXWI5rK1
         YHldZwKGKz6m0mVB4+D81ab/pYLRGoHovT+v/93h3VoqxC004AmZwK6rhy5vVQ3Mtu
         kLmYj6vvIgRQNSUFGHdxOoiQ2usCAL1XD2T0jvBK3MzuGaChf616bSZzIIxUhuvxSJ
         WsM6Azg79nCHXQm2azapx81Dy6QIVSg0OtbRwknAzgZCzrpheGE+iwDc3R/P5JUjSx
         LZRxyF7Wkdw3xFWhDYS3EWmw/pTf/GS5IQz7oUt+b9YqTggBYjHghyBFJnWhV2w603
         Z18ErA4SZOF1Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id AEA575C06B4; Wed, 19 Oct 2022 15:59:46 -0700 (PDT)
Date:   Wed, 19 Oct 2022 15:59:46 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org
Subject: [PATCH rcu 0/2] Torture-test updates for v6.2
Message-ID: <20221019225946.GA2501259@paulmck-ThinkPad-P17-Gen-1>
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

This series contains torture-test updates:

1.	Verify NUM_ACTIVE_RCU_POLL_FULL_OLDSTATE.

2.	Verify NUM_ACTIVE_RCU_POLL_OLDSTATE.

						Thanx, Paul

------------------------------------------------------------------------

 b/kernel/rcu/rcutorture.c |   23 +++++++++++++++++++++--
 kernel/rcu/rcutorture.c   |   22 ++++++++++++++++++++--
 2 files changed, 41 insertions(+), 4 deletions(-)

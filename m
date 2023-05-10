Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFB596FE2C0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 18:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235814AbjEJQvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 12:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231402AbjEJQvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 12:51:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D5B130FA;
        Wed, 10 May 2023 09:51:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BBA04635CD;
        Wed, 10 May 2023 16:51:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A675C4339B;
        Wed, 10 May 2023 16:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683737468;
        bh=JH7fggTPiuFvy0uFcmacl/dhal2azMqjhYx5FJ/7MLQ=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=dfXm6vXtvl8/0hRQJ4RLlkKw2E2ujlyRCGEnpsXBXH+vPCWEI+w5DjnOY7thO0m4d
         mMAgaBHTd22FDNtqcFQoUMwCj9b2kENu7+uRMW2CBQUxlUazmGUtl88+W3x0qYyGxw
         l+7TClCGTp5LnFANyyOFdQ4nWUZfiuWnRXLnWjy/T8lRwyHpAaWTI8PzMQdP+kIu4Y
         TpQFFhhuz9gVqwX07eN+3xMXt6OJWgoo+e8217dNUx7ge7Dmdnl5v16SKc/o02XwAK
         y8TkenZ1QkjVay+hJyd+ERCZBXC+jJ8a/69/tywcJmsNYjAyWlig70X45SFSfoih1s
         jm3QU1N8kbZiQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id B6A39CE126E; Wed, 10 May 2023 09:51:07 -0700 (PDT)
Date:   Wed, 10 May 2023 09:51:07 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org
Subject: [PATCH rcu 0/3] Documentation updates for v6.5
Message-ID: <16136ef4-9437-442b-b7c8-3fb6b2120873@paulmck-laptop>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This series contains documentation updates:

1.	Get rcutree module parameters back into alpha order.

2.	Document the rcutree.rcu_resched_ns module parameter.

3.	MAINTAINERS: Update qiang1.zhang@intel.com to
	qiang.zhang1211@gmail.com, courtesy of Zqiang.

						Thanx, Paul

------------------------------------------------------------------------

 Documentation/admin-guide/kernel-parameters.txt   |    7 +
 b/Documentation/admin-guide/kernel-parameters.txt |  120 +++++++++++-----------
 b/MAINTAINERS                                     |    2 
 3 files changed, 68 insertions(+), 61 deletions(-)

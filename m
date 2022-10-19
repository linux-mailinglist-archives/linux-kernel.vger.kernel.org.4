Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39ADA60534D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 00:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbiJSWpe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 18:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiJSWpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 18:45:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA5415A20;
        Wed, 19 Oct 2022 15:45:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8BC3B619E5;
        Wed, 19 Oct 2022 22:45:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9946C433C1;
        Wed, 19 Oct 2022 22:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666219529;
        bh=nEXcglxmuQMmEVn5saQrYZMN/AGmbuW/BHI2o8Yoviw=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=iBCf4Q4AaJmOiohfD4+jfr6qyOkzRoy/nMsCEW5DVd8Ju/hETfi15x5cTjSfojik+
         kks8QwZ9jxZAc70XuI99aMWh6ZYUwWsN4jVpQczvFTP9ZaqhUz/TIF3Tmy4JOm7u1r
         vJY9x8/Ch5DelYyzHRlp2LtS8X75KuiIKHbatUxAkRK1qnRwrR0SwnCowoypCUXMAU
         yhfA/g+hmchD98vD8aHc9wW45VQuBVoPIb8aNPraIQzWYOK2apeOb1YNIcd4hUo6Zg
         05Adthf6aI6xVhT7cYFtNQmBEQ9xsXIRkrUwT20T56Hl8H1CR+nEbUFukNM7Y3FS/G
         cLU+i5b1HpVpA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 913235C06B4; Wed, 19 Oct 2022 15:45:28 -0700 (PDT)
Date:   Wed, 19 Oct 2022 15:45:28 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org
Subject: [PATCH rcu 0/4] Documentation updates for v6.2
Message-ID: <20221019224528.GA2499145@paulmck-ThinkPad-P17-Gen-1>
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

This series contains documentation updates:

1.	Remove arrayRCU.rst.

2.	Update checklist.txt.

3.	Update listRCU.rst.

4.	Update RCU's lockdep.rst.

						Thanx, Paul

------------------------------------------------------------------------

 Documentation/RCU/arrayRCU.rst    |  165 -------------------------
 b/Documentation/RCU/checklist.rst |  244 ++++++++++++++++++++++----------------
 b/Documentation/RCU/index.rst     |    1 
 b/Documentation/RCU/listRCU.rst   |  174 ++++++++++++++++-----------
 b/Documentation/RCU/lockdep.rst   |    4 
 5 files changed, 250 insertions(+), 338 deletions(-)

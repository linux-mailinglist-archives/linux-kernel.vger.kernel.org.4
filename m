Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21B846E13B2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 19:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbjDMRoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 13:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjDMRoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 13:44:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E2D1FFB
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 10:44:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 90F53601C3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 17:44:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2B89C433EF;
        Thu, 13 Apr 2023 17:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681407850;
        bh=7nllnwi5Bvs+lC/6EvS35s1XAnlHHreApPviCo1OV3I=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=E6V/IA1y42AOqx96tKePxJWoQDctTP6OVhYHzW8ymvILjgu0KiR2CQhelYTYugZWc
         MyiRojthSi/9Zflzi6tfjD0oMmceYZIL9RKz2z0nSJHXdW25d9z7Xt70OGl5tDyXkB
         hN+Pkf5VSLADtXjaxtezeBr41SLoBTh40rGXWXXWHnP7BMGdrsryNwJkZz3g6SbikE
         +4yCXykhdGSLD6lnCbqOrNy2uXI3KKDOJjPxMZ/qgG8fy5zpXahhlXXvR1y7HIZX3p
         aUsNTFUIjldeNc3IbDXpMM70Njt0JX8Rk6ArHydIktJUun77eqyX85Ie1SRnsoTUDL
         +yUEt+ZlmxbyA==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 43B7415404B3; Thu, 13 Apr 2023 10:44:10 -0700 (PDT)
Date:   Thu, 13 Apr 2023 10:44:10 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     stern@rowland.harvard.edu, boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org
Subject: LKMM for next week
Message-ID: <c49a72c4-a392-49d9-9ff6-2af7b947b11f@paulmck-laptop>
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

I will be on travel for a week starting tomorrow, and may be off the
grid at times.  My guess is that nothing particularly earthshaking will
happen with LKMM during that week anyway, Mr. Murphy notwithstanding.

Either way, if you wonder why I am slow to respond during that time,
that might be why.  ;-)

							Thanx, Paul

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD13B6FF3D6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 16:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238418AbjEKOQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 10:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238456AbjEKOPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 10:15:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2208AD047;
        Thu, 11 May 2023 07:15:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D52864E04;
        Thu, 11 May 2023 14:14:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7653AC433EF;
        Thu, 11 May 2023 14:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683814440;
        bh=ZWjx3C6rNPU/hpiXcXTYiO4CLRg214TZSQKTD8ec2gU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=oQH0/8xFE2sx2qKye6e6EvdR3ax6AncraAr99pEu3CvrpWuiQ3hwF9yOGqy2CksV3
         3VwupBAAq5S5r/JtIHXMx94BrGb62SulrYbs67z46/7+LXd+OaqagFLPYYT613rhfX
         rYpcjp1/yLOIWJV5Rti/SWjOYMxdUrP5C1fp33dO10trTVf2BBobrZVSMVds1bFjOn
         z6f9VZRxCnmeoGNxRfQj+osE2QifbblYfetSy72Zk2BazX50fiD8LjEzaPs0LWU+Yg
         bxNzfJxyQAln6BHilrWUPAdGTCSzqywo5Iij7cg7Qtg9eXdpCyUpMSMxZ4ynmOzYl6
         fid/wZOzuyjzQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5BDA2E270C4;
        Thu, 11 May 2023 14:14:00 +0000 (UTC)
Subject: Re: [GIT PULL for v6.4-rc2] media fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230511070103.263505ba@sal.lan>
References: <20230511070103.263505ba@sal.lan>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230511070103.263505ba@sal.lan>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/media/v6.4-2
X-PR-Tracked-Commit-Id: ae3c253f595b31ff30d55b4c50b4470e56bc4e0d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 691e1eee1b4e5203fa5152a4603c11fbd5448528
Message-Id: <168381444036.1327.11509147009867461713.pr-tracker-bot@kernel.org>
Date:   Thu, 11 May 2023 14:14:00 +0000
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 11 May 2023 07:01:03 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/media/v6.4-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/691e1eee1b4e5203fa5152a4603c11fbd5448528

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

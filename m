Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6962F6F7856
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 23:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbjEDVux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 17:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbjEDVut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 17:50:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D09481154C;
        Thu,  4 May 2023 14:50:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6B9F763A30;
        Thu,  4 May 2023 21:50:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D0032C433EF;
        Thu,  4 May 2023 21:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683237047;
        bh=ddiDP2MXY2r+1cvikZNbUgl2oCcg9JbCUBxLdav6OQk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=V1QVYHNVeHwXbdfMZzj5fCAMxpooMVwLSW8afEilaf1YU/GSjcpVOdE3QHNeTTKge
         3Gvh57MR77QJfvBVxiyUjsO8wpJrqnhri1XU/gz/W0y+S/jSt+MsZ7iHlFRWZrE8JX
         rYTVcVwumOra5XA+LgV7DpBjCJlZXJm6tTrrrjNMp11A2UCzI9l05pdgFixjPSaEgy
         +v9RCjRiuVq8fMufoD8I/QdD95IqIO0tM8UX6oawBk/4D5dMemAwmXmuCpheyJ+Chs
         wbJxjw3S6Ua8/3UgxlBgye46bZ5VLZCvnHCSf17sOh4OjFQkoGObWLQmKBVUxYPA4l
         FeyWqj+nQwr+w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BD1F7C41677;
        Thu,  4 May 2023 21:50:47 +0000 (UTC)
Subject: Re: [GIT PULL] Ceph updates for 6.4-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230504182810.165185-1-idryomov@gmail.com>
References: <20230504182810.165185-1-idryomov@gmail.com>
X-PR-Tracked-List-Id: <ceph-devel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230504182810.165185-1-idryomov@gmail.com>
X-PR-Tracked-Remote: https://github.com/ceph/ceph-client.git tags/ceph-for-6.4-rc1
X-PR-Tracked-Commit-Id: db2993a423e3fd0e4878f4d3ac66fe717f5f072e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3c4aa44343777844e425c28f1427127f3e55826f
Message-Id: <168323704777.23044.15454892502938821649.pr-tracker-bot@kernel.org>
Date:   Thu, 04 May 2023 21:50:47 +0000
To:     Ilya Dryomov <idryomov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu,  4 May 2023 20:28:10 +0200:

> https://github.com/ceph/ceph-client.git tags/ceph-for-6.4-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3c4aa44343777844e425c28f1427127f3e55826f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

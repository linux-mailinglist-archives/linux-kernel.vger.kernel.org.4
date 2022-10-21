Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7FD6080EB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 23:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbiJUVrl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 17:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiJUVrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 17:47:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 242C7326E0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 14:47:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B217161F92
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 21:47:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1FFE3C433D7;
        Fri, 21 Oct 2022 21:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666388856;
        bh=J7+fm1rjaT/LZD3cv5obF8wpb4IoLIy0LmAjPcWm1xo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=gmvfrcw4LP9OjQHWubzsf642byo/MXHY1DN8t52f4itWDgPcUIO+6Dgo+jSSrxEc/
         eJpYzZdP0Evq65K5nosLhn1tgPfh26KtfREeINRkOE5RIvU+RQ48IfnLl+SUiOs5ca
         HQgmk86qs0r/qXjaxB3nXvXHVDjz/3OCQplPsD7bpkI0xCNHogy/eds4X9zLtLcg4V
         aGHQ/l4xa2U8yEJGspocsIEHacRQfFgiz5VBo3a47QAjUBGZZzwZjIZcAzh/Cx1wLu
         0XOsyI0PyS/EA7hCKe+et1//XLYKhW9Qjg/hx/8ze9BifFWOl3JVDMTSVkPIVoHkTE
         2zq7NMft+snyw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F361AE270E0;
        Fri, 21 Oct 2022 21:47:35 +0000 (UTC)
Subject: Re: [GIT PULL] xen: branch for v6.1-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221021093119.25978-1-jgross@suse.com>
References: <20221021093119.25978-1-jgross@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221021093119.25978-1-jgross@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-6.1-rc2-tag
X-PR-Tracked-Commit-Id: a383dcb1cca8305497877119fba0a320f41fe853
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1d61754caa8c69f566504e63c8b3f3a2df0954c8
Message-Id: <166638885598.26127.18249995136071823508.pr-tracker-bot@kernel.org>
Date:   Fri, 21 Oct 2022 21:47:35 +0000
To:     Juergen Gross <jgross@suse.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, sstabellini@kernel.org
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 21 Oct 2022 11:31:19 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-6.1-rc2-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1d61754caa8c69f566504e63c8b3f3a2df0954c8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

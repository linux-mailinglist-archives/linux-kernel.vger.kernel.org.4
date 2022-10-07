Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFFF55F7DE6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 21:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbiJGTVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 15:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbiJGTUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 15:20:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EC558E980;
        Fri,  7 Oct 2022 12:20:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3B676B820D5;
        Fri,  7 Oct 2022 19:20:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EEF69C43470;
        Fri,  7 Oct 2022 19:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665170412;
        bh=K3DQRzC/cZE+wRUrSERi+gL2f/D1qWbH5IQnLWXbYmw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=SIje80AX1c8uS6d5QlenbfmfyBQxR9TPxjtjvCqyNoejd8hUVopnc5jRtS8c6hDO1
         fmwvszKTSxCZ9d05dvCpPclKAZg0wfntq5y01EWzw/4r7NAhyKf83pSePMwRRrh0MH
         Ra5udgxH7ZjxxVCItDCVSzUJ5R+9lm54R/PafvorNKkDHifWwZuF4f5mTpVKJtPxrI
         vXCJPNk69JVBDl+YpqlsCQPd4VJyroeFtUVhh6EHr2nIOVqW+DjBtjtpD687PTEWqY
         qNXtQ4QaoN+VyMPWAhfTzBhODCl38TbuEgHYKtyhTkI4jRZqZqzCLCL3RM+Dkj9jWx
         89CbNVUpEIxig==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D4C97E2A05C;
        Fri,  7 Oct 2022 19:20:11 +0000 (UTC)
Subject: Re: [GIT PULL] remoteproc updates for v6.1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221007021046.2585078-1-andersson@kernel.org>
References: <20221007021046.2585078-1-andersson@kernel.org>
X-PR-Tracked-List-Id: <linux-remoteproc.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221007021046.2585078-1-andersson@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git tags/rproc-v6.1
X-PR-Tracked-Commit-Id: ccf22a48cc8789a35befea783448c259463a5eef
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 94e8ca6ebd1bc20a193eb552dee4de884a954938
Message-Id: <166517041186.8063.10728785589993602067.pr-tracker-bot@kernel.org>
Date:   Fri, 07 Oct 2022 19:20:11 +0000
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
        Peng Fan <peng.fan@nxp.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        wangjianli <wangjianli@cdjrlc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu,  6 Oct 2022 21:10:46 -0500:

> https://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git tags/rproc-v6.1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/94e8ca6ebd1bc20a193eb552dee4de884a954938

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

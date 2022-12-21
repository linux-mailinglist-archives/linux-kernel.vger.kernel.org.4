Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FFCF653582
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 18:45:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234606AbiLURou (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 12:44:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234927AbiLURop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 12:44:45 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1FDF233AD;
        Wed, 21 Dec 2022 09:44:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 25129CE1818;
        Wed, 21 Dec 2022 17:44:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 63232C433F1;
        Wed, 21 Dec 2022 17:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671644681;
        bh=DpQ4h0EGGCGKxyzcgAhk0mF2+ad8ywsb56AGt7rrpAU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Ll73BtDm4TiRLysBOSflJlEIKVUgcNdEM0feDQsH3xEO6E3NBxXrjYF9z/EInekuU
         IPbARLpgh2+MHUP6qOiZeGPAUB4dzArU7TOiy9o8Bom97KPu9gvJ8xVO/xI+/ipanc
         UZjFlB1JfM83uBJThMrFDcXiA2G6XHZ55+8FN6RrrdmUoL5WQJTxS1JZFuDQdM2SAX
         pOOOQztslaj61Mdt6pt3hG5bou/HJWbcfZniycSSyV0kdhp4EWno7Ugh7t0vyTF+6Q
         5taJhVWr8Pe8moq3LYlJQSVOK8zh5w/Z1DIWgu77MT580L9pbx732/e1u6sOYQmndr
         mgC8UmUTvpFTQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4E4D6C43141;
        Wed, 21 Dec 2022 17:44:41 +0000 (UTC)
Subject: Re: [GIT PULL] remoteproc updates for v6.2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221220180832.93801-1-andersson@kernel.org>
References: <20221220180832.93801-1-andersson@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221220180832.93801-1-andersson@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git tags/rproc-v6.2
X-PR-Tracked-Commit-Id: 11c7f9e3131ad14b27a957496088fa488b153a48
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9cf5b508bd260d5693d337bcf1f9b82b961b6137
Message-Id: <167164468130.23021.6887596002060025560.pr-tracker-bot@kernel.org>
Date:   Wed, 21 Dec 2022 17:44:41 +0000
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>,
        Ben Levinsky <ben.levinsky@amd.com>,
        Tanmay Shah <tanmay.shah@amd.com>,
        Luca Weiss <luca.weiss@fairphone.com>,
        Shang XiaoJing <shangxiaojing@huawei.com>,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        Jeff Johnson <quic_jjohnson@quicinc.com>,
        Maria Yu <quic_aiquny@quicinc.com>,
        Yuan Can <yuancan@huawei.com>,
        ye xingchen <ye.xingchen@zte.com.cn>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 20 Dec 2022 12:08:32 -0600:

> https://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git tags/rproc-v6.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9cf5b508bd260d5693d337bcf1f9b82b961b6137

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCE016A3406
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 21:40:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbjBZUk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 15:40:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbjBZUkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 15:40:15 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B56FEA241;
        Sun, 26 Feb 2023 12:40:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 40AFBCE0E7D;
        Sun, 26 Feb 2023 20:40:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D10FDC4339C;
        Sun, 26 Feb 2023 20:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677444013;
        bh=Km22Te9wN/g129rNtN8eXgSd31n9PN+XQV7UeRAODfw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=BA7Dwxje+cNHLUm72rFBGzpP0/NjDWR9nCg8CMEqWDbPiySk6xd05JISiCQ0SkIP3
         zRMYEJw2bwE5KmwZ2+CIt1qh+601BGaMU9wEOKGiSE1do5iGp0sEG6Fr+pas8dJFXB
         eMRw7bwFRttxh5zEZJ8GUBFSo+1GdhABl9VjuusTWYv0fsLdl3AxxAU0rmvioEalX1
         JCm9EUu7Y+hKb/QQYRHf+MMLdN9sAcV1Y0RvqDHTRdhPhMpuaO7ucTYhJS/3T1QmKd
         6VqGW9UE4UdiYgdYwdZPDFiKbGNkwwB6FQfW7T75TDPnibwcwrOm9ZmepWpyO/kuje
         0VMBVqdmAHfuw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BCA27E4D010;
        Sun, 26 Feb 2023 20:40:13 +0000 (UTC)
Subject: Re: [GIT PULL] remoteproc updates for v6.3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230226171522.299057-1-andersson@kernel.org>
References: <20230226171522.299057-1-andersson@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230226171522.299057-1-andersson@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git tags/rproc-v6.3
X-PR-Tracked-Commit-Id: 7c855ef7137a67bcff0e039691b969428dd8ef6a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f3a2439f20d918930cc4ae8f76fe1c1afd26958f
Message-Id: <167744401376.16333.3784249776230479571.pr-tracker-bot@kernel.org>
Date:   Sun, 26 Feb 2023 20:40:13 +0000
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sireesh Kodali <sireeshkodali1@gmail.com>,
        Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
        Mukesh Ojha <quic_mojha@quicinc.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        MD Danish Anwar <danishanwar@ti.com>,
        Suman Anna <s-anna@ti.com>, Abel Vesa <abel.vesa@linaro.org>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Christoph Hellwig <hch@lst.de>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>,
        Hari Nagalla <hnagalla@ti.com>, Jai Luthra <j-luthra@ti.com>,
        Roger Quadros <rogerq@ti.com>, Tero Kristo <t-kristo@ti.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Yogesh Lal <quic_ylal@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 26 Feb 2023 09:15:22 -0800:

> https://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git tags/rproc-v6.3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f3a2439f20d918930cc4ae8f76fe1c1afd26958f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A853A69E848
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 20:30:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbjBUTaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 14:30:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbjBUT35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 14:29:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFFB627D59;
        Tue, 21 Feb 2023 11:29:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6D125B810A7;
        Tue, 21 Feb 2023 19:29:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2327FC433EF;
        Tue, 21 Feb 2023 19:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677007794;
        bh=piqmWPC+59goAqSczQuEraMRLFAJweWXhNt9mWuzkvo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=KSKYsHbNRjaclz2p/ICLxajoyDQQ9M0dWELXxix5bpObEOR2jve75V8fzwX3X3REz
         zI/1g0etEXunyTqQkw3AteEoXxAYQhrsXXoG3++FozitVY8m8qEOKtmzvzyWWvfdIQ
         eAcM02hyg81ucPDn3LM8CVkP5G2G5g6dxYkmAg9MLf9aULAqQfnWm/1P5YzeeD2IF+
         6ykOJTdgujzJCGVN1l7gJbm5pIUeej1lyqIUCfTwQpU/SPgSnHdoeuutOGXUApbXH3
         VRLL0DcJnayra3uGkt4lfR16jMYqV+/3WJe4VUYgRP4HDwOy+NslNBMyxkXJoWh8cn
         gUWMO5nWmlKEw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1044DC43151;
        Tue, 21 Feb 2023 19:29:54 +0000 (UTC)
Subject: Re: [GIT PULL] RCU changes for v6.3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230218190641.GA1215210@paulmck-ThinkPad-P17-Gen-1>
References: <20230218190641.GA1215210@paulmck-ThinkPad-P17-Gen-1>
X-PR-Tracked-List-Id: <rcu.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230218190641.GA1215210@paulmck-ThinkPad-P17-Gen-1>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/rcu.2023.02.10a
X-PR-Tracked-Commit-Id: bba8d3d17dc2678f9647962900aa421a18c25320
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8cc01d43f882fa1f44d8aa6727a6ea783d8fbe3f
Message-Id: <167700779405.6594.2078957546829912295.pr-tracker-bot@kernel.org>
Date:   Tue, 21 Feb 2023 19:29:54 +0000
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, mingo@kernel.org, tglx@linutronix.de,
        rcu@vger.kernel.org, joel@joelfernandes.org, boqun.feng@gmail.com,
        frederic@kernel.org, quic_neeraju@quicinc.com, urezki@gmail.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 18 Feb 2023 11:06:41 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/rcu.2023.02.10a

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8cc01d43f882fa1f44d8aa6727a6ea783d8fbe3f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

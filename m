Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 616C66247DE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 18:03:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbiKJRDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 12:03:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232837AbiKJRDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 12:03:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66DA32AF6;
        Thu, 10 Nov 2022 09:03:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F3BF261CDA;
        Thu, 10 Nov 2022 17:03:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 579FCC433D6;
        Thu, 10 Nov 2022 17:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668099808;
        bh=UWE4RZ5+AseJvmo51LUKCAHDzNisN4jjXU7uMbeIvas=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=dvP9fVpzYKT9TXDgGV3vlouf/S0F58l7EUXZi/UcyRcqfp1zsRbMfnlCV22f9h+ZE
         EdOUdEbFT6eHK9It5d+KKCVyx9kaC8jSepTOGXMECGAXdXrzVBZE80djy5vbYiapJT
         iwyVRhD+5OdsgOII9xhe/fBDUYAEKv/ECaVyYrV98sLK68ITVGxYdmUTheetTKSde4
         ffX6upE1+cf8Ah4YaYAwmlbNEwLzrH2Nuv4bRzHyRCkuSoZMb3VKVKKjDKalQNn+Lt
         aQLzDIxDKzT/sJIozJdloRAgvcXNH8MGA4jjhOTX4Tt6M4A3Q+nwq7TKiqqaIso3+b
         v9Lx2hwjXtFvQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 44734C395F8;
        Thu, 10 Nov 2022 17:03:28 +0000 (UTC)
Subject: Re: [GIT PULL] hwspinlock updates for v6.1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221110030754.786462-1-andersson@kernel.org>
References: <20221110030754.786462-1-andersson@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221110030754.786462-1-andersson@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git tags/hwlock-v6.1
X-PR-Tracked-Commit-Id: c29f446108e10bb791220ffbba54d82722d60d45
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 179228654ddefcbd99060a113ad02079dcdf22f1
Message-Id: <166809980827.1852.17183268892163756706.pr-tracker-bot@kernel.org>
Date:   Thu, 10 Nov 2022 17:03:28 +0000
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed,  9 Nov 2022 21:07:54 -0600:

> https://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git tags/hwlock-v6.1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/179228654ddefcbd99060a113ad02079dcdf22f1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

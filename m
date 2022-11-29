Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9331D63B820
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 03:45:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235245AbiK2CpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 21:45:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235102AbiK2Co7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 21:44:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2274047313;
        Mon, 28 Nov 2022 18:44:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B0DF76154F;
        Tue, 29 Nov 2022 02:44:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 176A1C433B5;
        Tue, 29 Nov 2022 02:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669689896;
        bh=hF7ByP+KrceZ6o4BR7URyOmnFpw31uY5K5+ookuPxb4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=HAMNrJkQw6cBt36V4Zuru9vu1P+39P9eiOUETVi5s9ZPcS6c1CZqfBRohXVo+7kp/
         xH46nB5tqxN4aKws9ZXdab4q+TZLxYbfXdcKZO5cMq71IRJYgckd8oCRDWfcSJgX3I
         GdqbejwqXY7G8YBsQu9j0L+tGS6fm2ES/n3dsYFz37YdIrd3ncbqtAG5Zo5t9RZue+
         Y1cu0FgN45M42wEY5JX4QdoIaFKfbXr4SvX3k3IM4g5LD34hOBpHj5tsZKAlJPehBb
         JuQtIXRiSKVLKWP6775ewyKOiW5vnoiOOeURpMoZmBCD4199d2+rxd38oTr7+UNV8Y
         YcP8BbJO3/5YQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 01EC8E21EF6;
        Tue, 29 Nov 2022 02:44:56 +0000 (UTC)
Subject: Re: [GIT PULL] Devicetree fixes for v6.1, take 2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221128204801.GA1432027-robh@kernel.org>
References: <20221128204801.GA1432027-robh@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221128204801.GA1432027-robh@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-6.1-2
X-PR-Tracked-Commit-Id: 60d865bd5a9b15a3961eb1c08bd4155682a3c81e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4009166c3918ccfbf4daf0790630261153d6b646
Message-Id: <166968989600.2175.6139936512385557620.pr-tracker-bot@kernel.org>
Date:   Tue, 29 Nov 2022 02:44:56 +0000
To:     Rob Herring <robh@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 28 Nov 2022 14:48:01 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-6.1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4009166c3918ccfbf4daf0790630261153d6b646

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

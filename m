Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CEDE5FE2AA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 21:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbiJMT0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 15:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbiJMT0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 15:26:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3FE216D89B;
        Thu, 13 Oct 2022 12:26:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5D2A2B82079;
        Thu, 13 Oct 2022 19:26:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0DB29C433D6;
        Thu, 13 Oct 2022 19:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665689174;
        bh=9HwWYGQPN8+IixC9LVaIqt7zBVmRo+QSh7EnOgE8zd4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Dhn/ZuUuSZGKIUeVwvgdzZefsGRF0SQEsSeDMvuhM3Bog5GV9423WyP6qpKwslX7Q
         FgjbTDbgBI6sRi45UJmPYGaNdrmmrnxVAa/D5P9Pttnga8LfAWViNDOI6Rer3tJ9eq
         czcSmcD+VTtKbWrQXagSh2bjF+85a8Q2KUn9p9jNgHbH9VMEmbp1XzTXD9k/cx3FrC
         XmrMM+iYiTaLpm1Db6qm+dKYfu+le8NrWTsY0yqu+Epmhf6IF4xb5ZfBOe3tQoG8K7
         jxKdxIcypCpZlVkOW7WB+Ewqc3YayL5CSMZtKSLuaDY/bEUBQ59g61fuxJnqTCPlJP
         +fBal/G6gqwFQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EE0F4E29F30;
        Thu, 13 Oct 2022 19:26:13 +0000 (UTC)
Subject: Re: [GIT PULL] Devicetree fixes for v6.1, take 1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221013161322.GA447023-robh@kernel.org>
References: <20221013161322.GA447023-robh@kernel.org>
X-PR-Tracked-List-Id: <devicetree.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221013161322.GA447023-robh@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-6.1-1
X-PR-Tracked-Commit-Id: 917c362b5f8a6e31ff35719b1bacfc1b76a1fd2f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6d84c258e804db1983e70803af8be64bc8cb9a65
Message-Id: <166568917396.4575.15963995390144377462.pr-tracker-bot@kernel.org>
Date:   Thu, 13 Oct 2022 19:26:13 +0000
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

The pull request you sent on Thu, 13 Oct 2022 11:13:22 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-6.1-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6d84c258e804db1983e70803af8be64bc8cb9a65

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

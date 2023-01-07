Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0EF661122
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 19:46:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235663AbjAGSn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 13:43:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233006AbjAGSnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 13:43:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FC0C482B0;
        Sat,  7 Jan 2023 10:43:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C0FAB60BC7;
        Sat,  7 Jan 2023 18:43:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2C070C433F1;
        Sat,  7 Jan 2023 18:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673116996;
        bh=KHazOuuQeEcuUsq9NdmcMkHhurNTG58LRQop79RixZ4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=rWOo1zQU9q2lQA63NExxJqppGc8Ju/0jjOQ9rb/vHNy9KHjmoDtqMXVgHXTbO4Q2w
         DzFhLQJbLy0cw6ojJnAZmtv5czG2rccuvD9n/lcx88h17Y4c1eUjsp+D9is7BALMgJ
         79EPS8SK3ZHTaW0VVV3u3bHqMkVVuDOm91nrcYuA1zbRAqFphR6uDbGHOpOeK0TyIp
         ZaSBIHuQwlJ3RoD+H3tlqJfxB0bAklSFfIVpjxwtgK7HHLJBLGEyHr0iEaeAP5Y71M
         Xa/bem0ib7eq7CSYcD39/j9+XNEqw0XF+NgY7kfjaYordSM8qB9FPJFPM8gqG/rd/3
         4OuPa136clNMA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1A63DE5724A;
        Sat,  7 Jan 2023 18:43:16 +0000 (UTC)
Subject: Re: [GIT PULL] Devicetree fixes for v6.2, take 1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230107154742.GA1832142-robh@kernel.org>
References: <20230107154742.GA1832142-robh@kernel.org>
X-PR-Tracked-List-Id: <devicetree.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230107154742.GA1832142-robh@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-6.2-1
X-PR-Tracked-Commit-Id: 064e32dc5b03114d0767893fecdaf7b5dfd8c286
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0007c04038e5a3111bea1c4588bfb6778a69131d
Message-Id: <167311699610.9095.13026093400361936408.pr-tracker-bot@kernel.org>
Date:   Sat, 07 Jan 2023 18:43:16 +0000
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

The pull request you sent on Sat, 7 Jan 2023 09:47:42 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-6.2-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0007c04038e5a3111bea1c4588bfb6778a69131d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

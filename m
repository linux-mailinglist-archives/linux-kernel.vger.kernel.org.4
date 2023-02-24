Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C5FC6A250C
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 00:27:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjBXX1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 18:27:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbjBXX1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 18:27:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F1E67E06;
        Fri, 24 Feb 2023 15:27:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9621FB81D65;
        Fri, 24 Feb 2023 23:27:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5515FC4339E;
        Fri, 24 Feb 2023 23:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677281244;
        bh=rqnat2U7GCyVSphVnLvHYMAWNnjLAU443wvDA5jeHOw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=id1gAOJ4+B5J7RGUaYeEDYw5TVv7Qr8G6HmC0s94iWWVknKkr3fzDwvAYZjeJzKYr
         JtYHAmb5LmMAaRWJU5zaJj0I6Mif1LFbnpo7KY/ap86IxHdTF3BY0dd2qXy9P/Jp3i
         axyuqAFeF7EHzXAIBUCMSRCkjP15euGgbr5s7hb5HwBVftiz4uDN+GI62mNXpzysId
         evoEWMc6/XUp1UQrL8FL6x/vEBPuvbLhGtIwF8Drq0iP2eOszK406fe0aD41fDVpJe
         F7jM6LycaPXFF9WjFbDmfc5gcnWvuCYWOcBmpitil9YSYwL9X8KxIOMGSXC+4aa/xW
         kvwk4/UeqKDdA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 43C23C41676;
        Fri, 24 Feb 2023 23:27:24 +0000 (UTC)
Subject: Re: [GIT PULL] Devicetree updates for v6.3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230222163440.GA11643-robh@kernel.org>
References: <20230222163440.GA11643-robh@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230222163440.GA11643-robh@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-for-6.3
X-PR-Tracked-Commit-Id: 1ba7dfb905b3975bdb8b9d1f7793efcdfc59385b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8395d932d24a9b4c01ab33ed0b4b2de06328afc2
Message-Id: <167728124426.28021.2336383650288310291.pr-tracker-bot@kernel.org>
Date:   Fri, 24 Feb 2023 23:27:24 +0000
To:     Rob Herring <robh@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 22 Feb 2023 10:34:40 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-for-6.3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8395d932d24a9b4c01ab33ed0b4b2de06328afc2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

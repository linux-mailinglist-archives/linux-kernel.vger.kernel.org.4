Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05A0C74A315
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 19:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232437AbjGFR3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 13:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbjGFR3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 13:29:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32BC31FC4
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 10:29:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A57346105C
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 17:29:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 177EFC433C9;
        Thu,  6 Jul 2023 17:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688664546;
        bh=BVBS0MggoQXSkffHt01vaVu0wP5AR71Mqk3CcCEspnk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=m+wFxi9m9lGrZdn3a2h4sg0JFeN8PQ539Lx3c0IW/J/5jqO4FcZrIL6NOg+CNLr7j
         55E8+kaUHXh6zWJWdgc260+MdfJUqUK5b2h02Dg0yt/Gzby9WXyJKgl+jYEAwwlupX
         b7NpBJUOr1CgXft3wPNx+Pa05aRo7i6YZt0++HtOevivn81gP6rhp8vypVoqMXQ2Ch
         DZ+kVPuPiPnlqWJlOhKD9qca/HGp3gwWbi+70O2kkNl5wAT99W2L16/rWUkGtqpdDg
         TMnx73oD3D3/WpLl3uDxZJasWw4DvLUNANYLdpC2j+7Ez/gJsymI3VGdaMWSNkBrCN
         S3M4OE3QyRx7w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 04350E5381B;
        Thu,  6 Jul 2023 17:29:06 +0000 (UTC)
Subject: Re: [GIT PULL]: dmaengine updates for v6.5-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZKZdOWi8I0vxpdzL@matsya>
References: <ZKZdOWi8I0vxpdzL@matsya>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZKZdOWi8I0vxpdzL@matsya>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dmaengine-6.5-rc1
X-PR-Tracked-Commit-Id: 907514a7dc4c574136e8fb576b014be05d25813a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0b907305022beb1a4cf5b9f6d776483a2356c841
Message-Id: <168866454601.8259.1252097273555415465.pr-tracker-bot@kernel.org>
Date:   Thu, 06 Jul 2023 17:29:06 +0000
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 6 Jul 2023 11:50:41 +0530:

> git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dmaengine-6.5-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0b907305022beb1a4cf5b9f6d776483a2356c841

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

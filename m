Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D74AA6F7719
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 22:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbjEDUe7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 16:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbjEDUek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 16:34:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42F001AED1;
        Thu,  4 May 2023 13:26:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 520AB638CF;
        Thu,  4 May 2023 20:23:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B9A3FC433D2;
        Thu,  4 May 2023 20:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683231821;
        bh=XLvpoPHmZ00jSHRxfkj2g9jObNXiVaRgceMRaxzsM54=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=LKaRFpgt3+uN6shjZhyqXPwVKIjuQVCnQevwxk6/ioIHkglbL5Km///KHMRXymTUO
         t/dj388mF+yXuEcvsucSO2fqn8wnSqyCti1X+0Zvc81DfjXn0/p3/TRl+AuH2Kf3Ee
         dGSjpXCNe3NAEkPn4asPDNvGT+8hZc6IUUwETfYD33nMWC4jJVZwjYvqajmrmgcqDw
         BtDZfYpFdqU2B1wg483hgEFlL5v8gD6sIWO9r3uLOE004NYRStsKer0pk+jUZ/ylJk
         GTTuUUrPQWtpYrgoH0TFBf9RMPkBdpzWX9k1RjOCn2ZGiuk9MQQxG70jAUSc65qrPg
         2suS6OJARlsEQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A7D10E5FFC4;
        Thu,  4 May 2023 20:23:41 +0000 (UTC)
Subject: Re: [GIT PULL] final MM updates for 6.4-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230503162432.24a580b6c1a7fd465ed6bc2d@linux-foundation.org>
References: <20230503162432.24a580b6c1a7fd465ed6bc2d@linux-foundation.org>
X-PR-Tracked-List-Id: <linux-mm.kvack.org>
X-PR-Tracked-Message-Id: <20230503162432.24a580b6c1a7fd465ed6bc2d@linux-foundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-stable-2023-05-03-16-22
X-PR-Tracked-Commit-Id: 245f0922689364b21163af4937a05ea0ba576fae
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 15fb96a35db7aad8eb7cf98206b10e50a966e388
Message-Id: <168323182167.6214.14296184756604217729.pr-tracker-bot@kernel.org>
Date:   Thu, 04 May 2023 20:23:41 +0000
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, mm-commits@vger.kernel.org
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 3 May 2023 16:24:32 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-stable-2023-05-03-16-22

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/15fb96a35db7aad8eb7cf98206b10e50a966e388

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

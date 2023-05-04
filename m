Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B8A36F632E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 05:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbjEDDNz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 23:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbjEDDNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 23:13:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0560FDF
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 20:13:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 900116312D
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 03:13:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F3C88C433D2;
        Thu,  4 May 2023 03:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683170014;
        bh=BT17TKv14sHR5a5L0wHp6uZenNcjtUAts+/j2AlaLt4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=YVApyGFuteAKQKDiAo+vjztt6QpnEXHISgCnL+UkFVq5ITBwhpRDBGSa81bNGAI7P
         XKqdrmtnybGvkMU0KdihHRe+Zdlbkue8cgFfCSZ/H+7MPejA89QzIVIGRjbeZuwK2+
         GVSbcXu8Odq0gfu525DBxET2YuON1pI67OGJlvqtmn8ca3Wd6I00j22iYq3sHp0hif
         UZbCbE3uA5c8opeSRqyU3Z/uOWDWLswr+t/RokkUxAvsXbe5bPP9xyQJLrWUyqZK5F
         OUe/lY6wCVdT2F1dxODssg1HJJD3fqsf81lsZFskMLYqhv8eJeBP7ehaHAE6oCHp6Q
         81DgMSU8xpnVw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E2518C43158;
        Thu,  4 May 2023 03:13:33 +0000 (UTC)
Subject: Re: [GIT PULL] UML changes for v6.4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1396818281.2692347.1683141946452.JavaMail.zimbra@nod.at>
References: <1396818281.2692347.1683141946452.JavaMail.zimbra@nod.at>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1396818281.2692347.1683141946452.JavaMail.zimbra@nod.at>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/uml/linux.git tags/uml-for-linus-6.4-rc1
X-PR-Tracked-Commit-Id: 6032aca0deb9c138df122192f8ef02de1fdccf25
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 342528ff00e8a7dd31c1ea0c0093c2289d769b39
Message-Id: <168317001392.23861.17628098609837409912.pr-tracker-bot@kernel.org>
Date:   Thu, 04 May 2023 03:13:33 +0000
To:     Richard Weinberger <richard@nod.at>
Cc:     torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-um <linux-um@lists.infradead.org>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 3 May 2023 21:25:46 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/uml/linux.git tags/uml-for-linus-6.4-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/342528ff00e8a7dd31c1ea0c0093c2289d769b39

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

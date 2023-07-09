Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1575974C6D7
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 19:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232858AbjGIRqj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 13:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231920AbjGIRqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 13:46:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 798FB107;
        Sun,  9 Jul 2023 10:46:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0C04860C17;
        Sun,  9 Jul 2023 17:46:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 71B87C433CA;
        Sun,  9 Jul 2023 17:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688924794;
        bh=4WjXO1MvNfhzJmghOdRqOlpuOXX4aP6smlx1ETAuJUI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=tlEtwFHSenoUnlO9Gka41AQ7/giqkgbD7xZmZCAgNjqXshGZX3SWX0X+Fedc8Z8X0
         vP9iyIfSFLdmUQ15cn3Xj8kLuA0P4chiTa/z/1C/UkLKYh63ruax1qvUc/EwHV4mzc
         kqdz/GOvH9g/ovjcqUCeBqnk7pQkCfoJwsFEfJtKq7Jrftgj4LTTJq6g08FSOLVuyA
         NSwUHKeEECEoVXDXdwt6YT6XBm5tBM63zAeqZKLJWjI1MpUIC/0vBP9uM2HS/Y2TtL
         69dkSbANRFsBDQUXUZWI9TG5bVqMInmAbfLO894nCyMuRhn4axg6x5a9suFC7xYe9n
         ixbkEeulKsj0g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 60258C4167B;
        Sun,  9 Jul 2023 17:46:34 +0000 (UTC)
Subject: Re: [GIT PULL] MIPS fixes for v6.5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZKpkUhSd/GGm37IM@alpha.franken.de>
References: <ZKpkUhSd/GGm37IM@alpha.franken.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZKpkUhSd/GGm37IM@alpha.franken.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git/ tags/mips_6.5_1
X-PR-Tracked-Commit-Id: 3a6dbb691782e88e07e5c70b327495dbd58a2e7f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 74099e20348e84e62b5ea6ef270f91db48bc1352
Message-Id: <168892479439.9789.17791110295946119612.pr-tracker-bot@kernel.org>
Date:   Sun, 09 Jul 2023 17:46:34 +0000
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     torvalds@linux-foundation.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 9 Jul 2023 09:40:02 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git/ tags/mips_6.5_1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/74099e20348e84e62b5ea6ef270f91db48bc1352

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FACF746414
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 22:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbjGCUag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 16:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231162AbjGCUad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 16:30:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED9E410D7
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 13:30:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 35B906105D
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 20:30:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 097DAC433CA;
        Mon,  3 Jul 2023 20:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688416221;
        bh=Q9FHrr89lGjLPHdwDcgOAxecdAUgl9WNaZhwQLm0J9k=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=JouLxdJruZBQUzqWevSIXqUJ1ubN5gh1/bE4AnoGV1wEXJaRkfGuz9vkW6Od/jSu+
         9fDHd6J3qEzC16dVABY/Efq1DIozDmKpE2dHwzQJz987RwXXL+y2gvbXbtUBipoUw7
         zrFkY/28XJM+1tWFxuHkLHyaOMGNtmgyx5aJJ0aYc/EdL9/oYTk60EKsZa/TbYUG3g
         PlsyFMeXYRjJZQpWyA8P1lMQKWn5FLoAsC+9L2AWiSEtNhFM2wiSFP8XcT7Rh1C+mV
         VxTv1gPGSgCu+eiz9cW9lGqju/O79UrDKDPIMRwITI24Ql+AaNVr5FdfEfOJcP0sSj
         rqR5c+Gnzo3Ug==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EC658C561EE;
        Mon,  3 Jul 2023 20:30:20 +0000 (UTC)
Subject: Re: [GIT PULL] Char/Misc driver update for 6.5-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZKKeL16WHd83RU1k@kroah.com>
References: <ZKKeL16WHd83RU1k@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZKKeL16WHd83RU1k@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.5-rc1
X-PR-Tracked-Commit-Id: adfdaf81f9d48d8618a4d8296567248170fe7bcc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 44aeec836da880c73a8deb2c7735c6e7c36f47c3
Message-Id: <168841622096.1331.1171023408188681507.pr-tracker-bot@kernel.org>
Date:   Mon, 03 Jul 2023 20:30:20 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 3 Jul 2023 12:08:47 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.5-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/44aeec836da880c73a8deb2c7735c6e7c36f47c3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

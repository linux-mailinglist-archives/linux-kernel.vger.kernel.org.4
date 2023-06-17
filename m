Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56017734321
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 20:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346467AbjFQSok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 14:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346466AbjFQSo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 14:44:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B3BA1BD1;
        Sat, 17 Jun 2023 11:44:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0BB1C612BB;
        Sat, 17 Jun 2023 18:44:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 73A4FC433C9;
        Sat, 17 Jun 2023 18:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687027466;
        bh=i+KEPI2hh4OmCFFH7TpDaiWoPmOEzneQlCA7ROXzwRU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=P4GG9p5Y/nnxfH2l0q3387Glj8kgMApPugNB9GEOegyHc6CyNG4i2i4ni++uOU5Bn
         gmMTe+S9Xw7IgdoTTChcmTSvr4PMKfQMezm86NCd+h1bH1wejShZ4XP7ZAZbs/0Wzw
         ZdoHVKMKaoaluCxYk+dUPQfEUJBEtOkgqxdTmpu9i662fzRveSmYoMrkjz9ubifQyj
         hYNwPiT9HJ4oJ2ceFmSQIdMoSh4grv2S3/Pla6KtkQu404wAwrWxui1/nw+kcFqMUd
         Za37CRcxnH8WaSUMxqUz9jFpx16wgl4iUm0qqiItxp4/cO1lMxUReuJV3RUh+c+1XZ
         LjfeyEju9xbrQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5BBC1E29F3A;
        Sat, 17 Jun 2023 18:44:26 +0000 (UTC)
Subject: Re: [GIT PULL] USB driver fixes for 6.4-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZI25EoACbZnSfnYF@kroah.com>
References: <ZI25EoACbZnSfnYF@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZI25EoACbZnSfnYF@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.4-rc7
X-PR-Tracked-Commit-Id: 286d9975a838d0a54da049765fa1d1fb96b89682
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 670062e7e4199b13980cd1d46796beb05c4a8699
Message-Id: <168702746637.26928.15947094223823191782.pr-tracker-bot@kernel.org>
Date:   Sat, 17 Jun 2023 18:44:26 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 17 Jun 2023 15:45:54 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.4-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/670062e7e4199b13980cd1d46796beb05c4a8699

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

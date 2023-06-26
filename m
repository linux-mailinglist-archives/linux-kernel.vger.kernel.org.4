Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E360473E693
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 19:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbjFZRfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 13:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231294AbjFZReM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 13:34:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22D361B0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 10:34:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9103060EDE
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 17:34:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 037F8C433C0;
        Mon, 26 Jun 2023 17:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687800851;
        bh=aMdhW00lFPZAxqk672iPsS2RpwgfbdXm48NfNwp/Ryg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=uDYNiWJzwL94vyivVNyegBnG9Nq3Fy9j9F8FwGgJQdhN+8cYhU7CeRw+6AHm6ZXxN
         ZbrDqYM3ksvn34sQbzwpNF5A7W/yk6M0t2C5JPmFYTJh5LOrwfs6FGATJN7Gg+R1HS
         aexnTv4+yEe1ruZmqjRl3+B7kK9mOT8sWGoUy+653ScX3F7IfJzkEi+uznqYPL9wy6
         VniRGqvC9u9+GOK9Mo46ZKUwUX+kYyMNiVUtpKFzI2cEhNLBGA6nCSv5TXn0wUoa1x
         /fZiNLYdhqGfjAg23f35H/RrZ6izW0n6Uq9emWrLWYDtB9K/spNFrRbw0au+Hx+DOR
         Adjj2xVMJsyog==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E3375C43170;
        Mon, 26 Jun 2023 17:34:10 +0000 (UTC)
Subject: Re: [GIT PULL] nios2: updates for v6.5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230613223510.20803-2-dinguyen@kernel.org>
References: <20230613223510.20803-1-dinguyen@kernel.org> <20230613223510.20803-2-dinguyen@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230613223510.20803-2-dinguyen@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git tags/nios2_updates_for_v6.5
X-PR-Tracked-Commit-Id: 6a22e017f952ecaf4bb510cd0939259470a27b06
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: be5b52dc144415a88ce785575ec9b6d989fc5ac6
Message-Id: <168780085092.11860.1641848784168696752.pr-tracker-bot@kernel.org>
Date:   Mon, 26 Jun 2023 17:34:10 +0000
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     torvalds@linux-foundation.org, dinguyen@kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 13 Jun 2023 17:35:10 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git tags/nios2_updates_for_v6.5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/be5b52dc144415a88ce785575ec9b6d989fc5ac6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

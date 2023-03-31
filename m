Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26CAC6D26A1
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 19:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232190AbjCaR1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 13:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232341AbjCaR1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 13:27:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E021CBAC;
        Fri, 31 Mar 2023 10:26:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 13507B83126;
        Fri, 31 Mar 2023 17:26:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B5D66C433D2;
        Fri, 31 Mar 2023 17:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680283616;
        bh=GMwLGMAfaEvG0vtZI3jV7qsMY2XtSKRDENub3qsTL+4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=mqG3+GONqU3IkKtKqVWzhWYQ5IhQqTwOkFKWJNQrFFDHeW0CiMAsngFy7UTJR66Ie
         sthVBB7mc4/DnswpNpeMcjnolLzXYiw79Uie9FHnULxTMzjXNaqkv/AqgB6dCLQ7xf
         C8qw5EniZyHZhdVjCOisU22EWMtMP7MS8JyVsvrknecAEB0+VRgISBCJefhZpgZNIJ
         Nb/wMeekV2ITh8h9GpONgIjDf0Quf6pOIvlvYgReSNyZEPg6BQqnqXz8/AdSrFo0JD
         adGO7m2AhNgi3MtGeSGloeHLoHiXxbZ/K0CEJrxmKwvGy8SlWi9iJ+rd6yqZHRserC
         t90zF5lTJ4F5Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9FE41C43157;
        Fri, 31 Mar 2023 17:26:56 +0000 (UTC)
Subject: Re: [GIT PULL] MIPS fixes for v6.3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230331083330.GA6643@alpha.franken.de>
References: <20230331083330.GA6643@alpha.franken.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230331083330.GA6643@alpha.franken.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git/ tags/mips-fixes_6.3_1
X-PR-Tracked-Commit-Id: ab327f8acdf8d06601fbf058859a539a9422afff
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 52f1959502dec5069dcd247ce0462cdc608494b1
Message-Id: <168028361665.4567.409289269350391188.pr-tracker-bot@kernel.org>
Date:   Fri, 31 Mar 2023 17:26:56 +0000
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     torvalds@linux-foundation.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 31 Mar 2023 10:33:30 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git/ tags/mips-fixes_6.3_1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/52f1959502dec5069dcd247ce0462cdc608494b1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

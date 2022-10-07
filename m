Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBA905F7DE2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 21:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbiJGTVQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 15:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbiJGTUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 15:20:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 292471277B;
        Fri,  7 Oct 2022 12:20:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7809961DD2;
        Fri,  7 Oct 2022 19:20:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4591AC43141;
        Fri,  7 Oct 2022 19:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665170415;
        bh=y9XB6NRH9tplfZxlwLuLiy9ycFUX00yX1XcFjlgJPhs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=WW5QZo/hq+J9gYfi+b0LpP///EEJR6O+O7V08yogBADPh2fAzLPY8bWst5CJSpyFA
         UXswuUUYqrORhD+Mzrh8ZGJb21xsUtjBQ2O91b7hsqSa8jdTFMoLDwXZvYULcx2oB1
         RT/yRbbmhappvQR67eSM93wHT1j84LAVJgWkljRE1+ec1gvX3ClXyqbtJfsOKC4x0T
         +MrdxkDAr4a9J8ypKrNgObqvJBsptZ/S/uHkTcpfEX/yrGEmILzUWIeeyQZTbYhBNQ
         IyE4uHlnrqd6TvvwTorStS2uRvSXSZCKQsTEqmBwQ79+XUrA/kxOur+uUeHJb3Q/9/
         6cWzg/xZ83YLA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 34DAAE21ED6;
        Fri,  7 Oct 2022 19:20:15 +0000 (UTC)
Subject: Re: [GIT PULL for v6.1-rc1] media updates
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221005102323.4f751c1a@sal.lan>
References: <20221005102323.4f751c1a@sal.lan>
X-PR-Tracked-List-Id: <linux-media.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221005102323.4f751c1a@sal.lan>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/media/v6.1-1
X-PR-Tracked-Commit-Id: fbb6c848dd89786fe24856ee6b5e773910ded29c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5d435a3f7b6cb1db566d0f56f5f8dc33be0dde69
Message-Id: <166517041521.8063.13904314750240967629.pr-tracker-bot@kernel.org>
Date:   Fri, 07 Oct 2022 19:20:15 +0000
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 5 Oct 2022 10:23:23 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/media/v6.1-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5d435a3f7b6cb1db566d0f56f5f8dc33be0dde69

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

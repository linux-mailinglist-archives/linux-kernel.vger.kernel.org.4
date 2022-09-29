Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 359445EF946
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 17:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236027AbiI2PlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 11:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235716AbiI2Pka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 11:40:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D950B6F57C;
        Thu, 29 Sep 2022 08:38:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7B349B824D5;
        Thu, 29 Sep 2022 15:38:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2FEB2C433D6;
        Thu, 29 Sep 2022 15:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664465918;
        bh=7DFUJuaA4g7ss9rJewgMrIuo0+nl4JP9kQu+pcuHHrE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=uJ0SQc9OHFqpMEn9EgiBTD6Bo11+zv5HH86CFhlUFEZXcG+xfxkiPCdNp7ldYfeSl
         X+IP/j0S9BUedvc5nldaxI2ImX43lPFr3njB5xoWc/YieVq2o1E2zOfWK/8J2x+Dgw
         WFj7/X2fWsZBziC6I+/+daSluz0bKrRH6v/BCQesZu4Zxe5WmsyPG7EYKeRpYZ+Fxq
         mrriwgiIVEMblpmQZb1Jtm1qXF6tmYlu7vet3veyuezz8l1o7B06g8NCneqcdct9xo
         wYp8HoyDeq5uG81MGv4cRxeuGbbUBI1IIIEuXFK+k7Fk6KJA7tDGZ79K45Vp8jhHG2
         BQ3JLkshpMWUA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1BDF8C395DA;
        Thu, 29 Sep 2022 15:38:38 +0000 (UTC)
Subject: Re: [git pull] Input updates for v6.0-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YzUhj0yo9j/IUsvD@google.com>
References: <YzUhj0yo9j/IUsvD@google.com>
X-PR-Tracked-List-Id: <linux-input.vger.kernel.org>
X-PR-Tracked-Message-Id: <YzUhj0yo9j/IUsvD@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git tags/input-for-v6.0-rc7
X-PR-Tracked-Commit-Id: e62563db857f81d75c5726a35bc0180bed6d1540
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: da9eede6b2423381d592b832a7c5ba0082f2e905
Message-Id: <166446591810.14842.4352921312797448925.pr-tracker-bot@kernel.org>
Date:   Thu, 29 Sep 2022 15:38:38 +0000
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 28 Sep 2022 21:39:43 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git tags/input-for-v6.0-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/da9eede6b2423381d592b832a7c5ba0082f2e905

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

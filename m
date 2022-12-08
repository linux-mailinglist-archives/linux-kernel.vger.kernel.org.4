Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51F85647631
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 20:27:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbiLHT1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 14:27:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbiLHT0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 14:26:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48E2F9AE21;
        Thu,  8 Dec 2022 11:26:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F2ED5B8260A;
        Thu,  8 Dec 2022 19:26:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B7C5AC433F1;
        Thu,  8 Dec 2022 19:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670527597;
        bh=gRMgv8VlWkaarD7xijlxtiEai7TIaFe7+oa66LGsDZY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=MumKzoJ6DL6rdHiL0W6Fi/FjkaAg5bSlU2Y5copSctRT8kq8MChdvT6VPOhgeAYpE
         3sudv6iI1uitKfHJVjvdlDJmzZVH2ChjEYbSVUjbgL/IbxW5nfIw8xPmWbfIXNum75
         Gnd2ql+AWm0HnOvDXAEXVNmdWRHKdUwOk8ad7ffXaPmlWQEBNwS3Y8iID3CFf0wzc2
         YezUMJo4bpi7X8SuW4TncrCRZUrvlNdEjYPl8GlWl3erAsiXcf86ZjEcdUaF49LxcF
         AjJt/2djTwyVF/GuEuuNlqKXwPOCXlUdLp09WODUP7kmKpEvUpSw77/BXpu6M150Td
         LCUT1Xyhk4L1A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A50BDE1B4D8;
        Thu,  8 Dec 2022 19:26:37 +0000 (UTC)
Subject: Re: [GIT PULL] gpio: fixes for v6.1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221208184110.252270-1-brgl@bgdev.pl>
References: <20221208184110.252270-1-brgl@bgdev.pl>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221208184110.252270-1-brgl@bgdev.pl>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v6.1
X-PR-Tracked-Commit-Id: 63ff545af73f759d1bd04198af8ed8577fb739fc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 306ba2402de569a401549bf343ef60748b8f43df
Message-Id: <167052759767.15249.16000264001242254576.pr-tracker-bot@kernel.org>
Date:   Thu, 08 Dec 2022 19:26:37 +0000
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu,  8 Dec 2022 19:41:10 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v6.1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/306ba2402de569a401549bf343ef60748b8f43df

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

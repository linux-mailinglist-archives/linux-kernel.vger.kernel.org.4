Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0613E68F6E5
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 19:30:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbjBHSaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 13:30:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBHSaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 13:30:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 129031F4B6;
        Wed,  8 Feb 2023 10:30:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ACBD26178B;
        Wed,  8 Feb 2023 18:30:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 18144C433D2;
        Wed,  8 Feb 2023 18:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675881018;
        bh=3YOFdKnAwzqh0eCNoXvPPLYHZOdMnpSXzcOAzCSwheY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=SdUIHnNswCvU6EWW/DqDwaGUFjDorjoJI7XuZ1yWPE/j64k/eQLyQ7LkzCYa78OUD
         m+Rrne2+gcGKpeXj5dx2sL5WH6D2B2cT5CROAPeLGvuY4hH8+lAsozNYTI6HrvaoNC
         /wg1/RhyYWA9vShiShfsNL2TqQqxBSiU0AkOuIMt6W536mbvcHeCji9uqyxyLYyiYN
         un8rm8LFkhPl5KbT9Gbq1QQXoFfgyvZwpvL6FOFnipzNpCUljKCRiHZl6vkpuCJtq7
         uh/755ooa4+kCy4mwBmLHz2VOZPN1O1BDkavwLkIMQqnlFzEunRITzxczbn7DR25/t
         bdrKV7yQMa3UA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F23AFE4D032;
        Wed,  8 Feb 2023 18:30:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH][next] platform/chrome: Fix spelling mistake "Attenetion" ->
 "attention"
From:   patchwork-bot+chrome-platform@kernel.org
Message-Id: <167588101798.25749.5056097806112911445.git-patchwork-notify@kernel.org>
Date:   Wed, 08 Feb 2023 18:30:17 +0000
References: <20230207091443.143995-1-colin.i.king@gmail.com>
In-Reply-To: <20230207091443.143995-1-colin.i.king@gmail.com>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     pmalani@chromium.org, bleung@chromium.org, groeck@chromium.org,
        chrome-platform@lists.linux.dev, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to chrome-platform/linux.git (for-kernelci)
by Prashant Malani <pmalani@chromium.org>:

On Tue,  7 Feb 2023 09:14:43 +0000 you wrote:
> There is a spelling mistake in a dev_warn message, make it lower case
> and fix the spelling.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/platform/chrome/cros_ec_typec.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [next] platform/chrome: Fix spelling mistake "Attenetion" -> "attention"
    https://git.kernel.org/chrome-platform/c/b0d8a67715da

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



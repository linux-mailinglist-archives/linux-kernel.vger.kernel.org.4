Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0E9B72F3FC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 07:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242770AbjFNFKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 01:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232831AbjFNFKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 01:10:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B123D1A3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 22:10:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AA3A863DA3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 05:10:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1BE63C433C0;
        Wed, 14 Jun 2023 05:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686719430;
        bh=rrpNv/C6go2MmpKX0o57SzGsrFboftdRPFh4qo2BObQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=mO5acHYklFAkKHz2XpDuxJUf/x3IwHf2NIMcmfnupkIplogsIwt6JRpoOzGcAs9Oq
         bt18sF8oDThVT6MIAzRlJyxUCKwKlV+XTvkxjyZtEHngWzcT9ieXqsEWuEKhRnVlPT
         0ojMKy+zIk+b8vTy0JkKg4ILhHmksKHu1WvpOdb7Ft91vKCGwwVEbDYFiXrNWv/45A
         sT+sNsWXqZD2U6w8PuNYTOUWCWHuS8TrqJx5fJ5cgT5/p1FKHnKl5frqsi/Bfkzm1o
         VEhHV1XQxT166HQlJcFyO1NW/qkxF/DBCooFv1DVofuLFDiuN5ZpWXD+FwjP69ilyR
         amz8BSHJMqJxA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E850FC395F3;
        Wed, 14 Jun 2023 05:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 1/1] platform/chrome: cros_ec_spi: Use %*ph for printing
 hexdump of a small buffer
From:   patchwork-bot+chrome-platform@kernel.org
Message-Id: <168671942993.26522.11776127296036534588.git-patchwork-notify@kernel.org>
Date:   Wed, 14 Jun 2023 05:10:29 +0000
References: <20230612212336.4961-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230612212336.4961-1-andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        bleung@chromium.org, groeck@chromium.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to chrome-platform/linux.git (for-next)
by Tzung-Bi Shih <tzungbi@kernel.org>:

On Tue, 13 Jun 2023 00:23:36 +0300 you wrote:
> The kernel already has a helper to print a hexdump of a small
> buffer via pointer extension. Use that instead of open coded
> variant.
> 
> In long term it helps to kill pr_cont() or at least narrow down
> its use.
> 
> [...]

Here is the summary with links:
  - [v1,1/1] platform/chrome: cros_ec_spi: Use %*ph for printing hexdump of a small buffer
    https://git.kernel.org/chrome-platform/c/2b8cc5858a07

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



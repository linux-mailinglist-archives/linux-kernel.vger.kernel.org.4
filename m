Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18A5272D8A5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 06:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239926AbjFMEc5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 00:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239587AbjFMEcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 00:32:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A59810DF
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 21:30:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0EFD5630EC
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 04:30:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 74E11C433D2;
        Tue, 13 Jun 2023 04:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686630620;
        bh=3Upkbk78RnWCWTUOh1brAeXyaxKfWIHLIVC+3iNAk74=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=BqA2m9Zx4FEhwshAkHiXSD+pfHpiHJlIohjOP6C4LzV2tJ+UBCEboGyaGlG8l5e0U
         FHVavOCnum1+SJZjZ1n9k4WPim1HLokkOjVpfEBrJ/6L8NPPYrUej549bwrymT2yUu
         6tm3O8iY9NECd/8ORqo1znnIozKnDQYZ7IhB9yJePQTkFuTLd0zs0xQEdO3yUY8HrW
         JeG15KD7PoRNp2mgEz32PixNbxJRB5Q267C6jjgJYP+LrjEB/XSTqVVrzXLOayoX0E
         M1eBLtK7MyWWVp+6MouLfWQh6CFC5kRn0SdjoCvG9geD4d53R3WTWLw5VV4xIVRgyY
         osl2c5GfIkByA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5914BE21EC0;
        Tue, 13 Jun 2023 04:30:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 1/1] platform/chrome: cros_ec_spi: Use %*ph for printing
 hexdump of a small buffer
From:   patchwork-bot+chrome-platform@kernel.org
Message-Id: <168663062036.801.9347920578627986681.git-patchwork-notify@kernel.org>
Date:   Tue, 13 Jun 2023 04:30:20 +0000
References: <20230612212336.4961-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230612212336.4961-1-andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        bleung@chromium.org, groeck@chromium.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to chrome-platform/linux.git (for-kernelci)
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



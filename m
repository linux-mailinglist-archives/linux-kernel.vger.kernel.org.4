Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B8C56E88FB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 06:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232494AbjDTEKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 00:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjDTEKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 00:10:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0009E5F
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 21:10:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 38CD2643D4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 04:10:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 949EFC433EF;
        Thu, 20 Apr 2023 04:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681963819;
        bh=W35thcLsxSdb5IFXl2LRqkqSPXmH7NiM5RBfp7QRbug=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=LjuYn6maOgxEamvS0m/rZ1+/iogaopA12NdQbCAx7BVKrZB0ZJuuDlSY00USEPflf
         dWAkY4fGEdNMyFo69VjOjYKEXRrGXB6vwpuQKhmGsfOij/yALrftn6bXIKBsyghqq1
         c3vYzLTXh/1KxXqhkjPpR/Od+jtuk7Sx6Pn7WVRpNdKr0Uo/s8k23RefuVc0gsqE9m
         swmUcDArbkfFsFmrwLOVFXkzsbDKKxFl1Ouat66ZjSikHG5ypfBtl5+f+5d9Yf9Q2r
         8PDH7QuLRH2p/D+mZL4FClsRVNzmPIboMpl8S+kBIUlo/dGO1lyHfo6zxOhXMzAT4c
         wpfR/ywTVoe8g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7B670E3309F;
        Thu, 20 Apr 2023 04:10:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] platform: chrome: wilco_ec: remove return value check of
 debugfs_create_dir()
From:   patchwork-bot+chrome-platform@kernel.org
Message-Id: <168196381950.11566.18059888806263127590.git-patchwork-notify@kernel.org>
Date:   Thu, 20 Apr 2023 04:10:19 +0000
References: <20230419100303.343379-1-zkhuang@hust.edu.cn>
In-Reply-To: <20230419100303.343379-1-zkhuang@hust.edu.cn>
To:     Zhengkang Huang <zkhuang@hust.edu.cn>
Cc:     bleung@chromium.org, dzm91@hust.edu.cn,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
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

On Wed, 19 Apr 2023 18:03:03 +0800 you wrote:
> Smatch complains that:
> wilco_ec_debugfs_probe() warn: 'debug_info->dir' is an error
> pointer or valid
> 
> Debugfs checks are generally not supposed to be checked
> for errors and it is not necessary here.
> 
> [...]

Here is the summary with links:
  - platform: chrome: wilco_ec: remove return value check of debugfs_create_dir()
    https://git.kernel.org/chrome-platform/c/0ad5ce8407db

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



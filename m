Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D86506E503A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 20:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbjDQSav (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 14:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjDQSas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 14:30:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CFB344B7;
        Mon, 17 Apr 2023 11:30:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1CE5762886;
        Mon, 17 Apr 2023 18:30:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 533ECC4339B;
        Mon, 17 Apr 2023 18:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681756219;
        bh=Q1DxGXGs0+neLMqgN0EFcdZqkosQ0RRavIdVwRtF6uo=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Xj1kT+klmNkjyAc6vrtUA9PjQbXlJpBqtIp0nZeuTNz9x2P6PjT4RpC3kEXhwp7Of
         4NMRlNYyQyurIPFD2RKVIbfRNU80NOLYs4st8IGcvuc4XXNGFkPpdwsCXmU1FtC7hL
         J23cZsD/Mn9FoTV8wTl1PhXWGU6awVVyt5NIjchh+VF4EiaTWtMKgZlJAexUk958vJ
         xb4EasFp0/vgwlH74IGCOHHGbPEcDCc+T8oFTn2GiQbmRKFXyoxsZyEv1q6qlicZxC
         7WtC9/ZPm8FlDsp7MIfx2DpxX+3NXIBkjilU+Zlz0InjTSAxoLtPMGOc7C6cOPHtKN
         2VLwS8xtfEfhQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2C95FE330A0;
        Mon, 17 Apr 2023 18:30:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v5] Bluetooth: btrtl: Firmware format v2 support
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <168175621917.2755.2479462540235386581.git-patchwork-notify@kernel.org>
Date:   Mon, 17 Apr 2023 18:30:19 +0000
References: <20230417023358.38767-1-max.chou@realtek.com>
In-Reply-To: <20230417023358.38767-1-max.chou@realtek.com>
To:     Max Chou <max.chou@realtek.com>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        alex_lu@realsil.com.cn, allen_chen@realsil.com.cn,
        hildawu@realtek.com, karenhsu@realtek.com, kidman@realtek.com,
        mmandlik@google.com, abhishekpandit@chromium.org,
        apusaka@chromium.org, yinghsu@chromium.org, alainmichaud@google.com
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

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 17 Apr 2023 10:33:58 +0800 you wrote:
> From: Max Chou <max.chou@realtek.com>
> 
> Realtek changed the format of the firmware file as v2. The driver
> should implement the patch to extract the firmware data from the
> firmware file. The future chips must apply this patch for firmware loading.
> This patch is compatible with the both previous format and v2 as well.
> 
> [...]

Here is the summary with links:
  - [v5] Bluetooth: btrtl: Firmware format v2 support
    https://git.kernel.org/bluetooth/bluetooth-next/c/0330a285b7f1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



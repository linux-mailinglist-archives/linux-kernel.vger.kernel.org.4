Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2565F70E36A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 19:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237354AbjEWRk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 13:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238349AbjEWRkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 13:40:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB58390;
        Tue, 23 May 2023 10:40:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F17462C62;
        Tue, 23 May 2023 17:40:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A20FAC433D2;
        Tue, 23 May 2023 17:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684863621;
        bh=LLyJ2GkXJGOGWwYclJ0GhY8WvjoEHrVakiwzTjd3fVw=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=myzCbRH4jVKlnfTYtTbcOLntMb/CJ4h4Dbol2whmy8wZiPRj0VrIGiEUs2gxZr5oS
         q7CsAtE+DHpauph9RCxUHDzXqCTqShDqV9vfVI/F+/nPaw57xeG745bmG7LA4gNXUt
         YbCwamCwu/dcWcbE6tdGglzJe3CZHyRIZqQvr+4cjSKti3SLWgNOJH3KPtA5caDhLG
         K2BqOsLq4ZWuq3SAJ6ItpbImn7KTvvfblwqVJjEtB86YFzhMVPA2zKLKhon4DHTYnm
         sw8VBO86DWTW7gVgQOL9LN+ECxWnWad/BFheize+pZe+H1JfT8pE1AfZuu/ATRXAEm
         Z8u44bjoWkVbA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 81755E22AEC;
        Tue, 23 May 2023 17:40:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4] Bluetooth: btrtl: Add Realtek devcoredump support
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <168486362152.30009.17829530395112932245.git-patchwork-notify@kernel.org>
Date:   Tue, 23 May 2023 17:40:21 +0000
References: <20230427032755.28519-1-hildawu@realtek.com>
In-Reply-To: <20230427032755.28519-1-hildawu@realtek.com>
To:     Hilda Wu <hildawu@realtek.com>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        mmandlik@google.com, apusaka@chromium.org, yinghsu@chromium.org,
        alex_lu@realsil.com.cn, max.chou@realtek.com, kidman@realtek.com
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

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 27 Apr 2023 11:27:55 +0800 you wrote:
> From: Hilda Wu <hildawu@realtek.com>
> 
> Catch debug exception from controller and driver, and trigger a
> devcoredump using hci devcoredump APIs. The debug exception data
> will be parsed in userspace.
> 
> Signed-off-by: Alex Lu <alex_lu@realsil.com.cn>
> Signed-off-by: Hilda Wu <hildawu@realtek.com>
> 
> [...]

Here is the summary with links:
  - [v4] Bluetooth: btrtl: Add Realtek devcoredump support
    https://git.kernel.org/bluetooth/bluetooth-next/c/ab93c2a34458

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



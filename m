Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94B346A1141
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 21:30:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbjBWUaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 15:30:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbjBWUaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 15:30:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E8B260131;
        Thu, 23 Feb 2023 12:30:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4C92DB81A2E;
        Thu, 23 Feb 2023 20:30:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id ED748C4339B;
        Thu, 23 Feb 2023 20:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677184218;
        bh=hxvzbtsCEMo4F0XomVtge4pEk7LqE5xYjlJBo+9rCSA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=a0qjNGuH7qeniDeRy/Sm6W8nB4deDqXsQnL4vNfrXUnH09ri3MFzKJfPeifKH5dT9
         dC3UwWzjmT8Xf4Jd+z1dbkHAi6FBpz7WfnlDZYuAyDbQLVyBPr41J9Q8QL5ehAURr4
         0kDGfWbXqSqMUQWfKbRB557JzTaIvCK1HjlY9zidAjQmi17UXj+X0fFKXt3mLzYfGZ
         xmIHSf7gNmjZVbjflBamVtAu+O3BMnl+357yqoWIRREyjJPdEgTij91FPFnkvD8N22
         yiWuammQAaAy7BPcbbxJG2eZrXwDgcPpX97Y5mO2zL0VrXb3i6LG1T9bOe/immACpi
         40+/2coxe2lFA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D5A81E68D32;
        Thu, 23 Feb 2023 20:30:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [RESEND v2] Bluetooth: btrtl: Add support for RTL8852BS
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <167718421787.4523.8545278477915924408.git-patchwork-notify@kernel.org>
Date:   Thu, 23 Feb 2023 20:30:17 +0000
References: <20230222094720.67185-1-victor@allwinnertech.com>
In-Reply-To: <20230222094720.67185-1-victor@allwinnertech.com>
To:     Victor Hassan <victor@allwinnertech.com>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 22 Feb 2023 17:47:20 +0800 you wrote:
> Add the support for RTL8852BS BT controller on UART interface.
> The necessary firmware file will be submitted to linux-firmware.
> 
> Signed-off-by: Victor Hassan <victor@allwinnertech.com>
> ---
>  drivers/bluetooth/btrtl.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)

Here is the summary with links:
  - [RESEND,v2] Bluetooth: btrtl: Add support for RTL8852BS
    https://git.kernel.org/bluetooth/bluetooth-next/c/1fb7281c62c9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



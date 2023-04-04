Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48B546D5650
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 03:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233114AbjDDBye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 21:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjDDByd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 21:54:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91656F1
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 18:54:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 32111623C9
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 01:54:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 92735C433D2;
        Tue,  4 Apr 2023 01:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680573271;
        bh=hryDKmP5KESu5SQ1U29kbrRkg3Ll6z0zQN9N62UJGWQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=BrrHKhPayRefHk4AgT/tfcbwtWv6/cShtZgx/YYR1IBlAuXEQQTNdAmWc24qXqeH8
         gJVma4wYShxeQryG1gegTiFyRt1plgNa/XXXP+XI+TYaRNUkrshHMztcU9oW83pb9o
         7/bcnj6T51dkSb3BHo8pokoF0bDgRs8W+f6Q+uKJjzgb802w6d/KLCMGgPKRdy/Obr
         APzb1hmnmxFYBJ4B+v3m7jhsiuDw60V0VOv8/CnVis025LrHHmnO4D0GG7YYL/wpCn
         RZhvYpxjWmKqn2di1SgE7t0Mdd3CS+5l0Xw8jWwypwtLewd49sJ6AIZEQWvKoL6ZsY
         xJBS8WYCOSn+A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 744B8E5EA89;
        Tue,  4 Apr 2023 01:54:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix null pointer panic in tracepoint in
 __replace_atomic_write_block
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <168057327147.21470.3067072388880133796.git-patchwork-notify@kernel.org>
Date:   Tue, 04 Apr 2023 01:54:31 +0000
References: <20230403165038.3018949-1-jaegeuk@kernel.org>
In-Reply-To: <20230403165038.3018949-1-jaegeuk@kernel.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Mon,  3 Apr 2023 09:50:38 -0700 you wrote:
> We got a kernel panic if old_addr is NULL.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/segment.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [f2fs-dev] f2fs: fix null pointer panic in tracepoint in __replace_atomic_write_block
    https://git.kernel.org/jaegeuk/f2fs/c/053654436fc6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



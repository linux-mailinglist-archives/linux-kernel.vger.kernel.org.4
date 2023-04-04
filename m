Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6954B6D6EFC
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 23:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236296AbjDDVaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 17:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235912AbjDDVaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 17:30:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 189E9E75
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 14:30:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F944635D3
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 21:30:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0B13CC433EF;
        Tue,  4 Apr 2023 21:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680643819;
        bh=BhqwVjVyK+Eol6KMD537Bt+HCSapsZ3NENVcIm/jk3E=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=aRciJmjj3GSjvK/LQTaFh+wQ9PedRJ20Wpa6RH6UcqAZ4JfkmfZz2ESThlhzveigG
         4eUZcTY4xmnswV9DH2NY+xibmAAE2q0952DvDpXHrAwo4H8s1pIx2sMULX4m3A/bC0
         z3kMvySCcERCYKCtsudeXg63KL21X9KruWTVhGyQWvaDiGxMQI+hDyMEcmxXJ+zHgT
         E++8eYygKRVuk8Qf4Ggnlsqzz5eKAV70Aeav00Jh2UxFkEi9zuEsGpjj6c18jTPQPh
         ihHzOJu6vAvi+DrU8UvykCwVnHeq2pqHQvKaMQ6K3I11nKh6RtCObeD+ZaiAjSzbjE
         ymmib/CZ1lpgQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DB511C395C5;
        Tue,  4 Apr 2023 21:30:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: remove struct victim_selection
 default_v_ops
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <168064381889.16246.5404521009795232180.git-patchwork-notify@kernel.org>
Date:   Tue, 04 Apr 2023 21:30:18 +0000
References: <20230404040051.50726-1-frank.li@vivo.com>
In-Reply-To: <20230404040051.50726-1-frank.li@vivo.com>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     jaegeuk@kernel.org, chao@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Tue,  4 Apr 2023 12:00:51 +0800 you wrote:
> There is only single instance of these ops, and Jaegeuk point out that:
> 
>     Originally this was intended to give a chance to provide other
>     allocation option. Anyway, it seems quit hard to do it anymore.
> 
> So remove the indirection and call f2fs_get_victim() directly.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v2] f2fs: remove struct victim_selection default_v_ops
    https://git.kernel.org/jaegeuk/f2fs/c/4066666c1581

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



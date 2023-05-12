Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B16016FFF9C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 06:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbjELETV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 00:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239844AbjELETS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 00:19:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 995523AA5
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 21:19:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 365E664FAA
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 04:19:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8DABC4339C;
        Fri, 12 May 2023 04:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683865152;
        bh=vARwBB0vZd65KLmoL9I1g9uNa/99CsM0nUQcFhKkbcg=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=NEAGZI31i5H0PETYD/VjPpzfH5Nz+HKInH4gKnAr9QII6OKswv0810biQpM/pBUno
         uCt8nlku+L4vs0CcrapQ17McYjWWmZg18C/JbQ/BzXwoNh/wmzhIeXRmq1P7oJDMQ1
         SqM0sxvhRAcOY8WqkhiZrMQ252+LuInevcpOupWFibhcv+cJbc9cv7sgMp61/vcJfd
         LtdoR6VNY+pJUOJ9U7lTPH3bFI1J9yPpzIsIYTlxV8UVcHsl+F1NBgiqya3YoVAqyL
         rLPO0S+m9KwQ0sKR+tHF73ahkuRVAkPWuFHckVLrXmR/yBdrU1QiMWa3sZlE4O7u7T
         eEGRHspdkwPEQ==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        Rsplwe <i@rsplwe.com>
Cc:     linux-kernel@vger.kernel.org
In-Reply-To: <tencent_3C6819728B6704C39A864762FB0BB77DF509@qq.com>
References: <tencent_3C6819728B6704C39A864762FB0BB77DF509@qq.com>
Subject: Re: [PATCH] ASoC: amd: yc: Add MECHREVO Jiaolong Series MRID6 into
 DMI table
Message-Id: <168386515044.352974.6695727033811005763.b4-ty@kernel.org>
Date:   Fri, 12 May 2023 13:19:10 +0900
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bfdf5
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 May 2023 23:04:11 +0800, Rsplwe wrote:
> This model requires an additional detection quirk to enable the internal microphone.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: yc: Add MECHREVO Jiaolong Series MRID6 into DMI table
      commit: deeb7855f5d7e21deef25c7fdbeb8512564bdea6

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark


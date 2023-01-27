Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8BEC67DAFB
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 01:54:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231837AbjA0AyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 19:54:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232292AbjA0Ax7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 19:53:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D192530FD
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 16:53:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BE860619CB
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 00:53:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41F21C433EF;
        Fri, 27 Jan 2023 00:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674780835;
        bh=PJHJ9/eLbz4lLsG9p3KtlaXfM4oLzuXTDQ8E2Hls+w8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=ku1yF1KipVryMWdDMfHUHZ6XmekunQOyz5KbpG5RmZCAoqO+fgJooEI6S1mjDNODB
         Avzrmp9OCZcOb0VzmrJxj+JFqorGt9x6S43a2PrQ1igAxWvWat5ynK+sArUlQcsiYV
         IjsEVPjMzaJYBXSREcHWduxNM76MUpTpaP50ejmOTLRzkyZqGDozzOdf42lGaS4tzv
         CP15YMF1bfotCjvwTV1ofCKt0iLpKS96kcUBTcwvOnI16nezwJt7CjWlVNfpGS76yo
         xRW0jsemaUmnaRPM/CkGElZsA9pg317RQYbXN72RH+Eya8XUjbhjooB0jFpTeILGwP
         SaGOc/5LkvL1g==
From:   Mark Brown <broonie@kernel.org>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Cristian Marussi <cristian.marussi@arm.com>
Cc:     sudeep.holla@arm.com, Jim Quinlan <james.quinlan@broadcom.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>
In-Reply-To: <20230126180511.766373-1-cristian.marussi@arm.com>
References: <20230126180511.766373-1-cristian.marussi@arm.com>
Subject: Re: [PATCH] regulator: scmi: Allow for zero voltage domains
Message-Id: <167478083297.1118403.15307034817786674476.b4-ty@kernel.org>
Date:   Fri, 27 Jan 2023 00:53:52 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Jan 2023 18:05:11 +0000, Cristian Marussi wrote:
> SCMI Voltage protocol allows the platform to report no voltage domains
> on discovery, while warning the user about such an odd configuration.
> As a consequence this condition should not be treated as error by the SCMI
> regulator driver either.
> 
> Allow SCMI regulator driver to probe successfully even when no voltage
> domains are discovered.
> 
> [...]

Applied to

   broonie/regulator.git for-next

Thanks!

[1/1] regulator: scmi: Allow for zero voltage domains
      commit: 668f777d02f61faa834f1e24f3b99576dbe5ff6b

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


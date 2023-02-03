Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B0C1689C4D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 15:56:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233228AbjBCO4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 09:56:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232955AbjBCO4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 09:56:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE4623929E
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 06:56:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1441E61F6B
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 14:56:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17FC5C433D2;
        Fri,  3 Feb 2023 14:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675436165;
        bh=eEGNAnaXLsNmCdIMPQ111OgMwhkshA87XIXK/XShWCY=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=vJgs2cOqEK31OUMYvbuISPMT0nywLiRNhui5sSOrOPRFE4GHnZw40n4zbArzPTW0B
         5F/YEHsOtIok05vj03SxsSD/ak+C5B4ZNqG2zESwGBsEZv1ZEvXMBxjwg8BSU7C7W+
         XKyZiPFXjPQMkBSdyFlaLAJ1IbE87pO3Im+Uo+cEHZeYIANXVQYMXX950dQjvqyJ16
         VjqiWeE1ToeEPnJF1OLi7Xt6jUF88xruPiTBEG4fVhFMgt0FLCeJNgFMER+eO3Ni2d
         GbQeuj4CY1vCwFjxCcNFJusmlLWB/uny0WHxH/VE56c25QwVUX8YRAwo4xjFqLh+nH
         CwgCzB7j9RUTA==
From:   Mark Brown <broonie@kernel.org>
To:     perex@perex.cz, Yang Li <yang.lee@linux.alibaba.com>
Cc:     tiwai@suse.com, lgirdwood@gmail.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
In-Reply-To: <20230203011504.78918-1-yang.lee@linux.alibaba.com>
References: <20230203011504.78918-1-yang.lee@linux.alibaba.com>
Subject: Re: [PATCH -next] ASoC: codecs: fix platform_no_drv_owner.cocci
 warning
Message-Id: <167543616380.928818.16403862674733683634.b4-ty@kernel.org>
Date:   Fri, 03 Feb 2023 14:56:03 +0000
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

On Fri, 03 Feb 2023 09:15:04 +0800, Yang Li wrote:
> ./sound/soc/codecs/aw88395/aw88395.c:572:3-8: No need to set .owner here. The core will do it.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: fix platform_no_drv_owner.cocci warning
      commit: 1c9ded98bd4e5b87756423e0abededda6f4ba0b8

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


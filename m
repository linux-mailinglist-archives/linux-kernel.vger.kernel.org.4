Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10E6A6C6C9C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 16:53:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232180AbjCWPxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 11:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231974AbjCWPxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 11:53:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 219B815881
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 08:53:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 86EC16258C
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 15:53:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E288CC433D2;
        Thu, 23 Mar 2023 15:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679586811;
        bh=9rUYRZ3l58XJDeVYlDJ7IcP/1SCSmLpVoWVsRot2Vjo=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=EQZ5Uc3h+rEp+ZsXC+PIBNETtuPqMKrO4OO468/Iqc4S2EMQ+TKRGpKodbhCyNrmJ
         sE4HdKw6EUWlgCIQZzgaqiJQAQVx9rAwtLtF6aRo5DJi9KWJGITzIGmnxwUoJ5/EJa
         Ww5daTxKrhJISlwsf/gT4INVoDPc9EhOt9qeE625ztfKmIkAyGnmOKjWTTMEts3tbG
         yFC8qedof8JnsnbRqSzyrhESihfYHHlKSxTu+/mqm4tAOY4PcGWRkQPHMNRxF/WWm1
         kBuvORhzqYb5Nino0Icj3HVvqyxMx44pnM08c37SdxWhVZ32JSLHbwsV+Bzmuote0a
         3tHUWyaT/FnEg==
From:   Mark Brown <broonie@kernel.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     lgirdwood@gmail.com, dianders@chromium.org,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org
In-Reply-To: <20230323132047.833737-1-ckeepax@opensource.cirrus.com>
References: <20230323132047.833737-1-ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH 1/2] regulator: arizona-ldo1: Use
 PROBE_FORCE_SYNCHRONOUS
Message-Id: <167958680964.69791.4288005839640736438.b4-ty@kernel.org>
Date:   Thu, 23 Mar 2023 15:53:29 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bd1bf
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Mar 2023 13:20:46 +0000, Charles Keepax wrote:
> Restore synchronous probing for Arizona regulators because otherwise
> the main MFD driver will not find its core supplies.
> 
> As these regulators are built into the CODEC and typically have no DT
> representation the regulator framework is unaware of their existence
> until the driver probes. These means the probing of the driver needs to
> be synchronous to ensure the regulators are not substitued for the dummy
> later when the users request them.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/2] regulator: arizona-ldo1: Use PROBE_FORCE_SYNCHRONOUS
      commit: 557de8d84ae4988b08339032d2f405ef5057e82b
[2/2] regulator: arizona-micsupp: Use PROBE_FORCE_SYNCHRONOUS
      commit: b65a0a8edba2c0a03e8fdb03b6807132e4166483

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


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50B46671EE3
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 15:06:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbjAROGs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 09:06:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbjAROGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 09:06:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA002A5798;
        Wed, 18 Jan 2023 05:42:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 237186181D;
        Wed, 18 Jan 2023 13:42:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 497EEC433F0;
        Wed, 18 Jan 2023 13:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674049364;
        bh=aF1vAtO//C1XF9AQ5nzlkEx0tMeil3RfjeIi7EtuUu0=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=ihZWz81pyWzvJdsvlvz4m8Ur7xAg8Dde58yOtNO3Ha+GUPucbyX9r/Ik+lN6Gsz6K
         2AlQoLLjPYqAHppLT8Z+Y/MNGth0EfNLR9FWeJvHQyw6CVBblMhzu31K+e7JzUHb2t
         KzlBcRwsLNb6QPjFuWXF42CzdfFUewsRu1Y6ZClJhBMU47Jjzory8CvZdpSmbm4yxI
         jmnSEPMjJAmf7BQepzSPMdIi2K5RrbSs99f2Bp9ViHp0k3TVDOTTeWWyB13WFEwGGW
         e9FbBMXQJoQdqYLoMJa1PP/tojDac3ekIn3ESdu+HcmedkbdXrS1PhiqGd/RSXz4Uy
         ZhfAMuhtLFYuA==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, Faiz Abbas <faiz.abbas@arm.com>
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        kuninori.morimoto.gx@renesas.com, Anurag.Koul@arm.com,
        Deepak.Pandey@arm.com
In-Reply-To: <20230117061808.18422-1-faiz.abbas@arm.com>
References: <20230117061808.18422-1-faiz.abbas@arm.com>
Subject: Re: [PATCH v2] ASoC: dt-bindings: simple-card: Document
 simple-audio-card,plat
Message-Id: <167404935974.749539.3058245186501349723.b4-ty@kernel.org>
Date:   Wed, 18 Jan 2023 13:42:39 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-77e06
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Jan 2023 11:48:08 +0530, Faiz Abbas wrote:
> The simple card driver already has support for a simple-audio-card,plat
> property but its not reflected in the documentation. Add documentation
> for this plat property.
> 
> 

Applied to

   broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: simple-card: Document simple-audio-card,plat
      commit: e7e2b92e609f82cd164209509f852de941e1285b

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


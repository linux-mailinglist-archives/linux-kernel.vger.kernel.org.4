Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 480CD6D7C7C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 14:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237096AbjDEM0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 08:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237607AbjDEMZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 08:25:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB2AC5BB1
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 05:25:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 23FE461F20
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 12:25:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00FBEC433EF;
        Wed,  5 Apr 2023 12:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680697545;
        bh=bAwNBCT1MGIbFhfi1b8vQ7dGwmdleZML+qyHObqZRQk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=KPOtQy8Ee4LrHoVqOczsriag5PVojCKmXM94FJN53cCN/Kjhca3liQPkl1EK70DoR
         Jx6ap1CJdrLIJWJQUafLgOF43B1AMwDdDIKsTChWkKyqbGxpn+wZG/XYvHPteNrixv
         FX3o3y1OnI4dTIJylk4XYwRuprXpAcqbVD1I83P/da1l8nQRscfiUVKlYcJi5ttGrX
         ukqnp9uvc/IjzCVMNSm1G5GF6culM+CoEDjaz6nWDuszHwKMcR96tOCN99ustwAM2Z
         y5MjhdnhvizTLHtLpKGEfz7HKqHxX4KAHlVS+BFhLlnvt/wN/7pPZTFuoG9uKyhjPs
         a4I3oUAKayhAQ==
From:   Mark Brown <broonie@kernel.org>
To:     alsa-devel@alsa-project.org,
        Daniel Baluta <daniel.baluta@oss.nxp.com>
Cc:     linux-kernel@vger.kernel.org, cujomalainey@chromium.org,
        tiwai@suse.com, perex@perex.cz, kai.vehmanen@linux.intel.com,
        ranjani.sridharan@linux.intel.com, yung-chuan.liao@linux.intel.com,
        peter.ujfalusi@linux.intel.com, lgirdwood@gmail.com,
        pierre-louis.bossart@linux.intel.com
In-Reply-To: <20230405092655.19587-1-daniel.baluta@oss.nxp.com>
References: <20230405092655.19587-1-daniel.baluta@oss.nxp.com>
Subject: Re: [PATCH] ASoC: SOF: pm: Tear down pipelines only if DSP was
 active
Message-Id: <168069754270.50709.3405991457967735088.b4-ty@kernel.org>
Date:   Wed, 05 Apr 2023 13:25:42 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-00303
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 05 Apr 2023 12:26:55 +0300, Daniel Baluta wrote:
> With PCI if the device was suspended it is brought back to full
> power and then suspended again.
> 
> This doesn't happen when device is described via DT.
> 
> We need to make sure that we tear down pipelines only if the device
> was previously active (thus the pipelines were setup).
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: pm: Tear down pipelines only if DSP was active
      commit: 0b186bb06198653d74a141902a7739e0bde20cf4

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


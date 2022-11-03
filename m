Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 394DD6184E3
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 17:39:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232221AbiKCQj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 12:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbiKCQjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 12:39:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FC3D1EC4A;
        Thu,  3 Nov 2022 09:35:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5D5E161F5D;
        Thu,  3 Nov 2022 16:34:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC8E7C433D6;
        Thu,  3 Nov 2022 16:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667493294;
        bh=/ccW2ZLYtie//iuE3Z0X9cbimEJCwup/DH2xpMNHLnI=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=UWukCzRGudBv919/sH+I74MEzypxqLqYpIvPo+K0bDcfXWiWyDMyD6iMuQPIhOtL0
         j4uh5dfTRvuifo39nRCKLeELXdhbUdvDqp21GVSiXdyeYPTq93n+WF0rgsyWbgCfXD
         SBXLEtYj4br6ie5vVw7sXYuK7VX9ER1WKdtTmoHv4fjpuDQft3x17gxRFgbtk+xi0b
         Im+Y5+cO63sgDPY0pjSa3QvILW1IVRqPFAI4hfcCI4+l3d9bGe8h6OEh4OomJuuWoJ
         JRp0TswL+av9oAc+vtrBb0x1OV0OrmhaqdYrH7EPDTDMHp8DMNF8tXUaLv/Ia2g7IF
         sH9N9pR0bXD3A==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Colin Ian King <colin.i.king@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Brent Lu <brent.lu@intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        alsa-devel@alsa-project.org,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Takashi Iwai <tiwai@suse.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20221103120624.72583-1-colin.i.king@gmail.com>
References: <20221103120624.72583-1-colin.i.king@gmail.com>
Subject: Re: [PATCH] ASoC: Intel: cirrus-common: Make const array uid_strings static
Message-Id: <166749329166.480833.13410330883416925257.b4-ty@kernel.org>
Date:   Thu, 03 Nov 2022 16:34:51 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Nov 2022 12:06:24 +0000, Colin Ian King wrote:
> Don't populate the read-only const array uid_strings on the stack but
> instead make it static. Also makes the object code a little smaller.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: Intel: cirrus-common: Make const array uid_strings static
      commit: b43d0c0a42b2c44da824b3de0364d73be722a8c7

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

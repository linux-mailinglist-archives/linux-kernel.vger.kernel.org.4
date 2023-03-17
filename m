Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7759E6BEE9F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 17:41:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbjCQQlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 12:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbjCQQks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 12:40:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B80A860AA9
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 09:40:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5307F60B3B
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 16:40:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 161C2C4339B;
        Fri, 17 Mar 2023 16:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679071245;
        bh=wfMt2rqPVc8JIDu5zrxam2PXOGSEa4FBlP33E5oCfBM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=H9Yz3Jqyi6x+ITQuXlRg25ViG5PSiHTApwPXR35XydWhlsRUWQM+TbJ6Xj7z/IY0A
         MN3wOvlcK9xnW1J7L+p4iue7qA33FnQJvNuVicNnjkiqVOqm/kTiIh59fB2rV+IZOr
         8o/JdS/Q7hbfWt0LraQCFb1j4zkeLKzOYuOn32NTe8moHeFyxSB6K+LCm+TQWzCu6v
         5Uxl9vGarLGJ+YADVe9RKaa6cu9LEKaiWcl3Tje0HpLZ9EMiuO6uc73Sp/n7re+mCl
         GPz3yWfnn0XHiBJEuAPO0QTXfBlkVp4DgIon8nAihI5tivBowNHPP1F8D6GkIMEo20
         Ik5cUL/18cyHw==
From:   Mark Brown <broonie@kernel.org>
To:     gbrohammer@outlook.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
In-Reply-To: <PAVP195MB2261322C220E95D7F4B2732ADABC9@PAVP195MB2261.EURP195.PROD.OUTLOOK.COM>
References: <PAVP195MB2261322C220E95D7F4B2732ADABC9@PAVP195MB2261.EURP195.PROD.OUTLOOK.COM>
Subject: Re: [PATCH] ASoC: amd: yc: Add DMI entries to support Victus by HP
 Laptop 16-e1xxx (8A22)
Message-Id: <167907124480.46507.791817533962228386.b4-ty@kernel.org>
Date:   Fri, 17 Mar 2023 16:40:44 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bd1bf
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Mar 2023 00:38:51 +0200, gbrohammer@outlook.com wrote:
> This model requires an additional detection quirk to
> enable the internal microphone.
> 
> Tried to use git send-email this time.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: yc: Add DMI entries to support Victus by HP Laptop 16-e1xxx (8A22)
      commit: 205efd4619b860404ebb5882e5a119eb3b3b3716

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


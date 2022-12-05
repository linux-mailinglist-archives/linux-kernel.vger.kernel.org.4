Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE41C642EB9
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 18:29:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232141AbiLER3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 12:29:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231958AbiLER3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 12:29:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7BE7AE51;
        Mon,  5 Dec 2022 09:29:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 554C9611E8;
        Mon,  5 Dec 2022 17:29:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24E8AC433C1;
        Mon,  5 Dec 2022 17:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670261343;
        bh=9o+sSMrq9KvnPjqoO20e62XLRYjEsVjPF5T8c8sl2AI=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=egNrSPlAOL93I5JG/09Vuxnvw/YqWVYDq/oPwabaIgp8v+aTD1IqwlYTLtPZMzne2
         Nz4Xg82e6fiCIDhnCRhW01AVV3+gFdLB6z6FmKanPng7yMX794lup0NKNGVpUWOjnG
         l4zB8nYBmiNSzui2ZaMkE93Uw2FPmhFIb9tDVMNw7DrQh7lmtJBvHrSdF3X0ZfCOtE
         Z7ou2C57xHlPaspol+EeeAqaH1huH46yIOH6E7VQPq3AwYp67Y0Oza6TdTnNX667WK
         Lim3mOueKiIrh1mzRIk6i5U92ROURHdrob/POMNcYROTlgCE5qeXnh6ziJSAaA9X6w
         +CvREZ0dKxe4g==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>,
        Colin Ian King <colin.i.king@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org,
        Oder Chiou <oder_chiou@realtek.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
In-Reply-To: <20221202171450.1815346-1-colin.i.king@gmail.com>
References: <20221202171450.1815346-1-colin.i.king@gmail.com>
Subject: Re: [PATCH][next] ASoC: rt715: Make read-only arrays capture_reg_H and capture_reg_L static const
Message-Id: <167026134182.536379.4326237833077091583.b4-ty@kernel.org>
Date:   Mon, 05 Dec 2022 17:29:01 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Dec 2022 17:14:50 +0000, Colin Ian King wrote:
> Don't populate the read-only arrays capture_reg_H and capture_reg_L
> on the stack but instead make them static const. Also makes the
> object code a little smaller.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: rt715: Make read-only arrays capture_reg_H and capture_reg_L static const
      commit: b5d5051971b44c9952b62f261509cf837b9d21ba

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

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C55A666579
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 22:19:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234429AbjAKVTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 16:19:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235167AbjAKVTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 16:19:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91547193CF
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 13:19:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2F29661E6C
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 21:19:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0412C433D2;
        Wed, 11 Jan 2023 21:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673471973;
        bh=I6RVi3rMn06g5XGWsQnabnI2T34LE0uMNfo6RlULTGE=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=UtMvQGeJw9E3IdruelG3VenLhkQhouBDjy0/NDm0VRGsrFEZaZR10fw9/hAvQOcpz
         67i7BDkOspLZ4ShVUQoBzfuNhpZuwVLkIkGpHm/ImDav3TJaKWBvz4EaMrHnfJq77S
         LW4N+L0/RVgomp0zyVaKqKRQ1KnXxUuGHPlCkwM+mHHs3x4/Dts1IVDm0OQcO2WZz/
         s1134IINUELVjACdqSAO0vIY9vMFBfmshG012sHxX+5iXGM/s0c8nwRkwIfAEPoDFG
         2c7JGPQhGX60eJ+NWiPYWC8Fq7Nx95W+V1GFDQHkBtBIbYWwN+hma7DTYSoL0uTZHm
         77ZCWB1Qs1Tdw==
From:   Mark Brown <broonie@kernel.org>
To:     alsa-devel@alsa-project.org,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>
Cc:     Vijendar.Mukunda@amd.com, Basavaraj.Hiregoudar@amd.com,
        Sunil-kumar.Dommati@amd.com, shansheng.wang@amd.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        linkt <xazrael@hotmail.com>,
        Xiaoyan Li <lxy.lixiaoyan@gmail.com>,
        Leohearts <leohearts@leohearts.com>,
        Artem Lukyanov <dukzcry@ya.ru>,
        Brent Mendelsohn <mendiebm@gmail.com>,
        open list <linux-kernel@vger.kernel.org>
In-Reply-To: <20230111102130.2276391-1-Syed.SabaKareem@amd.com>
References: <20230111102130.2276391-1-Syed.SabaKareem@amd.com>
Subject: Re: [PATCH] ASoC: amd: yc: Add DMI support for new acer/emdoor platforms
Message-Id: <167347197037.2692419.7705644270342223963.b4-ty@kernel.org>
Date:   Wed, 11 Jan 2023 21:19:30 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-8b3d1
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Jan 2023 15:51:23 +0530, Syed Saba Kareem wrote:
> Adding DMI entries to support new acer/emdoor platforms.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: yc: Add DMI support for new acer/emdoor platforms
      commit: 7fd26a27680aa9032920f798a5a8b38a2c61075f

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

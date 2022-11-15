Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD628629F44
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 17:42:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238725AbiKOQmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 11:42:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238705AbiKOQmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 11:42:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5853B2B628
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 08:42:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 14DD8B816DA
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 16:42:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73785C4314D;
        Tue, 15 Nov 2022 16:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668530531;
        bh=LNHlirObCpIamiHi9qypUAFL9NzP+pKUa7A+X+ZOUOU=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=if+8LcdZ9DIbe+56rjY2IIv+yE91gFSlSJ1DOOlZv3gZMw8bY/e0WwCA6QKD22STf
         c6p/tgl8JcjjRr4SmBgHImVrSOqTSNJoNKapBsOTztoZLJP+pCTNDDXopROMaK3i6Q
         BlagDP3ZBehy83Sxf4yhWc+y4k4wmPedpZ9yQWBAwW2mEfrV46S10FXjTCWT6lmnEi
         4KVmH3WAX8kkrI4J58690z37Ei5wHr/ccvBBH0LPgqvpvNerPDDHTgAfQvO5ME5IcZ
         80rC6mJdbxnHFDgtTvnvFeHhl7HPi907vHOEgB1yPEUIEpbDERZDs2tUpwhZs9c06R
         ixJHM+VSXNigg==
From:   Mark Brown <broonie@kernel.org>
To:     tiwai@suse.com, lishqchn <lishqchn@qq.com>, perex@perex.cz
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        lgirdwood@gmail.com
In-Reply-To: <tencent_59850BB028662B6F2D49D7F3624AB84CCF05@qq.com>
References: <tencent_59850BB028662B6F2D49D7F3624AB84CCF05@qq.com>
Subject: Re: [PATCH] Asoc: core: fix wrong size kzalloc for rtd's components member
Message-Id: <166853052864.230692.17624573785284559319.b4-ty@kernel.org>
Date:   Tue, 15 Nov 2022 16:42:08 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-8af31
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Nov 2022 12:24:56 +0800, lishqchn wrote:
> The actual space for struct snd_soc_component has been allocated by
> snd_soc_register_component, here rtd's components are pointers to
> components, I replace the base size from *component to component.
> 
> 

Applied to

   broonie/sound.git for-next

Thanks!

[1/1] Asoc: core: fix wrong size kzalloc for rtd's components member
      commit: 66a796c04b639e2658b4d820dd5fbc842c8c3aae

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

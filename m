Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 629EB642EB6
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 18:29:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232016AbiLER3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 12:29:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbiLER3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 12:29:03 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD0E6432;
        Mon,  5 Dec 2022 09:29:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0CC87B80E98;
        Mon,  5 Dec 2022 17:29:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBBF0C433D6;
        Mon,  5 Dec 2022 17:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670261339;
        bh=qEvLyHNV7Ss9WZ2ubeO4+eopAKpla3iPV1553qghz4o=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=BWL/d3p+lHPnnOOSGwKOFAExfqjSlNsa7uTFSPirBXhEJTLWWQSD5zOjMJAIU4P23
         RSVYC41HWAiFZQn0DmPL1F8Vjt7yQqI08QAnSO3smdw5qRSyHNTbQw+aLxDx4P5leb
         Rfj0JMnRvsqGx75rDutGrq58CIpTcL8oWAj2nv/IPehUau4SbXawi2msOdq1Rhojw3
         EWhAZ+bhByjQqcFAxk9sBbM+fSvCiyI/A9FMsP+zcj4MolizM2CeVDt6faXhYXZUEZ
         r1T60gwbI1ofv+rStgaj6SAWyAEcp43Hc3GEhmcGWpiarRtFoVnqJ6sWWd8Vh1J8Ad
         veVGVYvLDi/9Q==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        linux-arm-kernel@lists.infradead.org,
        Takashi Iwai <tiwai@suse.com>,
        Colin Ian King <colin.i.king@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
In-Reply-To: <20221202164156.1812971-1-colin.i.king@gmail.com>
References: <20221202164156.1812971-1-colin.i.king@gmail.com>
Subject: Re: [PATCH][next] ASoC: uniphier: aio-core: Make some read-only arrays static const
Message-Id: <167026133758.536379.12650121708842082067.b4-ty@kernel.org>
Date:   Mon, 05 Dec 2022 17:28:57 +0000
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

On Fri, 2 Dec 2022 16:41:56 +0000, Colin Ian King wrote:
> Don't populate the read-only arrays slotsel_2ch, slotsel_multi, v_pll
> and v_div on the stack but instead make them static const. Also makes
> the object code a little smaller.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: uniphier: aio-core: Make some read-only arrays static const
      commit: cb870fdcf1332ee791d7de6bbf350f15fc19c989

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

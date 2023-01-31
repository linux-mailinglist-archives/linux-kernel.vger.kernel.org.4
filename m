Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3778C682F4A
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 15:32:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbjAaOcc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 09:32:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjAaOcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 09:32:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB45F2D56
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 06:32:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4693061444
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 14:32:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1DBCC433EF;
        Tue, 31 Jan 2023 14:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675175549;
        bh=Tn+0ChE4NWLr1lne+v5CorulaUB++qNmFcq2U3U5Ub8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=bSqK5/QUylC2NfQKLm6W2zyDrtNpfgRQVv+wpXzzthJFkJansSzrblzel+BFf86CC
         AogqKKfdpjztGW6ufG4Ql0aumbeRcT+3wZIDLWPrpAjBfJw1exlOcJp1f+iBv7P6sj
         PRyMvlCxSvzj4Yuplej+0Hb2V14PtmsSs1SzTPGBG2MpfxiruguOpYO5Ohu5COoWvE
         Kzx73gM8da5qkaXRfRtbf6LQOdBQakHsN4STNd7V3TGm8JVWpPjlQHjlQta/MewQmT
         btLDzqztOaajuV2EuHjxikIh2eNLjvmyoUu1ZvDgqekVXxlynWkWdBNsCGcbUfIVOR
         /ZkkJCp3xIsmQ==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230130120647.638049-1-claudiu.beznea@microchip.com>
References: <20230130120647.638049-1-claudiu.beznea@microchip.com>
Subject: Re: [PATCH 0/8] ASoC: mchp-spdifrx: add runtime PM support and
 fixes
Message-Id: <167517554751.691025.3083822887476196230.b4-ty@kernel.org>
Date:   Tue, 31 Jan 2023 14:32:27 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Jan 2023 14:06:39 +0200, Claudiu Beznea wrote:
> This series adds runtime PM support for Microchip SPDIFRX driver.
> Along with it I added few fixes identified while going though the code
> and playing with Microchip SPDIFRX controller.
> 
> Thank you,
> Claudiu Beznea
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/8] ASoC: mchp-spdifrx: fix controls which rely on rsr register
      commit: fa09fa60385abbf99342494b280da8b4aebbc0e9
[2/8] ASoC: mchp-spdifrx: fix return value in case completion times out
      commit: a4c4161d6eae3ef5f486d1638ef452d9bc1376b0
[3/8] ASoC: mchp-spdifrx: fix controls that works with completion mechanism
      commit: d3681df44e856aab523a6eb7ba15b5e41efcbb1c
[4/8] ASoC: mchp-spdifrx: disable all interrupts in mchp_spdifrx_dai_remove()
      commit: aaecdc32b7e35b4f9b457fb3509414aa9a932589
[5/8] ASoC: mchp-spdifrx: use unsigned long to store clk_get_rate() value
      commit: 36187a67ab931eae8b7d13d80fccd097971b7bac
[6/8] ASoC: mchp-spdifrx: remove struct mchp_spdifrx_dev::fmt member
      commit: ddce4aeccacb6f575cbfad623da5f0deb2592baf
[7/8] ASoC: mchp-spdifrx: add runtime pm support
      commit: c7db2a59438959bc881bc5722abf0d0a38681c2b
[8/8] ASoC: mchp-spdifrx: document data structures
      commit: 514d7f9df3f409cbb0ad59e726b4923d83251e4f

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


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E49775BD7E2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 01:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbiISXLR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 19:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbiISXKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 19:10:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE5C501BB
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 16:10:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 22D1762103
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 23:10:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D50C7C433C1;
        Mon, 19 Sep 2022 23:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663629038;
        bh=hJVCV38OsTD8Qec8wIU6hogxK5tFSOL11311yWaypDc=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=BPQaqEOG9yS8rppRTCAingKPT1rEggTJ5D56NivgIp7wBLgAs7QYGp+bqL66YZu6F
         Cl3Q52oIbUkmbRxwoIVpGaTXc8pqXwgy4aKDML1nD2XpiXUZTFCDAnTTrrAwPs+S38
         2GroimWVRGEG1kV72qj2vSK9cDgRWS4TcFtIrdx1KrrmLYSGL46SUFJpnkvryI1CXX
         mr8rD3s0MEENx0CNpKFjh4mWuRJv0nUc8CBY9lUA/sWO/xU2H4A2++rcLj+vfLUb08
         lU82OZS1Dp3SwfPjT+asQd1J85TIMY+lWswlMHRCS9JbUpOfqPmT8JS5pip8hjsemL
         +ingF7hWzTetw==
From:   Mark Brown <broonie@kernel.org>
To:     Ban Tao <fengzheng923@gmail.com>, tiwai@suse.com,
        jernej.skrabec@gmail.com, perex@perex.cz, wens@csie.org,
        lgirdwood@gmail.com, samuel@sholland.org
Cc:     alsa-devel@alsa-project.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
In-Reply-To: <1662965133-9232-1-git-send-email-fengzheng923@gmail.com>
References: <1662965133-9232-1-git-send-email-fengzheng923@gmail.com>
Subject: Re: [PATCH v10 1/2] ASoC: sunxi: Add Allwinner H6 Digital MIC driver
Message-Id: <166362903557.3419825.16271698266966070815.b4-ty@kernel.org>
Date:   Tue, 20 Sep 2022 00:10:35 +0100
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

On Sun, 11 Sep 2022 23:45:33 -0700, Ban Tao wrote:
> The Allwinner H6 and later SoCs have an DMIC block
> which is capable of capture.
> 
> 

Applied to

   broonie/sound.git for-next

Thanks!

[1/2] ASoC: sunxi: Add Allwinner H6 Digital MIC driver
      commit: 9fc2c8ed923d8ec8a49cf5b5076c84867126ca69

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

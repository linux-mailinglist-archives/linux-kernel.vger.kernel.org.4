Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEDE0686D17
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 18:33:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbjBARdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 12:33:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbjBARd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 12:33:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0295A7D9AD;
        Wed,  1 Feb 2023 09:32:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EEC88B820FE;
        Wed,  1 Feb 2023 17:32:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF9AFC4339B;
        Wed,  1 Feb 2023 17:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675272730;
        bh=XmgwpHMXcx6cF7ZijRoo32yT2OPtby/iS7JRxHm+vcU=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=dZa9bnsdKvTcbbtInRJQG2M6gM3Vf4mOLCSw1WFkXRJDJ/dPNRb0j+ib2Tth+Bgkx
         UilPN9t0FLNqmuiPBqKaxWjju+HJMAGVDyPWEv+h7LbcC1LSXSlfCSyUqb5qkQ60F+
         KM+3plbkdoXNde0GVdNO5SzbpH7jlSyWzC0hh3QGl98V2VRJLaziY5Ry9bGyXUeg9D
         y/weQ0eEzfsUf93tIf74xui8dSpxpQ+J5YAQBhVS7woZ42CA7xUoxNqptHCxhQDgph
         GivhUf53eRYD4UpO/m4Qo+0EHBtzxTgFk5pBqpoGbfSEc1AnICxQGab8xo7f+ngkho
         w+U2hHmzxBBkA==
From:   Mark Brown <broonie@kernel.org>
To:     paul@crapouillou.net, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, linux-mips@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Christophe Branchereau <cbranchereau@gmail.com>
In-Reply-To: <20230122210703.2552384-1-cbranchereau@gmail.com>
References: <20230122210703.2552384-1-cbranchereau@gmail.com>
Subject: Re: [PATCH] ASoC: codecs/jz4760: add digital gain controls
Message-Id: <167527272868.579168.13652532030958567402.b4-ty@kernel.org>
Date:   Wed, 01 Feb 2023 17:32:08 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 22 Jan 2023 22:07:03 +0100, Christophe Branchereau wrote:
> Both the DAC and ADC have digital gain controls available
> for their mixers, which go from -31 to 0db by step of 1db.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs/jz4760: add digital gain controls
      commit: 36acae192d65195342d02595f45e404cc0f2eca0

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


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61C737504C0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 12:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232463AbjGLKg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 06:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232441AbjGLKgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 06:36:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 139B81BFA
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 03:35:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AD0C361692
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 10:35:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85CA6C433C7;
        Wed, 12 Jul 2023 10:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689158149;
        bh=lHK5DMy1f13ZhJUQa8A7mt5eGqFKGXp1/kFQM9wbfN8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=rSC9H4cxTzxiumnizY9l+2BYu1pYgjw1kXJMien8h3COGjmwAXqbRpN46tUpoii22
         HAgCNFUp4KNNMxIzFvzPn65XqFf36vfDpKTQMCqmyIb5x+VBQhugwe5eDp9Lr+iU+H
         cdabMibuNoK4v38c7t4I2QvHAPVjpNtp0Un6obYeBIQjlcpE867zkdwbP0Zq6wAAQs
         Ee6wCn74T00ijfLpDCUTWcXjE1LGNbCwR00NJr96eAsBYs4B7aegxUWWeHL0qOKZiF
         dSKTQV/luAJHAZKGjh7P+UZQDS1D4Q31PoRbf8j9d5QBBjcTxy6a9Y06ULbMeX8UBo
         yJ+r+nQzlYgrw==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de
In-Reply-To: <20230626091544.557403-1-u.kleine-koenig@pengutronix.de>
References: <20230626091544.557403-1-u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] regulator: raa215300: Switch back to use struct
 i2c_driver::probe
Message-Id: <168915814709.10612.12478883048276174326.b4-ty@kernel.org>
Date:   Wed, 12 Jul 2023 11:35:47 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13-dev-099c9
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Jun 2023 11:15:44 +0200, Uwe Kleine-König wrote:
> struct i2c_driver::probe_new is about to go away. Switch the driver to
> use the probe callback with the same prototype.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: raa215300: Switch back to use struct i2c_driver::probe
      commit: 741da3f60479acc0de3d79501c4819e49fa28639

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


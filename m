Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E310167F742
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 11:48:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234222AbjA1KsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 05:48:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234119AbjA1KsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 05:48:16 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D8013539
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 02:48:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 5FC81CE08D5
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 10:48:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FDCAC433D2;
        Sat, 28 Jan 2023 10:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674902892;
        bh=LB9X3YXhGHVA4+HBj5qChWyiXDOkHfo5jifjX83LeIk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=IgdjBmFYRkCNLi5IKKSHZXEDdnYm/3hVayl0KPMpxEE4AXOcnYMVlxAA0T+md9Use
         4y3m1pzhMofbmziB+aMF3DOYrmOJjukVU3p1uQ5c1IgWqDVVS2d+nOcgqidbQuF5RP
         ob+C8rpfadYr+jXgltheARoKd3AX334Dl85cg7zGiHce1ar7z5fqb0YCTMtWoklVzt
         Da4wtKl2eur8XuStrPgab/PIi0wOEc8C+zt5zDj05d7mmDiOxCiV1/l6j70aQWemBj
         Fhp/yOg+o+BwomZzmS7+CGbRZPTRPH2Rd6XflSBIIXxQOqH7/KqdT1TF3JjZK7pl7E
         DKChQog0sMQTw==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de
In-Reply-To: <20230127101726.1313927-1-u.kleine-koenig@pengutronix.de>
References: <20230127101726.1313927-1-u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] regulator: max20411: Convert to i2c's .probe_new()
Message-Id: <167490289112.2145956.17807660921566308845.b4-ty@kernel.org>
Date:   Sat, 28 Jan 2023 10:48:11 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Jan 2023 11:17:26 +0100, Uwe Kleine-König wrote:
> The probe function doesn't make use of the i2c_device_id * parameter so
> it can be trivially converted.
> 
> 

Applied to

   broonie/regulator.git for-next

Thanks!

[1/1] regulator: max20411: Convert to i2c's .probe_new()
      commit: fad8ddda1c40c00bff4ac45eb9b85e1f717f17f4

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


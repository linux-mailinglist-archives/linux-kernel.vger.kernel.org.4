Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83F4F656A32
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 12:58:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231785AbiL0L6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 06:58:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232001AbiL0L5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 06:57:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B555B481;
        Tue, 27 Dec 2022 03:57:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 14D34B80F9F;
        Tue, 27 Dec 2022 11:57:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F42DC433D2;
        Tue, 27 Dec 2022 11:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672142263;
        bh=XEY00UJGVEilypSNo3qCX4Bi19Op389MXWhwCRixKPs=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=d6sYGprSOwDPnlA77oi0xaeENJ6fvU7OELgTWqw53Ny/P4zLEF7TpgObc90By7d5e
         NGLv8nWYVCZhtJAmoxKSZCRg2wsEt/LQgtqecYapZ722iDxJsczy73M3q3C5dq34QX
         Tcq2+RFVOrj3HDyNSluMdAJl74i5nBcDAMOt0gccpnsHVayvRNxgFCjZBl5EYEsBN6
         rw9ApURqjsOWbhcji82KEghO7J1uqrX6Wv2VkorolSZgoDlJPGOlejdYZEk5Mzmh8U
         rgPapPEjmFxo4a2/bTouYoI/8hXaA0/rux6++U6ziveLkTcnGZ5q8q1m4Dw28yX5qO
         x58NuscfltJUA==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>
Cc:     list@opendingux.net, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
In-Reply-To: <20221214155152.14349-1-paul@crapouillou.net>
References: <20221214155152.14349-1-paul@crapouillou.net>
Subject: Re: [PATCH v4] regulator: dt-bindings: Convert active-semi PMIC docs
 to YAML schemas
Message-Id: <167214226204.87975.1012017619670810099.b4-ty@kernel.org>
Date:   Tue, 27 Dec 2022 11:57:42 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-7ab1d
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Dec 2022 16:51:52 +0100, Paul Cercueil wrote:
> Create YAML bindings for the Active-semi PMICs and remove the old text
> files.
> 
> The bindings aren't perfect, for instance I couldn't find good
> descriptions for the vendor properties in the "charger" node of the
> ACT8945A because I am not familiar with the hardware and these
> properties were not documented anywhere.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: dt-bindings: Convert active-semi PMIC docs to YAML schemas
      commit: 413ec72963fc297f419a3d5f931bb43921969749

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

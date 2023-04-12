Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE8C86DFB6C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 18:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbjDLQe3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 12:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjDLQe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 12:34:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FFB69C;
        Wed, 12 Apr 2023 09:34:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AF00D62D59;
        Wed, 12 Apr 2023 16:34:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EF95C433D2;
        Wed, 12 Apr 2023 16:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681317266;
        bh=1IzJdqjARMlMU8tKfWoDMltgJOS9G7BGzofhQ14iq68=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Kkb93wjCyNcUfXAcjoJys8LwT5lbKW8HChBhoEw7HXjowYIZCn3BcCiPZirC7vULb
         A5Bgp8igqSznTUtaklKKWbHVN1tF3uiipftMB15A3NUdZvy9XI7hw8GUo0OhG2fVb5
         kX4fL4MHBJVjOLu2irBMivceI56oZnU3jqcOhyOoGvCzq05XKKNmdvczqiC8Aah8Il
         IaJq0yDiplhOL/1UuQXiSobQJz+BaSbWgx/4w6RFwQIGQN7KKbwPHxpboNiu6IyssH
         /YhjLfB4DPp+ORA99BclIIWsvrXC25hsSlrZZ94FhlPkdJNDgXVQGOCYvIpxTex5AD
         FNd1nATOppWCw==
From:   Mark Brown <broonie@kernel.org>
To:     Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Steve Twiss <stwiss.opensource@diasemi.com>,
        Benjamin Bara <bbara93@gmail.com>
Cc:     DLG-Adam.Thomson.Opensource@dm.renesas.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Benjamin Bara <benjamin.bara@skidata.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20230403-da9063-disable-unused-v3-0-cc4dc698864c@skidata.com>
References: <20230403-da9063-disable-unused-v3-0-cc4dc698864c@skidata.com>
Subject: Re: [PATCH v3 0/3] regulator: da9063: disable unused voltage
 monitors
Message-Id: <168131726333.91225.1829664211081647779.b4-ty@kernel.org>
Date:   Wed, 12 Apr 2023 17:34:23 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-00303
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 05 Apr 2023 19:14:33 +0200, Benjamin Bara wrote:
> Follow-up for my initial patch regarding the disabling of unused
> voltage monitors. We use the PWR_OK functionality, which asserts GP_FB2
> if every monitored voltage is in range. This patch should provide the
> possibility to deactivate a voltage monitor from the DT if the regulator
> might be disabled during run time. For this purpose, the regulator
> notification support is used:
> https://lore.kernel.org/all/cover.1622628333.git.matti.vaittinen@fi.rohmeurope.com/
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/3] regulator: da9063: add voltage monitoring registers
      commit: 13186dae182ab1a2a52a53424672f49cf3e81f9b
[2/3] regulator: da9063: implement setter for voltage monitoring
      commit: b8717a80e6ee6500ae396d21aac2a00947bba993
[3/3] dt-bindings: mfd: dlg,da9063: document voltage monitoring
      commit: 0271b61ba3bb06fff4726951667f46e68412b8c2

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


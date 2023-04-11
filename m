Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11F716DE290
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 19:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbjDKReA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 13:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbjDKRd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 13:33:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 331A459CA;
        Tue, 11 Apr 2023 10:33:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A9DDA62018;
        Tue, 11 Apr 2023 17:33:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40F3AC433EF;
        Tue, 11 Apr 2023 17:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681234428;
        bh=iEXSKNbC985Lxi/M/SXjfyiLy2lPpRmyV98zFwJJvns=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Chdu1WdsYBzm0fuPoVmMtmRbTkF31qUiFmwToGqm+gcugHSCAFxN5i5RNlAfWCcSC
         6v5FB9FI/FcevYOgCwIXD421Py/dfmfqIJoIvrvLtrSYiAJBGvmeyXFgCPI8pKpFQg
         +H2vgpsN2ysiRN5t/SGThP9gm6LVgTX0/4OZGbaPA3K0+Tkga73gV7T9AQd7x3pfE/
         wixhcnuI9K2EgurJ+PzMoxsTUICzDnDHbRK9af3JO68zmuVpE9M2hoyd+rGcmAC3A0
         /FZfpiz/EEDjsOzwgituEcuLltlzzxkdJ2vpI4E6rErH/i3WDuFIdSbBBbkg670eyy
         vXdFOCjKgYzYQ==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, daniel.baluta@nxp.com,
        Saalim Quadri <danascape@gmail.com>
Cc:     patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230405203419.5621-1-danascape@gmail.com>
References: <20230405203419.5621-1-danascape@gmail.com>
Subject: Re: [PATCH] ASoC: dt-bindings: wm8523: Convert to dtschema
Message-Id: <168123442597.491748.3278236721968610950.b4-ty@kernel.org>
Date:   Tue, 11 Apr 2023 18:33:45 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-00303
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 06 Apr 2023 02:04:19 +0530, Saalim Quadri wrote:
> Convert the WM8523 audio CODEC bindings to DT schema
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: wm8523: Convert to dtschema
      commit: 3e5f79723dc3f22fed30ba5a559db11b53b632ae

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


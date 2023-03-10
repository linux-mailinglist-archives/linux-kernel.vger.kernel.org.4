Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62CD36B493E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 16:10:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233807AbjCJPKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 10:10:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233751AbjCJPK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 10:10:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68EA012DDD8;
        Fri, 10 Mar 2023 07:02:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CAD3C6187C;
        Fri, 10 Mar 2023 15:02:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80517C4339C;
        Fri, 10 Mar 2023 15:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678460558;
        bh=4nO6S7AVKJRkqUospk0gd3rr/UVmqm229W5wXjOFSqU=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=aInGjzrM0pCcji/YZ458YXHR90uLPoDBXPhufKIlVHPF1oUYsOmmdDfPDnJnymjPS
         UPCWykKdDBlosBZCTOoGVn1OSgobEzk1joCjc06+G+rntnOlyY6vaCPAOyp6Nn8qJb
         ofguEF1TwOAv6Lt3moUg6h3+E2KyIBflz/HUM+Ri5+Kfr+c3Q2+t8dlY/8rblXzje6
         A9Yp1H0hHnQZ+EA53Xt5Nn4qbBr3IUp98y/Vfv6i3vS+GnuM9L4Rbn52MHYDbM82ak
         cUMUvchz4BPKuQ9NDxqgrhy0LPbQTFjZINV6ndYWXuUJZTO+8AREyTxD9PQzz9PThO
         ghTAnWA/kFlqw==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, perex@perex.cz, tiwai@suse.com,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20221213112851.89212-1-claudiu.beznea@microchip.com>
References: <20221213112851.89212-1-claudiu.beznea@microchip.com>
Subject: Re: [PATCH v3 0/4] ASoC: microchip: power saving features and
 cleanups
Message-Id: <167846055521.924369.14328317678015706144.b4-ty@kernel.org>
Date:   Fri, 10 Mar 2023 15:02:35 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bd1bf
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Dec 2022 13:28:47 +0200, Claudiu Beznea wrote:
> The following series adds runtime PM and suspend to RAM features for
> mchp-pdmc driver.
> 
> Along with it 2 cleanup patches were added:
> - patch 1/4: use vendor,device.yaml file format for Microchip AT91 ASoC
>   bindings
> - patch 4/4: use FIELD_PREP() in mchp-spdiftx.c
> 
> [...]

Applied to

   broonie/sound.git for-next

Thanks!

[1/4] ASoC: dt-bindings: microchip: use proper naming syntax
      (no commit info)
[2/4] ASoC: mchp-pdmc: use runtime pm for clock power saving
      (no commit info)
[3/4] ASoC: mchp-pdmc: add support for suspend to RAM
      (no commit info)
[4/4] ASoC: mchp-spdiftx: use FIELD_PREP() where possible
      commit: 28ce5698456ab53540093836c6fee15119cf1821

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


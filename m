Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF19E5BD7E5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 01:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbiISXL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 19:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbiISXK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 19:10:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C4ED50732;
        Mon, 19 Sep 2022 16:10:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 39AC4B821D6;
        Mon, 19 Sep 2022 23:10:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08E82C43470;
        Mon, 19 Sep 2022 23:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663629041;
        bh=b1MqEh6B42D87J4TSbATtghLyrLWxYN99xDJ54qoJjU=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=KI1qtB8dtbf2FWe6H6nRxplkR+NFVCp3Fa07+UpVQle4opGMzGzwsl7MKYGYnmQs+
         Mhk9JCWW2EDm3w8V7xI5QXHzf2VwBS/dWd03/tgajaTxJ8+ToxR9MtEPf4YlPxR/j8
         U3MBfXV0vt73WHMLljw6baL9kynOtDE2Zxv/x/BrgsDrauzgreTminioG5Sxr2vaqL
         XJe2gEuEHNlsgfBoNnN6DoYtWh4FBx2yZsHcDFP25wNeR1Qp734KFoGd3554cLOX02
         xgqopEYOSK6Zaa+SuYAl173l9b8QhlIFPf4P2UJQr92xIdOrzKWbkF3pGaQh6GK3y6
         1sMPXQ+BtELVQ==
From:   Mark Brown <broonie@kernel.org>
To:     Ban Tao <fengzheng923@gmail.com>, robh+dt@kernel.org,
        jernej.skrabec@gmail.com, wens@csie.org, lgirdwood@gmail.com,
        alsa-devel@alsa-project.org, krzysztof.kozlowski+dt@linaro.org,
        samuel@sholland.org
Cc:     devicetree@vger.kernel.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
In-Reply-To: <1662966333-18000-1-git-send-email-fengzheng923@gmail.com>
References: <1662966333-18000-1-git-send-email-fengzheng923@gmail.com>
Subject: Re: [PATCH v10 2/2] ASoC: sun50i-dmic: dt-bindings: add DT bindings for DMIC controller
Message-Id: <166362903874.3419825.606503427543635077.b4-ty@kernel.org>
Date:   Tue, 20 Sep 2022 00:10:38 +0100
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

On Mon, 12 Sep 2022 00:05:33 -0700, Ban Tao wrote:
> DT binding documentation for this new ASoC driver.
> 
> 

Applied to

   broonie/sound.git for-next

Thanks!

[2/2] ASoC: sun50i-dmic: dt-bindings: add DT bindings for DMIC controller
      commit: 5cf934e84659ca2f03db6254978d56f053745366

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

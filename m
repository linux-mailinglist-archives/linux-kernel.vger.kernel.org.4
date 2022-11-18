Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05A0262F6C0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 15:04:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242103AbiKROEd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 09:04:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235225AbiKROEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 09:04:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6841A31DE3;
        Fri, 18 Nov 2022 06:04:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 29AE2B823FD;
        Fri, 18 Nov 2022 14:04:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12590C433C1;
        Fri, 18 Nov 2022 14:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668780266;
        bh=2Etd7TTDGGQdc+eZ6ZY5zWcGDhXbE1E4P6nTodPzyHM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=LRI94Akwvj+M1u5ha7m2UTmQseNSMmZGrna/rH7PvgMy8dtRQjFvQDA0s0WS+6zA/
         xnyKsxczpvoukVdGYFFB6gPQMvmZ775/Ou2z9q1Ps39mgH2scRVlufQcyziWsPVmf1
         QuaHzmC13ig/Z4hNHDe1Z3uVcKaAlr58rB+giU71yHQtGEfTXIGLhAa9XC/WH8a2Wn
         tilnZAKph7ZPV8u+B2bJnyEbAS5XYun9zaySnnnlKMPf9YPJqve83vLjXyfsXuJjas
         0vBBmm1WefiNyE3qCSUTvaAGgSdv3WZanZrGfOmgrX6UbofbfKojgmUpyKlfirqKjH
         GXkSsVxQmHwkg==
From:   Mark Brown <broonie@kernel.org>
To:     Ban Tao <fengzheng923@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
        Rob Herring <robh+dt@kernel.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
In-Reply-To: <20221116034621.37762-1-samuel@sholland.org>
References: <20221116034621.37762-1-samuel@sholland.org>
Subject: Re: [PATCH] ASoC: dt-bindings: sun50i-dmic: Add D1 compatible string
Message-Id: <166878026369.872655.5958604584244669942.b4-ty@kernel.org>
Date:   Fri, 18 Nov 2022 14:04:23 +0000
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

On Tue, 15 Nov 2022 21:46:21 -0600, Samuel Holland wrote:
> The Allwinner D1 SoC has a DMIC codec like the one in the H6. It appears
> to be register-compatible with the H6 variant, and the existing Linux
> driver has been tested on a D1-based board, the Lichee RV 86 Panel.
> 
> 

Applied to

   broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: sun50i-dmic: Add D1 compatible string
      commit: b1af5b34d6b315ed34abb0fa9049bcf1babbd537

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

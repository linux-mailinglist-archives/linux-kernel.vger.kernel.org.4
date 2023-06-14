Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D9B77307AE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 20:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbjFNS66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 14:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjFNS6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 14:58:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDAF61A2;
        Wed, 14 Jun 2023 11:58:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 836F563F97;
        Wed, 14 Jun 2023 18:58:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B349AC433C0;
        Wed, 14 Jun 2023 18:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686769133;
        bh=MfSKiNLW05mGERHuhnhNQwVvkL/xDekK9aIDFT1YmyY=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=gITfLP0cyNOegD3RzZ0W7wpNlcNkVWbeldroFc5bQitzS9v2ZpRSYmczk4VLjIySf
         8d4mheEHIEn2A65saVCWeacvuCvPy0nmh9Y5GhzG5buCLw9TFB4k7DwAi3uvpALylt
         PrXUMK5fC3ygWc7BhxrkBsJILcMfRtwqChmYzy/JgJNnQWPnLZOHH7kMR9o2yYRAoY
         +q3BW2ADxDP+XsPxReKhoFdL4+GAUQbsw6NRXi0ZL5Ppojmc0kM1go7PxV3quzdGN9
         dJOhpep16rF6oPFN6YsJgXhz+wUMkaVs11q7BqmKgT/urfFaoBhLr3cA3omK3ANIFu
         2U6ZT43SBeK6g==
From:   Mark Brown <broonie@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chen-Yu Tsai <wenst@chromium.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230609083009.2822259-1-wenst@chromium.org>
References: <20230609083009.2822259-1-wenst@chromium.org>
Subject: Re: (subset) [PATCH 0/9] regulator: mt6358: Remove bogus
 regulators and improvements
Message-Id: <168676913142.240711.16106112357976617882.b4-ty@kernel.org>
Date:   Wed, 14 Jun 2023 19:58:51 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-c6835
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 09 Jun 2023 16:29:57 +0800, Chen-Yu Tsai wrote:
> This series is a cleanup and improvement of the MT6358 regulator driver.
> Various discrepancies were found while preparing to upstream MT8186
> device trees, which utilize the MT6366 PMIC, that is also covered by
> this driver.
> 
> Patches 1~8 should go through the regulator tree, and patch 9 through
> the soc tree. This series (patches 7 and 8) depends on "regulator: Use
> bitfield values for range selectors" [1] I sent out earlier.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/9] regulator: dt-bindings: mt6358: Merge ldo_vcn33_* regulators
      commit: a74d4c577c60b27fc57ea734ef8275921ae8dcb2
[2/9] regulator: dt-bindings: mt6358: Drop *_sshub regulators
      commit: 82f305b18eb0505444eab8ac86bfa134b67cb38e
[3/9] regulator: mt6358: Merge VCN33_* regulators
      commit: 65bae54e08c109ddbbf121bb00058cf3b3fb7b8e
[4/9] regulator: mt6358: Drop *_SSHUB regulators
      commit: 04ba665248ed91576d326041108e5fc2ec2254eb
[5/9] regulator: mt6358: Const-ify mt6358_regulator_info data structures
      commit: 1ff35e66cae53f7090a671afddaee45d4ccd9396
[6/9] regulator: mt6358: Use linear voltage helpers for single range regulators
      commit: ea861df772fd8cca715d43f62fe13c09c975f7a2
[7/9] regulator: mt6358: Add output voltage fine tuning to fixed regulators
      (no commit info)
[8/9] regulator: mt6358: Add output voltage fine tuning to variable LDOs
      (no commit info)

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


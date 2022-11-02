Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CDAF6168DC
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 17:30:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231875AbiKBQaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 12:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231871AbiKBQ3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 12:29:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D697910FD8;
        Wed,  2 Nov 2022 09:25:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6326A619EF;
        Wed,  2 Nov 2022 16:25:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EEC7C433D7;
        Wed,  2 Nov 2022 16:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667406355;
        bh=+g1CgBWkIiMCbv1W/RcPuKT/+Deqx9LhmW0ABdObp08=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=A8QSWhP/rftuVfFFPICgaABwav32s0xmeqyUuxJYFHIEGZF4gW+PMdm2PU0NsFisA
         3XRuvVCtRki8WIERAAyML5hO2LKWQ7gu51+XAeuzBCw/X1YG/1wb1eSpzfDMBsxCxP
         88IdVy5+ZW8rpxK2iEMaZEDAwrLKjklEG3Xy+mhg4PVh6G+yUqVANfwehO01kqrR+Z
         jGjjqpPyF4EN4SKpY0pH1nLVFBlr+/ANBp6euLURL0JhUrRnOcjmVzVUJaZG3xQrze
         1LiNU6e4eVbt5Gz0egi6IPbGObLzvGNrT2BSLdDgMRX9gW8PWyAbWYU/Feu6cQ7T3Q
         VkEYfhIRd0Ctg==
From:   Mark Brown <broonie@kernel.org>
To:     cy_huang <u0084500@gmail.com>, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        cy_huang@richtek.com, lgirdwood@gmail.com
In-Reply-To: <1667183334-16511-1-git-send-email-u0084500@gmail.com>
References: <1667183334-16511-1-git-send-email-u0084500@gmail.com>
Subject: Re: [PATCH v3 0/2] Add support for Richtek RT6190 36V 4-wwtich regulator
Message-Id: <166740635395.287466.16386075560173939069.b4-ty@kernel.org>
Date:   Wed, 02 Nov 2022 16:25:53 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Oct 2022 10:28:52 +0800, cy_huang wrote:
> From: ChiYuan Huang <cy_huang@richtek.com>
> 
> The RT6190 is a 4-switch Buck-Boost controller designed for USB power delivery
> (USB PD). It operates with wide input voltage range from 4.5V to 36V, and the
> output voltage can be programmable between 3V and 36V. It implements peak
> current mode control mechanism to deliver up to 100W power with the
> programmable constant voltage and constant current output. It also has built-in
> charge pumps for driving external low-cost N-MOSFETs to control the power path.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/2] dt-bindings: regulator: Add bindings for Richtek RT6190 regulator
      commit: 8facce4349d46fbc2ac4f6da3786130ddd104440
[2/2] regulator: rt6190: Add support for Richtek RT6190 regulator
      commit: e6999e7cca7eecd64c27dc72c51d11cb33079a0c

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

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07D826AC117
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 14:32:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbjCFNcN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 08:32:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231264AbjCFNcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 08:32:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CBBD2ED66;
        Mon,  6 Mar 2023 05:32:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A826060F10;
        Mon,  6 Mar 2023 13:31:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61B25C4339C;
        Mon,  6 Mar 2023 13:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678109519;
        bh=GGz/XSquEEkd/c1A8ozA7mQ9It/zjD2cp/cMY4WB4vA=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=iBaz7RSpiIHju+faTJoDDbYnqmTn2YoDyADXL2vTPaHobu59JQLQT7lk3IOORGJdB
         0ike2irMWoLD0BnVbFfW4l4Vhd9zdBvaTqjmyqMrp30fQPZTk6z/SElweq1D/d2gO1
         M0Rfe35aZMF/Z/lnJEVVioyP6WK6U1VSJjhfXR6RzqAlYFWwkGLlbCGxBTNGFRjljk
         pd3D8BWREFA3wcQM8gLvC5JSxBhHzNCSw55xylUXpfeeEV6J3mp25lQ75K6wZXapTS
         PZq/MV4+1/V9uUTYi79oYIab4NqqASTK7vAWyVgeMlsS/uDLxPKdkCCbAi06YgHS+I
         fZNTLSfJsfAVw==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Prabhakar <prabhakar.csengg@gmail.com>
Cc:     alsa-devel@alsa-project.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20230217185225.43310-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20230217185225.43310-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: (subset) [PATCH 0/4] RZ/G2L SSI: Update interrupt numbers
Message-Id: <167810951612.75807.7701310254952965635.b4-ty@kernel.org>
Date:   Mon, 06 Mar 2023 13:31:56 +0000
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

On Fri, 17 Feb 2023 18:52:21 +0000, Prabhakar wrote:
> This patch series aims to fix interrupt numbers for SSI channels and updates
> the DT binding and the driver accordingly.
> 
> Note, this patch series applies on top of [0].
> 
> [0] https://patchwork.kernel.org/project/linux-renesas-soc/cover/20230131223529.11905-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/4] ASoC: dt-bindings: renesas,rz-ssi: Update interrupts and interrupt-names properties
      commit: 56a3840486ae22c42176828e25d4073712837bfd
[2/4] ASoC: sh: rz-ssi: Update interrupt handling for half duplex channels
      commit: 38c042b59af0248a8b13f01b1a09d890997c9f6e

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


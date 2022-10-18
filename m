Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25325602C0A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 14:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbiJRMpv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 08:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbiJRMpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 08:45:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71D6F7284C;
        Tue, 18 Oct 2022 05:45:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 252A0B81BFB;
        Tue, 18 Oct 2022 12:45:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70209C433D6;
        Tue, 18 Oct 2022 12:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666097129;
        bh=jRFoqeAs6PqQmn5JQefnF9EBH8A3Cf2rw0GlfDexcGw=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=kj+uLC+hQU4DVsfHXBbIlMfuFkLYVPTE5S5ePWMyvZReNHoicUZnVcBDjjN35Jjmw
         UVN5/he5xgCYX75CRcRSY7QwxqcYsE46sFtg2RUQUekAebPA9OMSaLPW1Hb1TgzDxh
         DpJoVPGB6gm3rI40AW8knO/iHC/Qb80zoKkyPcbg9ZJfbOErDbFci6aOfFEDM7hDeJ
         F/6Uc2ZaFo/oKPFPk2+0brvtSEcEjZ+2gGQ+PaSMiE4MMmaERaOmKLdK/b/gp7+rDW
         7OcNgD4mwVgq/HqiIYeLlUuTQiX5sxFLEw01HhgIUhneX3X1AOkh3HS5gPCwSeGJqK
         JLcOlMSDjtF0Q==
From:   Mark Brown <broonie@kernel.org>
To:     conor.dooley@microchip.com,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>,
        linux-riscv@lists.infradead.org, daire.mcnamara@microchip.com
In-Reply-To: <20221017092141.9789-1-jiapeng.chong@linux.alibaba.com>
References: <20221017092141.9789-1-jiapeng.chong@linux.alibaba.com>
Subject: Re: [PATCH] spi: microchip-core: Remove the unused function mchp_corespi_enable()
Message-Id: <166609712817.385867.3776854548759783028.b4-ty@kernel.org>
Date:   Tue, 18 Oct 2022 13:45:28 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Oct 2022 17:21:41 +0800, Jiapeng Chong wrote:
> The function mchp_corespi_enable() is defined in the spi-microchip-core.c
> file, but not called elsewhere, so delete this unused function.
> 
> drivers/spi/spi-microchip-core.c:122:20: warning: unused function 'mchp_corespi_enable'.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: microchip-core: Remove the unused function mchp_corespi_enable()
      commit: 8f4b3d2f653937956fdc68b665c621dfa3cf2fa7

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

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A0DA735E70
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 22:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbjFSUXb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 16:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjFSUX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 16:23:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2453BCC
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 13:23:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ACFBA60ED5
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 20:23:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC1F5C433C0;
        Mon, 19 Jun 2023 20:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687206207;
        bh=qbJVM3XpT4X3ySyVLiVIAoHVAKR24dZDZgH5sVye2NU=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=O20zGSljPrNeeXuCubTRKdz1ysmqupz4r1TCn+cBoNnxUgfG9aEQyFfLGzCqNA+UO
         JvTECG1Q3JIE70mrYLai45TLZcXM25LrTboiJAkD4VLkz3Gi4KZbJfl1PfK+9W+TQ0
         k0vDoFvqo7QrdNBSRhPSXXxJdySFrfjhLdzzcxWDgW2PE0M1UFgZ615XSyfMvA37CU
         tGqC4toZRW9OkszsiIzlR15q27jAzxJviRohERokyJ4Z4AKg6khnbYgZUfxWP4rZEW
         c08H4JR+7meMCGbd2cfNNofVnlg/MhuVh+emflRuQAh1Xyz5B0HB5J0ujvPcoRXLKp
         ZQCm7x8zsdfwA==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Robin Gong <yibin.gong@nxp.com>,
        Teresa Remmet <t.remmet@phytec.de>
Cc:     linux-kernel@vger.kernel.org, upstream@lists.phytec.de
In-Reply-To: <20230614125240.3946519-1-t.remmet@phytec.de>
References: <20230614125240.3946519-1-t.remmet@phytec.de>
Subject: Re: [PATCH] regulator: pca9450: Fix LDO3OUT and LDO4OUT MASK
Message-Id: <168720620561.182378.18296392585847255014.b4-ty@kernel.org>
Date:   Mon, 19 Jun 2023 21:23:25 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-c6835
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Jun 2023 14:52:40 +0200, Teresa Remmet wrote:
> L3_OUT and L4_OUT Bit fields range from Bit 0:4 and thus the
> mask should be 0x1F instead of 0x0F.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: pca9450: Fix LDO3OUT and LDO4OUT MASK
      commit: 7257d930aadcd62d1c7971ab14f3b1126356abdc

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


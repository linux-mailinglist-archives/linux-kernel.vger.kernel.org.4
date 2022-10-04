Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18B455F43EB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 15:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbiJDNJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 09:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbiJDNJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 09:09:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 922F91AF3E;
        Tue,  4 Oct 2022 06:09:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 356A3B80DE3;
        Tue,  4 Oct 2022 13:09:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA00AC433C1;
        Tue,  4 Oct 2022 13:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664888968;
        bh=QW4O56IPgU24WExV5OY4sNEYMQqaUhElTAz7z7ip2K4=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=jFhwSaeYyxEk1m3dV6AVyuOKW/FqGrbd069rT8IJFEeTR0KdTE5vgDgUI39Lt/jO+
         465UlIlIEFErpDr3B1YxUvLbRQF46tssxSdKs4xBBsPhmXYEHcrhzjKppTW678Dlgo
         SYb9EVrIzjmzrEop6JnX/JuGMVM/rOhiu5YGI2RN6OUiOOa5vgp6s8VZTN4rDHre9s
         pymBICoilNkN3oc11WXTPXft11qVbfrR41900bNSAZRN1CSFQAytzzHkcRNWGqs9/1
         e8UJO9H1meooqaMjW2woCmTwoIWaoeY8yZ3Mi8Pd+gTkeYbZinK77QQ3cMjBD3kWeE
         MWDunhJwk4bvg==
From:   Mark Brown <broonie@kernel.org>
To:     verdun@hpe.com, "Bird, Tim" <Tim.Bird@sony.com>,
        nick.hawkins@hpe.com
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
In-Reply-To: <BYAPR13MB2503FF6412666D29FEAC8DCDFD5B9@BYAPR13MB2503.namprd13.prod.outlook.com>
References: <BYAPR13MB2503FF6412666D29FEAC8DCDFD5B9@BYAPR13MB2503.namprd13.prod.outlook.com>
Subject: Re: [PATCH] spi: spi-gxp: fix typo in SPDX identifier line
Message-Id: <166488896751.196160.8387974098406741585.b4-ty@kernel.org>
Date:   Tue, 04 Oct 2022 14:09:27 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Oct 2022 19:05:18 +0000, Bird, Tim wrote:
> Use '-' instead of '=' in identifier: "GPL-2.0-or-later"
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-gxp: fix typo in SPDX identifier line
      commit: 033d2d13a25113b6ffd24d72490f0e363dd3eb4c

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

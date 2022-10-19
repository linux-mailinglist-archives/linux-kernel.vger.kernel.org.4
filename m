Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECE81604E46
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 19:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbiJSRNs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 13:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbiJSRNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 13:13:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7FA71BE927
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 10:13:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6457D6193C
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 17:13:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 697BEC433D6;
        Wed, 19 Oct 2022 17:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666199623;
        bh=i3IFe9Dp6l/D420+8OJkSHWipA4PgNu7QAMi3ng4M/M=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=SrsYFKlC/RbxJ7Or6yL4/7szHV9ILz72+XAa0dyZJr217Bl5TmsBuTTcVNK0wt97D
         2q2EQT0FigVG2b4dxl7XJJ4L6DqUKPNrpv96eId9zEWP+6L/RAoRZsrKyVj7TDXoQ1
         ANq7MiIl6m+UI4uxw74HexLYN2bSISmph7KN16T/WKEhIZC2I1OnfsXfYsGydSd6jE
         D2cccJbUAgdUr//egmJjeZZRSQ622L8UnrcQHx3Tz39SjDEZ+N7ZBxINLGVqHz6WXY
         dvLSfgQQC/QjsU5VZnPOjuRjxh/86ZccRCxNM1PbJdEVVlMUSCBvF+HHiMJ1qZG0xj
         dPEi7uBxLX78g==
From:   Mark Brown <broonie@kernel.org>
To:     linkt <xazrael@hotmail.com>, lgirdwood@gmail.com, tiwai@suse.com,
        mario.limonciello@amd.com, perex@perex.cz
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
In-Reply-To: <MEYPR01MB8397A3C27DE6206FA3EF834DB6239@MEYPR01MB8397.ausprd01.prod.outlook.com>
References: <MEYPR01MB8397A3C27DE6206FA3EF834DB6239@MEYPR01MB8397.ausprd01.prod.outlook.com>
Subject: Re: [PATCH -next] ASoC: amd: yc: Adding Lenovo ThinkBook 14 Gen 4+ ARA and Lenovo ThinkBook 16 Gen 4+ ARA to
 the Quirks List
Message-Id: <166619962215.1416660.1802527696570911480.b4-ty@kernel.org>
Date:   Wed, 19 Oct 2022 18:13:42 +0100
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

On Tue, 11 Oct 2022 10:51:36 +0800, linkt wrote:
> Lenovo ThinkBook 14 Gen 4+ ARA and ThinkBook 16 Gen 4+ ARA
> need to be added to the list of quirks for the microphone to work properly.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: yc: Adding Lenovo ThinkBook 14 Gen 4+ ARA and Lenovo ThinkBook 16 Gen 4+ ARA to the Quirks List
      commit: a450b5c8739248069e11f72129fca61a56125577

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

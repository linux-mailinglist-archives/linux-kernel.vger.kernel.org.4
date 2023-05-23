Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88CA970E798
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 23:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238575AbjEWVoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 17:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235037AbjEWVoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 17:44:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4967C83;
        Tue, 23 May 2023 14:44:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D20D4625CA;
        Tue, 23 May 2023 21:44:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C31FCC433EF;
        Tue, 23 May 2023 21:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684878247;
        bh=jl2wdJNruwvnUiqYoU0FPPH9cZQ8q3wjXa6NzeQjbhE=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Xy8yDNPA1reeDezVtad/Tzl+j+ZfhB40u+jSOrLN9W8Umqs3LNLU/a32br+1jko3m
         t6rYgkv+dviyyg9fbKJdeJsnVufiy8iHJGODeIJfAt1pCher0cb83zIRVU11elDXrK
         5ql5XbvQwuMH36nT4/N9kuZc6634Yeq0CamJH4zvSFrKSHCjGU50ncF20Vy7lo7bg2
         6UrraVdXX9lwiNitM5O43WITCDWJQMoC+CjJ8vHAglsoB8Ernfu+6Cqvcsivh5qtfj
         XRVbxr3x43yHJT4jgcE+OC/wzKxKBRL4eLds2p4M9SMJSR/NIb0QGKzEeyJPS8aRLf
         0CanQHNFThBAQ==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        Anup Sharma <anupnewsmail@gmail.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <ZFUFAmBJXvkQAG7m@yoga>
References: <ZFUFAmBJXvkQAG7m@yoga>
Subject: Re: [PATCH] ASoC: dt-bindings: rt1016: Convert to dtschema
Message-Id: <168487824551.297010.16643781919959380552.b4-ty@kernel.org>
Date:   Tue, 23 May 2023 22:44:05 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bfdf5
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 05 May 2023 19:00:42 +0530, Anup Sharma wrote:
> Convert the RT1016 Stereo Audio Amplifier bindings to DT schema
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: rt1016: Convert to dtschema
      commit: d8b44d8df4d932db3d88b2e79c67ffbd2c72e4dd

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


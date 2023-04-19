Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6A7D6E7C73
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 16:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232557AbjDSOYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 10:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232441AbjDSOYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 10:24:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F67BAD15
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 07:23:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 615A063AB7
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 14:23:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2C06C4339B;
        Wed, 19 Apr 2023 14:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681914200;
        bh=hGLCHDWc9KqI/KLynLW2oZ7LkA2U31ZnlMwgjeHw/Us=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=Q0wHmR5yZdj/zYEEC8ZE4V6Qb6n5jVpwDX7AwU5J+NOLsHXJAX3YhVihZKyLsqoRB
         1JxE+bqsb3Flzua2d7hHGI0vs6YeFlbRWkcZZmc4OugkxKW5RfMMzrjzl6l1XzugLd
         R2rcq+0ZAdbPumKZp2nHhlFer0HBFb6UoaW7dSsn4fvTYlI+JfhKEiGj0txSPEyY39
         6MV1FCdYZ6+DfDS9dEbLjET5YpiZhuimFU/9qI7nldcJOyB4dey95U43CtZEYtQptZ
         sJApFjBuxs7l3c6Yg4cW4vSWmiCiQ9R9eVbneFgcaGu0Zyq9HFZXv4aQgjGd+Er9v3
         FrWiF2mG11BDw==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, shengjiu.wang@gmail.com,
        Xiubo.Lee@gmail.com, festevam@gmail.com, nicoleotsuka@gmail.com,
        Chancel Liu <chancel.liu@nxp.com>
In-Reply-To: <20230418094259.4150771-1-chancel.liu@nxp.com>
References: <20230418094259.4150771-1-chancel.liu@nxp.com>
Subject: Re: [PATCH] ASoC: fsl_sai: Fix pins setting for i.MX8QM platform
Message-Id: <168191419838.83860.13145358537748043922.b4-ty@kernel.org>
Date:   Wed, 19 Apr 2023 15:23:18 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-00303
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Apr 2023 17:42:59 +0800, Chancel Liu wrote:
> SAI on i.MX8QM platform supports the data lines up to 4. So the pins
> setting should be corrected to 4.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl_sai: Fix pins setting for i.MX8QM platform
      commit: 238787157d83969e5149c8e99787d5d90e85fbe5

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


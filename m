Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1DC2710EEF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 17:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240973AbjEYPCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 11:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231576AbjEYPCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 11:02:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1249189
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 08:02:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6375A64677
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 14:57:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84D6EC433D2;
        Thu, 25 May 2023 14:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685026623;
        bh=xSCR3xzh1AVE6419MbW9C5LH8QmAA5EiVTzhTG7OXUg=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=o1Hpkiv1XgsqH1ntBabvWS4gqCEzcsBotNfdcck+phxnX1s3a4Q3EUCsPp5nMvVWt
         +20FWqCBmQvUDynu3kwHha3Wtl8BdccF14FO4ORS0/zkoKgFanTz6au/Zq9ffcK87h
         v/njmB2I/Jyd2ePikTjNNMRtFBYm/BOz0iOsLZIwBGAwIUd4m9yfIHLdkBPlX1P38u
         gX9lrh3rmV8urSExmr2m8BPsoOZItKPND0Eh9FS9K8nik9/G8TD4mLdJuZ98WHmjO4
         VvkYwxolzFkPEdPiwig6/okhohVzB39nfz8GO1W0+DCp4XDgYSKsueZXjqheHW4IFw
         aLmmGrGvc8bLw==
From:   Mark Brown <broonie@kernel.org>
To:     Vitaly Rodionov <vitalyr@opensource.cirrus.com>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230524125236.57149-1-vitalyr@opensource.cirrus.com>
References: <20230524125236.57149-1-vitalyr@opensource.cirrus.com>
Subject: Re: [PATCH] ASoC: cs42l42: Add PLL ratio table values
Message-Id: <168502662226.304042.4675453488843160773.b4-ty@kernel.org>
Date:   Thu, 25 May 2023 15:57:02 +0100
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

On Wed, 24 May 2023 13:52:36 +0100, Vitaly Rodionov wrote:
> Add 4.8Mhz 9.6Mhz and 19.2MHz SCLK values
> for MCLK 12MHz and 12.288MHz requested by Intel.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: cs42l42: Add PLL ratio table values
      commit: 13e75f4b03217226f110c5bb5d11720adb5ca9d1

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


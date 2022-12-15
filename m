Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5CE364DFD6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 18:39:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbiLORjc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 12:39:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbiLORj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 12:39:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC4C2B633
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 09:39:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CFF9CB81C24
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 17:39:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 786A1C433EF;
        Thu, 15 Dec 2022 17:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671125964;
        bh=B3Y5fOQUoSGt0TYtxeTcs4ZxQAgDEMdgJClAQNYc+Ig=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=pMltQMFl74JuDyivFi/bQAsQNn2ojAqrLNwxkADl0inuLpsLCCzIG6Gf6iVZucVwW
         XSCzXD0qMl6kyZ6ipLgtQD6mfvF3gdXo+U0HFxv+Y1Vum9NK4SbUk8NyoDdw6eBMDC
         DMjwSMM4zn9tx9CKnHCq3ywg0X7XAWKZSuiA1xYhMXEd9qc1AjP9RZe1/o7iG3KmyJ
         b/3XHLJqo9+i3Q+V00NV+fRs9QE5BnfpQJgCAy0peRY5pcLw8ClnZoBin4YVDT4UJg
         Dge/devvBtZYyPITovZlWZxEPlz5RgwhEbKOYbqNU8cJVCCn92pYDjHfA7pH32b/Vq
         cyrE1XSHXsIng==
From:   Mark Brown <broonie@kernel.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, patches@opensource.cirrus.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     kernel test robot <lkp@intel.com>
In-Reply-To: <20221215134337.77944-1-krzysztof.kozlowski@linaro.org>
References: <20221215134337.77944-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] ASoC: lochnagar: Fix unused lochnagar_of_match warning
Message-Id: <167112596219.3721867.784009844476079097.b4-ty@kernel.org>
Date:   Thu, 15 Dec 2022 17:39:22 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-7e003
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Dec 2022 14:43:37 +0100, Krzysztof Kozlowski wrote:
> lochnagar_of_match is used unconditionally, so COMPILE_TEST builds
> without OF warn:
> 
>   sound/soc/codecs/lochnagar-sc.c:247:34: error: ‘lochnagar_of_match’ defined but not used [-Werror=unused-const-variable=]
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: lochnagar: Fix unused lochnagar_of_match warning
      commit: a12a383e59ce486abd719b6bda33c353a3b385e7

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

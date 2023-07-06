Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B28374A051
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 17:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233521AbjGFPD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 11:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233264AbjGFPDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 11:03:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05B6C1B6
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 08:03:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7C7E1608C3
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 15:03:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BFEFC433C7;
        Thu,  6 Jul 2023 15:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688655828;
        bh=QB/NVgqudtKMYDSKl52FwcM9ZO7WuIvYj3VPAY1XOWM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=AiWsV1UZe9nYCN1oDnixoZcs0hFazd+ZK1PSvjsd3n5kNzYtnByc0DXBGHgh4KUEi
         5JnekE9PK6XsVl9I8+HQBg8C57ee+/8qGHzqZE4EnX7htiRoiReapNrT7JjqsdSNFN
         6jDDUoDVtZa0MQg1kIjFRyNyNSL0uPDF3Elib10PMk3RlniaHmRUicSP53KXVNw5IU
         wcJNaS+XVS6+iUVxx2Zo7j23nG68FJgnxZ6OHGVoeozQm2EMPL5uCoL+qPFkRoK08z
         qHs6NvbclGxHZqoi/zFr5dsb3HsjtZiks3mfXngDeNNgeuQShDktnh/Afnl7Q98YO/
         LSo7PRBAxr9Kw==
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     perex@perex.cz, tiwai@suse.com, lgirdwood@gmail.com,
        ckeepax@opensource.cirrus.com, kuninori.morimoto.gx@renesas.com,
        linux-kernel@vger.kernel.org, pierre-louis.bossart@linux.intel.com,
        alsa-devel@alsa-project.org
In-Reply-To: <20230705125723.40464-1-srinivas.kandagatla@linaro.org>
References: <20230705125723.40464-1-srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH] ASoC: codecs: wcd938x: fix dB range for HPHL and HPHR
Message-Id: <168865582683.36989.12106598121832751013.b4-ty@kernel.org>
Date:   Thu, 06 Jul 2023 16:03:46 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 05 Jul 2023 13:57:23 +0100, Srinivas Kandagatla wrote:
> dB range for HPHL and HPHR gains are from +6dB to -30dB in steps of
> 1.5dB with register values range from 0 to 24.
> 
> Current code maps these dB ranges incorrectly, fix them to allow proper
> volume setting.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: wcd938x: fix dB range for HPHL and HPHR
      commit: c03226ba15fe3c42d13907ec7d8536396602557b

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


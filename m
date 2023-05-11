Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9293B6FEB7F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 08:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236672AbjEKGCu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 02:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231183AbjEKGCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 02:02:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0540C138;
        Wed, 10 May 2023 23:02:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 800D464AE3;
        Thu, 11 May 2023 06:02:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 320E5C433D2;
        Thu, 11 May 2023 06:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683784964;
        bh=L4Nnv6gPFOyuLFZDBZsL5VCSsSaGeg9xGtmV+5kvrYo=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=VyqAQJHFu2ZOa6qUeQpMH1Mij3SIUuel5M5juD/3iv6Fi4f3ZPTxuhUzsbHzwgYXp
         sdAHe2fn/srgdvZTlksC2EgyVJDPdRjkr6FQb/sJ0zBdsVZI6NqtS4mNd9SesYtwbV
         kYAP7xNLJfLWp2K7gHKdXxvZaGzo5ylVj+bU7B92cYN59jJSw0aD5hV8FYC9ItOH8W
         zkuu5idA/ma/R/8VlmhTYgeGRE0v4tJxjKRnOPXb7i0WPq3M49XdcQep4xP6KM6oTW
         kkB9oAcZkJfUp6qfaZTBtH8WVhZTjGzA5RAy3+E24SPb3NDi+SRMdCGDgbtvQsth7O
         ftLcsshj4LQ1w==
From:   Mark Brown <broonie@kernel.org>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, tsbogend@alpha.franken.de,
        paul@crapouillou.net,
        Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
In-Reply-To: <20230509124238.195191-1-aidanmacdonald.0x0@gmail.com>
References: <20230509124238.195191-1-aidanmacdonald.0x0@gmail.com>
Subject: Re: (subset) [PATCH v1 1/3] ASoC: jz4740-i2s: Add support for
 X1000 SoC
Message-Id: <168378495575.334814.10028126851566135486.b4-ty@kernel.org>
Date:   Thu, 11 May 2023 15:02:35 +0900
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

On Tue, 09 May 2023 13:42:36 +0100, Aidan MacDonald wrote:
> The X1000's AIC is similar to the AIC found on other Ingenic SoCs.
> It has symmetric playback/capture rates like the JZ4740, but more
> flexible clocking when outputting the system or bit clocks.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC: jz4740-i2s: Add support for X1000 SoC
      commit: bb1b282da4be8af998de7b5a2c600af6ef01aa4f
[2/3] ASoC: ingenic: Add compatible string for X1000 SoC
      commit: d40b28d642d52e4687c73dd098fbd8ac8e2dc1d8

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


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13C01613DE8
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 19:59:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbiJaS7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 14:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiJaS7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 14:59:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B081E2ACA;
        Mon, 31 Oct 2022 11:59:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 64399B81A4F;
        Mon, 31 Oct 2022 18:59:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABD61C433D6;
        Mon, 31 Oct 2022 18:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667242786;
        bh=8VQj+ZASnWKsMq5F2lwAZzxH4fhL26IZ/d81+ZNjgh4=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=l4wqZoqsTFW6zgfrtSlWuFUdQbs1wYiTdx7ozje+pmc3+E/1z6KNqiSd49UyHF9CS
         w+b+pFU+wsu8EIT0xPNUCbrESXvJQpLt+6jM+LsNLQXU3l4GXUtDIWtH4/d2mq0V3F
         Dqn7ndaKMHR7+aWyBfbE7SUA3JjigUEkf2vsatKuX/XY3gskTFRvyh7QV2abCVdGUv
         Gxx9f7XyWyERZqlSw+1+tXpFR/Rp59P+MkcVgGR5EwvPGBFu5dyfLX46L8Jc+zSwAr
         CX1Jy4i1Jkyy8d9y6yz6s1ObiaCe7uvzuMjsGj9hDYWZbAT0Rh3M8FT06mPG8mEdg7
         P/dnIqfWMXhyA==
From:   Mark Brown <broonie@kernel.org>
To:     tsbogend@alpha.franken.de, paul@crapouillou.net,
        lgirdwood@gmail.com, krzysztof.kozlowski+dt@linaro.org,
        perex@perex.cz, tiwai@suse.com,
        Aidan MacDonald <aidanmacdonald.0x0@gmail.com>,
        robh+dt@kernel.org
Cc:     alsa-devel@alsa-project.org, linux-mips@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20221028103418.17578-1-aidanmacdonald.0x0@gmail.com>
References: <20221028103418.17578-1-aidanmacdonald.0x0@gmail.com>
Subject: Re: (subset) [PATCH v1 0/3] ASoC: jz4740-i2s: Remove .set_sysclk() & friends
Message-Id: <166724278340.784642.4861390938395208106.b4-ty@kernel.org>
Date:   Mon, 31 Oct 2022 18:59:43 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Oct 2022 11:34:15 +0100, Aidan MacDonald wrote:
> A quick series to get rid of .set_sysclk() from jz4740-i2s.
> It wasn't used in practice so this shouldn't be troublesome for anyone,
> and fortunately there aren't any backward compatibility concerns.
> 
> The actual rationale for removing it, as opposed to fixing the
> issues of the current DT bindings and implementation, is provided
> in the dt-bindings patch.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] dt-bindings: ingenic,aic: Remove unnecessary clocks from schema
      commit: fc839054615427aa15de7677082b23b3033faf07
[3/3] ASoC: jz4740-i2s: Remove .set_sysclk()
      commit: 1c0036e03edd5d97fc0af94dd3ab7e8c58b8191d

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

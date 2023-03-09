Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB1F86B2ABF
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 17:30:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbjCIQaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 11:30:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbjCIQaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 11:30:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 265BB1111CF
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 08:21:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 432D361BEA
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 16:20:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 712CFC433D2;
        Thu,  9 Mar 2023 16:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678378827;
        bh=eg6WprGy/Dr+cy0XaA/osio6oPYUKPIB9Ye7I0EE6ss=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=rJzFZBsLaynOVkjfuV8D/Yn9ZDOux1qM+8Q0Zus7t3m8Nbzx/eJmhXjdvjjY4G7XO
         4Sl/F218aYv2fZ1+0krp4ycAu9vnITQUtcBeQ/bP3iEHnqy067ntOvyo9uqjw5t4iK
         QOMULkhkhopA4clZJkPQQbn+r4Lir6KcEyuBe8cH6ZxJVgte/d2xX8D9cT3+brcAs5
         fNvj6Z2aUnr2GSz7HCYuOGpLH4RQ7o6TeV7YrD8pND1qtePFeIBm4tr2+fmeakRgfj
         Q9vXT7B89ssnh/OqS2ibEm02E+vGlXx2xv/BQ9vc5iEwzb8PnP3wVc0ggEtXe+BAEh
         3Y5bLLQG07OQw==
From:   Mark Brown <broonie@kernel.org>
To:     David Rhodes <david.rhodes@cirrus.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        "Takashi Iwai --cc=alsa-devel @ alsa-project . org" <tiwai@suse.com>,
        Lucas Tanure <lucas.tanure@collabora.com>
Cc:     patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        kernel@collabora.com
In-Reply-To: <20230309104133.537056-1-lucas.tanure@collabora.com>
References: <20230309104133.537056-1-lucas.tanure@collabora.com>
Subject: Re: [PATCH v4] ASoC: cs35l41: Steam Deck Shared boost properties
 quirk
Message-Id: <167837882518.39474.5819778399084197705.b4-ty@kernel.org>
Date:   Thu, 09 Mar 2023 16:20:25 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bd1bf
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 09 Mar 2023 10:41:33 +0000, Lucas Tanure wrote:
> Add support for Steam Deck bios old properties. If a Steam deck didn't
> upgrade the BIOS, the driver should be able to handle the previous
> properties for shared boost types.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: cs35l41: Steam Deck Shared boost properties quirk
      commit: 8987986b07f5dded3f81b159f5bb146f2d1a21ed

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


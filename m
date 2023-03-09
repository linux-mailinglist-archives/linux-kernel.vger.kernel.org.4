Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E30856B2ABC
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 17:30:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbjCIQaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 11:30:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbjCIQ34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 11:29:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CDFB1111C7
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 08:21:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 79F42B81FB4
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 16:20:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1734EC4339B;
        Thu,  9 Mar 2023 16:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678378830;
        bh=fLoSnXS+etWXQ8M6uD29MTHdVitlDJTq7PK6O24OBfo=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=QaG3Kd9VVzOmhFoh/W4AmV37EkYL+vb+zzzjb1Acrv6qw6hjMmeOWF3e1h3CxG35c
         f/WmbKBrgG7+mctEYMLubgdTBLw0Opu83hiG/g1IAKEXz0IfqRcPxnVd8pL/eVa9rx
         dE/SSd5zfESGy11Bh0iQRJFUqCQfPuIp9cSDzO1MJSeTe/lnL3O3b8c76qphrnvBtG
         IiInb5TUd3Klp59I4IzBFB8kRbDNE1rTDtY2fbZmAZQ5pGd78kiorKRUhX7y29joDE
         iJY0bF/fOQKT0haAwQzgOysXfs5UGVbia39UdV290MjbSHyJpnrWH/Yq4N2zLOPTYU
         lYy1Q9Cp9py3Q==
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
In-Reply-To: <20230309140051.945329-1-lucas.tanure@collabora.com>
References: <20230309140051.945329-1-lucas.tanure@collabora.com>
Subject: Re: [PATCH v5] ASoC: cs35l41: Steam Deck Shared boost properties
 quirk
Message-Id: <167837882781.39474.4339514850949548082.b4-ty@kernel.org>
Date:   Thu, 09 Mar 2023 16:20:27 +0000
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

On Thu, 09 Mar 2023 14:00:51 +0000, Lucas Tanure wrote:
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


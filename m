Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDB086CC71F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 17:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233470AbjC1Pwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 11:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233237AbjC1Pwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 11:52:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AB1112B;
        Tue, 28 Mar 2023 08:52:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E45F6B81D81;
        Tue, 28 Mar 2023 15:52:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1747FC433EF;
        Tue, 28 Mar 2023 15:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680018747;
        bh=Czsqs77qTKp69tt1YlQhbRR69dd/LFM95tDt12Xd6/w=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=CsM9zvkG4StopJR15M7YAm8E1RksC5qq9QlMqFMngi8/eZXtkPNaeqO7ozxvHBhgA
         Vpl5DDUWKQflJ4J5WpNia6/q4+PKgEdnnyMtxvMVvaezAdIwsC/+WP1Ldq+bX4thPI
         mXUMubBlrWHZfPiHx7pEzIGjOl2a3Z5Y9DMjf/Zhx9/AgzMLglsaqXrOFSN2TadGFO
         Tm18JiBlJfAxwxAaR8qwbxl1ddwzRho4N1O5NQ5PfrLIhCz5Wof/nhGAqha7I39XaF
         R0Jm9yz6PGvsMGyY1gLmgkQyarB17zPWKamyxNJrlTHwq0DHl9+Xy27sBvmSA+xcZx
         BjYuaPTIbIx6g==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Ladislav Michl <ladis@linux-mips.org>,
        Richard Leitner <richard.leitner@linux.dev>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230328-max9867_dt_example_fix-v1-1-cdf31c3fdfc8@linux.dev>
References: <20230328-max9867_dt_example_fix-v1-1-cdf31c3fdfc8@linux.dev>
Subject: Re: [PATCH] ASoC: dt-bindings: maxim,max9867: fix example
Message-Id: <168001874582.43606.10998197986023512559.b4-ty@kernel.org>
Date:   Tue, 28 Mar 2023 16:52:25 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bd1bf
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Mar 2023 13:25:14 +0200, Richard Leitner wrote:
> Remove the common clock node from the example as suggested by
> Krzysztof Kozlowski in [1].
> 
> [1] https://lore.kernel.org/lkml/45d306d3-8efb-12ac-0a83-f01ca2982b0a@linaro.org/
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: maxim,max9867: fix example
      commit: d23d50de4ad9a960b752b8b7f4ffce32e05a8971

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


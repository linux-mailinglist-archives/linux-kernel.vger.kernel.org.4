Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D84C76BD238
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 15:19:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbjCPOS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 10:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbjCPOSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 10:18:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D582F227A0;
        Thu, 16 Mar 2023 07:18:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A016DB821E9;
        Thu, 16 Mar 2023 14:18:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 237B8C433D2;
        Thu, 16 Mar 2023 14:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678976285;
        bh=98zjYF4qPdU7E5+W0pjvEly3t4PzMPxRXgQA3FyuV20=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=cq/2eBWekY/DtQUoH8V4SMuY0JDOu4a+mwkNWpkfSz1iSs6nkKlKp/jjBKUAgv7DV
         3guczbA6rCGiawhfcmoISmuPe7qLSBOAa8trRfGz6w/QYJaZM6hh8Q+ly0dAX5AVbZ
         30tnqvFiW0PwrZhD1csFw8f6QQeR/FbSdA3PfjOtm9J0yer1u1/KbSbRJvPYfL0BUC
         kSrk5uSoUbeMCgf6blqakPnS9vQn3jjzyOSr9DamN0U4WClDIXUIFBORU6Fqqapic2
         mdgp+wcUQgq0ADDpvP2qK2oZHt4mrq/yQPvcYjIUaHlGDBH5189pZBJ6So/JVEIQju
         ECugjNRdqjiyw==
From:   Mark Brown <broonie@kernel.org>
To:     Otabek Nazrullaev <otabeknazrullaev1998@gmail.com>
Cc:     Daniel Baluta <daniel.baluta@nxp.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230315173404.7215-1-otabeknazrullaev1998@gmail.com>
References: <20230315173404.7215-1-otabeknazrullaev1998@gmail.com>
Subject: Re: [PATCH] ASoC: dt-bindings: maxim,max9759: Convert to DT
 schema.
Message-Id: <167897628282.92626.2266406042057860602.b4-ty@kernel.org>
Date:   Thu, 16 Mar 2023 14:18:02 +0000
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

On Thu, 16 Mar 2023 02:33:30 +0900, Otabek Nazrullaev wrote:
> Convert Maxim MAX9759 Speaker Amplifier bindings to DT schema.
> Add missing gpio header file into examples section
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: maxim,max9759: Convert to DT schema.
      commit: 1d8777d21fbb36c4a0e103eb128ca86f9761e61c

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


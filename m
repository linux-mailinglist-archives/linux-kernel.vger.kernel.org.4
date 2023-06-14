Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6556673054E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 18:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235682AbjFNQoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 12:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233913AbjFNQoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 12:44:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30BF31FDA;
        Wed, 14 Jun 2023 09:44:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C22D7638DC;
        Wed, 14 Jun 2023 16:44:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57F12C433C0;
        Wed, 14 Jun 2023 16:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686761042;
        bh=yMjud685GsR5I7RezokIHnnoxMgzYA57wB5eZx1rAZ8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=BkVR/uetIT0/BgWjs3MnpX6ncwyVGrdYFrzkSZvqp8mXmen4o6afbYuUDji+z8oJr
         2xuR2lUGgVKHuw6wKFsnVbGUAoS6mCEg+fjrlym2BbXJPL0++7r8vNmp09bLhbWFB7
         mRTOz0E5nggwwFWV0NC4mWqrbwl82DybODM1dH1MTeRNMIVmkiDX9lYJvvaAVAZajO
         m8l1rb7Tsidtr8dHuNLww858NV8QemKk36u0BBGtozG2UEGAPYbOKUcHZnQVbQKTjI
         XMsoeQXoCQ6TcQrJNE3EFDjq0JR3BGfUT1pr9xr12nkBshwhM3jNnd+uHejCGzV+mP
         XrJEo2ewzf98Q==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Brian Norris <briannorris@chromium.org>,
        Lee Jones <lee@kernel.org>,
        Alexandre Courbot <acourbot@nvidia.com>,
        Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20230613200956.2822740-1-robh@kernel.org>
References: <20230613200956.2822740-1-robh@kernel.org>
Subject: Re: [PATCH] regulator: dt-bindings: pwm-regulator: Add missing
 type for "pwm-dutycycle-unit"
Message-Id: <168676104003.202366.6275917850625203715.b4-ty@kernel.org>
Date:   Wed, 14 Jun 2023 17:44:00 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-c6835
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Jun 2023 14:09:56 -0600, Rob Herring wrote:
> "pwm-dutycycle-unit" is missing a type, add it.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: dt-bindings: pwm-regulator: Add missing type for "pwm-dutycycle-unit"
      commit: 2b026eabc3152592be75b7d7e73e9536b9eeb794

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


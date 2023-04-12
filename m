Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CBC06DFBB7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 18:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbjDLQrx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 12:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbjDLQrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 12:47:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAB027DB3;
        Wed, 12 Apr 2023 09:47:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D88E76339A;
        Wed, 12 Apr 2023 16:46:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5DFEC4339C;
        Wed, 12 Apr 2023 16:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681317967;
        bh=hUyUk0HVEmauyGnxF8rmJvXXqxDZnnR+L7bxIlBZgzA=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=IWCHHZdqVbKsnt4g/P6d1WohBEW0XsZkZzwD6aN3vbjzbeSYVyfVRjwNqL0qYt64w
         sXwE+SJDt4SUD/usBEDkUVBU+uesxwYQBRQrBuJ8Xh7BE/hb/EyhAqDlpRItlsGRxK
         J/yFBdEqZfsfwi4muh16sMzAEGm54KObHWbW1T/dMO9V7SEqCg8z5/lS2Bli9CkkCE
         06G6VGfoVduk//DuceYP8YIstvbghsdMxkoB9Olzm0nscr4b/yePmAaeyx/8o7cbi6
         PJvtkyxBlu/aEKKtJGW5UtpQKUpPOT4+gnzo9Ol28bZZeEejOzJrPpqIw/W4fnlm6/
         hHAC9Fc2SdeBQ==
From:   Mark Brown <broonie@kernel.org>
To:     devicetree@vger.kernel.org,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>
Cc:     Hartley Sweeten <hsweeten@visionengravers.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Nikita Shubin <nikita.shubin@maquefel.me>
In-Reply-To: <20230411165951.2335899-1-alexander.sverdlin@gmail.com>
References: <20230411165951.2335899-1-alexander.sverdlin@gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: sound: ep93xx: Add I2S description
Message-Id: <168131796432.93781.16086400644681374069.b4-ty@kernel.org>
Date:   Wed, 12 Apr 2023 17:46:04 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-00303
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Apr 2023 18:59:50 +0200, Alexander Sverdlin wrote:
> Add device tree bindings for Cirrus Logic EP93xx internal SoCs' I2S
> controller.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] dt-bindings: sound: ep93xx: Add I2S description
      commit: 13b1b95245a7c2dc959b06ed7f02f4832e401cd2
[2/2] ASoC: ep93xx: Add OF support
      commit: b599a4d7d905a8e8cf5c36ccae0b3dd97c956075

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


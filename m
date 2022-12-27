Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBC60656C6C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 16:24:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbiL0PXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 10:23:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbiL0PXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 10:23:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE78EBC23;
        Tue, 27 Dec 2022 07:23:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7F97DB8109E;
        Tue, 27 Dec 2022 15:23:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BBA5C433D2;
        Tue, 27 Dec 2022 15:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672154625;
        bh=D5yQQdbA5CGXo92xgHby4JQy84ydmeJguHLRU49qgdA=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=DNJXEI5dB1yWpgUGoKLSyXYobqcv7Qsj7Wzv22RQVsY6/ntzMQ6WAHK90hnO6auVN
         w43b8sJu2hm43z59Pya9015A7Rfs9J7oJ1i8bH04y+TQOelwvD7NlN6bKq4a98h74S
         jliQg8yA5ODPssLMIY2q/NXEoNsXBSEMw3MTVqGe3ZERngaYVsu7YXUHG1jKa+wb/b
         LiuX1iLXTa714ovAtUVu5gX062LujKbwbcq2c5+fA3OAzCQS9IghtlPRa0ySIy4ZYf
         BomHY4vFKSWXNq2JR4QnOId9idbqRuottzPa8R/wOvYaZEs1O2Ck9RApo+KEyB+c8x
         95ddiVZSCOYyg==
From:   Mark Brown <broonie@kernel.org>
To:     Vincent Tremblay <vincent@vtremblay.dev>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Stanislav Jakubek <stano.jakubek@gmail.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Marcello Sylvester Bauer <sylv@sylv.io>,
        Marek Vasut <marex@denx.de>,
        Samuel Holland <samuel@sholland.org>,
        Greg.Schwendimann@infineon.com,
        Conor Dooley <conor.dooley@microchip.com>,
        Pali =?utf-8?q?Roh=C3=A1r?= <pali@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
In-Reply-To: <20221227141011.111410-1-vincent@vtremblay.dev>
References: <20221227141011.111410-1-vincent@vtremblay.dev>
Subject: Re: [PATCH 1/2] dt-bindings: trivial-devices: Add silabs,si3210
Message-Id: <167215462106.681987.2666354139430332816.b4-ty@kernel.org>
Date:   Tue, 27 Dec 2022 15:23:41 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-7ab1d
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Dec 2022 09:10:07 -0500, Vincent Tremblay wrote:
> Add Silicon Labs SI3210 to trivial devices.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] dt-bindings: trivial-devices: Add silabs,si3210
      commit: f7879d677e76d0c4449fa1839f948d335795f334
[2/2] spidev: Add Silicon Labs SI3210 device compatible
      commit: 6c9d1fd52956c3148e847a214bae9102b1811de5

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

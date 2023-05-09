Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC5A6FBF62
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 08:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234926AbjEIGj5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 02:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234952AbjEIGjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 02:39:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDFA1AD25;
        Mon,  8 May 2023 23:39:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 530C162FE1;
        Tue,  9 May 2023 06:39:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9CFAC433D2;
        Tue,  9 May 2023 06:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683614361;
        bh=KXkW/Qg8nbm4fuj0v5jtuJso+Jg1YeFUBlNRcgIPRSs=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=R4VJbUJbQzcgCollmbqeGo9krMqPJxslF6QHynyHq4ogYe2eCTaMsBcgKBPQbK6Ww
         DXZeFAkZxBA0FfYNEVuwaECUH0YTuV87VER+s5IbD3ZWjlnwUoqbFWr3yAbxZ3oFke
         2ZCBSV7ImJCg2LJRk+0Ssmrw/+8YB1eEs5fswwLzP6EPezl+EmNRXM/9eoYhj9aHKK
         Xf93BXQpVif7O/twDRXO4CVIQQ9bOSTK0it6QVjVPpqVQq5sWmc9LpQ2AoWvtZY5FS
         uSj/5bExDJgQRSE7kEEhgf9AkMW7CWjxf0hrWxn6Qrp1uPfJHhr6uJaNNTcXLzSoGP
         f0ZNymha3thhA==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?utf-8?q?M=C3=A5rten_Lindahl?= <marten.lindahl@axis.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        kernel@axis.com
In-Reply-To: <20230502-tps6287x-driver-v3-0-e25140a023f5@axis.com>
References: <20230502-tps6287x-driver-v3-0-e25140a023f5@axis.com>
Subject: Re: [PATCH v3 0/2] regulator: Add support for TPS6287x
Message-Id: <168361435697.303261.4023695080353832209.b4-ty@kernel.org>
Date:   Tue, 09 May 2023 15:39:16 +0900
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

On Mon, 08 May 2023 15:14:06 +0200, Mårten Lindahl wrote:
> This series adds basic support for TI's TPS62870/TPS62871/TPS62872/
> TPS62873 high-frequency single-channel step-down converters with an
> I2C interface.
> 
> The devices can operate in power save mode for maximum efficiency, or
> forced-PWM mode for best transient performance and lowest output
> voltage ripple. All chip variants have four output voltage ranges and
> the driver changes active range depending on the requested voltage
> setting.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/2] regulator: dt-bindings: Add bindings for TPS6287x
      commit: 034008dd227877cca1588d66e2df505f5fae26c9
[2/2] regulator: Add support for TI TPS6287x regulators
      commit: 7b0518fbf2befd7c4afb81eb06c95c8fc93998be

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


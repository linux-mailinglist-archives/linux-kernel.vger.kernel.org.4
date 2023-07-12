Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E38E4750B09
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 16:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbjGLO3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 10:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232190AbjGLO3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 10:29:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45B6E1BC6;
        Wed, 12 Jul 2023 07:29:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D8CD5617C7;
        Wed, 12 Jul 2023 14:29:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D36FFC433C9;
        Wed, 12 Jul 2023 14:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689172175;
        bh=St2V/LpnW7GRIEdHqQzm5rOiN0dUShCz4WxumLLy+Jw=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=qNF0dVz+HghqqcuDJWsnMh0OtokZNamEbOwytaewhMXhJsQB6J6kYRpF7LVNL2jpN
         6q7yMYw10Qzae+CvdY6j/77khuY8Z5nmGLQzcEcM5eJm1n/uaGHniyhnaY7FIrELz7
         NH5vZb6PRpmCiHSkNvtgKt3x2BiZeoovAxh1vh9WvCfjATnETYpZvJBLuHWoHlIyRi
         TuukOdrRT6ZJO5S2Jldnh/SyTakjCWvJMJCLuP1yI3LfxX8OHsl95zaCBJ8xQbyziR
         qzixhe1qo7FIZEDQ+BZLTZzONbjMgHdb/HJkCfuoNBKkSsTsxHdiEzsT91kDNTlo1d
         Ym6O99GFfMlIA==
From:   Mark Brown <broonie@kernel.org>
To:     krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        cy_huang@richtek.com
Cc:     robh+dt@kernel.org, lgirdwood@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <1687942037-14652-1-git-send-email-cy_huang@richtek.com>
References: <1687942037-14652-1-git-send-email-cy_huang@richtek.com>
Subject: Re: [PATCH 0/2] Add support for RT5733
Message-Id: <168917217355.84133.14477051151431440172.b4-ty@kernel.org>
Date:   Wed, 12 Jul 2023 15:29:33 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Jun 2023 16:47:15 +0800, cy_huang@richtek.com wrote:
> This series is to add the compatible support for rt5733 based on rt5739.
> 
> ChiYuan Huang (2):
>   regulator: dt-bindings: rt5739: Add compatible for rt5733
>   regulator: rt5739: Add DID check and compatible for rt5733
> 
> .../bindings/regulator/richtek,rt5739.yaml    |  1 +
>  drivers/regulator/rt5739.c                    | 49 ++++++++++++++++---
>  2 files changed, 42 insertions(+), 8 deletions(-)
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/2] regulator: dt-bindings: rt5739: Add compatible for rt5733
      commit: 8978af5ef662541bc0a5a7722ad6942cd19daed0
[2/2] regulator: rt5739: Add DID check and compatible for rt5733
      commit: 6f5e285839845729858b8f6ca7cf3dd35e1f9a29

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


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7C773323E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 15:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344184AbjFPNdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 09:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344061AbjFPNds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 09:33:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE3E13593
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 06:33:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 53AA461CE8
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 13:33:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED924C433C8;
        Fri, 16 Jun 2023 13:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686922425;
        bh=b8f51cqluu5JQHKo6Ft3l/k4ksx9H0q8esoFN35GWAk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=lbCchXxccR1Uchf4dCU35MYDMGNcS1c2C92VAJD+sT2DHSrLfGw7Ff4URfnfXV239
         AO3UDIBJjMYM1FXTvEOwKNVRknnTs6yZ8FmUF2IXBPY1Nb9/dYQRz/x+T2KnwyAsZ6
         iBkKEIYKxezd5iGTJqKTEWrQMzBqJ+F9WAw9Yrnu14re0t6E6efENTXkrhnIL8P7q9
         rsDGQsU0Fi8wTd9dEk0m5S7EAQxTE8pMGF7hoePWC4YQd0NcDECMxwleobmcHZ9CXC
         rtG5SfR3UfYmKXjAT1jQuO9yBjYQmwIX2pD7htfT1HgNvD8fcC9Dl80Znwtr5hezgb
         Fs06u59//HpEg==
From:   Mark Brown <broonie@kernel.org>
To:     cy_huang@richtek.com
Cc:     lgirdwood@gmail.com, linux-kernel@vger.kernel.org
In-Reply-To: <1686881298-28333-1-git-send-email-cy_huang@richtek.com>
References: <1686881298-28333-1-git-send-email-cy_huang@richtek.com>
Subject: Re: [PATCH] regulator: helper: Document ramp_delay parameter of
 regulator_set_ramp_delay_regmap()
Message-Id: <168692242468.238679.12950223549204587682.b4-ty@kernel.org>
Date:   Fri, 16 Jun 2023 14:33:44 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-c6835
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Jun 2023 10:08:18 +0800, cy_huang@richtek.com wrote:
> With W=1:
> 
>     drivers/regulator/helpers.c:947: warning: Function parameter or member 'ramp_delay' not described in 'regulator_set_ramp_delay_regmap'
> 
> Fix it by documenting the parameter.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: helper: Document ramp_delay parameter of regulator_set_ramp_delay_regmap()
      commit: d3b555e563a0ac80383b66f4ffd8bee2f6272779

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


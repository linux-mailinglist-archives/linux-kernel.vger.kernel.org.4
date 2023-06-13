Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1404E72E844
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 18:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242920AbjFMQSW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 12:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235443AbjFMQSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 12:18:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C2492
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 09:18:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5BAFA632F3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 16:18:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B790C43396;
        Tue, 13 Jun 2023 16:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686673098;
        bh=a2rrXOBNbdz17opc1wDnoKiPwzIuSO/Z+/wGkvgS9ow=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=LUsoAlHVxQ2GCRxBCt2oa1W95dB7y8rR+aRhGio0+7J4ReGojrYa4cDruqm1g4AVD
         51fHNacVjUE42TmmEuui/YfOhEldEeL7V+7ILMrTclj+6AiaZnj0p/JtD8UgCVZDFa
         TZ9etvq7eHs8BJ0tqgNmKqXG4KKhSbGI3XlRQTvB17W5rj7Z84eGYXJAIkWXZCH+79
         /UXYmSpf4M3xT7HDVlutQy9lo/Shq/XQdOtY1ggADCMde1smZvSZumBDQzDEI4/ybd
         6iB4LCtFDEHPhAoxTQgWncd9kHqyH/KMOPa7C4GXPCNqkJBhaLWUODAwTDmru0o3R0
         gdkMuu1MMBSvw==
From:   Mark Brown <broonie@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Waqar Hameed <waqar.hameed@axis.com>
Cc:     kernel@axis.com, linux-kernel@vger.kernel.org
In-Reply-To: <pnd1qifa7sj.fsf@axis.com>
References: <pnd1qifa7sj.fsf@axis.com>
Subject: Re: [PATCH v2] regmap: Add debugfs file for forcing field writes
Message-Id: <168667309723.106862.4715235200493830383.b4-ty@kernel.org>
Date:   Tue, 13 Jun 2023 17:18:17 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bfdf5
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Jun 2023 13:42:27 +0200, Waqar Hameed wrote:
> `_regmap_update_bits()` checks if the current register value differs
> from the new value, and only writes to the register if they differ. When
> testing hardware drivers, it might be desirable to always force a
> register write, for example when writing to a `regmap_field`. This
> enables and simplifies testing and verification of the hardware
> interaction. For example, when using a hardware mock/simulation model,
> one can then more easily verify that the driver makes the correct
> expected register writes during certain events.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/1] regmap: Add debugfs file for forcing field writes
      commit: b629c698eae745eb51b6d92395e2eee44bbf5f49

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


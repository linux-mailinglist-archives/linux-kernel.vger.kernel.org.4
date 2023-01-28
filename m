Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C47AB67F741
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 11:48:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233903AbjA1KsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 05:48:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233099AbjA1KsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 05:48:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 249182CFEA
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 02:48:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B394D60B39
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 10:48:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6586C4339B;
        Sat, 28 Jan 2023 10:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674902888;
        bh=X9g24zwHYHzuWSbHrdtBTwJcaKn7C4eDSMB8zCgqzYM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=cInG9ZbXv3rWjk3KrXGYMnTes/ngAQ77H7cyCUrvd6emb68vGG5wTcZ7JOEYH4CqH
         IjMHAaagJMdhPY6JkQzzkwH7nFpMgghkKpn0rONHJvoVXFTeQeZJFlXLoHNHzWkYmL
         sfkzNZWMq1B0VMiGyOU2nVRvlIto/j2USJFYOUSk7e6rdG1DEeZH+gydhzcv3SlrdI
         Kc4JmEFIVmf+NP/Jvt3lTJo9xJ9w2oJ+sG3zFfwZ1u8BjVmIroTWJxsCPEOJkrXBUa
         BmaPUxjUpgDAL2CT4JdtkbJ4kQ7nbcKy0l1E+qWl1ooPVElnj3+WerZl/h7HLfZOGH
         JUwqpuptPWjjw==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Astrid Rost <astrid.rost@axis.com>
Cc:     kernel@axis.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230123135913.2720991-1-astrid.rost@axis.com>
References: <20230123135913.2720991-1-astrid.rost@axis.com>
Subject: Re: [PATCH v3 0/3] ASoC: simple-card-utils: create jack inputs for
 aux_devs
Message-Id: <167490288646.2145828.6069622969761502857.b4-ty@kernel.org>
Date:   Sat, 28 Jan 2023 10:48:06 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Jan 2023 14:59:10 +0100, Astrid Rost wrote:
> Add a generic way to create jack inputs for auxiliary jack detection
> drivers (e.g. via i2c, spi), which are not part of any real codec.
> The simple-card can be used as combining card driver to add the jacks,
> no new one is required.
> 
> Create a jack (for input-events) for jack devices in the auxiliary
> device list (aux_devs). A device which returns a valid value on
> get_jack_type counts as jack device; set_jack is required
> to add the jack to the device.
> 
> [...]

Applied to

   broonie/sound.git for-next

Thanks!

[1/3] ASoC: soc-component: add get_jack_type
      commit: df55122ba0955951a85ef3ffb19f0dcb0ad3ffbb
[2/3] ASoC: simple-card-utils: create jack inputs for aux_devs
      commit: 9b271207ac83db362fac757d367923bde57dce86
[3/3] ASoC: ts3a227e: add set_jack and get_jack_type
      commit: 087b9dda8658052a33031ef82a8d8ef77a7c94ea

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


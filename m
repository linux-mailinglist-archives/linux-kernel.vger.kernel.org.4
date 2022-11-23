Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 296736366E8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 18:24:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237768AbiKWRYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 12:24:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235917AbiKWRX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 12:23:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F47F8DA57
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 09:23:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D090C61E0F
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 17:23:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64AEBC433D6;
        Wed, 23 Nov 2022 17:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669224238;
        bh=t+/kpnWjuoaG2gEdS5WXbqjAxCPHj7ZSdzUgAZDbWO8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=GTY7aMqmsY6QoSopAnQDpoS7yxhfqG8cWFXSvDP+pjrJXEAvkhsopWMRS5J81mCte
         i+uRyMStVgVvZfJIyBZlZ73cUAHMTjMKoPrPg6wGMw8i22VsrfNf9emZZ+EsfRhFBk
         UwyKi6zS7FpPemX3oi25By09DDl0+sxhF8g1gAflpSUt0hqwW6czmcNVXB1plPfADq
         kn53xs8qCdMFR/6bKswJhMtZwzMudx0NjIPl78BU+ncKVe1Jis/0fR6iuuDPHWlIwo
         2XDtzbG2gS+plaYAgB6IzDTRCSwo+vtCW+VvgTdy1wUjpj+lUKvoezjX0F14RJOqUT
         I46gcyXjD5fyg==
From:   Mark Brown <broonie@kernel.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <cover.1669203610.git.mazziesaccount@gmail.com>
References: <cover.1669203610.git.mazziesaccount@gmail.com>
Subject: Re: [PATCH 0/3] regulator: ROHM BDxxxxx minor print improvements
Message-Id: <166922423714.540277.11534759044448507442.b4-ty@kernel.org>
Date:   Wed, 23 Nov 2022 17:23:57 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Nov 2022 13:59:48 +0200, Matti Vaittinen wrote:
> Minor (printing) improvements for ROHM regulator drivers.
> 
> This series:
> 
>  - Drops an unnecessary info print from bd718x7.
>    (Added a fixes tag for this but not really sure if worth
>    adding to stable)
>  - Convert the ROHM BDxxxxx PMIC regulator drivers to use dev_err_probe().
>  - Change the probe logic for bd718x7 to favor the more usual devm-style
>    where errors are returned immediately.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/3] regulator: bd718x7: Drop unnecessary info print
      commit: 44501eba9bb28946382b7a53099ce8098d1610f0
[2/3] regulator: bd71815: bd71828: bd9576: Use dev_err_probe()
      commit: d4e93e8da012880882671a46ac6ae3aefcae8076
[3/3] regulator: bd718x7: Use dev_err_probe()
      commit: 662a9bf883f42d09145cf083d93dadf0307f15ea

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

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76AD1724157
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 13:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236675AbjFFLzV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 07:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232631AbjFFLzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 07:55:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A45CAE47
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 04:55:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4029F62C0D
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 11:55:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1754C433EF;
        Tue,  6 Jun 2023 11:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686052516;
        bh=AwQKK+vTDce/hOWPJg3SWi3sPnJdf83ZO5vJmOamOkE=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=DHNG6V6/38Q7F4e45zExoOMuNwCarV2zw+iIG35cAsmapdi8OaU9g06REmXqAlMru
         wOgDlyyrGzdqiEAI/GUMHr7dvvi8qgZhxFcdZtpHZv0gmDgJQsQOiRVeCOWzgH3UEg
         gmdVkHWaVpCkhRFOEsi+YyalTDPx0gdnxnfXbd5ugn9lybnz40mzUf7waFN/RwBqBf
         a0lKyXkT7j1al+Q+DzxKI4+V/qK0BRS40FyzHcXKUd9vfM525paXPA+A0UYa6fvkFo
         R3VEwThIWwtxYmuWzrY8vFfeerJVAMj/CvNs7s2j2FDYDjVpZxieRebU8vgNkAlTPB
         /3O6z3ZiBP9+w==
From:   Mark Brown <broonie@kernel.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
In-Reply-To: <20230605143238.4001982-1-rf@opensource.cirrus.com>
References: <20230605143238.4001982-1-rf@opensource.cirrus.com>
Subject: Re: [PATCH] firmware: cs_dsp: Log correct region name in bin error
 messages
Message-Id: <168605251548.20864.13850925270775082245.b4-ty@kernel.org>
Date:   Tue, 06 Jun 2023 12:55:15 +0100
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

On Mon, 05 Jun 2023 15:32:38 +0100, Richard Fitzgerald wrote:
> In cs_dsp_load_coeff() region_name should be set in the XM/YM/ZM
> cases otherwise any errors will log the region as "Unknown".
> 
> While doing this also change one error message that logged the
> region type ID to log the region_name instead. This makes it
> consistent with other messages in the same function.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] firmware: cs_dsp: Log correct region name in bin error messages
      commit: ad24919540fb4df83981d469b5253cc1aecca939

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


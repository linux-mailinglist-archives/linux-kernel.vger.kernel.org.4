Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 353BF6CABD0
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 19:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbjC0R0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 13:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbjC0RZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 13:25:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56D6D40F3;
        Mon, 27 Mar 2023 10:25:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E651D6142F;
        Mon, 27 Mar 2023 17:25:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B68DC433EF;
        Mon, 27 Mar 2023 17:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679937955;
        bh=NN1rXg2/a4OR+Zj8dHIR9eD3NoyL52L9QcXdEkHp2FM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=dQJ+0pqioxl3A/j3OH3nboyWh1VAvrMf2Vb5SSIKQtKUfsgDRviAHzf6WnMu2xeBq
         Wb1xX0wmDiVQH1p57vOxdFs9kwhmuwORbecPJza0sm4s2jl/+aZzU7i0ub2bu3pM9V
         Alvo4r2L/OSgZl+8GeB+7No19K/UmJDbyQCLBcaGk2oYEwWPaxZzxYAJW9srYoie7l
         wBRP1LMfk/AE+TypdAkpqQmfQPu8iDzy6B0buGtmQlPEoUEntfAQ5e98CfBjyozFAJ
         7nmTn5N4V+hHBr0ssfyRtLlgw7R01nBbDEZIVsS5ZQtIUMQb1eYCnNyeO7v2uUEhHS
         lpCCnGaQkjJdA==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
In-Reply-To: <18459fae3d017a66313699c7c8456b28158b2dd0.1679819354.git.christophe.jaillet@wanadoo.fr>
References: <18459fae3d017a66313699c7c8456b28158b2dd0.1679819354.git.christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] regulator: Handle deferred clk
Message-Id: <167993795372.3174190.274005765842328093.b4-ty@kernel.org>
Date:   Mon, 27 Mar 2023 18:25:53 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-2eb1a
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Mar 2023 10:29:33 +0200, Christophe JAILLET wrote:
> devm_clk_get() can return -EPROBE_DEFER. So it is better to return the
> error code from devm_clk_get(), instead of a hard coded -ENOENT.
> 
> This gives more opportunities to successfully probe the driver.
> 
> 

Applied to

   broonie/regulator.git for-next

Thanks!

[1/1] regulator: Handle deferred clk
      commit: 02bcba0b9f9da706d5bd1e8cbeb83493863e17b5

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


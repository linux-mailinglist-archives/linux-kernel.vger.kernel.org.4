Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4DA362C1B5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 16:01:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233632AbiKPPBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 10:01:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233009AbiKPPBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 10:01:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EED6FC4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 07:01:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 42CCB61E31
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 15:01:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5D38C433D7;
        Wed, 16 Nov 2022 15:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668610890;
        bh=2wYCfr+v/AvwHLYVneY8nOtgsL+06z3uFqYRVDKCRow=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=GHcpmxt0r4pM7GI8GUBe8DVbzTOJX/A/l8UZPCQbHU/VD13Ec3WqaUzccOEln++sk
         ekj+GC85dRuIKpON2d/IVjHYlFntOt7tVYeMIXm9zR1UIIidBTUAwzWwmO5fW82VMa
         Smue2ux1/2wypIPIz7t/T17g2EfSu5eWwMGZCLVDOxdHv822SU1R9dDYC3fu1mPEHI
         Vub2/7/1lgGPR8hd3txqExbNBaCV1pPuiF1pBwro3QVXgDIQ252JGFfGwRYAfClpr8
         cUoV0vqpVUhM1eXctd0TOPYS9w4hEd+RtAKPNdzoPCEUar3U59vqmeHDogE8gbx2zD
         RHagJ0782cGXA==
From:   Mark Brown <broonie@kernel.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     linux-kernel@vger.kernel.org
In-Reply-To: <Y3R13IRrs+x5PcZ4@dc75zzyyyyyyyyyyyyydt-3.rev.dnainternet.fi>
References: <Y3R13IRrs+x5PcZ4@dc75zzyyyyyyyyyyyyydt-3.rev.dnainternet.fi>
Subject: Re: [PATCH RESEND] lib/test_linear_ranges: Use LINEAR_RANGE()
Message-Id: <166861088942.540847.6108812744052381919.b4-ty@kernel.org>
Date:   Wed, 16 Nov 2022 15:01:29 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-8af31
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Nov 2022 07:32:12 +0200, Matti Vaittinen wrote:
> New initialization macro for linear ranges was added. Slightly simplify
> the test code by using this macro - and at the same time also verify the
> macro is working as intended.
> 
> Use the newly added LINEAR_RANGE() initialization macro for linear range
> test.
> 
> [...]

Applied to

   broonie/regulator.git for-next

Thanks!

[1/1] lib/test_linear_ranges: Use LINEAR_RANGE()
      commit: bc64f30eb9a5edb299ee0a1a05cc21e4079fd9f3

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

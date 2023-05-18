Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C311B7086FE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 19:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbjERRdg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 13:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbjERRd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 13:33:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90DC01BF
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 10:33:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 20C6C65146
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 17:33:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58464C433D2;
        Thu, 18 May 2023 17:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684431204;
        bh=O7NzANsucBQTK8Jy2JnxxwlTMprkBLa749VfrRkMdRI=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Sfxz2DfG8apxlBN5LVVguKLk1pqhvDzMvvYS3mKO7zgrq0G0+qHEhDMOOc5Pp1e11
         CBnogkOxMZxWzF7d+omVe9/g4fVoIdvtfpDC5Kl2rzCRAUPfYefQzLG7/TwIm4uWlj
         A9sUwAsY9N/Cd7fMV7SLr04iMSqiX8A6vmy5xm2JVWMSpzMUDOgW16cqXU8RDyfXld
         QhtLtfx7yw25sMsg9KXpfvn+zq27UKASBGe2sMKHYgoRriKLRxwYG2lxPRb4c82Pc7
         ZhMFpE7H9+G8OSrktnWj1EVN6eeW5UadGSmLRx2Rm8RPDzOgP76alnm/iaAnXgvIHy
         KpHdnV/68xcWQ==
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     =?utf-8?q?M=C3=A5rten_Lindahl?= <marten.lindahl@axis.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230516082333.466429-1-axel.lin@ingics.com>
References: <20230516082333.466429-1-axel.lin@ingics.com>
Subject: Re: [PATCH] regulator: tps6287x: Fix missing .n_voltages setting
Message-Id: <168443120315.483131.2571327595680974458.b4-ty@kernel.org>
Date:   Fri, 19 May 2023 02:33:23 +0900
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

On Tue, 16 May 2023 16:23:33 +0800, Axel Lin wrote:
> Otherwise, regulator_list_voltage() will return -EINVAL.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: tps6287x: Fix missing .n_voltages setting
      commit: 15a1cd245d5b3cc6cf42ca9ceacf9a6dfc2e33b4

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


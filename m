Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 334695BD7D6
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 01:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbiISXKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 19:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiISXJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 19:09:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F3416364
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 16:09:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1D15C620DA
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 23:09:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4589C433C1;
        Mon, 19 Sep 2022 23:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663628992;
        bh=igYKGEMkVWZdVGm2ELsEz7si+LPkcjdSY2Z7eWGUFJo=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Alk8/hF8nfIlempZVl9m7mGDOD6fET76tus9iC7WtCzClw30IsM6huQt9WG6OiNw1
         cF2l+5VfLNJ/j8fMc8kg1nYdXLuzC+O+O0JsRZOz4PlejLV0JwP1qNqlknypzvGV4l
         6bwAZnPZeArHaXjfSWeEjmReX7gsfUlrx9Q4nmBeLZVYWMMLkR0TGIGq8/8qSo+By8
         njwsTDKNvT0QhFv6XioyODHk9p4pJj4JdQZNlPYy4/Vzq9MW/itgoG8UBkxr8ph4Am
         r2mwth4rvmd6MqnbeFpJOt5FeXXElWpjQNa+5uiadIt7eg08PMqOTC+rM6TUSMOB6a
         N7HNmM6OiVGgg==
From:   Mark Brown <broonie@kernel.org>
To:     cgel.zte@gmail.com
Cc:     ye xingchen <ye.xingchen@zte.com.cn>, Vsujithkumar.Reddy@amd.com,
        linux-kernel@vger.kernel.org, baijiaju1990@gmail.com,
        tiwai@suse.com, AjitKumar.Pandey@amd.com, akihiko.odaki@gmail.com,
        perex@perex.cz, Zeal Robot <zealci@zte.com.cn>,
        lgirdwood@gmail.com, alsa-devel@alsa-project.org
In-Reply-To: <20220916062027.152815-1-ye.xingchen@zte.com.cn>
References: <20220916062027.152815-1-ye.xingchen@zte.com.cn>
Subject: Re: [PATCH linux-next] ASoC: amd: acp: use function devm_kcalloc() instead of devm_kzalloc()
Message-Id: <166362898954.3419825.40424963961525082.b4-ty@kernel.org>
Date:   Tue, 20 Sep 2022 00:09:49 +0100
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

On Fri, 16 Sep 2022 06:20:27 +0000, cgel.zte@gmail.com wrote:
> From: ye xingchen <ye.xingchen@zte.com.cn>
> 
> Use 2-factor multiplication argument form devm_kcalloc() instead
> of devm_kzalloc().
> 
> 

Applied to

   broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: acp: use function devm_kcalloc() instead of devm_kzalloc()
      commit: f047199e6f3115896fee25ac8809e1a9a8c948fc

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

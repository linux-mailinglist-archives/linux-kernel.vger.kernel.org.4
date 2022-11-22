Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4687B633F3C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 15:49:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233287AbiKVOtl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 09:49:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233283AbiKVOtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 09:49:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A89966C83;
        Tue, 22 Nov 2022 06:49:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2E32DB81B9C;
        Tue, 22 Nov 2022 14:49:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B614C433C1;
        Tue, 22 Nov 2022 14:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669128567;
        bh=a3OVo2P+U554M6HgyX1t5OpywxtfTWA1mgEyuhYxNY0=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=F0QS8ohhUzRk3xijpbtDWtMrlkM1QsQADLZ+Bd3g9G5kMd+pAtLQbdcFlSZ1HNNvr
         X2+ylyneTh4cF/JpVZxjgmnCnF275IoQQdlujbX1fSDRY81iAe0jxGwW0hc+U62lDa
         Qq9ITu2dtdj5lOxn4u9vVA/mrYOZzTgUvFe+QPDMx6/QiN77Hs/uRpfI/8rseJV2U9
         nkwSNhZVSPx7Yntc1m+Q1g1oOlR4b4M9RXvMG0p10HycyqFWeTAqmraNwUSD1Bhk3s
         y6EEMvCw6PX1YuP2d8RP/NDo8HXescOYAHWAsrqXDfXbqP8XGTPdHpxYn3kPgBpgl5
         Y0q29MiNrimcg==
From:   Mark Brown <broonie@kernel.org>
To:     linux-omap@vger.kernel.org, tony@atomide.com, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, Nicolae_Rosia@mentor.com,
        Andreas Kemnade <andreas@kemnade.info>
In-Reply-To: <20221120221208.3093727-1-andreas@kemnade.info>
References: <20221120221208.3093727-1-andreas@kemnade.info>
Subject: Re: [PATCH 0/2] regulator: twl6030: some TWL6032 fixes
Message-Id: <166912856621.213500.2092954918480556621.b4-ty@kernel.org>
Date:   Tue, 22 Nov 2022 14:49:26 +0000
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

On Sun, 20 Nov 2022 23:12:06 +0100, Andreas Kemnade wrote:
> There are some problems regarding TWL6032 regulators, including
> inconsistent states. They come to light during porting support
> for the Epson Moverio BT-200 to newer kernels.
> Information sources are the 3.0 vendor kernel
> (http://epsonservice.goepson.com/downloads/VI-APS/BT200_kernel.tgz)
> and git blame archeology.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/2] regulator: twl6030: re-add TWL6032_SUBCLASS
      commit: 3d6c982b26db94cc21bc9f7784f63e8286b7be62
[2/2] regulator: twl6030: fix get status of twl6032 regulators
      commit: 31a6297b89aabc81b274c093a308a7f5b55081a7

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

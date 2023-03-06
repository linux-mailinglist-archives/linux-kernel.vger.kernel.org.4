Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF836AC128
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 14:33:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231325AbjCFNcz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 08:32:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231284AbjCFNcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 08:32:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA0D2F781;
        Mon,  6 Mar 2023 05:32:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 23F1B60F09;
        Mon,  6 Mar 2023 13:32:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07D3CC433A0;
        Mon,  6 Mar 2023 13:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678109533;
        bh=C5gzhVF9al1Ieb6s0tZHqRx2Mp9qfAXbdc2k184yTRM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=HqvWr+PJYwmxlnrMtIUVJEuCr8bYL535EiI2gpO87jDCnN+pRkwY6IwlTn6uOGbnu
         jCXaGuEGK9Rc5Ke3vC7QJ0DXrz0ksTygK3duhgllXuV+yQ1kPDzUMPDdm9Uqe4BMx8
         S5JaBRVYDmX4sVe7u9c5J7zT+OQqyGoJ1zulNeUTEWM/9m9RPpeWSO/lIlBWURlno9
         113ChyVWeZTFePNwGUibtPwA3veBqO9IhPGYmAd34JjNEk3WVosLW549sNSEjOk5AR
         JKhTtyyheF3mFJtGeKhjcrch9EjIgxZwrfOdQIn6ncBdFtAcODgrU+buOS5axTYfdv
         IMiC5TMj356Rw==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Ladislav Michl <ladis@linux-mips.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Benjamin Bara <benjamin.bara@skidata.com>,
        richard.leitner@linux.dev
Cc:     Benjamin Bara <bbara93@gmail.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Richard Leitner <richard.leitner@skidata.com>
In-Reply-To: <20230302-max9867-v2-0-fd2036d5e825@skidata.com>
References: <20230302-max9867-v2-0-fd2036d5e825@skidata.com>
Subject: Re: [PATCH v2 0/3] Add "mclk" support for maxim,max9867
Message-Id: <167810953075.75807.14829875612499629879.b4-ty@kernel.org>
Date:   Mon, 06 Mar 2023 13:32:10 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bd1bf
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 03 Mar 2023 11:04:00 +0100, richard.leitner@linux.dev wrote:
> This series adds support for the clocks properties in the
> maxim,max9867 bindings. Furthermore the binding definitions are
> converted from txt to yaml.
> 
> The clock property is needed to define the mclk for one of our
> boards which uses the the i.MX8MP SAI MCLK as clock for the
> maxim,max9867.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC: dt-bindings: maxim,max9867: convert txt bindings to yaml
      commit: 6668f70abeea30f4674b2fdbc4232d5c3611b272
[2/3] ASoC: dt-bindings: maxim,max9867: add clocks property
      commit: d63e55b3e8ec90da69107f32038f3059d7317cc5
[3/3] ASoC: maxim,max9867: add "mclk" support
      commit: 448b06ba107d925d59d02781acdd2e4ad12dda0b

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


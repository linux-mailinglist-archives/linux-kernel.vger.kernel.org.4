Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E92A63C060
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 13:54:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234694AbiK2Myr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 07:54:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233258AbiK2Myp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 07:54:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A62E92A964
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 04:54:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3DE9861712
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 12:54:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70C65C433D6;
        Tue, 29 Nov 2022 12:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669726482;
        bh=FS3QMf7lGbiy4UrDmdlvwB6d5Iy1+qNxQTClB3jGvBA=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=TLFeYOvdBP12WjyOSZBULkQkjnpnWzKTTq25ud8FgBgKtEUGeL4eAWOxEvpci+wjo
         fcuXABsBOBx+MF++qNA4Tmlk0/Gx9tjy48hVyOTdxiSqF8xEx9kkE9W4tP6T4PZy9C
         kkLkQPhSR8BQEBlomqtAx41bO1Ot9F5pkm8KfTF4YKmwFoIxaQaH/1xaNopcF0WWaH
         LwmbqOE4NisLSJI9TzS3HJbFKrE/Vitqkqy7K1fgK2sHZWPgeP2/YigaX4DB1pbcoh
         VT96A5ZGdluT9Q/LQNVb5UkXGGdiT8jN5Glcd8H8Xv1ghJghlQSWgsv7gE+C0IsxN6
         KgzBmqEX5g9ZA==
From:   Mark Brown <broonie@kernel.org>
To:     Matthias Kaehlcke <mka@chromium.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Takashi Iwai <tiwai@suse.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        alsa-devel@alsa-project.org, Judy Hsiao <judyhsiao@google.com>
In-Reply-To: <20221129001633.v2.1.I8d1993f41f0da1eac0ecba321678ac489f9c0b9b@changeid>
References: <20221129001633.v2.1.I8d1993f41f0da1eac0ecba321678ac489f9c0b9b@changeid>
Subject: Re: [PATCH v2] ASoC: qcom: lpass-sc7180: Delete redundant error log from _resume()
Message-Id: <166972648016.69085.432837268858452614.b4-ty@kernel.org>
Date:   Tue, 29 Nov 2022 12:54:40 +0000
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

On Tue, 29 Nov 2022 00:16:54 +0000, Matthias Kaehlcke wrote:
> sc7180_lpass_dev_resume() logs an error if clk_bulk_prepare_enable()
> fails. The clock framework already generates error logs if anything
> goes wrong, so the logging in _resume() is redundant, drop it.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: qcom: lpass-sc7180: Delete redundant error log from _resume()
      commit: 863b9179cee4570e5da4206dcf8dbcdcc37c8348

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

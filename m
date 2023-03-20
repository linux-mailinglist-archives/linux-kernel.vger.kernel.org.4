Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C8DE6C20F3
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 20:10:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbjCTTKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 15:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231569AbjCTTJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 15:09:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A75BA23D94
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 12:02:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0391B617C3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 19:01:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B214BC433D2;
        Mon, 20 Mar 2023 19:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679338902;
        bh=auoVdYOtaFZ7tJjU2PveRBMXElKWNrfOoBepx/ROR7w=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=sii6LBOrtHqKJG7Y4YUz31i2tN7Fh5MlZ/uEP+6QGMmYIWrXXnEsXwKogUun+TefF
         9lzNKuwjVTqKv6IyFnu3dTvOdSAOlSg3xtV8XFBuJV1flPTBo36lRR1h3TErUWGJnp
         IaK4Kdvn9G9Iv0ZxIkEEOomqG4USntrIUvDoB5Pb6iK1eKROGdWMslGIW1w0zqgWE+
         jC4w7YUMTt7VnEJoiKG+M/0yT7xKYBX7lHdEO4AEnQY31sLAaU7VbdDLiPJJt3Cp8G
         S5916enHPd5CGgklvnbH/tbPhkppVmgGK7YqxCv+lH+M0XMMNMrYrfrXepU29nqKI6
         yvKpgQ4rxK8+g==
From:   Mark Brown <broonie@kernel.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     mka@chromium.org, Liam Girdwood <lgirdwood@gmail.com>,
        Saravana Kannan <saravanak@google.com>,
        dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org,
        swboyd@chromium.org, briannorris@chromium.org
In-Reply-To: <20230316195444.3946980-1-dianders@chromium.org>
References: <20230316195444.3946980-1-dianders@chromium.org>
Subject: Re: [PATCH 0/7] regulator: Set PROBE_PREFER_ASYNCHRONOUS for
 everything in drivers/regulator
Message-Id: <167933890042.207143.7298283262381290865.b4-ty@kernel.org>
Date:   Mon, 20 Mar 2023 19:01:40 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bd1bf
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Mar 2023 12:54:37 -0700, Douglas Anderson wrote:
> This series directly follows from the discussion when I tried to turn
> on PROBE_PREFER_ASYNCHRONOUS just for the fixed-regulator [1] and
> attempts to switch everything in drivers/regulator over to async
> probe.
> 
> Like the similar patch series I did for the MMC subsystem a few years
> ago [2], I've split this patch series into batches corresponding to
> drivers corresponding to actively maintained stable kernel trees with
> the idea to break the patch series up somewhat.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/7] regulator: Set PROBE_PREFER_ASYNCHRONOUS for drivers that existed in 4.14
      commit: 259b93b21a9ffe5117af4dfb5505437e463c6a5a
[2/7] regulator: Set PROBE_PREFER_ASYNCHRONOUS for drivers between 4.14 and 4.19
      commit: ed6962cc3e05ca77f526590f62587678149d5e58
[3/7] regulator: Set PROBE_PREFER_ASYNCHRONOUS for drivers between 4.19 and 5.4
      commit: d3b81d97d55871cb11412caedded440f1fddc4e9
[4/7] regulator: Set PROBE_PREFER_ASYNCHRONOUS for drivers between 5.4 and 5.10
      commit: 67dc71c61b64be85ce33d3332ca5511f9b1faef7
[5/7] regulator: Set PROBE_PREFER_ASYNCHRONOUS for drivers between 5.10 and 5.15
      commit: 46600ab142f8c2ecc2a647175fd86d53bc285a9a
[6/7] regulator: Set PROBE_PREFER_ASYNCHRONOUS for drivers between 5.15 and 6.1
      commit: 41cff178e3d6df28acd8490519a656c509b4496f
[7/7] regulator: Set PROBE_PREFER_ASYNCHRONOUS for drivers that are newer than 6.1
      commit: bdce47bb19cbf7784d48e93677c868a69dbae439

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


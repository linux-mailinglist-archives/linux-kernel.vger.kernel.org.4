Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E63F76FEB80
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 08:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236468AbjEKGDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 02:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236812AbjEKGC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 02:02:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F8AE4C1F
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 23:02:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5353664AF5
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 06:02:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A10FC433EF;
        Thu, 11 May 2023 06:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683784974;
        bh=ab8zpCraWRQK2aWKTLGLlDBVYV4HywcNfc6Jb271giY=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=GeJyNjgHtviLcLtmLCHI1ZuGYJ50p64RnElp4xPJsIjRXpWvTb8ZpwLW3M8sLj7k+
         fcohTQNgGbJw73U1XwI9qsxKGLk8+Js3Cs1FPaPTwHHCtxn/syMQXkjZfjbfvfzl1Q
         behZIG/uinSPuftz2U3Si89BEP/NDWyN3O2AW2iSc+Q2flqx165SIp7ap+JzGbDRvF
         NpLbUaVKfh5hr6OMObnGZJSJwbFw/2QyBBtyI9ZAtCjgpmrPstygqed0OP3Rb+eFMj
         ZBr8tuUzYfDfabtb7wB/GS+2nWaBCiY6iT8uZ1Q3f+3w7+YPZxGbdaI1Gr6S/aT5uc
         IARs+mA9tddTQ==
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     perex@perex.cz, tiwai@suse.com, lgirdwood@gmail.com,
        ckeepax@opensource.cirrus.com, kuninori.morimoto.gx@renesas.com,
        linux-kernel@vger.kernel.org, pierre-louis.bossart@linux.intel.com,
        alsa-devel@alsa-project.org
In-Reply-To: <20230509112202.21471-1-srinivas.kandagatla@linaro.org>
References: <20230509112202.21471-1-srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH 0/4] ASoC: qcom: add display port module support.
Message-Id: <168378496820.334814.7836507648668066206.b4-ty@kernel.org>
Date:   Thu, 11 May 2023 15:02:48 +0900
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

On Tue, 09 May 2023 12:21:58 +0100, Srinivas Kandagatla wrote:
> This patchset adds support to displayport on AudioReach.
> Patches are tested on X13s with two display ports.
> 
> Srinivas Kandagatla (4):
>   ASoC: qcom: q6dsp-common: move channel allocation to common
>   ASoC: qcom: audioreach: add support for DISPLAY PORT SINK module
>   ASoC: qcom: q6dsp: add support to more display ports
>   ASoC: qcom: q6apm: add support to display ports in lpass dais
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/4] ASoC: qcom: q6dsp-common: move channel allocation to common
      commit: 4c2be53f411c25b569c8fe3f91d0acfc4c5b8392
[2/4] ASoC: qcom: audioreach: add support for DISPLAY PORT SINK module
      commit: a8ab65417d92803d15cc9aca461ecd9fdb3f2d81
[3/4] ASoC: qcom: q6dsp: add support to more display ports
      commit: 90848a2557fec0a6f1a35e58031a1f6f5e44e7d6
[4/4] ASoC: qcom: q6apm: add support to display ports in lpass dais
      commit: 2f6860e6133fca937d18b66faa32c460cef7ddad

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


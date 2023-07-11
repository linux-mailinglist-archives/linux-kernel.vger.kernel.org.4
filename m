Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59C7C74F940
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 22:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbjGKUok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 16:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbjGKUoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 16:44:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E96419BD
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 13:44:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4512B61615
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 20:44:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB0F5C433C7;
        Tue, 11 Jul 2023 20:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689108251;
        bh=WvLzSisJq2oRKTEyDbk28Gk5dGNC5kCY3InHxU+5L/s=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=WRE9flHX5D5Wxpf4PQ+f0TqDt7ibqwU0d/x0UIW8QpB6EnSuVLgDLXnG3XR2h7I/0
         YPOKEdR+f7hXXcUpjGjg82DVktk35wohrU2XStSuOwfvsAKAN4jpXrUr09VJc70TiV
         h6ieUp4xnEOqrl9uBxFNrkAQg6Pptz4bfIvvrhFw/LLiDU3SqR/fBELEegCi8ery5J
         DQuO2eXbKV0PrHxShYQBLfcc1W5KH+L4QRGwk8C7oFMx7Z2w7YochMdL60kIK8uiZD
         GrfGwvvoOItVUXaJFbXA2WlfIi5oTsEvqZJuAspfeS5a7Z1se+32KEuEZICF9boUVy
         l+CA/1mzPdNSg==
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     johan+linaro@kernel.org, perex@perex.cz, tiwai@suse.com,
        lgirdwood@gmail.com, ckeepax@opensource.cirrus.com,
        kuninori.morimoto.gx@renesas.com, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org
In-Reply-To: <20230705131842.41584-1-srinivas.kandagatla@linaro.org>
References: <20230705131842.41584-1-srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH] ASoC: qcom: q6apm: do not close GPR port before
 closing graph
Message-Id: <168910824948.478364.14308031274089171698.b4-ty@kernel.org>
Date:   Tue, 11 Jul 2023 21:44:09 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 05 Jul 2023 14:18:42 +0100, Srinivas Kandagatla wrote:
> Closing GPR port before graph close can result in un handled notifications
> from DSP, this results in spam of errors from GPR driver as there is no
> one to handle these notification at that point in time.
> 
> Fix this by closing GPR port after graph close is finished.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: qcom: q6apm: do not close GPR port before closing graph
      commit: c1be62923d4d86e7c06b1224626e27eb8d9ab32e

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


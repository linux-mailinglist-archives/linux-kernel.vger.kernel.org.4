Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26D1D73AC91
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 00:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbjFVWeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 18:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231389AbjFVWd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 18:33:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B771195
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 15:33:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B07661923
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 22:33:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDA44C433CC;
        Thu, 22 Jun 2023 22:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687473233;
        bh=pVo+/ISXibiLscmCDNLsV1/WF9MElrFoN9dy+8aHC3w=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=tMY4mvc2IEk3huRUmyd+CKSIQAg1Fq5ZpTvMm8j5idWbc8/Mgvh3uMK1sWAbWc1id
         Z81MdZKEwFZv4FWArTsafK1cLI/l+SkwloUA4P9hj79JW8pyPp6jQNCJm772mOuACm
         7tEfX4TKkP3DBZ7VjlGRu6q3Ym799nOHoVbGxRKCOy6v3IHaNKbIEx7K+ZIU4ODdtw
         Sr+MsXl6PpDKsLVwIoZ2S4UVq7QsNZyB50CHN83OlVlmClBxRTNpe3g2KpreDY/4vi
         8Hx9JxHmjPlmQkHWKkSf7Csvk/LyVQ7irOU9XOeNCDfUMch/NmZ6HIhcHEj7QXMpia
         m4bCIYUTRMNlw==
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        steev@kali.org, johan+linaro@kernel.org, quic_bjorande@quicinc.com
In-Reply-To: <20230302120327.10823-1-srinivas.kandagatla@linaro.org>
References: <20230302120327.10823-1-srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH] ASoC: qcom: common: add default jack dapm pins
Message-Id: <168747322954.318849.3017080931137286900.b4-ty@kernel.org>
Date:   Thu, 22 Jun 2023 23:33:49 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-c6835
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 02 Mar 2023 12:03:27 +0000, Srinivas Kandagatla wrote:
> If the soundcard does not specify the dapm pins, let the common
> code add these pins for jack.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: qcom: common: add default jack dapm pins
      commit: 82f76ac26c601c5b0c0db7f69500efc42f2ee7ed

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


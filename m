Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8879C6C7FBE
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 15:19:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbjCXOT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 10:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbjCXOTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 10:19:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5566BDEA
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 07:19:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8792FB82436
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 14:19:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C651DC433D2;
        Fri, 24 Mar 2023 14:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679667561;
        bh=dJfy8OilMODSedOI7pACYjRnM5TgCX4zPYcoJUl6/oE=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=N9JCIJ4iCqITSnbXftVrNfo9VS0OqlzqKVX8dX8tct7NgpHQTLR1JEvfoYX8Ijf3c
         C0ohXZAufysBv9a7DnZs68xjZaPkLMvhZEnGl6xJ59TbEqxyzWJlKVBXR3aGiprmNR
         l/FCv7B+Fxtu/7oix31N/mFGclmhKRi6y/HJ/U3pNzfs+h1Dev8Wx7WMLiq0JMTONT
         vLlfIDahD3kVKQ8nDazqWcar/I/nV1Pa+1fPl5udWQTrciPr3b/ueuSAReXekUHUGQ
         Tx88E3fTFl0XeTs1K0254BKTA5/QoZyDtoTebCHVvwc050kqTyISuTGooHLJnBZ4kO
         A3dSKTTvnzcWA==
From:   Mark Brown <broonie@kernel.org>
To:     james.schulman@cirrus.com,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     david.rhodes@cirrus.com, tanureal@opensource.cirrus.com,
        rf@opensource.cirrus.com, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
In-Reply-To: <20230324022303.121485-1-jiapeng.chong@linux.alibaba.com>
References: <20230324022303.121485-1-jiapeng.chong@linux.alibaba.com>
Subject: Re: [PATCH] ASoC: cs35l56: Fix an unsigned comparison which can
 never be negative
Message-Id: <167966755845.2601012.3004981341441229674.b4-ty@kernel.org>
Date:   Fri, 24 Mar 2023 14:19:18 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-2eb1a
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Mar 2023 10:23:03 +0800, Jiapeng Chong wrote:
> The variable 'rv' is defined as unsigned type, so the following if
> statement is invalid, we can modify the type of rv to int.
> if (rv < 0) {
> 	dev_err(cs35l56->dev, "irq: failed to get pm_runtime:
> 		%d\n", rv);
> 	goto err_unlock;
> }
> 
> [...]

Applied to

   broonie/sound.git for-next

Thanks!

[1/1] ASoC: cs35l56: Fix an unsigned comparison which can never be negative
      commit: ab76c891a687ae871f7e76dbf9bc3a0e32b53423

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


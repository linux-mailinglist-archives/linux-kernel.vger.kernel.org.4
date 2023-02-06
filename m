Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A4F068C03E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 15:36:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231437AbjBFOgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 09:36:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjBFOgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 09:36:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B998C274B5
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 06:36:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5B40460EE7
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 14:36:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D1CFC4339B;
        Mon,  6 Feb 2023 14:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675694198;
        bh=yHYu+XzXlkG74Rowq5WgT+fYwuPOyt6C56eAXo8PVUg=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Nmb59Yipa2fzBmHojOzcZen7S/Co8Mop20HmPhtR73KjYoiorQJHzu3bfutBqp7c9
         mbY5KqUw8sklTjix2HnauJJcFfbXa9GAK+7TNRbo70Kd+4YMnohq3duFf0ox0/LDmG
         PhcKX6Mx8/vawf4txzUiQL5YaOQVNAFCcxnfEBGSu19sQ3KzVnDnTkymIk8FcbJ3am
         yi6IxucxGlO5w/v/UlwE1K9ZCXw/JNTf23k5VVkfNtBlH0iZYRMYzVN15PeRkH+/Jk
         1WiaFeIsDSD80Y0Ay2EmiaWbUYzDfhLDsRKCYBY2XkVid0vEa8pOXqPKQ4vfwbEJyl
         cLP11lzFcg8vw==
From:   Mark Brown <broonie@kernel.org>
To:     herve.codina@bootlin.com,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
In-Reply-To: <20230206075518.84169-1-jiapeng.chong@linux.alibaba.com>
References: <20230206075518.84169-1-jiapeng.chong@linux.alibaba.com>
Subject: Re: [PATCH] ASoC: codecs: Fix unsigned comparison with less than
 zero
Message-Id: <167569419690.112200.18153004460501588598.b4-ty@kernel.org>
Date:   Mon, 06 Feb 2023 14:36:36 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 06 Feb 2023 15:55:18 +0800, Jiapeng Chong wrote:
> The val is defined as unsigned int type, if(val<0) is redundant, so
> delete it.
> 
> sound/soc/codecs/idt821034.c:449 idt821034_kctrl_gain_put() warn: unsigned 'val' is never less than zero.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: Fix unsigned comparison with less than zero
      commit: 05f5504b161054bdce74eef5d9ff602bbebaeca8

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


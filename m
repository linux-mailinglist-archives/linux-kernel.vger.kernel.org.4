Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B46A6B815E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 20:07:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbjCMTHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 15:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbjCMTHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 15:07:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BC94584B4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 12:07:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9071A6148E
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 19:07:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92246C4339C;
        Mon, 13 Mar 2023 19:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678734463;
        bh=ZuSDX5rYmGMOCuLmkY33ZeNcxthLztyqURCdRdw8JL0=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=jrEcryFrfiEjYX1bmlj29MXtjQk2hy12glEHEoFlP1MFwebAY/Ns+JNESdIERY33e
         GKVNw9iA4EuK7OL10MuQPb20YdS0rYgWWAPMMMKlqkyPvbh9YfT0nKwCsAhtJ7Z7pM
         vrRvHQc8nV2uZ2UJOPLa2Xs2gM0IxPTSEPmmteihd/tKw3n8pXqHNYgXQbHuDEvCmn
         t8dLr0LunUlQJNHtp+/5kjIiI84ExfnXkfmFrkcmDK3kqajm5oK/9gczOJYyigTfpz
         zoA5Ksy4MHDCzfJzpdLSZp4njNson42lyPr8mQHq4TmWgPcIGMgkipUcSLT2pvXMNb
         dv2J9ICdIiLyQ==
From:   Mark Brown <broonie@kernel.org>
To:     kiseok.jo@irondevice.com, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, Tom Rix <trix@redhat.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230309140959.2616497-1-trix@redhat.com>
References: <20230309140959.2616497-1-trix@redhat.com>
Subject: Re: [PATCH] ASoC: SMA1303: set sma_i2c_regmap
 storage-class-specifier to static
Message-Id: <167873446131.106067.2236196636490693766.b4-ty@kernel.org>
Date:   Mon, 13 Mar 2023 19:07:41 +0000
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

On Thu, 09 Mar 2023 09:09:59 -0500, Tom Rix wrote:
> smatch reports
> sound/soc/codecs/sma1303.c:1594:28:
>   warning: symbol 'sma_i2c_regmap' was not declared. Should it be static?
> 
> sma_i2c_regmap is only used in sma1303, so it should be static
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SMA1303: set sma_i2c_regmap storage-class-specifier to static
      commit: d7d103d1779c3d0bc4d55f2802930a6b067450c0

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


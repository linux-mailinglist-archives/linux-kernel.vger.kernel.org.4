Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7320F6FBF57
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 08:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234940AbjEIGjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 02:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234909AbjEIGjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 02:39:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39D61AD33
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 23:38:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CB88462E95
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 06:38:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3B35C433EF;
        Tue,  9 May 2023 06:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683614335;
        bh=wNzKQRvFcfMVUIvv9+cNT/9rkrHms8a9kZvsENS9+os=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=OUl0rrj95UTRGzGCvWR57cGDl6SRnVxV7IYotdf1W75dAYG+/HRYqZ+6llpb43EuN
         P1Xu2xV7SZidT66XI0KjGv4+JN3SLF4RxkDhF9lXIJ1y7P1XBCj+XVxi8fqdUoj9GO
         JxBynGXAP3HqhP137wy0wE4OfHFTjAQ2IFxGPQZU4FL7LRjCSirJtbbEfIdnyJvdtt
         wLLOBhhc/q8GNQUee6vh2l9dkBkumyr+cwWoF+t707RYcmZWoKEroOxHktSNJ5CMbJ
         NK5oQHKqDVt3lGxlOI3Nk6wunbTRUnChQBdOjtDUO+oP/Ko505uNU1bnfPe6GPEi68
         G0EQSLnXORCEg==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, Yang Li <yang.lee@linux.alibaba.com>
Cc:     perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
In-Reply-To: <20230505004538.70270-1-yang.lee@linux.alibaba.com>
References: <20230505004538.70270-1-yang.lee@linux.alibaba.com>
Subject: Re: [PATCH -next] ASoC: codecs: wcd938x: Remove unneeded semicolon
Message-Id: <168361433237.303059.8240679146907792775.b4-ty@kernel.org>
Date:   Tue, 09 May 2023 15:38:52 +0900
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

On Fri, 05 May 2023 08:45:38 +0800, Yang Li wrote:
> ./sound/soc/codecs/wcd938x-sdw.c:1274:2-3: Unneeded semicolon
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: wcd938x: Remove unneeded semicolon
      commit: 101b23830d3c26e9549274d16e8d4542c8bce4af

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


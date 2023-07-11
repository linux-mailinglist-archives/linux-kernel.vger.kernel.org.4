Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F77674F93E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 22:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbjGKUoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 16:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbjGKUoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 16:44:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E0E1716
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 13:44:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0F09D61615
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 20:44:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DB39C433C8;
        Tue, 11 Jul 2023 20:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689108246;
        bh=wQW4GBLchAMNvg0zf9lV5IU0ctx7DGvRlxsvP/ATa+8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=rTqvPzGG1ppsoIhKChbMaWF+HRAtG5ie1lyLUeXCFW7AwFq7fUXDa+ye4znhLsamH
         XJqvcQg1d1Y5FDvJ6MTzdKuD6LzPJG8aucajJlXDqL45OE6jkncze+1uUwQUyEdsl0
         gHqYAE2k4LUgfxia9KLPSl6ccN5paX85t3HrPjxMW24P+Ew6PnhfTva5K9AvPjul+k
         LXh+0dUBDzchhq+omXRfdnfsmhTSranBX4DOOyyA7lf1j7ew0wJtT7usC+T1kQxvfO
         wbjtBLDKn02YDqJDqE43baudBVCyqHIPiUXh+lFmQUd+C6vkqor+5lVx82jtHi2yhe
         Hlwbmelp0z7Tw==
From:   Mark Brown <broonie@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Lee Jones <lee@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Benjamin Gray <bgray@linux.ibm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
In-Reply-To: <cover.1688643442.git.geert@linux-m68k.org>
References: <cover.1688643442.git.geert@linux-m68k.org>
Subject: Re: (subset) [PATCH 0/3] regmap: Fix REGMAP selections
Message-Id: <168910824397.478364.12914850721215732231.b4-ty@kernel.org>
Date:   Tue, 11 Jul 2023 21:44:03 +0100
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

On Thu, 06 Jul 2023 13:42:01 +0200, Geert Uytterhoeven wrote:
> 	Hi all,
> 
> This patch series fixes several missing selects related to REGMAP.
> 
> The first patch fixes a serious thinko I made when making the regmap
> KUnit test depend on REGMAP.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[3/3] ASoC: codecs: SND_SOC_WCD934X should select REGMAP_IRQ
      commit: e231cd833f6463e9a1d54acae9614b513c74d45e

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


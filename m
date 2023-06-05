Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBDB87229EE
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 16:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234181AbjFEOzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 10:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230503AbjFEOzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 10:55:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18AA49E
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 07:55:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9EF8F62656
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 14:55:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE453C433D2;
        Mon,  5 Jun 2023 14:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685976934;
        bh=dsKLKUnSC7Lzve2PHpaN+dv2LWO64PBoXx6bYC755Pc=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=S+ftYoYQpGacxIKa1yAwv29a0D6wK+DJ8wWpQS81Tn5VEHNH5AgLMa/6KT2WcIagp
         PYvpxKY74SRtx2px4TO5oGTiNPZFtOH5g1J2LMTirs2dR21jf/bS2+oS1wpX1ZxJlb
         s24I+RSMcID6gT51C2FznLmM1yULh21mEM+pWlppWUktdAiwWAv4EMxCsTpkmQu0hF
         kSLzQKgVykmHaGWoXwiullH/KtGtSDjT3cwOpfjShLeukH1kiFgvlK4OVLv/vaQeId
         dHM0BEhKEGzuzqFYF87Mkco4taALMOroPQgNoND5sxIqXmG0NYk9g0R1SuBgfgRdve
         vmTK05vOr3/fg==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
        Arnd Bergmann <arnd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230605085839.2157268-1-arnd@kernel.org>
References: <20230605085839.2157268-1-arnd@kernel.org>
Subject: Re: [PATCH] [v2] ASoC: amd: vangogh: select
 CONFIG_SND_AMD_ACP_CONFIG
Message-Id: <168597693169.38149.4954524469531400415.b4-ty@kernel.org>
Date:   Mon, 05 Jun 2023 15:55:31 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bfdf5
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 05 Jun 2023 10:58:29 +0200, Arnd Bergmann wrote:
> The vangogh driver just gained a link time dependency that now causes
> randconfig builds to fail:
> 
> x86_64-linux-ld: sound/soc/amd/vangogh/pci-acp5x.o: in function `snd_acp5x_probe':
> pci-acp5x.c:(.text+0xbb): undefined reference to `snd_amd_acp_find_config'
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: vangogh: select CONFIG_SND_AMD_ACP_CONFIG
      commit: 812a05256d673b2b9c5db906775d1e6625ba4787

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


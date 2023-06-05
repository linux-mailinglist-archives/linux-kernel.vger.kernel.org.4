Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68D9772258C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 14:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233434AbjFEMXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 08:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233382AbjFEMXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 08:23:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F66CF9
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 05:22:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 12EC961CBE
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 12:22:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45DD9C433EF;
        Mon,  5 Jun 2023 12:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685967769;
        bh=Tako9Jjn1qXwfvMcNXryNFwd01oKCbgQ/tQ/2ZULMhM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Lv8we7ieDx+RY6Ldb4aRrIR5GFCyFjxfCSZ0xxzNiw0bwbyw5JEs3vSwIz6V4eYpv
         2nMbOP7OdL3OXeBzXzjDUEqLfHoWwRusjOxPoo5rW89MKNIcdE6AVlgWnmH1m/v71F
         qI8jpgDR14+ps4sAYYKt3Nz3pP9YpA1PORDX/kANuxqklpADEXC8ON+vUyevyDN23s
         Lq/kN7V6wYlL40QtF7aHpplwKZU05d5F9oVk9uGsg2QCDahNB4L5FYJlp+jOTqkds+
         Phz4nnFZyYXTiLyGlFsKbYl7Je2/+GlUFcNK2cBSPLo2NsG/n9IUrOQiZaAKIcHVJY
         lo1+aQYmIjtpQ==
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
In-Reply-To: <20230602124447.863476-1-arnd@kernel.org>
References: <20230602124447.863476-1-arnd@kernel.org>
Subject: Re: [PATCH] ASoC: amd: vangogh: select CONFIG_SND_AMD_ACP_CONFIG
Message-Id: <168596776700.22528.17027039625806220969.b4-ty@kernel.org>
Date:   Mon, 05 Jun 2023 13:22:47 +0100
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

On Fri, 02 Jun 2023 14:44:39 +0200, Arnd Bergmann wrote:
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


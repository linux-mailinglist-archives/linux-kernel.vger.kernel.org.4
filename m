Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 335B970E797
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 23:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235585AbjEWVoJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 17:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbjEWVoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 17:44:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5068B83
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 14:44:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D91E8625CA
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 21:44:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D798FC433D2;
        Tue, 23 May 2023 21:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684878245;
        bh=aMl8XSo6MAGNcouj2r0VodRBmRxEH/7FWMSr7kUooIk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=tjSA5U+NoSiz6ZoJmbQJK45dwGsdDMEhNmzvUZaejH8oRc2vJlqaDRTZUflFch0rd
         DnWr9fz+bio2zkQHI3MY1gpw+qbTpkQ2rgcPF5c5F5AfaBBbQiaU0jny6DtFW7Z/KO
         nQQvwBCemNOgUPPwpBu6VLMnCTjllEH/TKAhxGbkDSrWfJTFpeu8zuKVEMJg1tcrAo
         U9JqoAbRAITAfxrmx7AhMdVY1ocNyav7ZhgVyaSDg8VgIJDQCSWFokDkvahFvNgWdu
         U/xYu/ULg5ZsaJQN0i+MuiKcIr9kgucz0bPYjNNxUqzZxs7gpu5eehmGBlrikH/AjJ
         q/AfUqIMRvTsw==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, tiwai@suse.com, perex@perex.cz,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        Trevor Wu <trevor.wu@mediatek.com>
Cc:     bicycle.tsai@mediatek.com, ting-fang.hou@mediatek.com,
        alsa-devel@alsa-project.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230508071532.21665-1-trevor.wu@mediatek.com>
References: <20230508071532.21665-1-trevor.wu@mediatek.com>
Subject: Re: [PATCH 0/4] ASoC: mt6359: kselftest fix and driver extension
Message-Id: <168487824257.297010.16948141699377522681.b4-ty@kernel.org>
Date:   Tue, 23 May 2023 22:44:02 +0100
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

On Mon, 08 May 2023 15:15:28 +0800, Trevor Wu wrote:
> The patch series includes a kselftest fix and changes for extending
> driver capability to support more use cases.
> 
> Trevor Wu (4):
>   ASoC: mediatek: mt6359: add supply for MTKAIF
>   ASoC: mediatek: mt6359: fix kselftest error of playback gain
>   ASoC: mediatek: mt6359: add mtkaif gpio setting
>   ASoC: mediatek: mt6359: update route for lineout mux
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/4] ASoC: mediatek: mt6359: add supply for MTKAIF
      commit: 1a3eb4bb9826fd317358113ca048ed60184c6442
[2/4] ASoC: mediatek: mt6359: fix kselftest error of playback gain
      commit: acd4d219798769a6c1080bcfa7953e165dd8d681
[3/4] ASoC: mediatek: mt6359: add mtkaif gpio setting
      commit: 24f398e74ba0a53bc95421f7eb139f4dc0207bb2
[4/4] ASoC: mediatek: mt6359: update route for lineout mux
      commit: 104ce27bcbfb204001a300498aa192235bd0836f

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


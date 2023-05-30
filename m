Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BCCB716B4B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 19:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232868AbjE3Rki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 13:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjE3Rke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 13:40:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8D17B2
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 10:40:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7C51462139
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 17:40:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4394C4339C;
        Tue, 30 May 2023 17:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685468432;
        bh=NWzyPIenxHpyYo1mucKzHij5CxtkM5ZDEfEPep5bjA8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=GH655kjgZ20iqGzNX8pQDiizWa1wpnlbzlPCqwtIKP/IyXqpI0iWjBiPe3Atr/A/E
         GKYRZO1mS4riDqhFMWHTO4wp4gkHJ+1ZzgzL8u0kyQNc3FB64yA2oyKs6/6fZmEfjl
         MwZByPDyJupnZuB71giHi/yt0qIxLlBP+96bZ/gjjVEi26cCzKuUmlfixG24JZcVfH
         +Ru3vQOLyQji5bbiibOepQNMhdEqEXPaCAqkJwdfe8ANNlOLMS3WlKdwtpcJukczPv
         oFUDTNIHHwCgwM+u7NRhxAdGYkt3YSR8KVKVxwy+CWTZeWwpP8vXU5KvfV8ykYzbgE
         SO/xbqp98td5w==
From:   Mark Brown <broonie@kernel.org>
To:     pierre-louis.bossart@linux.intel.com,
        peter.ujfalusi@linux.intel.com, yung-chuan.liao@linux.intel.com,
        ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com,
        daniel.baluta@nxp.com, lgirdwood@gmail.com, tiwai@suse.com,
        perex@perex.cz, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com,
        Trevor Wu <trevor.wu@mediatek.com>
Cc:     yc.hung@mediatek.com, tinghan.shen@mediatek.com,
        sound-open-firmware@alsa-project.org, alsa-devel@alsa-project.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230523025933.30494-1-trevor.wu@mediatek.com>
References: <20230523025933.30494-1-trevor.wu@mediatek.com>
Subject: Re: [PATCH v2 0/2] ASoC: SOF: add mt8188 audio support
Message-Id: <168546842851.690777.4334822736947724679.b4-ty@kernel.org>
Date:   Tue, 30 May 2023 18:40:28 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bfdf5
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 May 2023 10:59:31 +0800, Trevor Wu wrote:
> This series adds mt8188 audio support and dbg_dump callback for
> mt8186 and mt8188.
> 
> Changes since v1:
>   - fix typo
>   - adopt reviewer's suggestion
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: SOF: mediatek: add mt8188 audio support
      commit: 0f3d5585ad20a23bf70d09deae2e0d84e745055e
[2/2] ASoC: SOF: mediatek: add adsp debug dump
      (no commit info)

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


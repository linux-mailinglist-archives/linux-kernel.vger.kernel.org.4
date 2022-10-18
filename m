Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50159602A1A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 13:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbiJRL2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 07:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiJRL2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 07:28:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 042EBAC3B5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 04:28:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B1B03B81EA5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 11:28:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6E31C433D7;
        Tue, 18 Oct 2022 11:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666092493;
        bh=lA4c61bWI/+sO8LDTMmKrestbI06OjaSkU8aIZelk10=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=A/C4bUwqwUrs5ibD9+YRYbEW0JFNnvz/3TvhFmCEj+J2qiAKF0WC7aBb97lyMiJHT
         +DNsE5ASL72vszqMOkrfZm9iORcI6WWN0LkWIPsbi/WbLgkPnCDj/GklNjqIoD5doT
         HCOrJHm0FtbKAJAJNHnh78e7C6fpvUzr0pF0S1V661/ths1VVxHonlHVlSeLyE0AIt
         o76uvNpURDJYL5A0iryldXvBsu/WZTVkIcq8OZfGiLTFPGaZA+IogNzvxqgXB2pONR
         /BhmWO4N1UajbU4Vpyz3Ni41VT9hUD48Np0mbFcmFqvFMGirWLHkpp2kHMN1twlhoN
         k95mtM8sJMTtQ==
From:   Mark Brown <broonie@kernel.org>
To:     alsa-devel@alsa-project.org,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc:     Jaroslav Kysela <perex@perex.cz>, Alexander.Deucher@amd.com,
        Takashi Iwai <tiwai@suse.com>, Sunil-kumar.Dommati@amd.com,
        open list <linux-kernel@vger.kernel.org>,
        Basavaraj.Hiregoudar@amd.com
In-Reply-To: <20221010093941.2354783-1-Vijendar.Mukunda@amd.com>
References: <20221010093941.2354783-1-Vijendar.Mukunda@amd.com>
Subject: Re: [PATCH] ASoC: amd: Update Pink Sardine platform ACP register header
Message-Id: <166609249165.155136.11484948754047304400.b4-ty@kernel.org>
Date:   Tue, 18 Oct 2022 12:28:11 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Oct 2022 15:09:40 +0530, Vijendar Mukunda wrote:
> Update Pink Sardine platform ACP register header with Soundwire
> Controller specific registers and other ACP registers.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: Update Pink Sardine platform ACP register header
      commit: 9f879fb1a7b6c964dcde96c4cca8eb4444318560

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

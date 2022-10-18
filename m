Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1E66602A1F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 13:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbiJRL2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 07:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbiJRL2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 07:28:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1DFDB7EE9;
        Tue, 18 Oct 2022 04:28:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 40B67B81EA8;
        Tue, 18 Oct 2022 11:28:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A290C433D6;
        Tue, 18 Oct 2022 11:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666092501;
        bh=pI36XOkkoXboW1diIWhOh4jcI962SNyYxN1ABYije7U=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=DjsY5NGSNOLccv65O4yqW40NUssLaHumEw+oqIdgMXmc05jZgxYd6sr5BVPLdy8yq
         lza28V6sN4N2ptonfgqcPc43f1vegrfn6Pz1UDXf7OJSe1SxWSA+fuE+b9mQAXqDPP
         qWmdb+ljLdmmRPbDHA9Cjj8cWmYlFuhjl/DXW8+hHD+v0GanQRtujHn5lemv1xhY9v
         hCwchU3wtDug0hHt/tw3hhK9ymh6aTjX2NJnSzKxrywCsJAjF71lzfeS8xS0QM1j+M
         XQiGDBDVQEtOls1HC0D6DnWmlwA8Qy+m/XCLwoOR6514tZXZ8AvLK0BOI/SJB/+V2x
         yUF8vYJsbbPLQ==
From:   Mark Brown <broonie@kernel.org>
To:     Siarhei Volkau <lis8215@gmail.com>
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-mips@vger.kernel.org, alsa-devel@alsa-project.org
In-Reply-To: <20221010185423.3167208-1-lis8215@gmail.com>
References: <Y0P/u4pJT8rup8Za@sirena.org.uk> <20221010185423.3167208-1-lis8215@gmail.com>
Subject: Re: [PATCH v2 0/6] ASoC: codecs: jz4725b: Various improvements and fixes
Message-Id: <166609249915.155136.16491946248695409974.b4-ty@kernel.org>
Date:   Tue, 18 Oct 2022 12:28:19 +0100
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

On Mon, 10 Oct 2022 21:54:17 +0300, Siarhei Volkau wrote:
> The patchset fixes:
>  - Line In path stays powered off during capturing or
>    bypass to mixer.
>  - incorrectly represented dB values in alsamixer, et al.
>  - incorrect represented Capture input selector in alsamixer
>    in Playback tab.
>  - wrong control selected as Capture Master
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/6] ASoC: codecs: jz4725b: add missed Line In power control bit
      commit: 1013999b431b4bcdc1f5ae47dd3338122751db31
[2/6] ASoC: codecs: jz4725b: fix reported volume for Master ctl
      commit: 088777bf65b98cfa4b5378119d0a7d49a58ece44
[3/6] ASoC: codecs: jz4725b: use right control for Capture Volume
      commit: 1538e2c8c9b7e7a656effcc6e4e7cfe8c1b405fd
[4/6] ASoC: codecs: jz4725b: fix capture selector naming
      commit: 80852f8268769715db335a22305e81a0c4a38a84
[5/6] ASoC: codecs: jz4725b: use right control for Master Playback
      commit: e6233ee25059de0eeac6ed3d9d49737afdbd5087
[6/6] ASoC: codecs: jz4725b: add missed Mixer inputs
      commit: 616c291820d155cbad258ecae5c7dbca2c01f07f

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

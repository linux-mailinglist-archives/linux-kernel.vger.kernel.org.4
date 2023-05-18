Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5DB470869C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 19:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbjERRUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 13:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjERRUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 13:20:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E92E43
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 10:20:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 241326510D
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 17:20:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97360C433EF;
        Thu, 18 May 2023 17:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684430415;
        bh=KPXg/5yPyrniXThCT2klHFRPnIFaUJrpaOqQCf5WrCc=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=eURGaxmzqCpj33xjMs8yJfH2oes/pBGH1tGKZPH8moIUkCOOzY+foi34bXgbbU9vW
         z0ei2WKHm3pd5JZ8tolxqr2sPYl+K55xkYIWf8N0dCbPenyY04eEEh8X/4caLB/VZT
         bOItT7NrEoGbp78vKCTZL0T2nm+bked0LQiZIE7ldCNL4iq5sNfpnPUdZjylrqtloH
         tR7vm+i1EGFO9zD73W/2Q17Q5crdGjD75mklec0X1L8e5c2L6TWLEGJBIE0FD4vLDr
         cuH5vVKK5ABf5oquK1lTqELF1ZZvN9xuSL7QJbouhOnD7YpuipT3rHjzTYwrEP2W7t
         SE9wvszOOd8ig==
From:   Mark Brown <broonie@kernel.org>
To:     Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230517111416.424420-1-krzysztof.kozlowski@linaro.org>
References: <20230517111416.424420-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 01/12] ASoC: codecs: rt1308: do not store status in
 state container
Message-Id: <168443041217.472592.17542478387194244341.b4-ty@kernel.org>
Date:   Fri, 19 May 2023 02:20:12 +0900
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

On Wed, 17 May 2023 13:14:05 +0200, Krzysztof Kozlowski wrote:
> Driver in its update status callback stores Soundwire device status in
> state container but it never uses it later.  Simplify the code a bit.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[01/12] ASoC: codecs: rt1308: do not store status in state container
        commit: cc3ff544a296b5b4bb021f4dc415b53a6955b980
[02/12] ASoC: codecs: rt1316: do not store status in state container
        commit: 70207b95b2245502496443475c9fc4eb72ba3b66
[03/12] ASoC: codecs: rt1318: do not store status in state container
        commit: 28eb1e4224c3b3ff29fe4c29bcdc011d3a0ffd07
[04/12] ASoC: codecs: rt5682: do not store status in state container
        commit: 758665b15acc1adb21a833c6456746ffbce07ed7
[05/12] ASoC: codecs: rt700: do not store status in state container
        commit: 9564c9f691128bc2dc69de02f7eed205d9b2513f
[06/12] ASoC: codecs: rt711-sdca: do not store status in state container
        commit: 8322947e9228ef7f8c3dd13822d32c491f9488e7
[07/12] ASoC: codecs: rt711: do not store status in state container
        commit: 22e15c18b4a91c71bf66de06187b8a3199bb8cad
[08/12] ASoC: codecs: rt712-sdca-dmic: do not store status in state container
        commit: d7a79616fc723305094fd7391085428b7a893636
[09/12] ASoC: codecs: rt712-sdca: do not store status in state container
        commit: 5cd02f96f49a7e6d2f8b96ddc42092776b554873
[10/12] ASoC: codecs: rt715-sdca: do not store status in state container
        commit: cda72c89d082f5953fab9948fc1212ca0df11d96
[11/12] ASoC: codecs: rt715: do not store status in state container
        commit: 0315dac5406c9c0b8e334195aa01c4ec155adf47
[12/12] ASoC: codecs: rt722-sdca: do not store status in state container
        commit: b932f21f6678659bd434c0d47e3bebc94bae0a51

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


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C916686584
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 12:44:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjBALn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 06:43:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjBALn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 06:43:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0044539B4;
        Wed,  1 Feb 2023 03:43:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DF8E3B810FD;
        Wed,  1 Feb 2023 11:43:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A586C433D2;
        Wed,  1 Feb 2023 11:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675251819;
        bh=MmpffVf8hWOZgiIPLTUppyG844PtEs1DvL1GWwkqiDY=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=k5X21ojPzgg64FyE0xLoklKIZ3cC3qnVqQ78IQszlmXX1/dSDT+N1mfUsmFkEC5Km
         mlxz3LFAE9E7Z6JoA28n5m9iUUP4nWyHd+L8Q61fFaTMEja9sGiLReo/8H28rHJMcy
         S2h3siUiaQHgc0KZJn3gx7gS8XYkOVpmNWjI99OekPPUu3uq5aSnxONRrS1Mqd6NXo
         Plvc6pukuchxj/QtAgbYYLHCs9YlHPgSlVy/dCANsZAZ9jKCI5GTsc/Tjyk01AR/gc
         9u0dAPzipbvLYli4GXBHDl0D9ref8rySSsTbySLA3E08ilvACYevxfqWEDYkyujgQ4
         WHVun4uDpW6Sg==
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Yassine Oudjana <yassine.oudjana@gmail.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220622061106.35071-1-y.oudjana@protonmail.com>
References: <20220622061106.35071-1-y.oudjana@protonmail.com>
Subject: Re: [PATCH] ASoC: qcom: apq8096: set driver name correctly
Message-Id: <167525181733.63465.381746473105058457.b4-ty@kernel.org>
Date:   Wed, 01 Feb 2023 11:43:37 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Jun 2022 10:11:06 +0400, Yassine Oudjana wrote:
> Set driver name to allow matching different UCM2 configurations
> for the multiple devices sharing the same APQ8096 ASoC.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: qcom: apq8096: set driver name correctly
      commit: 86b753a86f6dc31ca9bccb489ebde1968d26c89b

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


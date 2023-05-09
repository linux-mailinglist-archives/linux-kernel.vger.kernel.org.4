Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB1F26FBF51
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 08:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234902AbjEIGie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 02:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234836AbjEIGid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 02:38:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9121893C1;
        Mon,  8 May 2023 23:38:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CE82E62E90;
        Tue,  9 May 2023 06:38:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1125C433EF;
        Tue,  9 May 2023 06:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683614310;
        bh=cL/8W1gKYqgUDJCngf9UaX/y9LEB1zjqY7zbcy6iHIc=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=F911bnui9tZ23j84w581GYOVtuVf+6m5FBu99Bn01JKqA6XwayUAgnpmMFMlwgzSR
         7e2q7jrD9OVYYlXlRfUOBerFOaWZWOZ19FS5ttR2o3b+MBiPgkW568tuaRullTFk6D
         xzez7fHibdifUwyBoSOnELLRP6JH2zFuMsm7J2Njdq9kJY7uTHvipDPq9b+Fz6fz0T
         KsCn1kdfeOEcbD/0KSPwckVq1xtAS9ZZpOYM8haMfU8HI2k0UIWCBN3Bj78pULCo8S
         IiRAJ1wWLX3DTR2r/sMW5wrkdb501s63OALduJUHOYFO1GOpUTvKwwypnR5h+bNZZZ
         Hn6pRzuSMHdWA==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, robh+dt@kernel.org,
        Anup Sharma <anupnewsmail@gmail.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        KCHSU0@nuvoton.com, linux-kernel@vger.kernel.org
In-Reply-To: <ZE9rK6mktPByvRRz@yoga>
References: <ZE9rK6mktPByvRRz@yoga>
Subject: Re: [PATCH] ASoC: dt-bindings: nau8540: Convert to dtschema
Message-Id: <168361430649.303059.2161758713822951358.b4-ty@kernel.org>
Date:   Tue, 09 May 2023 15:38:26 +0900
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

On Mon, 01 May 2023 13:02:59 +0530, Anup Sharma wrote:
> Convert the NAU8540 audio CODEC bindings to DT schema
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: nau8540: Convert to dtschema
      commit: 0f0d70c2881f8c28e6d449349e057963a742f842

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


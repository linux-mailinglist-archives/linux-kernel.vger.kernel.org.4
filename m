Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5FE76DDD02
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 15:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbjDKN5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 09:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231268AbjDKN4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 09:56:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C021A5BB4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 06:56:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9982861EEF
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 13:56:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 266F4C433D2;
        Tue, 11 Apr 2023 13:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681221387;
        bh=0gtQpUUIloVTJSsmNpoIIfXCN8r4Dfes+aOQUgPFjGU=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=YG2plDMyKHfs+ElEoxzLE4eRKhSlH7q/bBOnB8x9kQQEagaIELNJ5LOZwWYQpsqn8
         8+66N9qgSqiVJdEhnnNaHgbK+uyRcI5/W3fgNDGpcwRCGjeuModv/NNKEp7LYbP4En
         xfBJpRh2ubkLO0Uq3/M7qhnhFkZ6lp25IJAKxqez8qqSmkJe0MZXn5ycVmUoYF7dDf
         p5o8BCSLk2lyoh0/DgsSDlscfY76HGyIg0yDWctsvyZv/pw5rqQf2MtxecI1qb5qkk
         Es9LbELSZUS7HFCp++OgEPNV9pmpuaCDkVsoXG3orxuI19QFHiLXFi+KWUx6J2m64Q
         yGe+mwlTAVVqg==
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Markuss Broks <markuss.broks@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230409025529.241699-1-axel.lin@ingics.com>
References: <20230409025529.241699-1-axel.lin@ingics.com>
Subject: Re: [PATCH] regulator: sm5703: Fix missing n_voltages for fixed
 regulators
Message-Id: <168122138587.49933.14336482610023357360.b4-ty@kernel.org>
Date:   Tue, 11 Apr 2023 14:56:25 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-00303
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 09 Apr 2023 10:55:29 +0800, Axel Lin wrote:
> Set n_voltages = 1 for fixed regulators.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: sm5703: Fix missing n_voltages for fixed regulators
      commit: 7c7504067c709905fc188c61ac3072d6022d1209

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


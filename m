Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1E955BD293
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 18:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbiISQva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 12:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbiISQu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 12:50:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D2E63DBCB
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 09:50:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2A98AB80861
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 16:50:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63B0BC433D6;
        Mon, 19 Sep 2022 16:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663606199;
        bh=8Cm0prfANubtGRN0g8pwMtDF/68EwNwb2RXuCHxg6p4=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=pIrbUEt65nZtPau2Pee9ASAjviMPqmWRY4RVbRs4gYU4YEQ+n5CXyPg6L+dD8tKtB
         YAiFAjuGOjDNCM+rRpiinzwJKxA/efemZ9O/t1pDkrnCo9ATwL8Dc7kLyaUILm2xl6
         EFkcDQUTOo8Ad1C/uJVylZHASj0Q5v/Yd5H5tr695cHWm5tz5Pmjl5+rA7R9mj903s
         xBWBHrjL0EhOvk8pWePAGioBQtLGpGazBWNlT4GJntyTO+aPzJG+4eSZZQQq0Qm5ZM
         XHJr50AyYSA6Of0aabEnXmWWbyUy8IRrUXfwgH4o4VCgRLCzVkDdz6ppiRPWw2c4yt
         GXonchBMvWpNw==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     Abaci Robot <abaci@linux.alibaba.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20220919024830.111874-1-jiapeng.chong@linux.alibaba.com>
References: <20220919024830.111874-1-jiapeng.chong@linux.alibaba.com>
Subject: Re: [PATCH 1/2] regulator: of: Fix kernel-doc
Message-Id: <166360619731.3110686.1760094237998655148.b4-ty@kernel.org>
Date:   Mon, 19 Sep 2022 17:49:57 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-8af31
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Sep 2022 10:48:29 +0800, Jiapeng Chong wrote:
> drivers/regulator/of_regulator.c:689: warning: expecting prototype for of_parse_coupled regulator(). Prototype was for of_parse_coupled_regulator() instead.
> 
> 

Applied to

   broonie/regulator.git for-next

Thanks!

[1/2] regulator: of: Fix kernel-doc
      commit: 7ec12d153998616d9f9fd0e603d56b5e122fc768
[2/2] regulator: of: Fix kernel-doc
      commit: 7ec12d153998616d9f9fd0e603d56b5e122fc768

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

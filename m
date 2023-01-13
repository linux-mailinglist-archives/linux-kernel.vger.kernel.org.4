Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11C19669BDA
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 16:22:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbjAMPWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 10:22:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjAMPVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 10:21:50 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C98F97490
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 07:14:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4E65DB8216D
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 15:14:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23BE3C433F0;
        Fri, 13 Jan 2023 15:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673622886;
        bh=g/sqeAVjndp7TvZR33I83lufc1cIoWr6FB/dGg50uHg=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=VXCHUbA+jnVjZpv+/fIfUhjkmINjP3A5YF34WQnBlYN/atI71Iv69idFGnRcKqMlb
         LvcQ+KDFZqHAeCSH5qlCrhRdXSsURTGoyUfulSjXfb2JahyjR2D3b+aeeDrlcDBool
         ljJtELAoh4mFj4m7aMzagWltNA4AuPRNoDxh4jl/7X4r3r4jMms3U0L/gIpbRit+qr
         MkhsqvUO8xR/MyHiOeBIH1W6MbOHYnmM/ePlu/GNpNswnd415+5w0wqebSMSf+knOG
         7zxULF7j2dsJ4T0SptRI6KpVnNGpKwyNZHJQOb5yIl56pGW1d2tC7UsFAid1KNoW26
         bdKqUDHs0Ptjw==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>
In-Reply-To: <20230113064421.11986-1-rdunlap@infradead.org>
References: <20230113064421.11986-1-rdunlap@infradead.org>
Subject: Re: (subset) [PATCH] regulator: fixed-helper: use the correct
 function name in comment
Message-Id: <167362288586.139122.13318171140227201352.b4-ty@kernel.org>
Date:   Fri, 13 Jan 2023 15:14:45 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-8b3d1
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Jan 2023 22:44:21 -0800, Randy Dunlap wrote:
> Use the correct function name and modify the function short description.
> This prevents a kernel-doc warning:
> 
> drivers/regulator/fixed-helper.c:32: warning: expecting prototype for regulator_register_fixed_name(). Prototype was for regulator_register_always_on() instead
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: fixed-helper: use the correct function name in comment
      commit: a508a267dda6e67d2eccbc12088a7fecc127ba90

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

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD1BD6B9B4E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 17:26:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbjCNQ0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 12:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbjCNQZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 12:25:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 384313C0A
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 09:25:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 558F36184A
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 16:25:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A92AEC433D2;
        Tue, 14 Mar 2023 16:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678811118;
        bh=ZfJ7DoowlnfEJtqtW2HTk5HtViAZXRbciYaFKLR7iI8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=THYhYAUXXHqGgwKS1ZFIdriAaZZqkcCbBcnj7U2fhBdnbbxa/jNmiQCdGfRmDht75
         3UjRqAn8xITFwoFr79PukwL383CstkH5/4fz2MVbghMxWbF7jDrBDqIpAQvlcQEO4o
         yUiP+CqUaz+m4NU9hvU75pSp6+Ei4NOBO+PXo/Dwf8XjIC/Zjglzqn7YdclRN4z5Y6
         OIol4g+IGo1YdGo8eafuqiDYskyb0ndhvbFeIuIoPpqIgTSR0z1Fsiga2tAaJ+Upbr
         ApwQEcYy2F545Ql2cHIKRqiicRbsOywFBVJ/W+FBXmBY3QdpaQMkJOgrUqqBqMc0gS
         DUmo01WNUtH3w==
From:   Mark Brown <broonie@kernel.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     mka@chromium.org, christian@kohlschutter.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230313181820.2482385-1-dianders@chromium.org>
References: <20230313181820.2482385-1-dianders@chromium.org>
Subject: Re: (subset) [PATCH 0/2] regulator: Fix boot speed regression w/
 off-on-delay-us
Message-Id: <167881111741.52189.2713635636188395950.b4-ty@kernel.org>
Date:   Tue, 14 Mar 2023 16:25:17 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bd1bf
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Mar 2023 11:18:18 -0700, Douglas Anderson wrote:
> These two patches together fix a boot speed regression on
> sc7180-trogdor boards which use off-on-delay-us together with
> regulator-boot-on with the eDP power rail.
> 
> The first patch is _almost_ a revert of another patch. Depending on
> when the regulator is probed and the actual delay, the end result
> might be the same as a revert or might result in a delay that's
> somewhere between "no delay" and a full delay. As talked about in the
> patch, I believe this is the correct behavior and, if the problems
> fixed in the original patch are still present, I'm hoping that they
> can be fixed in a cleaner way.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/2] regulator: core: Shorten off-on-delay-us for always-on/boot-on by time since booted
      commit: 691c1fcda5351ed98a44610b7dccc0e3ee920020

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


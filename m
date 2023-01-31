Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88035682F53
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 15:33:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbjAaOdG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 09:33:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231656AbjAaOdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 09:33:02 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6EFB19684
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 06:32:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 8E9CACE1ED2
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 14:32:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D21DCC4339B;
        Tue, 31 Jan 2023 14:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675175566;
        bh=6aJbhQ9qv33ZI5eTdT7s/7trJb8D2Ja+TrNBeR3fSnM=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=YltB6a3tssR4HeEHaAEk4hRrzZgBrrf5FLK8jeDAcLFHpl1DEGFseGQT+pty28ENi
         8iy1InWGTgRJlfW6WE1UkRbksGRtw6Rt4xS5ZJS5mXblcC+SLZ1X+xmiyKiSUeptf3
         2tliFflaMqRrMeiqEkpZSBzOaw0wYrB7cTDK3mVCIt9RqiUY3zPkjfbOvJ70YE9nfI
         RHXY19A4UcJOvALNCYuz9svxAz0b4DbhdLtwv9nMfKJ/eEkYyC92rc8Y4Ulb6SPXbC
         LvNGRtmY7ZtZiQJ5H1z0tIuMePeJ8gAVnZaITVPeC15a32hH60DdLqfG2orOiSmR1r
         DmxMOOnvGi2Tg==
From:   Mark Brown <broonie@kernel.org>
To:     Colin Foster <colin.foster@in-advantage.com>,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Golle <daniel@makrotopia.org>
In-Reply-To: <Y9clyVS3tQEHlUhA@makrotopia.org>
References: <Y9WAPBYaLMsCbQN6@euler> <Y9clyVS3tQEHlUhA@makrotopia.org>
Subject: Re: [RFC PATCH v2] regmap: apply reg_base and reg_downshift for
 single register ops
Message-Id: <167517556557.691302.14946061846357129320.b4-ty@kernel.org>
Date:   Tue, 31 Jan 2023 14:32:45 +0000
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

On Mon, 30 Jan 2023 02:04:57 +0000, Daniel Golle wrote:
> reg_base and reg_downshift currently don't have any effect if used with
> a regmap_bus or regmap_config which only offers single register
> operations (ie. reg_read, reg_write and optionally reg_update_bits).
> 
> Fix that and take them into account also for regmap_bus with only
> reg_read and read_write operations by applying reg_base and
> reg_downshift in _regmap_bus_reg_write, _regmap_bus_reg_read.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/1] regmap: apply reg_base and reg_downshift for single register ops
      commit: 697c3892d825fb78f42ec8e53bed065dd728db3e

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


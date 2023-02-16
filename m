Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 483056989AC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 02:10:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbjBPBKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 20:10:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjBPBJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 20:09:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB1712A6D7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 17:09:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7791DB824E6
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 01:09:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC05FC433D2;
        Thu, 16 Feb 2023 01:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676509794;
        bh=CLxgvvve9og1cYZR7tzc8NisOq0EVCJzqM3j00w+GMk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=KhFwyZr8ZeBQpyFjSqclLU+LukmBr5iengkv65ncdRPVCYQfRa1bGIYmbf4G+fV4P
         ijd/DINCvS83OsaSMNsF3VJjas27bibniojy0lqNFrFNXui3MWcwHrOzIHV9qydDXL
         odn5iMDyWlv5F39siQgYZHjTLsm6S6xsEK8jUPVq02uA5QieZdZjZebUfbq7Zkl6kN
         /Eo22EcrRjLagPIPAyp+jiSJ9wke4zHDZihMQDNuWmm+37sUcwetrLvAYRgQWgetTl
         iPe2h6hlq9/SLg+oZHouznK67jPg89Aqmw7u4Jw+uRdjZR6KEpND2POcKjGaD19/gP
         Y991AFtvkcqCQ==
From:   Mark Brown <broonie@kernel.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     lgirdwood@gmail.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
In-Reply-To: <20230215105818.3315925-1-ckeepax@opensource.cirrus.com>
References: <20230215105818.3315925-1-ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH v2 1/2] ASoC: cs35l45: Remove separate tables module
Message-Id: <167650979263.3620645.17342543857239200742.b4-ty@kernel.org>
Date:   Thu, 16 Feb 2023 01:09:52 +0000
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

On Wed, 15 Feb 2023 10:58:17 +0000, Charles Keepax wrote:
> There is no reason to have a separate module for the tables file it just
> holds regmap callbacks and register patches used by the main part of the
> driver. Remove the separate module and merge it into the main driver
> module.
> 
> 

Applied to

   broonie/sound.git for-next

Thanks!

[1/2] ASoC: cs35l45: Remove separate tables module
      commit: 4dac6f5abc02ffeeb10459c575aba2343363d4ee
[2/2] ASoC: cs35l45: Remove separate namespace for tables
      commit: 926505cf14258376c3cd244e891c7d739a2a049a

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


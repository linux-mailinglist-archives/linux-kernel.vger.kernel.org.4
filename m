Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A65DE6361DB
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 15:31:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238062AbiKWOan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 09:30:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238275AbiKWOaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 09:30:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C733905AE
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 06:28:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 00184B8202D
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 14:28:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFFD8C433D6;
        Wed, 23 Nov 2022 14:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669213731;
        bh=C8LAvH10eyEIrd0dXgkWe5lm7XPXVZ76OgS++XwNOis=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=ZnfA+CxxK3VgKvHxqPMhzhGXrPRo5KpWjezJhPCd4dRf6jNfKMPBxz72e0tF9dDzj
         SxsETo5g0GhItRkimtnFB0fwgj1XVPzvi+ywZov60FAH3fC3nw4YiaeQ1fq1S2BGzY
         sTv4Z1J34nRBYn4SrfsKXn3IvE24e4TANMX2g9NlIHOL7hZoNgc+fh33jgQGHS/D5P
         1++fcfePg2Jn9i4xlpmc92Eu1r72rujKBxH7FPP1Ee1yAgZu+CSjUHujZw/vgsdYNj
         PF5d7h6x6BEBVeQw2xpa8IuZmZUCbJGGr3c2lr4jrK1KALmPJWQO2uTjZN1R4l3hc4
         KIFgYSMPhz6Lg==
From:   Mark Brown <broonie@kernel.org>
To:     Wang ShaoBo <bobo.shaobowang@huawei.com>
Cc:     lgirdwood@gmail.com, liwei391@huawei.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221123034616.3609537-1-bobo.shaobowang@huawei.com>
References: <20221123034616.3609537-1-bobo.shaobowang@huawei.com>
Subject: Re: [PATCH] regulator: core: use kfree_const() to free space conditionally
Message-Id: <166921373057.240778.13837593639387001474.b4-ty@kernel.org>
Date:   Wed, 23 Nov 2022 14:28:50 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Nov 2022 11:46:16 +0800, Wang ShaoBo wrote:
> Use kfree_const() to free supply_name conditionally in create_regulator()
> as supply_name may be allocated from kmalloc() or directly from .rodata
> section.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: core: use kfree_const() to free space conditionally
      commit: dc8d006d15b623c1d80b90b45d6dcb6e890dad09

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

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95D2C6CA582
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 15:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232384AbjC0NXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 09:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232290AbjC0NW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 09:22:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76E322695
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 06:22:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 36979B8149C
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 13:22:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53103C433EF;
        Mon, 27 Mar 2023 13:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679923376;
        bh=uYjosYOeek7l6haaAvL38vJM5PCsC4+3/9spOrm6THU=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=GPhP5JazbltW6EK2PHUP0Wt2uLw0f65JMaHQ/xqEwuoOEe836lTPyjHuMfOWq/tKT
         HbELJzVRFrhuxOkIEwDdNG+TgjOyX+k27T2Hkg5PQc8mIJuu7NDlDH4IodkWkvV2Be
         IFyeGezsyE1pznPqd7Vc56QT+VPRtQFlyUYTsFhisAnZnwsgdPNGBOXb0WvIbpGjUk
         +0dGbPA/oN3bGEKvLdM6D0CKV6zFzIENhDhtUfqLPE+EHCGCb4ojcv2mC5nhZzKK9R
         YvVb7EBIcsfHO3hkIA4nQYwEudqqretkVwtqd8X+I4ETCM4KMCLyYlJzDTM74aDANR
         Fv2i/iX7DLPaQ==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
In-Reply-To: <20230324-regcache-lzo-v1-1-08c5d63e2a5e@kernel.org>
References: <20230324-regcache-lzo-v1-1-08c5d63e2a5e@kernel.org>
Subject: Re: [PATCH] regmap: Removed compressed cache support
Message-Id: <167992337424.3162264.13526769899510906833.b4-ty@kernel.org>
Date:   Mon, 27 Mar 2023 14:22:54 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-2eb1a
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Mar 2023 16:21:49 +0000, Mark Brown wrote:
> The compressed register cache support has assumptions that make it hard to
> cover in testing, mainly that it requires raw registers defaults be
> provided. Rather than either address these assumptions or leave it untested
> by the forthcoming KUnit tests let's remove it, the use case is quite thin
> and there are no current users.
> 
> 
> [...]

Applied to

   broonie/regmap.git for-next

Thanks!

[1/1] regmap: Removed compressed cache support
      commit: c4bf2c90af6d423b844b4d235a072d4c0d5f6b57

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


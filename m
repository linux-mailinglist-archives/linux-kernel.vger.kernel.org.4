Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C947D6B8164
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 20:08:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbjCMTIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 15:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjCMTH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 15:07:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED7907339D
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 12:07:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 83FC76148F
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 19:07:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 127DCC433EF;
        Mon, 13 Mar 2023 19:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678734473;
        bh=dVzyeI1ai4Ujar3YKUeoi8Er0WSdbcW2uOritJOC8x4=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=UdpTbuMoI5gADbjAeqnwx7sh+58vprfoQ8OXuxODFdMVKW8vFsUCQ29Eu6Q0dkwtJ
         3OoX4LpR19W9TGWbNUXS7sHnREERJRJbjvC3on77bz0zyCxqo5V2RiGLapQVUu1ak9
         jIQ5rQZAT827TUXwpCEMxx3p9/6oiII3p6YopNe32s8ACmDIUBc+H+dvV8eUpVRPpe
         TCgHEOW+iQovEO3eKyPMPtUdbQ8kKKV7mJ5wTmFWBawcQqlSAX5KDdBNAkDOZ63PFy
         ufuyi56Gr8GcVS+qoONmO3PFTGz5SKI3PL99uQxyQsMGdqmWb6ebPb3Z3D98w8Y8cV
         sLTvzc7DYj45g==
From:   Mark Brown <broonie@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     linux-kernel@vger.kernel.org
In-Reply-To: <20230313071812.13577-1-alexander.stein@ew.tq-group.com>
References: <20230313071812.13577-1-alexander.stein@ew.tq-group.com>
Subject: Re: [PATCH v2 1/2] regmap: cache: Return error in cache sync
 operations for REGCACHE_NONE
Message-Id: <167873447279.106268.14396431970338711104.b4-ty@kernel.org>
Date:   Mon, 13 Mar 2023 19:07:52 +0000
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

On Mon, 13 Mar 2023 08:18:11 +0100, Alexander Stein wrote:
> There is no sense in doing a cache sync on REGCACHE_NONE regmaps.
> Instead of panicking the kernel due to missing cache_ops, return an error
> to client driver.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/2] regmap: cache: Return error in cache sync operations for REGCACHE_NONE
      commit: fd883d79e4dcd2417c2b80756f22a2ff03b0f6e0
[2/2] regmap: cache: Fix return value
      commit: 24d80fde40c995b2e2faaf72034e12e60a416630

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


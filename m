Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D22FE662BB2
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 17:51:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237211AbjAIQvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 11:51:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237072AbjAIQuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 11:50:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B087632D
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 08:49:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D6774B80E7E
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 16:49:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 241C3C433F2;
        Mon,  9 Jan 2023 16:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673282949;
        bh=vfToooFvqG7PPIh4+IgqDfsebCiWzTMy8pkLwP+eTLE=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=dTZ4S4m0Kixw+/ADbnK/a9lxMmzQ94LmS1Z0eEq/i7EruP1hlAt81aajr5fwcRNL5
         pOe/qFU5fQrbC3YDNIrtf8kwCZ2gRziMWn/OJXEed2A8OQOSFNcQ2ees5Li5P207ee
         K/OpgSs6fJRl/z5g7grnlJDAoCwaNoSPN9ngl+DIeGdT6RUWHbcWA8wpufWGHVf/TH
         +d7hDCYszE6gHjpqBwAPwHzMeyi9Gmv1H0gxd8GztsrKkI2/+rjCgDjOy0bV/mrpVA
         z03ZwJ58N6JEuKglO24N5iDEZPXIOvhDD/sqliSpfEjtxoV12W8/ATmgS3Y9AXsPA0
         CU2OT9vfCG6LQ==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, Nathan Chancellor <nathan@kernel.org>
Cc:     Vijendar.Mukunda@amd.com, Syed.SabaKareem@amd.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
In-Reply-To: <20230105-wsometimes-uninitialized-pci-ps-c-v1-1-4022fd077959@kernel.org>
References: <20230105-wsometimes-uninitialized-pci-ps-c-v1-1-4022fd077959@kernel.org>
Subject: Re: [PATCH] ASoC: amd: ps: Fix uninitialized ret in
 create_acp64_platform_devs()
Message-Id: <167328294786.323147.5948330744390772644.b4-ty@kernel.org>
Date:   Mon, 09 Jan 2023 16:49:07 +0000
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

On Thu, 05 Jan 2023 08:53:32 -0700, Nathan Chancellor wrote:
> Clang warns:
> 
>   sound/soc/amd/ps/pci-ps.c:218:2: error: variable 'ret' is used uninitialized whenever switch default is taken [-Werror,-Wsometimes-uninitialized]
>           default:
>           ^~~~~~~
>   sound/soc/amd/ps/pci-ps.c:239:9: note: uninitialized use occurs here
>           return ret;
>                  ^~~
>   sound/soc/amd/ps/pci-ps.c:190:9: note: initialize the variable 'ret' to silence this warning
>           int ret;
>                  ^
>                   = 0
>   1 error generated.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: ps: Fix uninitialized ret in create_acp64_platform_devs()
      commit: de1cae22898cf10aacc735a21d799b5bbce4496c

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

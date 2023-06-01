Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A99CC71A2F6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 17:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233924AbjFAPom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 11:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232684AbjFAPoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 11:44:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD40DFB
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 08:44:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 555DC646AC
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 15:44:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D71E8C4339C;
        Thu,  1 Jun 2023 15:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685634272;
        bh=j1B6GqZ6f9Zd5X+R4g+J68Lei5mv2+LyJ/NMxepU/1Y=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=am4NtIdKTbfvWg6fiTkl7rSByUtsHgJTbc4bgyQlPp2CUhXJ/uqdnazoxmJYnpRre
         mRd+55hioSHZFq0zczsTCJf4fU4j9RSuMklxljAYWPP2HkFmpu+42N22MqOr4b8cYl
         XNG9mDguGgnIC0GARPlXCWfvJ7821kfOmjT06YFRgyATMOoTPeE49AvwX+E3MPG1rk
         CDc0lMhC+gd25Kr8S3/K5Jd5KXG4Muw9n2rWbTwLkHIxOETzSLpbqxFsbnohy0z3Tw
         by+hJB6eCfM5QcMxq0ZC9TBxtZaPb/OjI0eHvU4IGVE/6BvAsaFEYkSrjeAPp2CLYg
         Q4E6JCGvUEZ6g==
From:   Mark Brown <broonie@kernel.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
In-Reply-To: <20230601124907.3128170-1-rf@opensource.cirrus.com>
References: <20230601124907.3128170-1-rf@opensource.cirrus.com>
Subject: Re: [PATCH] ASoC: cs35l56: Remove NULL check from
 cs35l56_sdw_dai_set_stream()
Message-Id: <168563427160.132600.8355964544027390403.b4-ty@kernel.org>
Date:   Thu, 01 Jun 2023 16:44:31 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bfdf5
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 01 Jun 2023 13:49:07 +0100, Richard Fitzgerald wrote:
> The dma pointer must be set to the passed stream pointer, even
> if that pointer is NULL.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: cs35l56: Remove NULL check from cs35l56_sdw_dai_set_stream()
      commit: 524306c3764276ce6cc7509908934982ce167039

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


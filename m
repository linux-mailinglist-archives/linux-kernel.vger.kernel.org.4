Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F11769A399
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 02:54:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbjBQByV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 20:54:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbjBQByS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 20:54:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25C44595A8
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 17:54:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2CD7B61255
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 01:54:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97AFEC433D2;
        Fri, 17 Feb 2023 01:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676598855;
        bh=5E0xNde/0F80z0TLoNh/g+P+lmKNIJr51U3t2Ma/xQA=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=AV7ZQJXDuJaa16zwSVXbam2fzYmjCc5SnQG+V5arpsRcm/xKT7o24XGWHjoBFY5uE
         vdP5/c4F3y3tYbIrQvAisrc5dPgWhzmxY2+4kSYG6S7oQ/AX15zPnH9vlbY1jPXJfg
         lN2+GKLdslWjpyRRERifwAVL9qHPgHNwOn2lxNyxDpSdfjAPX2V0FaiBY9BwMidvm6
         9szGBH5rg5UWHRCnuyZbKohA1HaIyTTBNrcoXkcWV9ysMbAxOpA2/Tf1o6jw+SmUo2
         TSk3e4Uc5zpKKetenogb3mrKErf/gHn485moRZIqvQRiTFwOQ8boXNFmUxF8DMWWMW
         uOP8njZaNkRuA==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Naresh Solanki <naresh.solanki@9elements.com>
Cc:     Naresh Solanki <Naresh.Solanki@9elements.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230216075302.68935-1-Naresh.Solanki@9elements.com>
References: <20230216075302.68935-1-Naresh.Solanki@9elements.com>
Subject: Re: [PATCH v2] regulator: max597x: Align for simple_mfd_i2c driver
Message-Id: <167659885429.51492.13243455907379415227.b4-ty@kernel.org>
Date:   Fri, 17 Feb 2023 01:54:14 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Feb 2023 08:53:01 +0100, Naresh Solanki wrote:
> Use regmap provided by simple_mfd_i2c driver and remove unused variable.
> Identify device variant by checking compatible property in DT.
> 
> 

Applied to

   broonie/regulator.git for-next

Thanks!

[1/1] regulator: max597x: Align for simple_mfd_i2c driver
      commit: 7f62cb8861190e7cc1018ff37597fc49b2eaafa8

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


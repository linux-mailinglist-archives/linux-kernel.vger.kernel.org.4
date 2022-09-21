Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5595BFAD1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 11:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbiIUJZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 05:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231377AbiIUJZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 05:25:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 437AEC16
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 02:25:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D462562374
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 09:25:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCA40C433C1;
        Wed, 21 Sep 2022 09:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663752329;
        bh=Fm7uUxvGjUpzhdYGBvMLJdPletDumytisj8ycEeYgK0=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=gmi20xMW6hzLrEFOFX0Zy/6ZspTLaKvcpQaB/LpoQz+SiltCIvWuE/Fr3lQc9+ol/
         kX04ba9r4TZqW+5M2/lu8ncSfDW+4qn0yHIUG61xXQs/4DuVIFkf0D5RLpmd+UwG7k
         r0AMfjALX/5NwNJPcyCX9lZoHuAkR7qttBr+WrkuVnkzd7y5FMeO673ZGOEuiIB4xJ
         S2S7giTPqq0gHENd7E5BIHI0zpAXFprt3qLLU6pIWw5k3Fxs56AI8QiBS+qje5py3g
         QBB4pwoIJ7/DT7BvPEjHOcoGi1yUtHGqI3ZetozvY5PDDtwBnVUwUVNWLGKGNSi1TP
         yJa+B2CrPIetw==
From:   Mark Brown <broonie@kernel.org>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Saba Kareem Syed <Syed.SabaKareem@amd.com>,
        Sebastian S <iam@decentr.al>, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, Xiaoyan Li <lxy.lixiaoyan@gmail.com>,
        Travis Glenn Hansen <travisghansen@yahoo.com>
In-Reply-To: <20220920194621.19457-1-mario.limonciello@amd.com>
References: <20220920194621.19457-1-mario.limonciello@amd.com>
Subject: Re: [PATCH v2 0/2] Add some models into acp6x quirk list
Message-Id: <166375230411.526450.3070541932734238859.b4-ty@kernel.org>
Date:   Wed, 21 Sep 2022 10:25:04 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-8af31
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Sep 2022 14:46:19 -0500, Mario Limonciello wrote:
> Another model from ASUS and Lenovo have been identified that
> don't include anything in ACPI tables to indicate they require the
> ACP6x DMIC driver to be loaded.
> 
> This series adds them both to the quirk list.
> 
> changes from v1->v2:
>  * Both models were independently sent in v1 but touch the same code,
>    so v2 collates them together.
> 
> [...]

Applied to

   broonie/sound.git for-next

Thanks!

[1/2] ASoC: amd: yc: Add ASUS UM5302TA into DMI table
      commit: 4df5b13dec9e1b5a12db47ee92eb3f7da5c3deb5
[2/2] ASoC: amd: yc: Add Lenovo Yoga Slim 7 Pro X to quirks table
      commit: 2232b2dd8cd4f1e6d554b2c3f6899ce36f791b67

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

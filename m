Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CDBF70E799
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 23:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235037AbjEWVoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 17:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238538AbjEWVoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 17:44:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEA48C1
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 14:44:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5C1406255E
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 21:44:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3D75C4339C;
        Tue, 23 May 2023 21:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684878249;
        bh=zHVq50k7DbZjqBSZlH/G4JnZ1dYJHDa4rC6ODp4owhk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=AzR5ZlIhTpi5h4bYNEPttRp0VDE9+KDUccSlJ203y698CwH4MU4uO+JxJ+16nz3Fo
         j8ekD8gRJRcD5koVOa+fpC3EI1zqnZTmCoPqzMMzjORIkU6fqC9fAk3Z2oqPj7bg6w
         V0WqgPdv40lNMDDv/xsBZZRdlg+Bt0shtMS4JZ0NEoy5VzYAlZk2rPHogyhx1ECSuA
         tAzMaG5aRz8QJoHsqeVvtljroas5Veu15NEJRdwPJnYxyRWsj0ARuHy/J+QzcvYDOo
         voGJ9uPTvst/DVbZabbeGIR6BGPdDtZKVhxxYErvopByCjxbXVea6BEB0n8sgd11vv
         dHPlnsURAC/LQ==
From:   Mark Brown <broonie@kernel.org>
To:     alsa-devel@alsa-project.org,
        Daniel Baluta <daniel.baluta@oss.nxp.com>
Cc:     linux-kernel@vger.kernel.org, pierre-louis.bossart@linux.intel.com,
        lgirdwood@gmail.com, peter.ujfalusi@linux.intel.com,
        yung-chuan.liao@linux.intel.com, ranjani.sridharan@linux.intel.com,
        kai.vehmanen@linux.intel.com, daniel.baluta@gmail.com
In-Reply-To: <20230503081049.73847-1-daniel.baluta@oss.nxp.com>
References: <20230503081049.73847-1-daniel.baluta@oss.nxp.com>
Subject: Re: [PATCH 0/2] Improve support for sof_ipc{3|4}_bytes_ext_put
Message-Id: <168487824751.297010.12344595686520411932.b4-ty@kernel.org>
Date:   Tue, 23 May 2023 22:44:07 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bfdf5
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 03 May 2023 11:10:47 +0300, Daniel Baluta wrote:
> This patch series provides better handling of cases where sending
> a data blob to FW results in a validation error.
> 
> In this case we restore to the last good known value instead of keeping
> the data that firwmare rejected.
> 
> Paul Olaru (2):
>   ASoC: sof: Improve sof_ipc3_bytes_ext_put function
>   ASoC: sof: Improve sof_ipc4_bytes_ext_put function
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: sof: Improve sof_ipc3_bytes_ext_put function
      commit: 299f6c752f8f7dabb62fe4df62ebd233b58402bd
[2/2] ASoC: sof: Improve sof_ipc4_bytes_ext_put function
      commit: db38d86d0c54e0dbea063e915ce3e1fe394af444

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


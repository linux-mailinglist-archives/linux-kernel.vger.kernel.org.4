Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7026D4B69
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 17:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234250AbjDCPIE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 11:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234158AbjDCPHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 11:07:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 465F518276
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 08:07:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 84CF561FD9
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 15:07:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4266C4339B;
        Mon,  3 Apr 2023 15:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680534470;
        bh=lf4upq3FdpRAqhv049TEQuv0s9Un/cwgAomIIpEaq0s=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=iKoGuZuQuiB2AATagOH6QT06cLYsL9IFURw0gD3/EwCcErabq2543tv9bsmViTDXB
         Ntl5DHlpgqVlZXvPmNd4vL6bsf1c03/hKV9DR5mtxuPdMqGgIMY0cbn29J/u68TUef
         KU+pa+ddaDhqh8/zSWnYh9K7fdhpkUmCXXPvN5+q3Ik+VlkvZ3T0iAOPFPAW1cTsxZ
         F0cOEI5nr96DvY+HgbJsiOsz9gjO22nE/nfp5/3pr9d53mF7/3AMweg9QiIKo+9vGF
         DxRzecYn4/dw3M9u13AIKY5euxw/Bn9SgPflEgvmIk6vs3ehdH6OhK1tAAWikPn7ij
         i2LrEc+qA57WQ==
From:   Mark Brown <broonie@kernel.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Simon Trimmer <simont@opensource.cirrus.com>
In-Reply-To: <20230328131018.6820-1-rf@opensource.cirrus.com>
References: <20230328131018.6820-1-rf@opensource.cirrus.com>
Subject: Re: [PATCH v2] firmware: cs_dsp: Add a debugfs entry containing
 control details
Message-Id: <168053446957.47553.1396193248539137592.b4-ty@kernel.org>
Date:   Mon, 03 Apr 2023 16:07:49 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-00303
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Mar 2023 14:10:18 +0100, Richard Fitzgerald wrote:
> The file named 'controls' in the DSP's debugfs root contains a
> formatted table describing the controls defined within the loaded DSP
> firmware, it is of the form
> 
>   name: len region:offset addr fwname algid ctltype flags en dirty
> 
> Where flags is represented as a character for each flag if set, or '-',
> enabled is whether the control is enabled or disabled and dirty is
> whether the control value is set in the cache but not the hardware.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] firmware: cs_dsp: Add a debugfs entry containing control details
      commit: 7a3f924cee4bdfe85eda4e636213e79d3fda6182

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


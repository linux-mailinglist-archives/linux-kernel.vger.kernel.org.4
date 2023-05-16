Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC7DB7050F5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 16:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233409AbjEPOiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 10:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232016AbjEPOiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 10:38:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D4E131
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 07:38:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DB04A63AA1
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 14:38:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DBABC433D2;
        Tue, 16 May 2023 14:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684247883;
        bh=Rp891Wn0Cv9Njo4jV9mzOxWl35NvhyIucIFSBf4T7Ds=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=mONIeLqEex+UW4Q07DFZTiSg15hTFF9JtA6KGAWjF/JtphUPzfMZM1C/5HSPfU2Wx
         dff6+Hpc78H+NUBGrfHRjkJi0Cp7j8uvybYbWzZUMCNYc0qJvMHSnqyE87lpjRxeP2
         lz4NEcaH7gI5i7Q+Ild8vw081EHiXK5wzOUeVgpwy515yL4LvTNIbbjt6dTQwAVA0d
         hOwTeEEzTM6SAbei6rdfvhupuMJJUGtagBSnPNENvaGfct4xpCz7dLjlgsLLl0/iyh
         xzsu/1mo4Ow6givSsH9GXCHPaWRlOxs+inO+yIAIycvd8BBy0Z8SJQpUwfTPP20rns
         qpIgBZ3UIrEHA==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, Osama Muhammad <osmtendev@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Ivan Orlov <ivan.orlov0322@gmail.com>
In-Reply-To: <20230515172938.13338-1-osmtendev@gmail.com>
References: <20230515172938.13338-1-osmtendev@gmail.com>
Subject: Re: [PATCH] regulator:core.c: Fix error checking for
 debugfs_create_dir
Message-Id: <168424788116.433984.10581444850230359141.b4-ty@kernel.org>
Date:   Tue, 16 May 2023 23:38:01 +0900
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bfdf5
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 May 2023 22:29:38 +0500, Osama Muhammad wrote:
> This patch fixes the error checking in core.c in debugfs_create_dir.
> The correct way to check if an error occurred is 'IS_ERR' inline function.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator:core.c: Fix error checking for debugfs_create_dir
      commit: 2bf1c45be3b8f3a3f898d0756c1282f09719debd

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


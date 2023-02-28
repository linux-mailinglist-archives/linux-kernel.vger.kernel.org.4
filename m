Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B8B86A5E83
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 19:01:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjB1SBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 13:01:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbjB1SBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 13:01:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A2532CDF
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 10:00:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9B42461193
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 18:00:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C676C433D2;
        Tue, 28 Feb 2023 18:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677607241;
        bh=jiPmz/AWg9rLj0S+IiJdtOp7FLXKtGmHtNkSLyWmiPQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=iSzYTQ5dc/RsadQOmK3ot1ZMvParCn20Vn960n5o3ZkjAhrSvzYU5ZTEamtl55/OF
         BFixxlCTDYAx5SDyOPYqD3XNZg6rTkZHJn5+DbtJ8qvqQN0yRCV2GBoAg+W7L0PYs/
         6tGABE/5mcsBv+NyRdlNWODxKE+ndEPLspbCJdHI1p+l0KZ9TR88pT6KB+1nGef0kj
         LYaPYGklR9bC61TmRN9UBVDR8eKnMScWFwdubmYx4BL8xdHuuI6m4cl/hRHYpImh6R
         gGCCB/3TXLemu4c45FBJflyvOml1AQ1R/6P/NYiM9Ck6imNW11elIARRZ2EpTnr7ON
         EOp84x9e+YEiA==
From:   Mark Brown <broonie@kernel.org>
To:     Duc Anh Le <lub.the.studio@gmail.com>
Cc:     linux-kernel@vger.kernel.org
In-Reply-To: <20230227234921.7784-1-lub.the.studio@gmail.com>
References: <20230227234921.7784-1-lub.the.studio@gmail.com>
Subject: Re: [PATCH v2] ASoC: amd: yc: Add DMI entries to support HP OMEN
 16-n0xxx (8A43)
Message-Id: <167760724023.68866.2119410766257240896.b4-ty@kernel.org>
Date:   Tue, 28 Feb 2023 18:00:40 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-ada30
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Feb 2023 00:49:21 +0100, Duc Anh Le wrote:
> This model requires an additional detection quirk to enable the internal microphone.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: yc: Add DMI entries to support HP OMEN 16-n0xxx (8A43)
      commit: d52279d5c9204a041e9ba02a66a353573b2f96e4

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


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE06271670D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 17:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbjE3PaE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 11:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjE3PaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 11:30:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B00EB0
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 08:30:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C4C8762D61
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 15:30:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E0D7C4339B;
        Tue, 30 May 2023 15:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685460600;
        bh=vsD5m4iJ4+NY2hP2qZr9HzAWD+GIDugO2KNzUU//2Io=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=goNe//XAAZO5kKndhAUNyceOMq+N3/kL9qBf3cIPU5QQQJARRk+w04TFjtkQOxqcy
         WrEKwMRD5NIsNpGhWtex1rvOFyP2jqMWdEHUAISs01w5U2uuyKXManB4ctSv2dpOTJ
         vghMjjGs89aQAYhKDQ/PQoF45mEz9Uz46rbrWhdgnILARZikYXruSf1nTLuc4NFveq
         /pBip85LqVd/2hhUMHnwdr3awrQqBsDUnZH3jV8pLXw6l7XsL9UC8kB7tjbzN3xV90
         fXuCYFhEUofdrgBKVuniqyiAeVi/j23YIfwOViZw9gpmWVcSB5X9RXW1Ssm4aQp9mI
         L/3A9aRC3CGiw==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Osama Muhammad <osmtendev@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     linux-kernel@vger.kernel.org
In-Reply-To: <cover.1684930647.git.geert+renesas@glider.be>
References: <cover.1684930647.git.geert+renesas@glider.be>
Subject: Re: [PATCH v2 0/2] regulator: core: Fix error checking and
 messages
Message-Id: <168546059901.564321.11681079059781030918.b4-ty@kernel.org>
Date:   Tue, 30 May 2023 16:29:59 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bfdf5
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 May 2023 14:22:16 +0200, Geert Uytterhoeven wrote:
> 	Hi all,
> 
> This patch series corrects an error check, fixes error messages when
> debugfs is not enabled, and improves debugfs error handling in the
> regulator core.
> 
> Changes compared to v1:
>   - Split in two patches,
>   - Improve rationale.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/2] regulator: core: Fix more error checking for debugfs_create_dir()
      commit: 2715bb11cfff964aa33946847f9527cfbd4874f5
[2/2] regulator: core: Streamline debugfs operations
      commit: 08880713ceec023dd94d634f1e8902728c385939

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


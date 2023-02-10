Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67C47692503
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 19:07:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232724AbjBJSHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 13:07:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232716AbjBJSG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 13:06:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB0F05B776
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 10:06:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 67ED3B824DD
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 18:06:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B895C4339B;
        Fri, 10 Feb 2023 18:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676052414;
        bh=QbXIEweKeedyn7oh9MOgX9ZMqy1sYkxDXvcpRLSGvK4=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=VUOtbKR5ROuzUsdv007adndiFf9GZRMUj1/W4To1P6Z72afLPDibrbE/HaCuU8Kxg
         BK07be9d01kE05csE5GiauqflM/13KJE0rZhIg7QgLvpTXWu6pIAo0EFNGkuFIsj6N
         BXvVNHwIskm7XrMuIOztpA/r9Hbhl/h2l3sSug2BqIpt+ya1cpD+7BlzWILppembBA
         LlyWAUrLW+OwtEzPpeaCfQt/O4IUlsj2NnYfWE/cuNDDpE89LxTCqeRrM7UauVja0G
         zmQ/c75vh0FTVvjVSpAWX8nnl5BxMjDwi6dE4etKwOmsnlps1sO41XKqZrrM2xYB5C
         kzh3ohQatOo+A==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Naresh Solanki <naresh.solanki@9elements.com>
Cc:     Naresh Solanki <Naresh.Solanki@9elements.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230210163225.1208035-1-Naresh.Solanki@9elements.com>
References: <20230210163225.1208035-1-Naresh.Solanki@9elements.com>
Subject: Re: [PATCH] regulator: max597x: Remove unused variable
Message-Id: <167605241295.676115.12744943779625897241.b4-ty@kernel.org>
Date:   Fri, 10 Feb 2023 18:06:52 +0000
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

On Fri, 10 Feb 2023 17:32:25 +0100, Naresh Solanki wrote:
> max597x_regmap_config isn't used & hence remove the same.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: max597x: Remove unused variable
      commit: 6caacd82f09c183a91951776cd8d326e46ef84b4

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


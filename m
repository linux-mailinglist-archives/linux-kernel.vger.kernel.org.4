Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF94672060
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 16:00:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbjARPAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 10:00:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231794AbjARPAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 10:00:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05B9F5EF8C
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 06:55:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 71F6B61830
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 14:55:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FD1CC433D2;
        Wed, 18 Jan 2023 14:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674053741;
        bh=uLfI3nBG1CWhsMl2w9mCNm6lY5o39Ejx/DHfSYUUkIA=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=pU16rgmMm7MXDkVDMA1TQu0wzxgtU4uvLZ7CXKzhgo7fZoUuLzYwza3KfqOSGNosR
         GQCMPCnFCeY7OrXFyJCZD900LYv5ZCpomHEZjvdjqAHOzMcIlWlcYrNU59n6qw5zda
         TPRB+mRei0FZGwA59ni2vtTaRbsXSNvnswDap+tXjPGL2KvA3F4RNK0hrNja9EVcQ8
         2dp2L3nqoDNMRI8y3tZw6rAkSg+2v+ly38DQCEtBaGZIamiOntiysfhI2ip9YwVkjk
         ZdZI6wrue8xwS0MS+8mnJcQsAIwl3pJEZdvLtxEtF5xqUsLMY4NeJ13GzDBmeyuNb2
         axRkTyxZSMMfw==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Cc:     Andrei Stefanescu <andrei.stefanescu@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        linux-arm-kernel@lists.infradead.org
In-Reply-To: <20230117070139.28905-1-rdunlap@infradead.org>
References: <20230117070139.28905-1-rdunlap@infradead.org>
Subject: Re: [PATCH] regulator: mcp16502: add enum MCP16502_REG_HPM
 description
Message-Id: <167405373960.864083.14418700342230230973.b4-ty@kernel.org>
Date:   Wed, 18 Jan 2023 14:55:39 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-77e06
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Jan 2023 23:01:39 -0800, Randy Dunlap wrote:
> Add description for MCP16502_REG_HPM to prevent a kernel-doc warning:
> 
> drivers/regulator/mcp16502.c:90: warning: Enum value 'MCP16502_REG_HPM' not described in enum 'mcp16502_reg'
> 
> 

Applied to

   broonie/regulator.git for-next

Thanks!

[1/1] regulator: mcp16502: add enum MCP16502_REG_HPM description
      commit: 84c13763f2a22acc31472dccde8b6130b8f2e9c2

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


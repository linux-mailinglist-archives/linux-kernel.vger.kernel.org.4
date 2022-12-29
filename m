Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A189265917D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 21:25:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233999AbiL2UZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 15:25:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233850AbiL2UZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 15:25:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E461315F1B
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 12:24:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6312361950
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 20:24:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14C89C433D2;
        Thu, 29 Dec 2022 20:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672345498;
        bh=d4rkeTQGfofmBsx4GPmbWQ0NW/x1XL125mE2mQL8t2s=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=Efqj3ZzYjU3trqWya/0wgbvX/C5TJwjVJJrSdRySP6lczUuXahzJ/kNcRb9U4adRB
         PxJJKrgfVxHxMzO3dJSASn9w0g+9IxEZPkB08v4PgZuAx7uryfhQ0Txxr4//4tOJ8n
         b6I4vdKFu+FSKKaThgNCTzk5eCu/ltOZ+/YWIV3iSns6gRSMRQesAwWqj4r9w/1yMG
         JcgjmVUdE6hRi42wrJhtorx6pxrkKCvx8k+Gv8D5bV84H8giJbH08Zx90y4Zq89lkQ
         489Cg8toJT5uGPcvzGfWZaDVCQ/wb+wuxONjl/U0lmJCJHA3rCr6ltY56NX+cvlITO
         CdWX++unmchRg==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org, mario.limonciello@amd.com,
        Aniol =?utf-8?q?Mart=C3=AD?= <aniol@aniolmarti.cat>
In-Reply-To: <20221227224932.9771-1-aniol@aniolmarti.cat>
References: <20221227224932.9771-1-aniol@aniolmarti.cat>
Subject: Re: [PATCH] ASoC: amd: yc: Add ASUS M5402RA into DMI table
Message-Id: <167234549772.88546.11100329443121665735.b4-ty@kernel.org>
Date:   Thu, 29 Dec 2022 20:24:57 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12-dev-69c4d
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Dec 2022 23:49:32 +0100, Aniol Martí wrote:
> ASUS VivoBook 13 OLED (M5402RA) needs this quirk to get the built-in microphone working properly.
> 
> 

Applied to

   broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: yc: Add ASUS M5402RA into DMI table
      commit: a0dd7fcab5cd221fa960f594c586e1f9f16c02c0

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

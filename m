Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD5263F75C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 19:16:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231264AbiLASQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 13:16:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231251AbiLASQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 13:16:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B04F355CBA
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 10:16:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6BEDCB81FCD
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 18:16:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7FFDC433C1;
        Thu,  1 Dec 2022 18:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669918572;
        bh=xyhTKfcDbX7uDUnZWqgBFfiKEcdyGZ9jVqILUdnip9g=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=mlkDrZIHbPJ3IL35B44jWlJJutayDMFbZjo5EWvmtPr8KhslhGzmplnaxUctn/TRr
         3TU6VfkkDYtf0frmi7E2/LLC2by7Q3zcT/K5gEeFZ4L/uAiqAAlqNGFW6YPa66MIAU
         zZCy2zKnRzPS7ZGbNfdhbyDszlgq1mhkThPTYVV3GIizaDkxJkFXP0sJDBF39YZj6m
         yYiLj+PIS7aDikfXHj8avIw6ZO85wf6y9WPQT8w8euZm3Ms1uBl7XQxj43U4HaiqRS
         hHEVEcCcT6NLGNpSlb2QqpPpygtjcjftDwXXHeWAZb9PCKrb2t3UpcixoGWi5JQTh4
         8WFucm9QQ4THw==
From:   Mark Brown <broonie@kernel.org>
To:     Yang Yingliang <yangyingliang@huawei.com>, javier@osg.samsung.com,
        christian@kohlschutter.com, lgirdwood@gmail.com,
        mirq-linux@rere.qmqm.pl
Cc:     linux-kernel@vger.kernel.org
In-Reply-To: <20221201122706.4055992-1-yangyingliang@huawei.com>
References: <20221201122706.4055992-1-yangyingliang@huawei.com>
Subject: Re: [PATCH 0/2] regulator: core: fix some resource leaks
Message-Id: <166991857062.1721915.16994544340015847623.b4-ty@kernel.org>
Date:   Thu, 01 Dec 2022 18:16:10 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Dec 2022 20:27:04 +0800, Yang Yingliang wrote:
> This patchset fixes resource leaks in some error cases.
> 
> Yang Yingliang (2):
>   regulator: core: fix module refcount leak in set_supply()
>   regulator: core: fix resource leak in regulator_register()
> 
> drivers/regulator/core.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/2] regulator: core: fix module refcount leak in set_supply()
      commit: da46ee19cbd8344d6860816b4827a7ce95764867
[2/2] regulator: core: fix resource leak in regulator_register()
      (no commit info)

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

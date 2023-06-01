Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01471719F4B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 16:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233811AbjFAOMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 10:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233925AbjFAOM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 10:12:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C0121A7
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 07:12:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AC8A864584
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 14:12:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F065C433EF;
        Thu,  1 Jun 2023 14:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685628745;
        bh=7JEOY5KQdqPCrKUkJxJKMsT5SEyQBEO158XALTuHM6o=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=MTrqJnI3vhI7DcD8S3xAI1nzE2botnX1sofoFfnJ5M6kI/E5atSt67JlRoxUC2+gy
         EFjmkv8jwlN8eKpO5VpVSVNQwY1KJcvfT1V4bbLHlW0VwpEc0DIGElaWsZMLDd8AUQ
         3vz8Hw52ztEfBoIbH3DtBYzb4SFTUMccExtZ5DaxVMMe1ncbIXQyvnA9tQe4hQfSpz
         y3XgBs3rMsWn0m9rNNyUWKvGIivJvjXeDxTezgZQRR0rgJscOEMRmu67dYvVCbbbDd
         EEuqvAbcaL1tAt/JF7Ktwdein5Xja1c+Gfse8ERcYWyFGLXRg7I+T6oPj1bsK33eea
         ZNaa66r4e53oQ==
From:   Mark Brown <broonie@kernel.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
In-Reply-To: <20230531170158.2744700-1-rf@opensource.cirrus.com>
References: <20230531170158.2744700-1-rf@opensource.cirrus.com>
Subject: Re: [PATCH] firmware: cs_dsp: Log that a bin file was loaded
Message-Id: <168562874389.66708.18316483706903232896.b4-ty@kernel.org>
Date:   Thu, 01 Jun 2023 15:12:23 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bfdf5
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 May 2023 18:01:58 +0100, Richard Fitzgerald wrote:
> Change the message at the start of bin file loading from
> cs_dsp_dbg() to cs_dsp_info() so that there is confirmation
> in the kernel log that a bin file was loaded, and the name
> of the file.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] firmware: cs_dsp: Log that a bin file was loaded
      commit: 8f4007e87ef9637aa557340762d6c3bbcbbd5669

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


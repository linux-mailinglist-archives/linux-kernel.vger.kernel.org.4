Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26B25702B1E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 13:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241203AbjEOLKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 07:10:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241191AbjEOLJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 07:09:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AEF91738
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 04:09:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0F16B62295
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 11:09:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76926C433D2;
        Mon, 15 May 2023 11:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684148986;
        bh=AzqOmQc7OrwPNPM/ssnco453fybt0WCECRc/Pyq/wu0=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=LB03kSIDbU5zCmAqtLnCcGqTE1YXvzkj9MSUdYA0qHhOAfityGb7oI8oPH412R67d
         Ks5SEV7MYOkjwEIET6zHeE9YRRW8QmzChbrysCVJ7hJSJBh6JHMMhLaZKo6Od+VG1o
         bxchNBsaQg2YMEYuCiugpcL4rOjWEirjtHbyoloSuIXYRx4JEiNauacN7t3Xj72YiC
         WQI4Ccfk47XWi7M8aa8amEvjCB+IKKU3D+Z5izH/5PiY+9OTwXMOf0obhc08u2Bxb9
         06fvUUm+WdL66JKwMPOuB/N9R3OeTQszOV5UsiJNKOq+U3AGUGHp+xugFUItwYNAax
         kZUKlPuifOupA==
From:   Mark Brown <broonie@kernel.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com,
        Lucas Tanure <tanureal@opensource.cirrus.com>
In-Reply-To: <20230512154503.741718-1-rf@opensource.cirrus.com>
References: <20230512154503.741718-1-rf@opensource.cirrus.com>
Subject: Re: [PATCH RESEND] MAINTAINERS: Remove self from Cirrus Codec
 drivers
Message-Id: <168414898513.394037.16270681416045014663.b4-ty@kernel.org>
Date:   Mon, 15 May 2023 20:09:45 +0900
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

On Fri, 12 May 2023 16:45:03 +0100, Richard Fitzgerald wrote:
> I'm leaving Cirrus Logic, and will no longer have access to
> hardware and documentation necessary to be effective in a
> maintainership role.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] MAINTAINERS: Remove self from Cirrus Codec drivers
      commit: dc60b67d259ea63196dcd0400dd43ba062e2e097

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


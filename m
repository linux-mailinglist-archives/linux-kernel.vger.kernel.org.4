Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CDFE669BD9
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 16:22:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbjAMPWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 10:22:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbjAMPVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 10:21:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D4B2EB
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 07:14:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4E9E562163
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 15:14:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2438C433EF;
        Fri, 13 Jan 2023 15:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673622885;
        bh=HH+IHQBfnoL4vEdSLg+2Y9mHPBx3BF/9VZVgAb6Oo64=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Trt7RFAQOheYK666igSR53Q4RDwWdiiMVQZ52d5OAg9aadWmY+sHma0dclJqJNxrc
         KA5OE273vuPsAMo/SCJI4JxBDr23QljgK0KAsvoaWQhIYU7N58n68bqsb6fV7l7xCe
         ZPEDi65tI9DpQzmhP2roL+WGcLjgXGSV0vD7Ch+aGaob+gnrp6QHT/+QfsEalQNAOh
         QoLoE+K4yE98QlI8jyttpDFLOLO9bsx0YiTfqgtKvOtv5xSzqoBmiKAFJcmMZFKg7T
         CFfox6zNoHuf4yWKJSAUxwLCrJKl5F6FAo1K+vZaBAuRcE5U4bVKMDC4PiSA2oZA+h
         XX3J4ZIsXO7Lw==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>
In-Reply-To: <20230113064412.11038-1-rdunlap@infradead.org>
References: <20230113064412.11038-1-rdunlap@infradead.org>
Subject: Re: [PATCH] regulator: act8945a: fix non-kernel-doc comments
Message-Id: <167362288471.139122.5287366296409861069.b4-ty@kernel.org>
Date:   Fri, 13 Jan 2023 15:14:44 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-8b3d1
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Jan 2023 22:44:12 -0800, Randy Dunlap wrote:
> Don't use kernel-doc "/**" markers for comments that are not in
> kernel-doc format. This prevents these warnings:
> 
> drivers/regulator/act8945a-regulator.c:19: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>  * ACT8945A Global Register Map.
> drivers/regulator/act8945a-regulator.c:50: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>  * Field Definitions.
> drivers/regulator/act8945a-regulator.c:56: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>  * ACT8945A Voltage Number
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: act8945a: fix non-kernel-doc comments
      commit: 80332ec8c0994dc457026b20619dee0f9990706f

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

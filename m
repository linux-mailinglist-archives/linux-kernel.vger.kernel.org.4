Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6B426B5EA5
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 18:19:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbjCKRTp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 12:19:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbjCKRTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 12:19:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4DF9D5153;
        Sat, 11 Mar 2023 09:19:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 538F260D29;
        Sat, 11 Mar 2023 17:19:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B75E7C433A1;
        Sat, 11 Mar 2023 17:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678555171;
        bh=468t4HrwRu7/rsBqVcjX19Z80GSYIgoLlm0Iv/qhlhw=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=KuYf8cREzwlia2X2zMlDCukw/175q6tFMwMuRfK0+N/JX18BMRBBbBm1ONbC6hFmC
         SWlwIT9c+tP+2LN1REX0ALpWwJnTCEXjVpgzdrlWuJAFpgEe3V5J97DcCD8Fv0ZxAS
         RYGE5gvjxK6toT2feqq23On4EuTWpqx4Z/0tuDg1r+gM/O/kW8kU9YC27UQ4xomJ+9
         XOP1CTSa/s+0bOS4rCq8NCq2JYkBfYuaaG26Ra8fzXaWPNBL5k+AG7JRNRx4sfWiWF
         s25whORoUHcAEQnkhDSWPGnJ8L0hrO/ih1qyI/2jgGkT2sm+RubLDMj/WhoxtRRK9U
         JoO/QtAnIlEOw==
From:   Mark Brown <broonie@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230310144736.1547110-1-robh@kernel.org>
References: <20230310144736.1547110-1-robh@kernel.org>
Subject: Re: [PATCH] spi: omap2-mcspi: Use of_property_read_bool() for
 boolean properties
Message-Id: <167855516965.950686.4250661181877486648.b4-ty@kernel.org>
Date:   Sat, 11 Mar 2023 17:19:29 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-2eb1a
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Mar 2023 08:47:36 -0600, Rob Herring wrote:
> It is preferred to use typed property access functions (i.e.
> of_property_read_<type> functions) rather than low-level
> of_get_property/of_find_property functions for reading properties.
> Convert reading boolean properties to to of_property_read_bool().
> 
> 

Applied to

   broonie/spi.git for-next

Thanks!

[1/1] spi: omap2-mcspi: Use of_property_read_bool() for boolean properties
      commit: 03adaa404a2c8f9ae0528eb963e86a962a3a2f39

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


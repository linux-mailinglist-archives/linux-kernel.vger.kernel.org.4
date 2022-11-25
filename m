Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3190638C19
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 15:27:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbiKYO1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 09:27:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbiKYO0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 09:26:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A0162B247
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 06:26:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8C7EE62475
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 14:26:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E29FC433C1;
        Fri, 25 Nov 2022 14:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669386411;
        bh=XAIRBJbnf54MBkCwp15rFPKjE5v6h8r+OImi98VohDA=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=NQJzQ5WAawQDE0R7OHT86nbCtYWBg8hKID49uirIDj64HINAUmJ1dSmHdv0KQpP8b
         IItJE+jJk/EQW3NXhcJenhVtWEkYQy28SGP0wGZQf5WOzRkPiOYocYuncrdEEuxm9C
         4f/mrxMYY3r3kq/4by4DgnsMyoAzuy1D2OQuKQMP20/V38tyQaYptlqNAQFv1oWwHU
         A/qh7+FFEA/Fi2p79Jc3H1QcVhh7Pb6tQbt5nnpXlBqvIQig62CikzuWZhElmClxS5
         DfyNj1xMC3wSISElPWPX5LBarOPHUzOZQH/dtznbS+TXDRoSxMikt4TNM1GyJ0BYp+
         JhnmEp1d5DJCw==
From:   Mark Brown <broonie@kernel.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     linux-kernel@vger.kernel.org, patches@opensource.cirrus.com,
        alsa-devel@alsa-project.org
In-Reply-To: <20221123165811.3014472-1-rf@opensource.cirrus.com>
References: <20221123165811.3014472-1-rf@opensource.cirrus.com>
Subject: Re: [PATCH v2 0/2] ASoC: wm_adsp: Report when a control write changes the value
Message-Id: <166938640983.506633.5904617504530907005.b4-ty@kernel.org>
Date:   Fri, 25 Nov 2022 14:26:49 +0000
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

On Wed, 23 Nov 2022 16:58:09 +0000, Richard Fitzgerald wrote:
> Writing a firmware control should be returning 1 if the control value
> changed, so these two patches add that.
> 
> Though this is an ALSA requirement it is also useful for non-ALSA clients
> of cs_dsp to know if the control value changed, so the main handling is
> implemented in cs_dsp. TLV controls are specifically an ALSA thing so they
> are handled specially in wm_adsp.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] firmware: cs_dsp: cs_dsp_coeff_write_ctrl() should report changed
      commit: c56f4b2442d33bd94c418697f753271099384bee
[2/2] ASoC: wm_adsp: Return whether changed when writing controls
      commit: 7406bdbc4fb8b99cf0150cb2056a585c95ceafe7

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

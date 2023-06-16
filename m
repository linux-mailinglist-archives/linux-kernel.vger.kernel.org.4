Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7AC1733216
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 15:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345616AbjFPNWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 09:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345605AbjFPNWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 09:22:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0898A358E
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 06:22:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8926A627DE
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 13:22:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19906C433C8;
        Fri, 16 Jun 2023 13:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686921723;
        bh=DqqgaENLrZimYT7uA4EsAi84O97PWBTtKxtnUhTbzUQ=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=CNuWZbXxJG7rfKPl62veFBk+iteoizhyRsIbHFWYIT2T7clunsrqkxd12QA6X2eXq
         rfL9p7EDYGhkSaQ1N1YD9Dov0zynZ1F1Zsv8JxUi1fPB0tFJdX1Li7BvksSwCSXk+0
         Vsj8SQNQAPDPSn8yB6Z4bn/X3F70KMUzg+CwyRTzP4gLcxvl69PiYFwRXGF5K0E0gN
         +oAVCkr4IqKUV3edB9+nRoGVJbNGUKwRWMwQOk5XinLPP9tuTeA7OEjlMWKXxZ14QN
         uJgCrHLvooz6pqtN7yuRszqziQeArncX3dMMpZaLjPycjRYhKOcb/X4elehIVEjSfL
         rEAsu/j3uXebA==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org,
        Konrad Dybcio <konradybcio@kernel.org>,
        Mark Brown <broonie@kernel.org>
In-Reply-To: <20230615-regmap-drop-early-readability-v1-1-8135094362de@kernel.org>
References: <20230615-regmap-drop-early-readability-v1-1-8135094362de@kernel.org>
Subject: Re: [PATCH] regmap: Drop early readability check
Message-Id: <168692172278.235227.5361924639572805383.b4-ty@kernel.org>
Date:   Fri, 16 Jun 2023 14:22:02 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-c6835
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Jun 2023 00:04:40 +0100, Mark Brown wrote:
> We have some drivers that have a use case for cached write only
> registers, doing read/modify/writes on read only registers in order to
> work more easily with bitfields.  Go back to trying the cache before we
> check if we can read from the device.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/1] regmap: Drop early readability check
      commit: 3e47b8877d6c0f60943b00f3112756ca3b572cd6

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


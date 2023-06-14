Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84D29730069
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 15:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245194AbjFNNsJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 09:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245132AbjFNNr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 09:47:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE1F268C
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 06:47:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7A6A76426A
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 13:47:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FA06C433C0;
        Wed, 14 Jun 2023 13:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686750468;
        bh=v2S9ICKtWodQVVO1lhYJyrYbyK3RwIOTKb/9RuxU5mE=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=aJbawgyCC8/XckiuYl3kB1svwQ4eDwyZr9ZeVRnd084v5HGFrKMBXKfT2P4WDy2eP
         TwXkt35ue0CGwiHQSEGF4Ju5RGvpTUMjcOhqpgkHSrflV39lYtS/QU+wfAi+P6BIIW
         ENIxTemz1D8hcPSEvbmsZ1lnaq1QSEnv1fiQd9+yUjSOiXOmRN0rRfpcfwAAXM56RL
         Qz84uUN1Nl/VZpQXE4NwleZtbKRlADngdt4GxCrkSom9slLjNyiaQqyO/iC8REISYG
         OcfQP3nUydpJ7Oc4gmiXaGCN9UHxpW+9AUsdonT6hs7G+KnTZU9UsvkiilTC4771aC
         BDUkMTwJNXygQ==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
In-Reply-To: <20230613-b4-regmap-check-readability-before-cache-v1-1-b144c0b01ed9@kernel.org>
References: <20230613-b4-regmap-check-readability-before-cache-v1-1-b144c0b01ed9@kernel.org>
Subject: Re: [PATCH] regmap: Check for register readability before checking
 cache during read
Message-Id: <168675046809.162502.15059417172912846988.b4-ty@kernel.org>
Date:   Wed, 14 Jun 2023 14:47:48 +0100
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

On Tue, 13 Jun 2023 21:07:16 +0100, Mark Brown wrote:
> Ensure that we don't return a spurious cache hit for unreadable registers
> (eg, with the flat cache which doesn't understand sparseness) by checking
> for readability before we do a cache lookup.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/1] regmap: Check for register readability before checking cache during read
      commit: eab5abdeb79f0f694c007c3a76a97902705c86f0

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


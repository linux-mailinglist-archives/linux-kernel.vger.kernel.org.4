Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4BA46D7C83
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 14:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238017AbjDEM0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 08:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237210AbjDEM0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 08:26:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D442759F9
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 05:25:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2BD2C63BF0
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 12:25:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EDB0C433D2;
        Wed,  5 Apr 2023 12:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680697549;
        bh=2ViGdaKT/6uhXxtE9hEmZxbA1lJCR9L0M3W86yX8NRw=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=ajQw2KUV+U7AlAbiTWrS44Dn0JZN29/FoH1Uf8830ZM+AiH14ll6N7SCKY3yinvSk
         6wgekz2Ry/KZ14hWq5an/q3SN2Kwl5SQ9zwPNyT83LUKOl9imwkpyf+rRPEpaV/pKr
         iirivpX5fvCEKGAMpPWYyCnenDzSY3TM5s+QoFAl1htZYqVX5XKCQCXFOHq/CkRmD7
         KThlEWaRgCIHJzdHdI+e6Ix/4ulLo4dTDJigCAwSBLfKgQwWEn106b5Z1z+ILnu/nr
         gCRldej6QzOmFl0kwKL63r37T7YsR71KlVs5K+T4dN/YKUz7kEqAuacvXNOTClBBNq
         YNTyl9P0SStoA==
From:   Mark Brown <broonie@kernel.org>
To:     Liam.Howlett@Oracle.com, Mark Brown <broonie@kernel.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230403-regmap-maple-walk-fine-v2-1-c07371c8a867@kernel.org>
References: <20230403-regmap-maple-walk-fine-v2-1-c07371c8a867@kernel.org>
Subject: Re: [PATCH v2] regmap: Use mas_walk() instead of mas_find()
Message-Id: <168069754829.50839.3429287671431516828.b4-ty@kernel.org>
Date:   Wed, 05 Apr 2023 13:25:48 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-00303
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 04 Apr 2023 20:42:28 +0100, Mark Brown wrote:
> Liam recommends using mas_walk() instead of mas_find() for our use case so
> let's do that, it avoids some minor overhead associated with being able to
> restart the operation which we don't need since we do a simple search.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/1] regmap: Use mas_walk() instead of mas_find()
      commit: fac79bad889bb167a37492181646992c8c48903b

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


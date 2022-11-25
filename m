Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F500639113
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 22:28:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbiKYV2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 16:28:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbiKYV2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 16:28:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB836537F1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 13:28:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6C0E860EF4
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 21:28:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D36EC433D6;
        Fri, 25 Nov 2022 21:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669411721;
        bh=QiMeHracAPcJNUmU/97XystmnPIWB7tNUE61xoEs2fE=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Wavsfc/tfP9wiPgIeqbXnir/udsRF7leGt/6uh/2SFn1FYaV5GQYKK2+MH2fWKVwY
         51v2xCP+HXKT8mhZkSOxV0NYjHYaIFHIvutvagaIl+PAw1kqMSIW/p57mgH7uLHSBg
         cjt2A/JpUeACl+5pSwS3X1M5qG6QzzdmBdQUDYJtv1UzfWgDuxC2USHjtWYyhJQIc/
         Fh7KSwB3Ud8EkpZ95Hx/k+NBx99DJJqY7oLeWIqUo+AXhxmOUMvy7LvvDL0Wyk1WF0
         Cwa26/1CJr5C86+XQ8CFVkFYAtgYca6MPXZGqxSbCVEDtQfHGyz+MFI+uz9xyLPCPg
         KfTS9YH2SuX8w==
From:   Mark Brown <broonie@kernel.org>
To:     Eddie James <eajames@linux.ibm.com>, linux-fsi@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, alistair@popple.id.au,
        joel@jms.id.au, jk@ozlabs.org, rafael@kernel.org,
        gregkh@linuxfoundation.org
In-Reply-To: <20221102205148.1334459-1-eajames@linux.ibm.com>
References: <20221102205148.1334459-1-eajames@linux.ibm.com>
Subject: Re: (subset) [PATCH v2 0/5] fsi: Add regmap and refactor sbefifo
Message-Id: <166941172004.2089843.9744380408394537777.b4-ty@kernel.org>
Date:   Fri, 25 Nov 2022 21:28:40 +0000
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

On Wed, 2 Nov 2022 15:51:43 -0500, Eddie James wrote:
> The SBEFIFO hardware can now be attached over a new I2C endpoint interface
> called the I2C Responder (I2CR). In order to use the existing SBEFIFO
> driver, add a regmap driver for the FSI bus and an endpoint driver for the
> I2CR. Then, refactor the SBEFIFO and OCC drivers to clean up and use the
> new regmap driver or the I2CR interface.
> 
> Changes since v1:
>  - Instead of a regmap driver for the I2CR, just have a private interface
>    driver for FSI, since SBEFIFO is likely the only user.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/5] regmap: Add FSI bus support
      commit: bf0d29fb51ff5e6c13097dbfed7b99e0e35b4a15

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

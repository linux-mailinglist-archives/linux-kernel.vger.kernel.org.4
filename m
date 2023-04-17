Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9D006E50E5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 21:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbjDQT2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 15:28:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbjDQT2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 15:28:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A876A6E;
        Mon, 17 Apr 2023 12:28:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C79326207E;
        Mon, 17 Apr 2023 19:28:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3867AC433A0;
        Mon, 17 Apr 2023 19:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681759691;
        bh=/SRLQYvRMDyytZR815x8uObk4ij3vjSpbDwjYtRJ6Js=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=pqlm6Zv3MX1oJijk0WnBcdFADz1loMhWE3y6bYZzlO8fz+tnETfJMPEvAZzTxskEp
         HVXTyblBVS8khf8puCLuNQ+d9GxHvSZI0KZafPi/Xw5MPKmsWN3ewxc7x+JB0Y5LJY
         TVp+9oeLFvxpaPEzBlA9Y8Wv4ZyL+YNgMx1okEpPp4nkak4AtEctMKdSULJnWx7ZKn
         vMLbBQbrA2rdXEv2fQBwj0uYO19TitKf0w7YHV8/g8YJZi3JIbf1JhcgzH65wTTV0L
         RoRrNY309oHVP2s0mFeRdAynix5F4AR80UNCZEPe5ebWNPmSKFeAcIRBB3BiigOvm8
         CTz9FDD7Iurlw==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, daniel.baluta@nxp.com,
        Saalim Quadri <danascape@gmail.com>
Cc:     patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230414223801.1106550-1-danascape@gmail.com>
References: <20230414223801.1106550-1-danascape@gmail.com>
Subject: Re: [PATCH] ASoC: dt-bindings: wm8753: Convert to dtschema
Message-Id: <168175968893.1283403.17451659759711572272.b4-ty@kernel.org>
Date:   Mon, 17 Apr 2023 20:28:08 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-00303
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Apr 2023 22:38:01 +0000, Saalim Quadri wrote:
> Convert the WM8753 audio codec bindings to DT schema.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: wm8753: Convert to dtschema
      commit: 59de6c38d713bb16760cc2612a79bc373f79bc6b

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


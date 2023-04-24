Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEE346E6943
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 18:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231710AbjDRQV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 12:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231169AbjDRQVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 12:21:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC0B3C38;
        Tue, 18 Apr 2023 09:21:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC9C76364E;
        Tue, 18 Apr 2023 16:21:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CB76C4339C;
        Tue, 18 Apr 2023 16:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681834881;
        bh=ap6Q5odoQ4rNoTfPJqKCKCL+ukarr6XYL6tmAzzw7Qw=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=MrFuEiWQY5pEd6wb4KR1+TS3E3VXN4mi6xoxWF1ods9t1Mg/FK1Og11IWCNOFPIIw
         c1OrFuxGXfWdR9Qc752L7Ete4iHhYkaDZPDclXzWrjkPqPIbl3HTpPVorMEfWF/m9P
         B3z3cie4yBQSOGkt8f4D21Euykk4rqB0A2pa5pI4Gi1ab04i2Frm+HbcPgoeAh09T9
         e48IEmR4HvUXjpjEHaXS7jxZCqi5bmdNNC+xb59EG1B3nR3+gppahy/+U0nW2QYXVB
         OffyKv8UyCCbjdWxnEdAWJAFOOs0BGd6d57Zd2+zl2DMHAi+RBDoyDiOAtKtYmdvYw
         6UOF3m/W48MIg==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, daniel.baluta@gmail.com,
        Saalim Quadri <danascape@gmail.com>
Cc:     patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230417212400.161796-1-danascape@gmail.com>
References: <20230417212400.161796-1-danascape@gmail.com>
Subject: Re: [PATCH] ASoC: dt-bindings: wm8737: Convert to dtschema
Message-Id: <168183487901.87933.8631683727283438800.b4-ty@kernel.org>
Date:   Tue, 18 Apr 2023 17:21:19 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-00303
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Apr 2023 21:24:00 +0000, Saalim Quadri wrote:
> Convert the WM8737 audio CODEC bindings to DT schema
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: wm8737: Convert to dtschema
      commit: c341b5681fa074faa596fbb0fa0fc256b7e2301a

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


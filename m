Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5617D70F4BE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 13:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234329AbjEXLEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 07:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234317AbjEXLEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 07:04:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2E691AE;
        Wed, 24 May 2023 04:04:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5C01F63BB1;
        Wed, 24 May 2023 11:04:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F720C433EF;
        Wed, 24 May 2023 11:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684926271;
        bh=afkaeFx0ab/vSGv0Hu2IOltH+7rU/mCIFnFsmEYzd6U=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=k5v+PymPmEws7orUUcVTez97drKQq+JQzlK8hGFUPa3l0M/n+sqt1pbaYetlIpc88
         P1Eo3JT5XLDxH14Hyqrg8P01Vik/rf7NPiJoHwGTOvCId4I5e/pf6EdTwBRuhthGwG
         +RdygwbQLH1Qmm/n2fO2dtRr/embB0CZeDACEssm4KjZP9GT7AHqnQxVSsHcnM7LYQ
         gDahNNgIoo2V2hqc3BoeJeuKdiqui6GS+nZCfl2mSUAJ4dQVxu7rI0+GVkOADnxMc0
         lYLCXWjDbMQFoMJoQHEIGPXSoV5/kSX7pwSw9d0dyGpg8h46qsFquQ2iNccssWzkSd
         msBh0gmFeuwXQ==
From:   Mark Brown <broonie@kernel.org>
To:     conor+dt@kernel.org,
        David Rau <David.Rau.opensource@dm.renesas.com>
Cc:     support.opensource@diasemi.com, lgirdwood@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20230523161821.4260-1-David.Rau.opensource@dm.renesas.com>
References: <20230523161821.4260-1-David.Rau.opensource@dm.renesas.com>
Subject: Re: [PATCH 0/3] ASoC: da7219: Add jack insertion detection
 polarity
Message-Id: <168492626936.37175.18228969711177024530.b4-ty@kernel.org>
Date:   Wed, 24 May 2023 12:04:29 +0100
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

On Tue, 23 May 2023 16:18:18 +0000, David Rau wrote:
> This patchset adds the support of DA7219 Jack insertion detection
> polarity selection.
> 
> The first patch replaces the old txt binding with a new schema binding.
> 
> The second patch adds `dlg,jack-ins-det-pty` property for Jack
> insertion detection polarity selection.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC: dt-bindings: dialog,da7219: convert to dtschema
      commit: 345585b776e6f6f1cab846eb3efbef32c53fc0e3
[2/3] ASoC: dt-bindings: da7219: Add jack-ins-det-pty property
      commit: c28dc3bdfcd9e93b6cf1f3f0bb3c51e819fc977f
[3/3] ASoC: da7219: Add Jack insertion detection polarity
      commit: dc0ff0fa3a9bf9f7be3a9530f8f6079324f54fa5

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


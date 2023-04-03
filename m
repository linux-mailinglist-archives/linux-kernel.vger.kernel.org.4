Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F62B6D4B65
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 17:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232501AbjDCPHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 11:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232521AbjDCPHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 11:07:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1116235A9;
        Mon,  3 Apr 2023 08:07:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A135361419;
        Mon,  3 Apr 2023 15:07:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D711CC433D2;
        Mon,  3 Apr 2023 15:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680534464;
        bh=9XtzN3OjyD2EdWqBisgPuKgrj6g/+EyaufBYf2jb4Io=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=GHAEzlEZqjrAWLj1f3yse1Nnv+wuZtoKxDHYCmL5lLSzaO1u7+rScEmXO1eQ5Xz5f
         +xAAczFoDl2ZC26s4pCO2EZa4rEICIeduFnTV42Zlww2N2cDt/AeHKyV6+NjScf+2V
         9fqzZ9fkJ30rF3Adgxxu0J/sNwsEQ1BQVVkvZq8dF+bcj0hyQl838uvvyJLihBjfcD
         fk7qiqnrOBVXQgoW1LMmVZ3BEAGjf+A982MjPx3/vpbTOsP92heRDqROh6+NOIV6Aw
         jBM4PpaNklhfhni+6FsSw7cYYwacPg8y8g5cO7fwSc2Rf78WCYqxJMyFkNTnGndDt6
         ddqxCFTF4dRDA==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        anish kumar <yesanishhere@gmail.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?utf-8?q?Andr=C3=A9_Morishita?= <andremorishita@gmail.com>
Cc:     mairacanal@riseup.net, dri-devel@lists.freedesktop.org,
        daniel.baluta@nxp.com
In-Reply-To: <20230401181930.533067-1-andremorishita@gmail.com>
References: <20230401181930.533067-1-andremorishita@gmail.com>
Subject: Re: [PATCH v3] ASoC: dt-bindings: maxim,max98371: Convert to DT
 schema
Message-Id: <168053446153.47553.4385638479008014826.b4-ty@kernel.org>
Date:   Mon, 03 Apr 2023 16:07:41 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13-dev-00303
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 01 Apr 2023 15:19:29 -0300, André Morishita wrote:
> Convert the Maxim Integrated MAX98371 audio codec bindings to DT schema.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: maxim,max98371: Convert to DT schema
      commit: 5781c22ea87700cd1da8f8de8a82fc10ef2f14d2

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


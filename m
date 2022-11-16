Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 013C562C1B9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 16:01:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233866AbiKPPBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 10:01:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233774AbiKPPBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 10:01:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F41123;
        Wed, 16 Nov 2022 07:01:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3A5BBB81DC0;
        Wed, 16 Nov 2022 15:01:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A2DBC433C1;
        Wed, 16 Nov 2022 15:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668610893;
        bh=fW6w1idZxb4pYL1tbNrDvO8loV3/4f3FgP5oo/YyO6M=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=JSJe6RakS/RPXPxgiSMPkYUBiJScY9c29XGPMrvHoW8P7kbElGJzqyvuwpEnMgkpH
         q1DP4iVi91j4L2/j+DcbyhdwgZYm3usqMrlNMysi9ew1zzywExVElPCP7Tu3T164Ri
         dzKnmjtTgq2cejT1M9jSYvw2hGxzTzAC2/DvoscV0oDEUed8vHHN2JcXiARwe6+ZPg
         75L6Cyu8xFMxZOtytnFYO69g0rrjlcC045SRQbKx7vW/uXIp8Gdz8IkH4SRTvtBp2H
         kIe7Xa2Ii5y2so0zZElZeCpctGytnGaVWymG+l3zvm9ZVPcNFb/XUXRt9DbCwOwdGj
         JTLkyg5iTxbRg==
From:   Mark Brown <broonie@kernel.org>
To:     Bjorn Andersson <andersson@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Parikshit Pareek <quic_ppareek@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>
In-Reply-To: <20221116102054.4673-1-johan+linaro@kernel.org>
References: <20221116102054.4673-1-johan+linaro@kernel.org>
Subject: Re: (subset) [PATCH 0/2] arm64: dts: qcom: clean up 'regulator-allowed-modes' indentation
Message-Id: <166861089087.540847.301727183033006932.b4-ty@kernel.org>
Date:   Wed, 16 Nov 2022 15:01:30 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-8af31
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Nov 2022 11:20:52 +0100, Johan Hovold wrote:
> When reviewing a new devicetree for sa8540p-ride I noticed that the
> indentation for the 'regulator-allowed-modes' properties was off and
> realised that this had been copied from the recent patches adding the
> missing modes properties.
> 
> Let's clean up the binding example and current devicetree sources to
> avoid this pattern being reproduced further.
> 
> [...]

Applied to

   broonie/regulator.git for-next

Thanks!

[1/2] regulator: dt-bindings: qcom,rpmh: clean up example indentation
      commit: b8dfb3bed5524589052dafa0e4d6c4e25ae11544

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

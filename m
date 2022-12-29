Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDFF96592A1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 23:51:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234182AbiL2Wur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 17:50:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233980AbiL2Wud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 17:50:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D65B5F42;
        Thu, 29 Dec 2022 14:50:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F2ADBB81A87;
        Thu, 29 Dec 2022 22:50:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FC50C433EF;
        Thu, 29 Dec 2022 22:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672354229;
        bh=+mS+jxc0T3aY1DE/pg2vRdCUe9wchN2hSQ75BZQ4TEo=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=D8A/Pol2RvrmSaIB1zs3b9wd4y1O3xd8MHeln1BubcTmpOVndHaJuVFRm0ibF5/WI
         hOwWkvj5E0cPK69rK9lHgHSdIFumC1ZIDMmngoXWaPTISX7W4capNOJKLRn0hKM7DB
         hJwUIe1kCgv/NxGTh73AM9Uw08/xO62CBcb1uIh7sKYe3hjRXXUwMmxdKSdK2vHjmt
         Wm3MgD3x8gb5ohY1mEI9JDNDx1Fvz4udBTOTRg1frvQZ8yWDryFxwAFyojn3g0QZWs
         W8So/q8bLcwAW263HBKx6/ZC2GA7sLWEUKmLzNMIIPTxeKXiSdq7/COgCnbmQ4vYmx
         RVaZ4Gs6w+QKQ==
From:   Mark Brown <broonie@kernel.org>
To:     linux-arm-msm@vger.kernel.org, luca@z3ntu.xyz
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Rob Herring <robh@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20221229191542.123367-1-luca@z3ntu.xyz>
References: <20221229191542.123367-1-luca@z3ntu.xyz>
Subject: Re: [PATCH v3] regulator: dt-bindings: qcom,usb-vbus-regulator:
 change node name
Message-Id: <167235422463.130576.13068228295548630470.b4-ty@kernel.org>
Date:   Thu, 29 Dec 2022 22:50:24 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-69c4d
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Dec 2022 20:15:43 +0100, luca@z3ntu.xyz wrote:
> usb-vbus-regulator is a better generic node name than dcdc to change the
> example to match.
> 
> 

Applied to

   broonie/regulator.git for-next

Thanks!

[1/1] regulator: dt-bindings: qcom,usb-vbus-regulator: change node name
      commit: d13da2f4c81602fc22cdf2cb13b15283b260e0d5

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

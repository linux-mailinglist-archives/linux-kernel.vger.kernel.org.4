Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D68BB61E942
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 04:14:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231124AbiKGDOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 22:14:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231230AbiKGDNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 22:13:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6767D1180C;
        Sun,  6 Nov 2022 19:13:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0040B60EA8;
        Mon,  7 Nov 2022 03:13:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9311EC43141;
        Mon,  7 Nov 2022 03:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667790783;
        bh=tva1iC0FY12NvXlI1E71mEA9U/VOFJ9kre1bIw5oYDs=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=fGCLDpr9Hpux7msiRjQOg4Ep6If4xHou7i2V0MDecqBw6GSRWY53wtYFkaQ4/vsIE
         nGV857piCkFkE1my5+8TpC0UjNleS3jiMWbQs/8JXZg1MZ44T/m9NwWt5Sp/mJ70aM
         uIFs7/aRgmqWdmRJBzGbs+NuBBU9PdkzPnyUBeSjsNU0RkxREuUPWVnN1oS99ekohm
         Ymd3w4kwrzxXIUPbkgL9tp+zhT7PZwdu7eQmqNCqPsHzZvZmHDttLficwxIm4LToDG
         PCAdPyKtEY0RrI9wjivFTR9IaZDt4ZDKDBRMBS/ZtFkpE7IcLYsjNcIWnp+RK+SalT
         WRLDiOwwZiXzQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        swboyd@chromium.org, Rob Herring <robh+dt@kernel.org>,
        dianders@chromium.org, linux-arm-msm@vger.kernel.org,
        konrad.dybcio@somainline.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        mka@chromium.org, linux-kernel@vger.kernel.org,
        Andy Gross <agross@kernel.org>
Subject: Re: [PATCH v4 0/3] arm64/pinctrl: dt-bindings: qcom: sc7180: convert to dtschema
Date:   Sun,  6 Nov 2022 21:12:21 -0600
Message-Id: <166779074260.500303.10906017267624975878.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221020225135.31750-1-krzysztof.kozlowski@linaro.org>
References: <20221020225135.31750-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Oct 2022 18:51:32 -0400, Krzysztof Kozlowski wrote:
> Changes since v3
> ================
> 1. Drop bindings patch: applied.
> 2. Rebase.
> 3. Add tags.
> 
> Changes since v2
> ================
> 1. New patch: revert of glitch SPI CS workaround
> 2. dt-bindings: Drop entire drive-strength (not needed, brought by common TLMM
>    schema).
> 3. Add tags.
> v2: https://lore.kernel.org/all/20221013184700.87260-1-krzysztof.kozlowski@linaro.org/
> 
> [...]

Applied, thanks!

[1/3] arm64: dts: qcom: sc7180-trogdor-homestar: fully configure secondary I2S pins
      commit: 59e787935cfe6f562fbb9117e2df4076eaf810d8
[2/3] arm64: dts: qcom: sc7180: revert "arm64: dts: qcom: sc7180: Avoid glitching SPI CS at bootup on trogdor"
      commit: 8ddfa04de492ceac93e72063e027216bb9b07ca5
[3/3] arm64: dts: qcom: sc7180: align TLMM pin configuration with DT schema
      commit: 2f0300a6946702ff48f6584e0146bbe62c32abac

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

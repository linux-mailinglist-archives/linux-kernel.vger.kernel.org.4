Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CCBE658FAD
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 18:24:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233932AbiL2RY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 12:24:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233872AbiL2RYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 12:24:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A0091581B;
        Thu, 29 Dec 2022 09:23:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E4D0B6186B;
        Thu, 29 Dec 2022 17:23:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E256C43392;
        Thu, 29 Dec 2022 17:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672334634;
        bh=11HRK/sQ9WMqDBQIG7ZV6/m2FP9Qe0PP+4D0D+MSMnM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kaIIljixOb8bj6ZwREFhvQqKnKULU1ofWz7bfywYhtbbPPXqAT50gyk7OXWbrn0JY
         7Kl5Lfw1BzwMZZ1XBS/VYpP19EQy3PIhuSNQCHwPVWaPtxgYNNonoxaZNtJGCSqiEQ
         c/GQJIcY4XJNDEluq5dzOF8YgbulXd/CjCGyiqne9glpezn83pxA45O/idy2iIEzNp
         70f3d4COPrGzsgdGIv1ch0rc88NKRqR2GWRjt4I0BYrvFvNfYbPvUBpeMFpfLjTiJv
         3TF7DP3J0Ymlq69zSoU2QUow7ubiBZIbeZ/DmaW0amFEfDHiVgjggo+uPXElhnrvfm
         wy5gmkmPheq3Q==
From:   Bjorn Andersson <andersson@kernel.org>
To:     phone-devel@vger.kernel.org,
        Marijn Suijten <marijn.suijten@somainline.org>
Cc:     agross@kernel.org, linux-arm-msm@vger.kernel.org,
        martin.botka@somainline.org, jami.kettunen@somainline.org,
        they@mint.lgbt, konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        angelogioacchino.delregno@somainline.org, konrad.dybcio@linaro.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sm6125: Reorder HSUSB PHY clocks to match bindings
Date:   Thu, 29 Dec 2022 11:23:33 -0600
Message-Id: <167233461770.1099840.1670695457828000276.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221216213343.1140143-1-marijn.suijten@somainline.org>
References: <20221216213343.1140143-1-marijn.suijten@somainline.org>
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

On Fri, 16 Dec 2022 22:33:43 +0100, Marijn Suijten wrote:
> Reorder the clocks and corresponding names to match the QUSB2 phy
> schema, fixing the following CHECK_DTBS errors:
> 
>     arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dtb: phy@1613000: clock-names:0: 'cfg_ahb' was expected
>             From schema: /newdata/aosp-r/kernel/mainline/kernel/Documentation/devicetree/bindings/phy/qcom,qusb2-phy.yaml
>     arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dtb: phy@1613000: clock-names:1: 'ref' was expected
>             From schema: /newdata/aosp-r/kernel/mainline/kernel/Documentation/devicetree/bindings/phy/qcom,qusb2-phy.yaml
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: qcom: sm6125: Reorder HSUSB PHY clocks to match bindings
      commit: 8416262b0ea46d84767141b074748f4d4f37736a

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

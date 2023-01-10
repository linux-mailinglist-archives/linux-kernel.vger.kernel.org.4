Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86BD7664B81
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 19:45:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234554AbjAJSpf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 13:45:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239504AbjAJSpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 13:45:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECCC543D92;
        Tue, 10 Jan 2023 10:40:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8494161883;
        Tue, 10 Jan 2023 18:40:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30367C433D2;
        Tue, 10 Jan 2023 18:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673376006;
        bh=3zcw/QSnK/HKBE/+hZPSJtRzMf2Y7IM4NUEOSf9SHxU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W7HzxtAZHUsn3G8/H2Ddh49uOTT/0O/6dDPcb+wc1G4u6ThfSjnB25I7LfLiFV2ju
         kp7i4akWRzK0O4eQ6e66zpYSEcThIfH0rAg8uKID0UY3aXT0t44Dz5oYTv5InFJisl
         bOJgdDGWJv56XcryPmbIvDVqufz4vgU1xPTTnTpbJQwSVYR9StBXhRqwhFqTYW3vds
         6OsRGENUu3er/ecjGeCxmC2VvfcknQRYqQPBE6V4Gl3AYSB7dtxaiZnVjXle5SwHP5
         SVoY66Hdxv3p0sHOw08CCsjj+KWG01LbjUb6cSOOldiXkPsMM2NGnkmRpAR4YjOYV8
         ueEvlOMNHU7Gg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        abel.vesa@linaro.org, dmitry.baryshkov@linaro.org,
        agross@kernel.org, neil.armstrong@linaro.org,
        konrad.dybcio@linaro.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: (subset) [PATCH v9 00/10] arm64: dts: Add base device tree files for SM8550
Date:   Tue, 10 Jan 2023 12:40:03 -0600
Message-Id: <167337600119.2164548.16297064320903019223.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230106201047.337409-1-abel.vesa@linaro.org>
References: <20230106201047.337409-1-abel.vesa@linaro.org>
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

On Fri, 6 Jan 2023 22:10:37 +0200, Abel Vesa wrote:
> This series adds the base device tree files and MTP board support
> for the Qualcomm SM8550 SoC, including the clock, pinctrl, smmu,
> regulators, interconnect, cpufreq, and qup nodes.
> 
> The SM8550 is the latest Qualcomm Mobile Platform.
> See more at:
> https://www.qualcomm.com/content/dam/qcomm-martech/dm-assets/documents/Snapdragon-8-Gen-2-Product-Brief.pdf
> 
> [...]

Applied, thanks!

[02/10] arm64: dts: qcom: Add base SM8550 dtsi
        commit: ffc50b2d382879b237f2667f5f02ac48e42ffd32
[03/10] arm64: dts: qcom: Add pm8010 pmic dtsi
        commit: 89565d8f546832b0c097660cb740d51752391f3b
[04/10] arm64: dts: qcom: Add PM8550 pmic dtsi
        commit: 2e9686d1948af21450b3e0da80fb3ad59937aaca
[05/10] arm64: dts: qcom: Add PM8550b pmic dtsi
        commit: 9543f989c244686e9c578812480b0dc622aab258
[06/10] arm64: dts: qcom: Add PM8550ve pmic dtsi
        commit: 8ba6d5d8f11eda942bd060581ff478b95207aab2
[07/10] arm64: dts: qcom: Add PM8550vs pmic dtsi
        commit: d6056ec543daab9482682c9440cf2dfd5b3d0469
[08/10] arm64: dts: qcom: Add PMK8550 pmic dtsi
        commit: e9c0a4e48489c50e71e8cf956eb08b5e5421da12
[09/10] arm64: dts: qcom: Add PMR735d pmic dtsi
        commit: 4e7b112617a904b7d5c9db710f546c45f14408c2
[10/10] arm64: dts: qcom: Add base SM8550 MTP dts
        commit: 71342fb91eae160fa58c1f51c6d368d088b04cf6

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

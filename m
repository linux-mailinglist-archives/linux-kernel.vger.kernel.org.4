Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BABF46205FA
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 02:28:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233509AbiKHB2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 20:28:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233304AbiKHB2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 20:28:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 407002C668;
        Mon,  7 Nov 2022 17:28:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DFAE5B81716;
        Tue,  8 Nov 2022 01:28:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 650F2C433B5;
        Tue,  8 Nov 2022 01:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667870883;
        bh=I/Q1j+W/idseU06QYyrP82z/fy9UA32ni80WkeWtiDE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RQh+qGU84ZiPVgBI5BmMt4XaPzZEdXu8AxCfaOekjrVIXk331Dr4Cf0Q9oQSyEtbH
         d4NRvB9C7rp+xekJ9Gp0r4W0fzmXpgpW6yQBcuFcMGfGUK9W5ObyH90inC78oPApGA
         VlXqXy3WLqwYnI/DIsu6un8f+LpvPGD+Nio2+PbVZx6VYvhQIgna3GHJVDo5lesXvb
         12y6wygj+xvA4/HAUfXcxjBCwxWPkX9QB5A/oDVgLVrC4dPvrZxuA9iJ1fSTemw01B
         nVBhahFT5hhMBQJfkj4hdHE5mLrg8DMJBssMEizl/LVEY2IdrC+wp9dLRuA7AbDKWR
         T9Rhiwr4KwQ4Q==
From:   Bjorn Andersson <andersson@kernel.org>
To:     marijn.suijten@somainline.org, phone-devel@vger.kernel.org
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        konrad.dybcio@somainline.org, krzysztof.kozlowski+dt@linaro.org,
        martin.botka@somainline.org, agross@kernel.org, luca@z3ntu.xyz,
        angelogioacchino.delregno@somainline.org,
        linux-kernel@vger.kernel.org, jami.kettunen@somainline.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 00/10] arm64: dts: qcom: sm6350: SD Card fixes, pm6350 keys and touchscreen for PDX213
Date:   Mon,  7 Nov 2022 19:27:33 -0600
Message-Id: <166787084682.599230.499975577064224403.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221030073232.22726-1-marijn.suijten@somainline.org>
References: <20221030073232.22726-1-marijn.suijten@somainline.org>
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

On Sun, 30 Oct 2022 08:32:22 +0100, Marijn Suijten wrote:
> Enable SD Card for Sony Lena PDX213 on the sm6350 SoC by providing it
> the necessary IOMMU stream ID(s) and pinctrl in SoC dtsi, and setting up
> the regulators in device/board DT.  Together with regulator support,
> power up the touchscreen and import pm6350 dtsi to enable the power and
> volume up/down keys.
> 
> Marijn Suijten (10):
>   arm64: dts: qcom: sm6350: Add resets for SDHCI 1/2
>   arm64: dts: qcom: sm6350: Add pinctrl for SDHCI 2
>   arm64: dts: qcom: sm6350-lena: Add SD Card Detect to sdc2 on/off
>     pinctrl
>   arm64: dts: qcom: pm6350: Include header for KEY_POWER
>   arm64: dts: qcom: sm6350-lena: Include pm6350 and configure buttons
>   arm64: dts: qcom: sm6350-lena: Define pm6350 and pm6150l regulators
>   arm64: dts: qcom: sm6350-lena: Provide power to SDHCI 2 (SDCard slot)
>   arm64: dts: qcom: sm6350-lena: Enable QUP and GPI DMA
>   arm64: dts: qcom: sm6350-lena: Configure Samsung touchscreen
>   arm64: dts: qcom: sm6350: Add apps_smmu with streamID to SDHCI 1/2
>     nodes
> 
> [...]

Applied, thanks!

[01/10] arm64: dts: qcom: sm6350: Add resets for SDHCI 1/2
        commit: e10d451e10418f12e72ed8564f22fdba8b10a9b0
[02/10] arm64: dts: qcom: sm6350: Add pinctrl for SDHCI 2
        commit: a5d0314b9d5166503e99336bb832b3b81b200399
[03/10] arm64: dts: qcom: sm6350-lena: Add SD Card Detect to sdc2 on/off pinctrl
        commit: edf070fcbcec70765fe520d476fd9527b5e96477
[04/10] arm64: dts: qcom: pm6350: Include header for KEY_POWER
        commit: f6e2d6914c7c095660a9c7c503328eebab1e2557
[05/10] arm64: dts: qcom: sm6350-lena: Include pm6350 and configure buttons
        commit: 2b8bbe985659e640fda30435c187432c0f614f81
[06/10] arm64: dts: qcom: sm6350-lena: Define pm6350 and pm6150l regulators
        commit: deaf8c88db7d327ba768ac224e53d29f56027331
[07/10] arm64: dts: qcom: sm6350-lena: Provide power to SDHCI 2 (SDCard slot)
        commit: 85eef5cb65ab7e8905725d13c98c90442bb93dbc
[08/10] arm64: dts: qcom: sm6350-lena: Enable QUP and GPI DMA
        commit: 8bad51c68930eba8b26ce362c7c9bfce5d074a2f
[09/10] arm64: dts: qcom: sm6350-lena: Configure Samsung touchscreen
        commit: 2904a41c50e408c0a1e90da0045400edb6f155fe
[10/10] arm64: dts: qcom: sm6350: Add apps_smmu with streamID to SDHCI 1/2 nodes
        commit: 7372b944a6ba5ac86628eaacc89ed4f103435cb9

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

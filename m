Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E03D7710481
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 06:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239332AbjEYEyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 00:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232087AbjEYEwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 00:52:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A4B1197;
        Wed, 24 May 2023 21:51:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 74226642BA;
        Thu, 25 May 2023 04:51:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22132C4339E;
        Thu, 25 May 2023 04:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684990285;
        bh=4XcWpzOi9IBferzxRK/KhnQw0L9w77o3cwaLVn4q5S0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Ph/X5mXibLWYu0mMg+KWEoyYIg0zl4SWeKYBma11ujvoLvQxvnGWVoVtXWZRIK3FA
         43MJkZf+eBdCgVk1PACiEzifEXgBtuL+62ecruIdnanfCKaGneD78/nnmHkrl+sHYy
         HMAtzHkw7S4ulkSgv8k1K/28fcGqeGaKzmvJL9YiSRfHZdRaEjAa5E4FmP9ISfCxZb
         BKE0cLz9hzLn2NeTh9kOu5G3b1xMnIMg10syWFSiZi1CvsRCa/ngwyS6X7OGCztvCr
         93UMGQpOQOap3KkUX3b7ki6XbqklnLHqoLMYoe0emIc9g34nFT3+MZAcZypFZwYY/n
         vywkLJxyWsibA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Luca Weiss <luca@z3ntu.xyz>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        "Ivan T. Ivanov" <ivan.ivanov@linaro.org>,
        linux-arm-msm@vger.kernel.org, Todor Tomov <todor.too@gmail.com>,
        Sivaprakash Murugesan <sivaprak@codeaurora.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Molly Sophia <mollysophia379@gmail.com>,
        Andrey Konovalov <andrey.konovalov@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Adam Skladowski <a39.skl@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        devicetree@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>
Subject: Re: (subset) [PATCH 01/18] arm64: dts: qcom: ipq6018: correct qrng unit address
Date:   Wed, 24 May 2023 21:54:05 -0700
Message-Id: <168499048184.3998961.13273522217706071499.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230419211856.79332-1-krzysztof.kozlowski@linaro.org>
References: <20230419211856.79332-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Apr 2023 23:18:39 +0200, Krzysztof Kozlowski wrote:
> Match unit-address to reg entry to fix dtbs W=1 warnings:
> 
>   Warning (simple_bus_reg): /soc/qrng@e1000: simple-bus unit address format error, expected "e3000"
> 
> 

Applied, thanks!

[01/18] arm64: dts: qcom: ipq6018: correct qrng unit address
        commit: 085058786a7890dd44ec623fe5ac74db870f6b93
[02/18] arm64: dts: qcom: msm8916: correct camss unit address
        commit: 48798d992ce276cf0d57bf75318daf8eabd02aa4
[03/18] arm64: dts: qcom: msm8916: correct MMC unit address
        commit: 72644bc76d5145c098c268829554a0b98fab1de1
[04/18] arm64: dts: qcom: msm8916: correct WCNSS unit address
        commit: 1f9a41bb0bba7b373c26a6f2cc8d35cc3159c861
[05/18] arm64: dts: qcom: msm8953: correct IOMMU unit address
        commit: 1c06b93461ec9df8a5878947db4a9d2d1cb72855
[06/18] arm64: dts: qcom: msm8953: correct WCNSS unit address
        commit: 751038676e3075a5cb816034f7d5ba6e95f4486d
[07/18] arm64: dts: qcom: msm8976: correct MMC unit address
        commit: 80284797a4cb8ceae71e3c403bafc6648263a060
[08/18] arm64: dts: qcom: msm8994: correct SPMI unit address
        commit: 24f0f6a8059c7108d4ee3476c95db1e7ff4feb79
[09/18] arm64: dts: qcom: msm8996: correct camss unit address
        commit: e959ced1d0e5ef0b1f66a0c2d0e1ae80790e5ca5
[10/18] arm64: dts: qcom: sdm630: correct camss unit address
        commit: c8b7faa7e9913a94444b3f00b6480e53a174fcfd
[11/18] arm64: dts: qcom: sdm845: correct camss unit address
        commit: a05b913a27e46926ba60ba2bcacc7ec7a8403e4c
[12/18] arm64: dts: qcom: sm6115: correct thermal-sensor unit address
        commit: 2358b43256080459fcc5642265ed4fec75558f8c
[13/18] arm64: dts: qcom: sm8350: correct DMA controller unit address
        commit: 41d6bca799b3f40d4d3c22dd4545aeac7c210e33
[14/18] arm64: dts: qcom: sm8350: correct PCI phy unit address
        commit: ab98c21bc9246f421a6ae70e69f1b73cea6f85e3
[15/18] arm64: dts: qcom: sm8350: correct USB phy unit address
        commit: a560ab70c6e28ba784a824611d3f58969d8fadba
[16/18] arm64: dts: qcom: sm8550: correct crypto unit address
        commit: 3cbf49ef16962ab6d99a3659cb34a33c5f147b50
[17/18] arm64: dts: qcom: sm8550: correct pinctrl unit address
        commit: 950a4fe6ec8498799d1c7bd31a489a718f94a87e
[18/18] arm64: dts: qcom: sdm845-polaris: add missing touchscreen child node reg
        commit: 4a0156b8862665a3e31c8280607388e3001ace3d

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

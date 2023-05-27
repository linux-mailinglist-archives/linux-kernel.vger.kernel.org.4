Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22C9E713131
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 03:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238311AbjE0BEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 21:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238015AbjE0BDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 21:03:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD8A135;
        Fri, 26 May 2023 18:03:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F1252654C9;
        Sat, 27 May 2023 01:03:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3347C433A0;
        Sat, 27 May 2023 01:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685149430;
        bh=gISudB4jkKFsEH7Lv8uLVi/rF4cbWr1F9+9ffxGNtOc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=R97aTjJTinKjNqcJyTPE2u5mblWQGq7F7pn93LfCf/mXPixLD5/KV6Nn1ZaDu0Ru8
         R5Y2bGljA5QhRxOd/RFCG1qlTafCCyy4IPs5nsDae6RpS8M9GEg3u7iPkgHWIJoXU3
         z4kZeExKfKtjLa6qQ/1MNQgF2G0ljO13YuMVN43RD+oEnDoqSOXtPqf0IqdBCpk2xe
         W8VMsLLJQaOQeryJ5//Wgg6sDIyS0AmCwkrXDVNvP/bz/5rxcr3aILo1KoFaWsksXc
         UCePSZHVIHX4Wkcno7zvw/CXTEjmeUIrB8R3oz+Bsq04/jOqjXFattoNQR1nRWc2jJ
         OB3JzCtEw2gGA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: (subset) [PATCH 1/6] arm64: dts: qcom: ipq6018: drop incorrect SPI bus spi-max-frequency
Date:   Fri, 26 May 2023 18:07:25 -0700
Message-Id: <168514964950.348612.17081162880468129369.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230416123730.300863-1-krzysztof.kozlowski@linaro.org>
References: <20230416123730.300863-1-krzysztof.kozlowski@linaro.org>
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

On Sun, 16 Apr 2023 14:37:25 +0200, Krzysztof Kozlowski wrote:
> The spi-max-frequency property belongs to SPI devices, not SPI
> controller:
> 
>   ipq6018-cp01-c1.dtb: spi@78b5000: Unevaluated properties are not allowed ('spi-max-frequency' was unexpected)
> 
> 

Applied, thanks!

[1/6] arm64: dts: qcom: ipq6018: drop incorrect SPI bus spi-max-frequency
      commit: b8420d478aa3fc739fcdba6b4b945850b356cb3b
[2/6] arm64: dts: qcom: ipq8074: drop incorrect SPI bus spi-max-frequency
      commit: e6e0e706940b64e3a77e0a4840037692f109bd5f
[3/6] arm64: dts: qcom: qdu1000: add missing qcom,smmu-500 fallback
      commit: 395aba1b1912d059a13345531fd4090caf51da38
[4/6] arm64: dts: qcom: sm8250: add missing qcom,smmu-500 fallback
      commit: 2438aba45f65b723763299a7b34eddfc40923680
[5/6] arm64: dts: qcom: sm8550-qrd: add missing PCIE1 PHY AUX clock frequency
      commit: ec888e6cff94af8fc5889824d98b1f1df65f3131
[6/6] arm64: dts: qcom: sm6125-sprout: align ADC channel node names with bindings
      commit: a2d8dcd48e132967eb8596a02a06185db8fbcb92

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

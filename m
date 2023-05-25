Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BECEB7104BE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 06:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239885AbjEYEzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 00:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239475AbjEYEyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 00:54:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1BDA1A7;
        Wed, 24 May 2023 21:51:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A5664642C6;
        Thu, 25 May 2023 04:51:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 718B0C433A4;
        Thu, 25 May 2023 04:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684990289;
        bh=Ikf2TX+5gn4e7uhdgsgGYHpjK1B53ZyVkfMtyXCGkBU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=MjwZCV72WMYE3ZAv51BbNnDNshrz0LtHfHJ+QrEvqKqmMrLBLoKj+wMG5SoENaHM9
         jT8D+/ARItGHDUb6aUEwzJsNfp1eLGadY6KV2/voIynJaiNZcXpMCOTQE1K1HQQrbE
         2B7qcjeCNKYV6w1kRJGpsQ7lVJmFv1rXtz7Al1qTgDgzuQB44z4SobTRNcPvGRQ9r+
         b845QmbJ3nM/JmIf4xDG5ilAVToOA4mI8llTqYVojCASd3sTTE/yEzXAplwfryg/JH
         ypd3ExBaZIZ44+IK78hCToyDzdEIum2XXGeyr3NZ+tO5Z9dG333nIinC9x1eJr+/VN
         rXnCv/Wg8ED2A==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>
Subject: Re: (subset) [PATCH 1/7] arm64: dts: qcom: ipq6018: add unit address to soc node
Date:   Wed, 24 May 2023 21:54:08 -0700
Message-Id: <168499048184.3998961.7860160396345243798.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230420063610.11068-1-krzysztof.kozlowski@linaro.org>
References: <20230420063610.11068-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Apr 2023 08:36:04 +0200, Krzysztof Kozlowski wrote:
> "soc" node is supposed to have unit address:
> 
>   Warning (unit_address_vs_reg): /soc: node has a reg or ranges property, but no unit name
> 
> 

Applied, thanks!

[1/7] arm64: dts: qcom: ipq6018: add unit address to soc node
      commit: 393595d4ffbd0a1fafd5548f8de1b8487a037cf2
[2/7] arm64: dts: qcom: ipq8074: add unit address to soc node
      commit: da6aa1111a17db11367817ddc10c5a6c188cdc44
[3/7] arm64: dts: qcom: msm8994: add unit address to soc node
      commit: f7fd546dd693f64404bbbdc154b3dac0aee1f3bb
[4/7] arm64: dts: qcom: msm8996: add unit address to soc node
      commit: b67f5c337f894109a8a9c40f7dbb74de9cf07d57
[5/7] arm64: dts: qcom: msm8998: add unit address to soc node
      commit: 77462beddbfc700d36fe1f24d77b545fe3d6db44
[6/7] arm64: dts: qcom: sdm630: add unit address to soc node
      commit: cefb40777a6c695e754d918cf5a5551169e40965
[7/7] arm64: dts: qcom: sm6125: add unit address to soc node
      commit: 188e26bc67896cb89aca0821b366833e9abf829e

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

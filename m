Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC0068FEEF
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 05:31:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbjBIEb5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 23:31:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbjBIEb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 23:31:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2DF7E05D;
        Wed,  8 Feb 2023 20:30:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3D2DBB8200F;
        Thu,  9 Feb 2023 04:21:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51C1CC433A1;
        Thu,  9 Feb 2023 04:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675916517;
        bh=sLgrUop8ocbgCtD1yX0C+pABu761BAWsGXgyjyBiRuw=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=IRTLjpHw3OykEusaZkou6v0wMMToAbG4nWJMlOdaOpm8f20KhkvksPU4QmH+6Wb6l
         kIUhkbdn8Lq7G4VYbwRgTy1jcMawsNKcvIu05EC3PX8mK+9d5I2cRxeu6ooy+z0Pwy
         xdpTRaH+iq4gQdL7IJLM4vyEQP4t8FeFxzM8vXkxAiE3CU6FHGYAM0C5E0LDlSwuXd
         rr9xg0ajDF+erxhXZTUMNvilz1mVvb3w+Pkbalnug4TtaYuoma5Lyu9mKFoLamLMRU
         IbhMcb2yg5/NyphXBrFRo7q7mB+BzP2kHmNLQM6XkhqODd/K21JqaiqAG0S3f/oHaR
         ZvGKJaRHFw2zA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org
Subject: Re: [RFT PATCH v3 1/6] arm64: dts: qcom: sdm845-db845c: add generic sound compatible
Date:   Wed,  8 Feb 2023 20:23:14 -0800
Message-Id: <167591660369.1230100.11109749250951288122.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230123084300.22353-1-krzysztof.kozlowski@linaro.org>
References: <20230123084300.22353-1-krzysztof.kozlowski@linaro.org>
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

On Mon, 23 Jan 2023 09:42:55 +0100, Krzysztof Kozlowski wrote:
> Use generic sound card fallback compatible, because the device is
> actually fully compatible with the generic one.
> 
> 

Applied, thanks!

[1/6] arm64: dts: qcom: sdm845-db845c: add generic sound compatible
      commit: 077d29e81963b415e49216878563e933d346efa2
[2/6] arm64: dts: qcom: sdm845-xiaomi-beryllium: add generic sound compatible
      commit: f7c45f3d87a1a2639db67dbdbaf533e20337344e
[3/6] arm64: dts: qcom: sdm850-lenovo-yoga: correct sound compatible
      commit: 099f035d03d2318f5a7edb0305d178c7206fd820
[4/6] arm64: dts: qcom: sdm845: move codec to separate file
      commit: 34c861737720f89593adb6a4eab1d117b602510f
[5/6] arm64: dts: qcom: sdm845-audio-wcd9340: commonize pinctrl
      commit: 71c461a325e35bba0481bfacc40209c4d7189cc1
[6/6] arm64: dts: qcom: sdm845-audio-wcd9340: commonize clocks
      commit: 47a17dfb65a2caf4fb079102d2ad7c90c393322a

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

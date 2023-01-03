Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64E5F65B9A4
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 04:15:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236656AbjACDPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 22:15:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbjACDPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 22:15:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08341BE3C;
        Mon,  2 Jan 2023 19:15:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B516AB80E3D;
        Tue,  3 Jan 2023 03:15:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D03E3C433D2;
        Tue,  3 Jan 2023 03:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672715706;
        bh=zCOS2TtWxPLxuwGn2m2jlEmrcT5+h7zVtcF5ZDoprfg=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=jnx6Rdw2Ek9B2KWrGiOEHgN0xwSVsDNLP09BgbaP7kHaicDwwWqCB4uXj7hheN19D
         vT7uN+H+YBCXp+pwggz3RaKSfB/LCWfaMpVxQa2NHSEgbGbG8atoDfzAPPfwHHRKlT
         X2xpt8AR5dE43Mwri3pGWOSudp95Pv7tyAPuC+r5zhD49fii5bhdNi+88THlA2eFNd
         IBBU+VIZuj0rTEo82UXpD77xLz8BULJbT67zxvzOyaF3th8dghLv+g4StlcTwvT+/W
         8qY/jGRNMdUfjSS0KYFQvHYpBjH6nzu7afjakQRXp+zvWAE/ogFvoe5TFffRchbpmC
         aoO8kt0BO512Q==
From:   Bjorn Andersson <andersson@kernel.org>
To:     devicetree@vger.kernel.org, konrad.dybcio@linaro.org,
        krzysztof.kozlowski@linaro.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v2 1/6] arm64: dts: qcom: sc8280xp: align PSCI domain names with DT schema
Date:   Mon,  2 Jan 2023 21:15:02 -0600
Message-Id: <167271569385.1479016.11808942826791367727.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230102085452.10753-1-krzysztof.kozlowski@linaro.org>
References: <20230102085452.10753-1-krzysztof.kozlowski@linaro.org>
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

On Mon, 2 Jan 2023 09:54:47 +0100, Krzysztof Kozlowski wrote:
> Bindings expect power domains to follow generic naming pattern:
> 
>   sc8280xp-crd.dtb: psci: 'cpu-cluster0', 'cpu0', 'cpu1', 'cpu2', 'cpu3', 'cpu4', 'cpu5', 'cpu6',
>     'cpu7' do not match any of the regexes: '^power-domain-', 'pinctrl-[0-9]+'
> 
> 

Applied, thanks!

[1/6] arm64: dts: qcom: sc8280xp: align PSCI domain names with DT schema
      commit: ac392971357375bbbba905c6c12cd1ac6962da2d
[2/6] arm64: dts: qcom: sm6375: align PSCI domain names with DT schema
      commit: 0c8bfc7f3be4d99fc314676210c77838aa282cd6
[3/6] arm64: dts: qcom: sm8150: align PSCI domain names with DT schema
      commit: 5ca45690551a304c7bc8996962315f2e8b2909d8
[4/6] arm64: dts: qcom: sm8250: align PSCI domain names with DT schema
      commit: 56d590022b6c6baea11e3a9f6106fddafaba8a58
[5/6] arm64: dts: qcom: sm8350: align PSCI domain names with DT schema
      commit: a9371962c3b26ba4012dc05ab0fbb964eb142a66
[6/6] arm64: dts: qcom: sm8450: align PSCI domain names with DT schema
      commit: fce310a2d2321874423b11f6cab4ad3fce5ef639

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

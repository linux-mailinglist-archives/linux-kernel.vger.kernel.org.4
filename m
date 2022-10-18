Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7210760221D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 05:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231365AbiJRDKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 23:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230345AbiJRDI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 23:08:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AC3C9AFB9;
        Mon, 17 Oct 2022 20:07:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 609FDB81C5C;
        Tue, 18 Oct 2022 03:07:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15DC2C43143;
        Tue, 18 Oct 2022 03:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666062427;
        bh=3LUISltUd4st4SsRXvFnMm4UZUmqbYBVNnG8ZxfyLBo=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=fm7Q2s57KYSvBEKo5ufYAR8ZIsQR6gQZsRqF9OaOvIqeBLSYRle8Idw1RhfvdfiZk
         i/F2n2InQHKEJm1O3TACmKdNY0l+b4Vy46c4PalyD+xZGMzNftN7z8OJuo6ZdYTcEA
         tRpOCI0aFn08mCDeZovNortt3SYQtdB0p7E9VM/jvZcRjbwounF67b4A3Obl1vo5p3
         kTqbuxnohtjD7Jap//+wf32/G6nMpDlNLbaCSyeOY6+gY6SsR/D+PL8uJEouTv57ZA
         J80AqbmaIzGQL/eggEah7FkqrSOi11MrkhC753WsjaIyMu5B3bzRMB5VDx8mQ5Yjxj
         RTQWoD85KVVYQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Sivaprakash Murugesan <sivaprak@codeaurora.org>,
        stephan@gerhold.net, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org,
        linus.walleij@linaro.org, vkoul@kernel.org, shawn.guo@linaro.org,
        robh+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        quic_vamslank@quicinc.com,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: Re: (subset) [PATCH v3 00/34] pinctrl/arm64: qcom: continued - fix Qualcomm TLMM pinctrl schema warnings
Date:   Mon, 17 Oct 2022 22:05:40 -0500
Message-Id: <166606235858.3553294.11393452555755385240.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220927173702.5200-1-krzysztof.kozlowski@linaro.org>
References: <20220927173702.5200-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Sep 2022 19:36:28 +0200, Krzysztof Kozlowski wrote:
> Changes since v2
> ================
> 1. ipq6018-cp01-c1: do not switch to blsp1 (Robert).
> 2. pinctrl: qcom,ipq6018: correct BLSP6->BLSP0 functions: new patch.
> 3. Drop quotes from $ref when not needed (Rob).
> 4. Add Rb tags. Few patches from v1 got review from Rob, but I changed them in
>    v2 significantly, so I did not keep these Rb tags.
> 
> [...]

Applied, thanks!

[03/34] ARM: dts: qcom: sdx55: add gpio-ranges to TLMM pinctrl
        commit: 0139f183bcddcf5b36f805254bb0f0625963f783
[04/34] ARM: dts: qcom: sdx55: align TLMM pin configuration with DT schema
        commit: bda79af488a3e75769433fb961800c39bb07b29c
[05/34] ARM: dts: qcom: msm8226: align TLMM pin configuration with DT schema
        commit: df9c86025510c45a6d90669347129e8000e1bbbc
[06/34] ARM: dts: qcom: msm8974: align TLMM pin configuration with DT schema
        commit: 6cd72414abc7345e277fcab5e1c763c3a017dc6a

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

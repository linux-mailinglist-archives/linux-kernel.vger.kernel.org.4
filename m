Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A51061E946
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 04:14:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbiKGDOb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 22:14:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbiKGDNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 22:13:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1542C1183D;
        Sun,  6 Nov 2022 19:13:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A9292B80D8F;
        Mon,  7 Nov 2022 03:13:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ED7FC43155;
        Mon,  7 Nov 2022 03:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667790784;
        bh=Bq8erqkFiD3Oil3Ip4jna8LKMJxYbU0vWaCzoO8q6q0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=UElE+BH06y2L66zUoTVh/gMPHkSFXTq3Fwj2SKftfjjlW7uYe1awoDVLGP6ZYWiS5
         dAT9DSgmAiIGro4v6IL5x/uicQnPxoDFotcXKXg21pVR4xx2NM7pAbmeHKSeR7s++1
         MXzWKTayM0Vg5cAljpYORcPQlUt6ZDQj/qv4nzZ0vLOA2LFbg2r8ha2/8dbperXoWJ
         8R6diLmmbAdyev083AaLWdoOIP/eWo5pF8N/3LOXpnpZtvzq6yX41jBIJZvml1QgWb
         Zztb/wJj8JUTSrLHC1kcP7Tt9toUbLk646bp8e2TnRNXa/8IcCdLJdfBrB99q8Zr6B
         gD4azp2q+3Nyw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, konrad.dybcio@somainline.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>
Subject: Re: (subset) [PATCH v4 1/2] arm64: dts: qcom: msm8996-sony-xperia-tone: drop incorrect wlan pin input
Date:   Sun,  6 Nov 2022 21:12:22 -0600
Message-Id: <166779074260.500303.14851343217715817416.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221020225309.32116-1-krzysztof.kozlowski@linaro.org>
References: <20221020225309.32116-1-krzysztof.kozlowski@linaro.org>
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

On Thu, 20 Oct 2022 18:53:08 -0400, Krzysztof Kozlowski wrote:
> Pin configuration has no "input-high" property, so drop it from node
> described as Wifi host wake up pin.
> 
> 

Applied, thanks!

[1/2] arm64: dts: qcom: msm8996-sony-xperia-tone: drop incorrect wlan pin input
      commit: 5ecbf096e0565d4761e0294aaa2e79ce44a53e6d
[2/2] arm64: dts: qcom: msm8996: align TLMM pin configuration with DT schema
      commit: 169e1553accfd31386a7d364ab57293802027ab7

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

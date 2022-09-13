Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5368B5B7D4A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 00:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbiIMWsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 18:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbiIMWsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 18:48:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE4257266;
        Tue, 13 Sep 2022 15:48:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7B57661633;
        Tue, 13 Sep 2022 22:48:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12D77C433C1;
        Tue, 13 Sep 2022 22:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663109295;
        bh=o9OIk885vyZJTga7FlpTPbIJ66vBCL62iD+MWzKjerk=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=ToLNKLDL9gcSKRmoFvcXKS5RrT5qUgPALnwTjceD7qiZ9vVnI8ndDcKra0OgBp6aB
         W687LCj3DnU2yr6Td4Jn4ceDSqDiLlyFQtqjbPI5uRj6ul1IG1rzUmmkL9iHzbrs+N
         F56QQqQU7RAHEKpV0Jb2EZCU+jhnJCxjkDCwBKgYzCwjxmTmz8l44sfNheHNpGvC/t
         h8rZlX95/FpNwu7ZqgVsDkacyN+bQC/OD3ekfOYI3qtdBXF9u5XxwlbG3wDrTZZHX5
         GWVFTkgDF/sly2MLGsg7Kax1lzBYf+1NWVIQQsLmCYw7uERQEBvtHMDqIqJntbXmK2
         mbGo06Wy9dtpQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     linux-kernel@vger.kernel.org, agross@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, konrad.dybcio@somainline.org,
        ohad@wizery.com, linux-arm-msm@vger.kernel.org,
        baolin.wang@linux.alibaba.com, linux-remoteproc@vger.kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski@linaro.org,
        devicetree@vger.kernel.org, vkoul@kernel.org
Subject: Re: (subset) [PATCH v3 00/15] ARM/hwlock: qcom: switch TCSR mutex to MMIO
Date:   Tue, 13 Sep 2022 17:48:08 -0500
Message-Id: <166310928500.670084.9085382465104729419.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220909092035.223915-1-krzysztof.kozlowski@linaro.org>
References: <20220909092035.223915-1-krzysztof.kozlowski@linaro.org>
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

On Fri, 9 Sep 2022 11:20:20 +0200, Krzysztof Kozlowski wrote:
> Switch older Qualcomm SoCs to use MMIO-based method instead of syscon.
> 
> Not tested on hardware. Please kindly provide tests.
> 
> Changes since v2
> ================
> 1. Rebase on current MFD changes.
> 2. Add Rb tag.
> 3. Split MFD patch to separate patchset:
> https://lore.kernel.org/linux-devicetree/20220909091056.128949-1-krzysztof.kozlowski@linaro.org/T/#u
> 
> [...]

Applied, thanks!

[05/15] arm64: dts: qcom: ipq6018: add missing TCSR syscon compatible
        commit: d30bcfa4408596e8dd3714dfdd90334d2bdc9856
[06/15] arm64: dts: qcom: msm8953: add missing TCSR syscon compatible
        commit: d07ac9d93ced0f8203230bf1de49b7cc605e1547
[07/15] arm64: dts: qcom: qcs404: add missing TCSR syscon compatible
        commit: 98460385091fc2e86a296f9643105d8a8777ccc2
[08/15] arm64: dts: qcom: msm8996: add missing TCSR syscon compatible
        commit: 8a99e0fc8bd3fa9c8be1fc115a2e38f4fd51ccda
[11/15] arm64: dts: qcom: ipq6018: switch TCSR mutex to MMIO
        commit: f5e303aefc06b7508d7a490f9a2d80e4dc134c70
[12/15] arm64: dts: qcom: msm8994: switch TCSR mutex to MMIO
        commit: 9e826e05061c61d84217bbe436b4ef0bedbfe458
[14/15] ARM: dts: qcom: apq8084: switch TCSR mutex to MMIO
        commit: 16ae4e557b2fa9fc7372b4503247aca80a476272
[15/15] ARM: dts: qcom: msm8226: switch TCSR mutex to MMIO
        commit: 18a4af7a598445af54e1e16a66b7f31669578701

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

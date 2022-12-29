Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4FFC658FA1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 18:24:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233884AbiL2RYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 12:24:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233832AbiL2RXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 12:23:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08100140C5;
        Thu, 29 Dec 2022 09:23:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3114B6186A;
        Thu, 29 Dec 2022 17:23:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5877C43392;
        Thu, 29 Dec 2022 17:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672334629;
        bh=HU4MnHmmBDb9OIPsFbHECPnG5crF+eulSsFCVAVp9t4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=tGrxrApVFYFtZLpt5k7J3a+ffiyQeS8NEyXL61RPme9p3hHyyzmruKMyMgtFDfdPj
         pI4fXQ/mnhBrlzSRLmlEs9wsASuV4WJbuTdS8a5nEbut1/4S1lMbaD/nsn226UT2G6
         yPDR+/c9RD6QHwEY9Gw8MjFhZ+T2FqXzxxsa/slQ+wHzMgsNLT3ZZKpsRedIqmDcAN
         Q56ZcuroJevj8ess9u0OEppWGk/MI8NOJJqqVOtsVhCpMZBlmU/VPXMx9L2r/eeZHl
         5LU+DT/XwZGzEFWxn49pIthycylH7SVYjqJU27QmpQYj3EkmoAbTPE/D/MFwa7Dyma
         66MRk1TXT/8Bw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     agross@kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        vkoul@kernel.org, linux-arm-msm@vger.kernel.org,
        quic_wcheng@quicinc.com, linux-phy@lists.infradead.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-kernel@vger.kernel.org, kishon@kernel.org,
        konrad.dybcio@linaro.org, devicetree@vger.kernel.org
Subject: Re: (subset) [PATCH 1/4] dt-bindings: phy: qcom,usb-snps-femto-v2: use fallback compatibles
Date:   Thu, 29 Dec 2022 11:23:28 -0600
Message-Id: <167233461765.1099840.11639944662425293788.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221223161835.112079-1-krzysztof.kozlowski@linaro.org>
References: <20221223161835.112079-1-krzysztof.kozlowski@linaro.org>
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

On Fri, 23 Dec 2022 17:18:32 +0100, Krzysztof Kozlowski wrote:
> Document SoC-specific compatibles with generic fallback (e.g.
> qcom,usb-snps-hs-7nm-phy) already used in DTSI.  Add SoC-specific
> compatibles for PHY on SDX55 and SDX65.
> 
> This disallows usage of the qcom,usb-snps-hs-5nm-phy and
> qcom,usb-snps-hs-7nm-phy generic compatibles alone.  Do not touch
> remaining two compatibles - qcom,usb-snps-femto-v2-phy and
> qcom,sc8180x-usb-hs-phy - because there are no upstream users, so not
> sure what was the intention for them.
> 
> [...]

Applied, thanks!

[4/4] arm64: dts: qcom: sm8350: align MMC node names with DT schema
      commit: 06a0676b5de9221537156957b90b2b69dfceebba

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

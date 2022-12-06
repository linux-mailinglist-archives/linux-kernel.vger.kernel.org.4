Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E686A644B90
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 19:22:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbiLFSWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 13:22:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbiLFSV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 13:21:59 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAA9240908;
        Tue,  6 Dec 2022 10:20:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 5986DCE1AFB;
        Tue,  6 Dec 2022 18:20:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBCC5C4347C;
        Tue,  6 Dec 2022 18:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670350812;
        bh=RYRnmTLyBQh7YO2uEdnWpvLMN4M/7M66xA2+K+Edoq4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UxRoRPowC8b7yFrEDBRV7o21/3GeNie3+nD0LUWrdFQLtkFG7kBw5LllMd3cqbBR5
         SMsb+L4oDxnPoNHFq1miEn0kjPLzL/X9VC0T2FIrHeRZpe/cHLTxh2vLTklJnLEGGC
         /9t9A4Soe6gMLMrPURoWq8Xj6PXOj0Zi44qho4UjPIm3odfZRCqsr32eGenLHUpZYI
         UW0wTm4TQUS413N1nTBBGg0p7bLy7X2+Ye0QZDARzdyG4E281oj1Hk9mv9njAgNy6c
         QPT0G3BpIA7ESM2d6YgJHMbfoJs8RCXmPzAOBvK1mgSXK+zmmfDG0HCmHMfF6luasL
         XBt9PT/WZ6E0w==
From:   Bjorn Andersson <andersson@kernel.org>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        konrad.dybcio@linaro.org
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v6 0/3] arm64: dts: qcom: sm8450-hdk: add sound support
Date:   Tue,  6 Dec 2022 12:19:18 -0600
Message-Id: <167035076354.3155086.14011164593208879458.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221202152054.357316-1-krzysztof.kozlowski@linaro.org>
References: <20221202152054.357316-1-krzysztof.kozlowski@linaro.org>
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

On Fri, 2 Dec 2022 16:20:51 +0100, Krzysztof Kozlowski wrote:
> Changes since v5
> ================
> 1. Patch 2:
>    - Use different clocks (codec@31e0000, codec@3240000).
>    - Order LPASS pinctrl nodes by GPIO number.
>    - Add dmic01-default-state and dmic02-default-state to LPASS pinctrl.
> 2. Patch 3:
>    - Use TX_CODEC_DMA_TX_3 for VA capture.
>    - Reverse order of speakers (left/right).
>    - Drop duplicated wcd-playback-dai-link and add wcd-capture-dai-link.
> 
> [...]

Applied, thanks!

[1/3] arm64: dts: qcom: sm8450: add GPR node
      commit: 38463210a9cb9eb03431c6c610ad3b66df3afc6c
[2/3] arm64: dts: qcom: sm8450: add Soundwire and LPASS
      commit: 14341e76dbc7e10c9bf19f4c214161dc3030ca3d
[3/3] arm64: dts: qcom: sm8450-hdk: add sound support
      commit: 2dcd495f15cbf330aa68dc074f0eb0aeaff4eead

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

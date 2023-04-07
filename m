Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05E026DB1D9
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 19:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbjDGRjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 13:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbjDGRiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 13:38:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09C53B76E;
        Fri,  7 Apr 2023 10:38:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B29E65332;
        Fri,  7 Apr 2023 17:38:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 627CEC4339B;
        Fri,  7 Apr 2023 17:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680889116;
        bh=pv2uwpKyfCuevF6OQpgNZ1zctQm7KH8g/8PQsJPJZEQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E8M2YmikbEg/mN9QwWnTC03dZxqi2p5wPjzzMPU8/79tOwt5jvxPukkvi1RXFp8WM
         9K3wkdwVH2EwFlF11VVjKmTEHvVl4J/93iTKLm9qWdYQOUulSJyLq3JMmdN2JBm6K4
         TgH97uu0hBSvI3ZhC4JWKBOJjJBpgfS8SzPTqc6xp5L/T+GJIUCvZESbljI4NdkDR/
         Hb+vNsYsNKDjEkI4t6LW1+xxLxYnN8E2K8qu1dRZZ82UOUfI+N7Js1LocZy/4FrXXK
         QJ7maZoyicwqSyxtdH7PzHPk0+2L2rFEEl6nYSzFsi4eT+G8a1o6sQwgopuMV1e4h1
         fRTzgWNFcOrDA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
        konrad.dybcio@linaro.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: Remove "iommus" property from PCIe nodes
Date:   Fri,  7 Apr 2023 10:41:13 -0700
Message-Id: <168088927577.2561591.5257509522357724563.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230308075648.134119-1-manivannan.sadhasivam@linaro.org>
References: <20230308075648.134119-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Mar 2023 13:26:48 +0530, Manivannan Sadhasivam wrote:
> Currently, most of the Qualcomm SoCs specify both "iommus" and "iommu-map"
> properties for the PCIe nodes. First one passes the SMR mask to the iommu
> driver and the latter specifies the SID for each PCIe device.
> 
> But with "iommus" property, the PCIe controller will be added to the
> iommu group along with the devices. This makes no sense because the
> controller will not initiate any DMA transaction on its own. And moreover,
> it is not strictly required to pass the SMR mask to the iommu driver. If
> the "iommus" property is not present, then the default mask of "0" would be
> used which should work for all PCIe devices.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: qcom: Remove "iommus" property from PCIe nodes
      commit: 6340b391e15094575911ab0d96bfff09deadafba

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

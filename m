Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D31A46DB753
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 01:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbjDGXhh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 19:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbjDGXh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 19:37:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ED3FE1B8;
        Fri,  7 Apr 2023 16:37:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CB43465589;
        Fri,  7 Apr 2023 23:37:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95224C433A7;
        Fri,  7 Apr 2023 23:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680910644;
        bh=omn/epBAd866J+43NDNWF/7PK4wYSm3QFJmV50MEDGs=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=VbQC1XaDjOj/RFxpod6XYw1CkbZlNfWTJJsqMIVQLml9+mRqCg+C4TX8Y2rfono2A
         cv/VixgmUgSPtX4d6a/29JppRCYUztYuwu1GFNEC7ADR17wOvxATzqqOuZ04LrCsrE
         fxMhJCN2tPG7qa1CjPs+eqCzGkRR7VS6LLaF8MU/8V9niplJ9cb51vvj++forZAf93
         APP1hwW6XTKJdBBOxFxk7zDDBQfdSSo257SfQoqdybAiXGh4RNSEgnrFK3QQfcnaA3
         JQUJpIPu/29nx8CRnZxl3qK+IT5h7ztYkBjxvgVCtrasBD7EqBpQRskVJNYxW8MCDw
         iGWuiQXXyNv3Q==
From:   Bjorn Andersson <andersson@kernel.org>
To:     linux-arm-msm@vger.kernel.org, robh+dt@kernel.org,
        Kathiravan T <quic_kathirav@quicinc.com>, agross@kernel.org,
        konrad.dybcio@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org
Subject: Re: (subset) [PATCH V2 0/2] Add initial support for RDP468 of IPQ5332 family
Date:   Fri,  7 Apr 2023 16:40:09 -0700
Message-Id: <168091080212.2759405.11120234958962384657.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230323093120.20558-1-quic_kathirav@quicinc.com>
References: <20230323093120.20558-1-quic_kathirav@quicinc.com>
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

On Thu, 23 Mar 2023 15:01:18 +0530, Kathiravan T wrote:
> Add the initial device tree support for the RDP(Reference Design
> Platform)468 based on IPQ5332 family of SoCs. This patch carries the
> support for Console UART, SPI NOR, eMMC.
> 
> This series depends on the below which adds support the SPI NOR
> https://lore.kernel.org/linux-arm-msm/20230320104530.30411-1-quic_kathirav@quicinc.com/
> 
> [...]

Applied, thanks!

[2/2] arm64: dts: qcom: ipq5332: add support for the RDP468 variant
      commit: f1d33c902a1be727416fce3161db37a84d3f38d1

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

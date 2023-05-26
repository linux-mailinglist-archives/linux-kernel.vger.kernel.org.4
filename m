Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEA16712DAB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 21:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243922AbjEZTfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 15:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243959AbjEZTev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 15:34:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C51D9;
        Fri, 26 May 2023 12:34:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 48CC665309;
        Fri, 26 May 2023 19:34:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C6BBC4339B;
        Fri, 26 May 2023 19:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685129689;
        bh=A2XtxZCHF5re1ZmCZEy4r5DcD8A7Eu/unPZglQG4lHM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sqJcXMlp1VMxvz2eH0H8enSj07ACG9gZ1bmNmepIHAozLf4NJ4Ph07hGEjaUGp24B
         jkQ9HTNXSGS0/z7kpjhWxe3P3dzmlbr29aBl1Om2WXfzN7LS46R0X/W+oDWXFf3fVn
         ow8d4IyOZAVy81h5Ae83KCILQeEp1SSViF5aEjX/v/BqPKZ2DnUQNjGPrmtjUi+wDr
         51o10N1L/mExNKsXQxFqL4p1KI15tsTZVXDtvEDK881/oGBXEbQ/iF4eXx0tpeWgRF
         EEgGtzXYsqXbJVZPkaHyolHMRkoHxu6SRHll56jaTrOoJ7PtVCIFUq1c9wYTaEpDu2
         pg01r6MMa2MDg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     agross@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, konrad.dybcio@linaro.org,
        conor+dt@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        Devi Priya <quic_devipriy@quicinc.com>
Cc:     quic_poovendh@quicinc.com, quic_kathirav@quicinc.com,
        quic_anusha@quicinc.com, quic_sjaganat@quicinc.com,
        quic_srichara@quicinc.com, quic_arajkuma@quicinc.com
Subject: Re: [PATCH 0/2] Add initial support for RDP418 of IPQ9574 family
Date:   Fri, 26 May 2023 12:38:30 -0700
Message-Id: <168512991479.248818.17725559044727954822.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230510104359.16678-1-quic_devipriy@quicinc.com>
References: <20230510104359.16678-1-quic_devipriy@quicinc.com>
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

On Wed, 10 May 2023 16:13:57 +0530, Devi Priya wrote:
> Add the initial device tree support for the Reference Design
> Platform(RDP) 418 based on IPQ9574 family of SoC. This patch series adds
> support for Console UART, SPI NOR, eMMC and SMPA1 regulator node.
> 
> Devi Priya (2):
>   dt-bindings: arm: qcom: document AL02-C2 board based on IPQ9574 family
>   arm64: dts: qcom: ipq9574: add support for RDP418 variant
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: arm: qcom: document AL02-C2 board based on IPQ9574 family
      commit: e3c98aac28bd8964031ebb057cb6e48fc492d256
[2/2] arm64: dts: qcom: ipq9574: add support for RDP418 variant
      commit: d8a83f8d2e730d4e05e8fc8e1faccbee0f95ca12

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

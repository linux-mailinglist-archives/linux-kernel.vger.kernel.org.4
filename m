Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E3E2712DA4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 21:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244039AbjEZTfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 15:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244042AbjEZTey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 15:34:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F37B13D;
        Fri, 26 May 2023 12:34:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 96A45651B9;
        Fri, 26 May 2023 19:34:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16015C433A0;
        Fri, 26 May 2023 19:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685129692;
        bh=auGaAhJ3gYADbZU1xnhReZDvPilOzS4YXc6T3mEquUE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aPBeKiWXo0vGy5Lf0sM9gTcAjMiP0WOLU511SRhC9zPaKeRjhd2tptL9Lir3h4Ogh
         TIShwaNCdJMoWBl0eOMcvjWXsi88DHbP5WtT9806OgwljZvtD3iryvFv9YiCst2GzY
         hDd1K3lt3AHoz6CG5ct9i8E/iavo8Pd3+7LEeoL/FkVacLSDZT6YXelJAVRTyVcgjh
         F9xSFQXMVOdNmN0PAa5bGKt2HBGYlpsqQL7ixcQ8SSmq8hX0dsitdQDWgMaSyy3bK2
         U+FhI5NDnO6lGJ41Wk2hMC9N3xYUuAQ3xa66t8ErDu+r7mr+Ckn7IC6lK/dEWDskXC
         EDJjLE61HQP7w==
From:   Bjorn Andersson <andersson@kernel.org>
To:     agross@kernel.org, devicetree@vger.kernel.org,
        konrad.dybcio@linaro.org, linux-kernel@vger.kernel.org,
        conor+dt@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        Devi Priya <quic_devipriy@quicinc.com>
Cc:     quic_kathirav@quicinc.com, quic_anusha@quicinc.com,
        quic_sjaganat@quicinc.com, quic_srichara@quicinc.com,
        quic_arajkuma@quicinc.com
Subject: Re: [PATCH 0/2] Add initial support for RDP453 of IPQ9574 family
Date:   Fri, 26 May 2023 12:38:32 -0700
Message-Id: <168512991479.248818.11535051961870996195.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230526153152.777-1-quic_devipriy@quicinc.com>
References: <20230526153152.777-1-quic_devipriy@quicinc.com>
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

On Fri, 26 May 2023 21:01:50 +0530, Devi Priya wrote:
> Add the initial device tree support for the Reference Design
> Platform(RDP) 453 based on IPQ9574 family of SoCs. This patch series adds
> support for Console UART, SPI NOR and SMPA1 regulator node.
> 
> The series depends on the below patch sets which adds support for
> SPI NOR and SMPA1 regulator nodes.
> https://lore.kernel.org/linux-arm-msm/20230329053726.14860-3-quic_kathirav@quicinc.com/
> https://lore.kernel.org/linux-arm-msm/20230407155727.20615-1-quic_devipriy@quicinc.com/
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: arm: qcom: document AL02-C8 board based on IPQ9574 family
      commit: b866fba43698479fef5dd301313e8a73e28c789e
[2/2] arm64: dts: qcom: ipq9574: add support for RDP453 variant
      commit: 8a465494d62215ca531dfa0cde993779a77e61aa

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

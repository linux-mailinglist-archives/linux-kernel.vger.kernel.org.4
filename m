Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF02E72F096
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 01:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241970AbjFMXsQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 19:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjFMXrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 19:47:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD69B1FCB;
        Tue, 13 Jun 2023 16:46:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D37263C84;
        Tue, 13 Jun 2023 23:45:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58776C433C0;
        Tue, 13 Jun 2023 23:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686699951;
        bh=zPjSJFw05vwE6Pveeo8vKrum/cAGp/1i8QWbejGQEtA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IyvKLqDOukqIoDG9w8T478VqhyfgOzzDvf5M5G4S62yslDR5gID8jdt3h2r3RQszx
         cjxvk0YZfc1TCcg5kvvrMmyX/A19ZKITKXeEB/JIgChSl51FXOVi+l50jadDkyCmAk
         jT/p1RmQG1YG7U202bUKbCJMMJ4B4vBMfMDVAUEq0JmoKxG+xkTz4zRBqjeUGnNzwj
         xZ4Zcjr27L+ARUOEJnSDjPNSOB2FXenzoYR0gh+mHSAvqumqZ0pEBYDolHUaQLIbnv
         0DSOm2usXt2yu+/KFV+zNQmPZn8qO7P6yDQafxOhQUPZUij0i2C+P+Dpf18bNZ6DiQ
         TOPO2Sdkq0P2Q==
From:   Bjorn Andersson <andersson@kernel.org>
To:     devicetree@vger.kernel.org, konrad.dybcio@linaro.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        conor+dt@kernel.org, robh+dt@kernel.org,
        Poovendhan Selvaraj <quic_poovendh@quicinc.com>,
        krzysztof.kozlowski+dt@linaro.org, agross@kernel.org
Cc:     quic_sjaganat@quicinc.com, quic_srichara@quicinc.com,
        quic_anusha@quicinc.com, quic_gokulsri@quicinc.com,
        quic_devipriy@quicinc.com, quic_kathirav@quicinc.com,
        quic_arajkuma@quicinc.com
Subject: Re: [PATCH 0/2] Add initial support for RDP454 of IPQ9574 family
Date:   Tue, 13 Jun 2023 16:48:54 -0700
Message-Id: <168670013500.1400697.7352127193171333793.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230519103128.30783-1-quic_poovendh@quicinc.com>
References: <20230519103128.30783-1-quic_poovendh@quicinc.com>
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

On Fri, 19 May 2023 16:01:26 +0530, Poovendhan Selvaraj wrote:
> From: POOVENDHAN SELVARAJ <quic_poovendh@quicinc.com>
> 
> Add the initial device tree support for the Reference Design
> Platform(RDP) 454 based on IPQ9574 family of SoCs. This patch series adds
> support for Console UART, SPI NOR and SMPA1 regulator node.
> 
> The series depends on the below patch sets which adds support for
> SPI NOR and SMPA1 regulator nodes.
> https://lore.kernel.org/linux-arm-msm/20230329053726.14860-3-quic_kathirav@quicinc.com/
> https://lore.kernel.org/linux-arm-msm/20230407155727.20615-1-quic_devipriy@quicinc.com/
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: arm: qcom: document AL02-C9 board based on IPQ9574 family
      commit: add687cbfc3482ca74949b91b251e76792d25652
[2/2] arm64: dts: qcom: ipq9574: add support for RDP454 variant
      commit: 2435d79033f5e7400195ed3b31585c0c053de553

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

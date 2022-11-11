Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ABFB625744
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 10:48:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233576AbiKKJsX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 04:48:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233492AbiKKJsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 04:48:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A230EB873;
        Fri, 11 Nov 2022 01:48:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 59F3CB82479;
        Fri, 11 Nov 2022 09:48:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 039BAC433D7;
        Fri, 11 Nov 2022 09:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668160087;
        bh=UO9s2rNz3wCUuSsslxBtOPMFhO1pE6RogR5vqI60ktk=;
        h=From:To:Cc:Subject:Date:From;
        b=DuYTNluMNNvdH1bbbj/4psFYLT6thyXv3D8kBDp2WPc9FCm7iFB8Zs2ga196bZvg/
         XNRzr9SP2PP83uD8lb5xvdtbjmV9i3rsN1AcM3KYyoygHJBkKoJ20bbxbfi0CPxEQd
         EzzPURsbE2o7P4dkyzGnAJvcXOadW80SA6JNl30bYdv7manRfdhgkaqDeYdyLdhCWc
         y3viUDwZJD7zyRTxvXi4ncBA0x2SkcTr/fnEpl+NDbd0vPAJgUXWNw13CshKFVR2QY
         b0cy3wmwnNmw5ShlXQE/U7uWuph8jLWsXkAZy/Bo72GVCKyZU3/74iMn8XUyL1zm0+
         T+yogpDk2LADw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1otQdP-00035F-03; Fri, 11 Nov 2022 10:47:39 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 0/2] arm64: dts: qcom: fix USB-DP PHY registers
Date:   Fri, 11 Nov 2022 10:47:27 +0100
Message-Id: <20221111094729.11842-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.37.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fixes DisplayPort support on sm6350 and sm8250, which used
the wrong offset for the DP_PHY registers.

Johan


Johan Hovold (2):
  arm64: dts: qcom: sm6350: fix USB-DP PHY registers
  arm64: dts: qcom: sm8250: fix USB-DP PHY registers

 arch/arm64/boot/dts/qcom/sm6350.dtsi | 5 ++---
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 5 ++---
 2 files changed, 4 insertions(+), 6 deletions(-)

-- 
2.37.4


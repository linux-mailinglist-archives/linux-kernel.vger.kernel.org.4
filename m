Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C44906256FE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 10:40:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232583AbiKKJkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 04:40:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbiKKJkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 04:40:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 598A0654C9;
        Fri, 11 Nov 2022 01:40:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0099A61F26;
        Fri, 11 Nov 2022 09:40:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 482D8C433C1;
        Fri, 11 Nov 2022 09:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668159611;
        bh=oyTBZ13gV8eABN+USBSLXLHgr9cRq7vSHs8d2NKvDGQ=;
        h=From:To:Cc:Subject:Date:From;
        b=bZp7H0gZzw5hdzr3QZX3lql2VyV6mhRI2h5Bm1xk6oYrjL0DU/JUUzA5AyHW1FZ9K
         +Lzg9yDF0QfHwu/6uO/ZUdJOeDQRaTq/4+bTY5OwQsxwkOZ4s3NP07iCyZTC/VE20X
         zS0cQQmpiScFpC8tbKwKVHyuby5a63jDjRlQSpf1jqHIO72dyKCi0oMVHK/sPb8aFQ
         WSWWifHgu+A4VhKZZwZPx/6dTajKlMwK6yFnTMxMXFXNKwSifTnq2Mnm9Kv/5SNVRb
         fGOomulrS7lsM5TwxHfnlpF5QrqbF03Ouw1lFmukygUJDVSHGevD9J2+OEbEYHXIzh
         HAwm4bPKPO5dQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1otQVi-0002xf-E9; Fri, 11 Nov 2022 10:39:43 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 0/3] phy: qcom-qmp-usb: drop sc8280xp reference-clock source
Date:   Fri, 11 Nov 2022 10:38:54 +0100
Message-Id: <20221111093857.11360-1-johan+linaro@kernel.org>
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

The source clock for the reference clock is not used by the PHY directly
and should not have been included in the devicetree binding.

As the new SC8280XP binding has been merged for 6.2, we should get this
fixed as soon as possible.

Johan


Johan Hovold (3):
  dt-bindings: phy: qcom,sc8280xp-qmp-usb3-uni: drop reference-clock
    source
  phy: qcom-qmp-usb: drop sc8280xp reference-clock source
  arm64: dts: qcom: sc8280xp: drop reference-clock source

 .../phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml   |  7 ++-----
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi        |  8 ++------
 drivers/phy/qualcomm/phy-qcom-qmp-usb.c       | 20 +++++++++++--------
 3 files changed, 16 insertions(+), 19 deletions(-)

-- 
2.37.4


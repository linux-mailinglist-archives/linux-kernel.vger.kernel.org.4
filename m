Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3514962400E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 11:38:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbiKJKiZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 05:38:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbiKJKiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 05:38:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3249D6B3BA;
        Thu, 10 Nov 2022 02:38:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BDBC061241;
        Thu, 10 Nov 2022 10:38:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0469C433D6;
        Thu, 10 Nov 2022 10:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668076698;
        bh=tuskuxpD8PyKvoprUL7xmJmRkvljdUornrZzJLAfpoc=;
        h=From:To:Cc:Subject:Date:From;
        b=dioA63g2zCaaytdtXbJTFzPCevvl+fFEe1YxLSUrJ1yAuWLvR7UVvbl8niPUNX+xU
         xRLeu8atU7PZHB8XS21ppNICeEs99185ByJkDXjeGXGzABRhz6YEZV2JDcj6US2yNT
         vI3APDfrHsAum5eKODR3TYVigGrzwRH2MaMZXxa8kBEU9cntYKVpPRVuwMutnfwoxn
         z580nvJtTo4PjMLJjV+i31LSZD9OD8HONB0Rl8p+EiNkj/TbNl7JHLUh1m0j1SmmJn
         n/axEq4dI7KcBSJtHUqqWY/SvQv7rX+08qoAAXjZ7mIIx/CU83oN88AIENev9wsaCD
         i62zKNmVvla7Q==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1ot4wP-0003LN-VN; Thu, 10 Nov 2022 11:37:50 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 0/9] arm64: dts: qcom: sc8280xp/sa8540p: add support for PCIe
Date:   Thu, 10 Nov 2022 11:35:49 +0100
Message-Id: <20221110103558.12690-1-johan+linaro@kernel.org>
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

This series adds support for PCIe to the SC8280XP and SA840P platforms
and specifically enables the NVMe SSD, modem and WiFi controller on the
SC8280XP-CRD and Lenovo Thinkpad X13s.

Note that these patches depend on the PCIe QMP PHY support that was
merged this morning:

	https://lore.kernel.org/lkml/20221105145939.20318-1-johan+linaro@kernel.org/

as well as the PCIe interconnect support:

	https://lore.kernel.org/all/20221102090705.23634-1-johan+linaro@kernel.org/

where the binding has been acked by the DT maintainer but support has
not yet been merged.

Johan


Johan Hovold (9):
  arm64: dts: qcom: sc8280xp/sa8540p: add PCIe2-4 nodes
  arm64: dts: qcom: sa8295p-adp: enable PCIe
  arm64: dts: qcom: sc8280xp-crd: rename backlight and misc regulators
  arm64: dts: qcom: sc8280xp-crd: enable NVMe SSD
  arm64: dts: qcom: sc8280xp-crd: enable SDX55 modem
  arm64: dts: qcom: sc8280xp-crd: enable WiFi controller
  arm64: dts: qcom: sc8280xp-x13s: enable NVMe SSD
  arm64: dts: qcom: sc8280xp-x13s: enable modem
  arm64: dts: qcom: sc8280xp-x13s: enable WiFi controller

 arch/arm64/boot/dts/qcom/sa8295p-adp.dts      | 171 ++++++
 arch/arm64/boot/dts/qcom/sa8540p.dtsi         |  59 +++
 arch/arm64/boot/dts/qcom/sc8280xp-crd.dts     | 197 ++++++-
 .../qcom/sc8280xp-lenovo-thinkpad-x13s.dts    | 202 +++++++
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi        | 493 +++++++++++++++++-
 5 files changed, 1115 insertions(+), 7 deletions(-)

-- 
2.37.4


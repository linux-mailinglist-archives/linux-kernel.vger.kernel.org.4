Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A05C74E874
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 09:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231558AbjGKH5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 03:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231537AbjGKH5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 03:57:51 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CD5E1A4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 00:57:48 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36B6PBbW025741;
        Tue, 11 Jul 2023 09:57:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=cLmVdpN73a4nVNMVZyde0rbXTQOu0nQgP3fB1A/cg9Y=;
 b=pNPMJbxqVth8akkJKbC/13M7Zhfp3E75wikE71m0Dy+MtGmvffsWnyB1Cck2QNVK7FSh
 kUYXmwoNW8R1T0r2HVepjgdRFsQ3+eFYyMeBOEAqrNbjNQf7iAAYHhhmG8SXiB51URmW
 6RPQEQcKlMDD1sMVDQVfQSQs8Sq+ZRF5hjJ6Y/mx+/Egg02UbtR8m/TuvbQoEfsQyf4M
 srPM0bxIX9ug/MSlvYqiMIVmHzK84/CF3D1+/0lLwpPkueecpz/eB0WoMIpQjEhNz7YO
 FG5RVwvLLNu5L7515xgCGolsCCwt4ViYB/wV88VkBI/Xnjd+7ojeJHNuhlHxcAG5H+h7 qA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3rrs59b81q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Jul 2023 09:57:39 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D5F7610005D;
        Tue, 11 Jul 2023 09:57:35 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B89EE20F553;
        Tue, 11 Jul 2023 09:57:35 +0200 (CEST)
Received: from [10.201.21.122] (10.201.21.122) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Tue, 11 Jul
 2023 09:57:35 +0200
Message-ID: <56c5add3-d63a-1e47-1b14-2b276e4268b7@foss.st.com>
Date:   Tue, 11 Jul 2023 09:57:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 0/8] ARM: dts: stm32: lxa-tac: add Linux Automation
 GmbH TAC
Content-Language: en-US
To:     =?UTF-8?Q?Leonard_G=c3=b6hrs?= <l.goehrs@pengutronix.de>,
        Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <linux-kernel@vger.kernel.org>
CC:     <kernel@pengutronix.de>
References: <20230614123222.4167460-1-l.goehrs@pengutronix.de>
From:   Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20230614123222.4167460-1-l.goehrs@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.201.21.122]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-11_04,2023-07-06_02,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Leonard

On 6/14/23 14:32, Leonard Göhrs wrote:
> The Linux Automation Test Automation Controller (LXA TAC)[1] is an embedded
> software development tool built around the Octavo Systems OSD32MP15x SiP.
> 
> The device contains an eMMC for storage, a DSA-capable on board ethernet
> switch with two external ports, dual CAN busses, a power switch to turn
> a device under test on or off and some other I/O.
> 
> As of now there are two STM32MP157 based hardware generations (Gen 1 and
> Gen 2) that have most of their hardware config in common.
> In the future there will also be a STM32MP153 based hardware generation.
> 
> [1]: https://www.linux-automation.com/en/products/lxa-tac.html
> 
> V1: https://lore.kernel.org/lkml/20230607115508.2964574-1-l.goehrs@pengutronix.de/
> 
> Changes since V1:
> 
>    - Rebase on top of stm32-next as requested by Alexandre Torgue.
>    - Split addition of shineworld lh133k compatible into separate
>      vendor-prefix patch and panel-mipi-dbi-spi.yaml patch as suggested
>      by Conor Dooley.
>      Did not carry over the Reviewed-by: Rob Herring <robh@kernel.org>
>      from the original patch due to the split.
>    - Drop "dt-bindings: gpio: pca9570: add gpio-line-names property"
>      as it is already in gpio/for-next.
>    - Replace "dt-bindings: can: m_can: add termination-{gpios,ohms}
>      properties" with a patch that replaces additionalProperties with
>      unevaluatedProperties in bosch,m_can.yaml, as suggested by
>      Rob Herring.
>    - Drop "dt-bindings: net: dsa: microchip: add missing spi-{cpha,cpol}
>      properties" as setting the correct SPI mode is the responsibility of the
>      driver (suggested by Rob Herring).
>    - Rename ethernet0_rgmii_pins_d pinctrl group to ethernet0_rgmii_pins_e
>      as the former is already taken in stm32-next, as suggested by
>      Alexandre Torgue.
> 
> Leonard Göhrs (8):
>    dt-bindings: vendor-prefixes: Add prefix for ShineWorld Innovations
>    dt-bindings: display: panel: mipi-dbi-spi: add shineworld lh133k
>      compatible
>    dt-bindings: display: panel: mipi-dbi-spi: add spi-3wire property
>    dt-bindings: can: m_can: change from additional- to
>      unevaluatedProperties
>    dt-bindings: net: dsa: microchip: add interrupts property for ksz
>      switches
>    ARM: dts: stm32: Add pinmux groups for Linux Automation GmbH TAC
>    dt-bindings: arm: stm32: Add compatible string for Linux Automation
>      LXA TAC
>    ARM: dts: stm32: lxa-tac: add Linux Automation GmbH TAC
> 
>   .../devicetree/bindings/arm/stm32/stm32.yaml  |   4 +-
>   .../display/panel/panel-mipi-dbi-spi.yaml     |   3 +
>   .../bindings/net/can/bosch,m_can.yaml         |   2 +-
>   .../bindings/net/dsa/microchip,ksz.yaml       |   3 +
>   .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
>   arch/arm/boot/dts/Makefile                    |   2 +
>   arch/arm/boot/dts/stm32mp15-pinctrl.dtsi      | 129 ++++
>   .../arm/boot/dts/stm32mp157c-lxa-tac-gen1.dts |  93 +++
>   .../arm/boot/dts/stm32mp157c-lxa-tac-gen2.dts | 172 +++++
>   arch/arm/boot/dts/stm32mp15xc-lxa-tac.dtsi    | 610 ++++++++++++++++++
>   10 files changed, 1018 insertions(+), 2 deletions(-)
>   create mode 100644 arch/arm/boot/dts/stm32mp157c-lxa-tac-gen1.dts
>   create mode 100644 arch/arm/boot/dts/stm32mp157c-lxa-tac-gen2.dts
>   create mode 100644 arch/arm/boot/dts/stm32mp15xc-lxa-tac.dtsi
> 
> 
> base-commit: c9cb7e72e293141d0d6c1d74c26788d3a0605172

Patches 4 to 8 applied on stm32-next.

thanks
Alex

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8A25717EA7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 13:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234678AbjEaLmi convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 31 May 2023 07:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbjEaLmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 07:42:36 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F064E5;
        Wed, 31 May 2023 04:42:33 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 2765124E293;
        Wed, 31 May 2023 19:42:26 +0800 (CST)
Received: from EXMBX171.cuchost.com (172.16.6.91) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 31 May
 2023 19:42:26 +0800
Received: from [192.168.125.108] (113.72.147.198) by EXMBX171.cuchost.com
 (172.16.6.91) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 31 May
 2023 19:42:24 +0800
Message-ID: <b289c78d-cc61-5fbf-94b9-e94d10eefb60@starfivetech.com>
Date:   Wed, 31 May 2023 19:42:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v6 0/7] Add JH7110 USB and USB PHY driver support
Content-Language: en-US
To:     Roger Quadros <rogerq@kernel.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Conor Dooley <conor@kernel.org>,
        "Vinod Koul" <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pawel Laszczak <pawell@cadence.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Chen <peter.chen@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <linux-usb@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Mason Huo" <mason.huo@starfivetech.com>
References: <20230518112750.57924-1-minda.chen@starfivetech.com>
 <e733829d-2314-aa6f-7e9a-053f1b074526@kernel.org>
From:   Minda Chen <minda.chen@starfivetech.com>
In-Reply-To: <e733829d-2314-aa6f-7e9a-053f1b074526@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Originating-IP: [113.72.147.198]
X-ClientProxiedBy: EXCAS061.cuchost.com (172.16.6.21) To EXMBX171.cuchost.com
 (172.16.6.91)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/5/26 17:03, Roger Quadros wrote:
> 
> 
> On 18/05/2023 14:27, Minda Chen wrote:
>> This patchset adds USB driver and USB PHY for the StarFive JH7110 SoC.
>> USB work mode is peripheral and using USB 2.0 PHY in VisionFive 2 board.
>> The patch has been tested on the VisionFive 2 board.
>> 
>> This patchset should be applied after the patchset [1], [2] and [3]:
>> [1] https://patchwork.kernel.org/project/linux-riscv/cover/20230518101234.143748-1-xingyu.wu@starfivetech.com/
>> [2] https://patchwork.kernel.org/project/linux-clk/cover/20230512022036.97987-1-xingyu.wu@starfivetech.com
>> [3] https://patchwork.kernel.org/project/linux-phy/cover/20230412084540.295411-1-changhuang.liang@starfivetech.com/
>> 
>> This patchset is base on v6.4-rc1
>> 
>> patch 1 is usb phy dt-binding document.
>> patch 2 is Pcie PHY dt-binding document.
>> patch 3 is USB 2.0 PHY driver.
>> patch 4 is PCIe PHY driver.
>> patch 5 is usb dt-binding document.
>> patch 6 is the wrapper module driver of Cadence USB3. USB controller IP is Cadence USB3.
>> patch 7 is USB device tree configuration.
>> 
>> previous version
>> ---
>> version 1 patchset are split to different kernel organization. It is
>> incorrect. But they were sent, and Emil sent comments. I think I should 
>> reserve them in cover-letter. To read the change records and previous version, 
>> please start with version 2. 
>> 
>> v1: https://patchwork.kernel.org/project/linux-usb/cover/20230306095212.25840-1-minda.chen@starfivetech.com/
>> v2: https://patchwork.kernel.org/project/linux-usb/cover/20230308082800.3008-1-minda.chen@starfivetech.com/
>> v3: https://patchwork.kernel.org/project/linux-usb/cover/20230315104411.73614-1-minda.chen@starfivetech.com/
>> v4: https://patchwork.kernel.org/project/linux-usb/cover/20230406015216.27034-1-minda.chen@starfivetech.com/
>> v5: https://patchwork.kernel.org/project/linux-usb/cover/20230420110052.3182-1-minda.chen@starfivetech.com/
>> 
>> changes
>> v6:
>>   1. (patch 3) remove the platform remove function.
>>   2. (patch 4)
>>      - add switch to pcie mode function.
>>      - remove the redundant init/exit function.
>>   3. (patch 5)
>>      - dts split to wrapper layer and cdns node. The codes are
>>        like v3.
>>      - add cdns3 sub node dts-binding references.
>>   4. (patch 6)
>>      For stg-syscon iomem 0x10240000 - 0x10240010 actually is belonged
>>      to usb, so USB contain its own registers. So do not merge the dts node.
>>      The codes are like v3.
>>      - remove the cdns3_platform_add function.
>>      - remove phy ops because cdns3 contain all the phy ops.
>>      - runtime suspend function just shutdown the clocks.
>>   5. (patch 7)
>>      - add cdns3 subnode again.
>> 
>> v5:
>>   1. (patch 1) set correct model name and commit title.
>>   2. (patch 2) change to '-item' in syscon property. change commit title.
>>   3. (patch 5)
>>      - change to '-item' in syscon configure.
>>      - change commit title and doc title.
>>   4. (patch 6)
>>      - add clk and phy deinit function
>>      - add clk deinit function if phy init failed.
>>      - coding style changes and other format changes. 
>> 
>> v4:
>>   1. (patch 1) split PCIe PHY dt-binding doc to patch 2.
>>   2. (patch 2) PCIe PHY add stg and sys con configuration to dt-binding doc.
>>   3. (patch 3)
>>      - split PCIe PHY driver to patch 4.
>>      - replace dr_mode to phy mode in jh7110_usb2_phy.
>>   4. (patch 4) 
>>      - Makefile and Kconfig sorted by alphabet sequence.
>>      - Add PCIe PHY stg and syscon PHY connection configuration
>>        for USB 3.0.
>>   5. (patch 5)
>>      - commit message changed.
>>      - merge wrapper dts node and cdns3 node in example.
>>      - Add interrupts, reg, phy and dr_mode in property.
>>      - Add reset-name in property example.
>>   6. (patch 6)
>>      - For dts node is merged, Using platform_device_alloc and
>>        platform_device_add to generate cadence sub device.
>>      - IOMEM and IRQ resource are passed to Cadence sub device.
>>      - Add PHY ops process for PHY dts setting can not be passed to
>>        Cadence USB driver.
>>      - remove the stg and sys USB 3.0 PHY configuration.
>>      - Change the suspend clock reset and clock enable sequence.
>>      - Get all reset and clock resources before enable them in 
>>        cdns_clk_rst_init.
>>      - commit message changed.
>>   7. (patch 7)
>>      - merge wrapper dts node and cdns3 node in usb dts.
>>      - move the stg and sys USB 3.0 PHY confiuration to
>>        PCIe PHY dts node.
>>      - commit message changed.
>>      - Add reset-names dts.
>> 
>> v3:
>>   1. Add patch 1 - 4. Add USB PHY driver and dt-binding doc. 
>>      USB PHY codes are moved to patch 3 and patch 4.
>>   2. (patch 5)
>>      - USB wrapper module dts document is moved to usb directory.
>>      - Remove the 'dr_mode' and 'starfive,usb2-only' setting.
>>      - Some dts format changes. dts binding check pass.
>>   3. (patch 6)
>>      - Remove the PHY codes. 
>>      - Search 'dr_mode' and phy setting from Cadence subnode.
>>   4. (patch 7)
>>      - Add USB PHY dts configurion. 
>>      - 'dr_mode' is moved to Cadence controller submode.
>> 
>> v2:
>>   1. (patch 5) dt-binding changes. The document example is the same as dts config.
>>   2. (patch 6) using dev_err_probe and syscon_regmap_lookup_by_phandle_args function. Some formats changes
>>   3. (patch 7) dts nodes sorted by the address after @
>> 
>> Minda Chen (7):
>>   dt-bindings: phy: Add StarFive JH7110 USB PHY
>>   dt-bindings: phy: Add StarFive JH7110 PCIe PHY
>>   phy: starfive: Add JH7110 USB 2.0 PHY driver
>>   phy: starfive: Add JH7110 PCIE 2.0 PHY driver
>>   dt-bindings: usb: Add StarFive JH7110 USB controller
>>   usb: cdns3: Add StarFive JH7110 USB driver
>>   riscv: dts: starfive: Add USB dts configuration for JH7110
>> 
>>  .../phy/starfive,jh7110-pcie-phy.yaml         |  58 +++++
>>  .../bindings/phy/starfive,jh7110-usb-phy.yaml |  50 ++++
>>  .../bindings/usb/starfive,jh7110-usb.yaml     | 115 ++++++++
>>  MAINTAINERS                                   |  14 +
>>  .../jh7110-starfive-visionfive-2.dtsi         |   5 +
>>  arch/riscv/boot/dts/starfive/jh7110.dtsi      |  53 ++++
>>  drivers/phy/starfive/Kconfig                  |  21 ++
>>  drivers/phy/starfive/Makefile                 |   2 +
>>  drivers/phy/starfive/phy-jh7110-pcie.c        | 204 +++++++++++++++
>>  drivers/phy/starfive/phy-jh7110-usb.c         | 150 +++++++++++
>>  drivers/usb/cdns3/Kconfig                     |  11 +
>>  drivers/usb/cdns3/Makefile                    |   1 +
>>  drivers/usb/cdns3/cdns3-starfive.c            | 246 ++++++++++++++++++
>>  13 files changed, 930 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/phy/starfive,jh7110-pcie-phy.yaml
>>  create mode 100644 Documentation/devicetree/bindings/phy/starfive,jh7110-usb-phy.yaml
>>  create mode 100644 Documentation/devicetree/bindings/usb/starfive,jh7110-usb.yaml
>>  create mode 100644 drivers/phy/starfive/phy-jh7110-pcie.c
>>  create mode 100644 drivers/phy/starfive/phy-jh7110-usb.c
>>  create mode 100644 drivers/usb/cdns3/cdns3-starfive.c
>> 
> 
> For this series:
> Reviewed-by: Roger Quadros <rogerq@kernel.org>

Thanks Roger， Coner and Greg.
Patch 6 (USB controller codes) are accepted. 

Thanks Rob and Krzysztof.
  Dts-binding doc are reviewed.

Hi Vinod , Kishon and Linux-PHY maintainer
  Could you take time to review USB PHY codes (patch 3 and patch4) ? Thanks

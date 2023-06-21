Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97BD2737FD4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 13:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbjFUJbp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 05:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232295AbjFUJao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 05:30:44 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A31CE19AF;
        Wed, 21 Jun 2023 02:29:40 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id D3D1824E208;
        Wed, 21 Jun 2023 17:29:37 +0800 (CST)
Received: from EXMBX171.cuchost.com (172.16.6.91) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 21 Jun
 2023 17:29:37 +0800
Received: from [192.168.125.127] (113.72.145.217) by EXMBX171.cuchost.com
 (172.16.6.91) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 21 Jun
 2023 17:29:36 +0800
Message-ID: <d4824941-85dd-d378-be5b-072907b1169d@starfivetech.com>
Date:   Wed, 21 Jun 2023 17:29:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v7 4/5] phy: starfive: Add JH7110 PCIE 2.0 PHY driver
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Conor Dooley <conor@kernel.org>,
        "Vinod Koul" <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        "Roger Quadros" <rogerq@kernel.org>
CC:     <oe-kbuild-all@lists.linux.dev>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <linux-riscv@lists.infradead.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Mason Huo" <mason.huo@starfivetech.com>
References: <20230619094759.21013-5-minda.chen@starfivetech.com>
 <202306192215.TvQco9m6-lkp@intel.com>
From:   Minda Chen <minda.chen@starfivetech.com>
In-Reply-To: <202306192215.TvQco9m6-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [113.72.145.217]
X-ClientProxiedBy: EXCAS065.cuchost.com (172.16.6.25) To EXMBX171.cuchost.com
 (172.16.6.91)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/6/19 22:45, kernel test robot wrote:
> Hi Minda,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on robh/for-next]
> [also build test ERROR on linus/master v6.4-rc7 next-20230619]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Minda-Chen/dt-bindings-phy-Add-StarFive-JH7110-PCIe-PHY/20230619-184756
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
> patch link:    https://lore.kernel.org/r/20230619094759.21013-5-minda.chen%40starfivetech.com
> patch subject: [PATCH v7 4/5] phy: starfive: Add JH7110 PCIE 2.0 PHY driver
> config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20230619/202306192215.TvQco9m6-lkp@intel.com/config)
> compiler: s390-linux-gcc (GCC) 12.3.0
> reproduce: (https://download.01.org/0day-ci/archive/20230619/202306192215.TvQco9m6-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202306192215.TvQco9m6-lkp@intel.com/
> 
> All errors (new ones prefixed by >>, old ones prefixed by <<):
> 
>>> ERROR: modpost: "devm_platform_ioremap_resource" [drivers/phy/starfive/phy-jh7110-pcie.ko] undefined!
I can not find this error. devm_platform_ioremap_resource is an exported symbol
> ERROR: modpost: "devm_ioremap_resource" [drivers/dma/qcom/hdma.ko] undefined!
> ERROR: modpost: "devm_platform_ioremap_resource" [drivers/dma/fsl-edma.ko] undefined!
> ERROR: modpost: "devm_platform_ioremap_resource" [drivers/dma/idma64.ko] undefined!
> ERROR: modpost: "iounmap" [drivers/tty/ipwireless/ipwireless.ko] undefined!
> ERROR: modpost: "ioremap" [drivers/tty/ipwireless/ipwireless.ko] undefined!
> ERROR: modpost: "devm_platform_ioremap_resource" [drivers/char/xillybus/xillybus_of.ko] undefined!
> ERROR: modpost: "devm_memremap" [drivers/misc/open-dice.ko] undefined!
> ERROR: modpost: "devm_memunmap" [drivers/misc/open-dice.ko] undefined!
> ERROR: modpost: "iounmap" [drivers/net/ethernet/8390/pcnet_cs.ko] undefined!
> WARNING: modpost: suppressed 19 unresolved symbol warnings because there were too many)
>> Kconfig warnings: (for reference only)
>    WARNING: unmet direct dependencies detected for USB_PHY
>    Depends on [n]: USB_SUPPORT [=n]
>    Selected by [m]:
>    - PHY_STARFIVE_JH7110_PCIE [=m]
> 
I will fix it.

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 360A3738318
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 14:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231492AbjFUL6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 07:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231398AbjFUL6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 07:58:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE8ADE;
        Wed, 21 Jun 2023 04:58:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 20F966154C;
        Wed, 21 Jun 2023 11:58:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5208C433C8;
        Wed, 21 Jun 2023 11:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687348717;
        bh=zjlaqUJd/M2XG3eUFn4mMZVwk591aoxerwCGAG/o7Kg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HH2K6wz1VGKLKMLtvE0b4Iv/nxoeEKa+38PupxaUY2AxourukKfqZ9jcB5o7NUqyw
         sb+dYFkRi/KB8EEzEstq04IWUTuzAkCRgJ1Vpj020oEco12DfL5Vy+jkKP9N6GPTl0
         cDwiVvpDXeIrdLKynX8Gr4oK2fgKEgZSm2rgE/enKb2aKwT9g9LEU2psDIynmFi3zF
         Ir2vR09ejfeBzfKSlNzrkC5dvheSUOjbydClg5C+39yFx5MWfF2cVt5j5EMAGiOBam
         WPT3jZVD2gqpgXkwrAvQ9BsoDIryMXF2yoygQ9liWRBn0GScDDRYB+KD63NxNMOWpJ
         0TDFJnZAaENww==
Date:   Wed, 21 Jun 2023 17:28:33 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Minda Chen <minda.chen@starfivetech.com>,
        kernel test robot <lkp@intel.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Conor Dooley <conor@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Roger Quadros <rogerq@kernel.org>,
        oe-kbuild-all@lists.linux.dev, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Mason Huo <mason.huo@starfivetech.com>
Subject: Re: [PATCH v7 4/5] phy: starfive: Add JH7110 PCIE 2.0 PHY driver
Message-ID: <ZJLl6Sb0hPdYUGC0@matsya>
References: <20230619094759.21013-5-minda.chen@starfivetech.com>
 <202306192215.TvQco9m6-lkp@intel.com>
 <d4824941-85dd-d378-be5b-072907b1169d@starfivetech.com>
 <20230621-duckbill-scarf-fa79744cd42d@wendy>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621-duckbill-scarf-fa79744cd42d@wendy>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-06-23, 12:44, Conor Dooley wrote:
> Hey,
> 
> On Wed, Jun 21, 2023 at 05:29:34PM +0800, Minda Chen wrote:
> > On 2023/6/19 22:45, kernel test robot wrote:
> > > kernel test robot noticed the following build errors:
> > > 
> > > [auto build test ERROR on robh/for-next]
> > > [also build test ERROR on linus/master v6.4-rc7 next-20230619]
> > > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > > And when submitting patch, we suggest to use '--base' as documented in
> > > https://git-scm.com/docs/git-format-patch#_base_tree_information]
> > > 
> > > url:    https://github.com/intel-lab-lkp/linux/commits/Minda-Chen/dt-bindings-phy-Add-StarFive-JH7110-PCIe-PHY/20230619-184756
> > > base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
> > > patch link:    https://lore.kernel.org/r/20230619094759.21013-5-minda.chen%40starfivetech.com
> > > patch subject: [PATCH v7 4/5] phy: starfive: Add JH7110 PCIE 2.0 PHY driver
> > > config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20230619/202306192215.TvQco9m6-lkp@intel.com/config)
> > > compiler: s390-linux-gcc (GCC) 12.3.0
> > > reproduce: (https://download.01.org/0day-ci/archive/20230619/202306192215.TvQco9m6-lkp@intel.com/reproduce)
> > > 
> > > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > > the same patch/commit), kindly add following tags
> > > | Reported-by: kernel test robot <lkp@intel.com>
> > > | Closes: https://lore.kernel.org/oe-kbuild-all/202306192215.TvQco9m6-lkp@intel.com/
> > > 
> > > All errors (new ones prefixed by >>, old ones prefixed by <<):
> > > 
> > >>> ERROR: modpost: "devm_platform_ioremap_resource" [drivers/phy/starfive/phy-jh7110-pcie.ko] undefined!
> 
> > I can not find this error. devm_platform_ioremap_resource is an exported symbol
> 
> I asked Arnd about this since the error confused me too. Arnd pointed
> out that this "allmodconfig" isn't really allmodconfig as PCI is
> disabled. On s390, CONFIG_HAS_IOMEM depends on PCI and thus none of
> this devres stuff is usable without it. He suggested that you make the
> driver depend on USB_SUPPORT, which in turn depends on HAS_IOMEM.

Or add HAS_IOMEM as few drivers already do :-)

> 
> Cheers,
> Conor.
> 
> > > ERROR: modpost: "devm_ioremap_resource" [drivers/dma/qcom/hdma.ko] undefined!
> > > ERROR: modpost: "devm_platform_ioremap_resource" [drivers/dma/fsl-edma.ko] undefined!
> > > ERROR: modpost: "devm_platform_ioremap_resource" [drivers/dma/idma64.ko] undefined!
> > > ERROR: modpost: "iounmap" [drivers/tty/ipwireless/ipwireless.ko] undefined!
> > > ERROR: modpost: "ioremap" [drivers/tty/ipwireless/ipwireless.ko] undefined!
> > > ERROR: modpost: "devm_platform_ioremap_resource" [drivers/char/xillybus/xillybus_of.ko] undefined!
> > > ERROR: modpost: "devm_memremap" [drivers/misc/open-dice.ko] undefined!
> > > ERROR: modpost: "devm_memunmap" [drivers/misc/open-dice.ko] undefined!
> > > ERROR: modpost: "iounmap" [drivers/net/ethernet/8390/pcnet_cs.ko] undefined!
> > > WARNING: modpost: suppressed 19 unresolved symbol warnings because there were too many)
> > >> Kconfig warnings: (for reference only)
> > >    WARNING: unmet direct dependencies detected for USB_PHY
> > >    Depends on [n]: USB_SUPPORT [=n]
> > >    Selected by [m]:
> > >    - PHY_STARFIVE_JH7110_PCIE [=m]
> > > 
> > I will fix it.



-- 
~Vinod

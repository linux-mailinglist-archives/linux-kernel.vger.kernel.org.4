Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EDA97381CA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 13:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbjFULI4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 07:08:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbjFULIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 07:08:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2AFD9B;
        Wed, 21 Jun 2023 04:08:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5331E614F0;
        Wed, 21 Jun 2023 11:08:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C31C7C433C8;
        Wed, 21 Jun 2023 11:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687345732;
        bh=pDMlNd8ACfLvQmNU6tj/DpiQ1icRIIy6rldPkFKNQNY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nDaFj5hbkaoHpWVX2S1kRS79PjrjwDvtc3au5R9O09gR8LnTBUfvAscY33QWPoJLa
         yG1HfWL9Fzzwy7p48+VhvhQ3m3vY/tSdrFjR19RDbrGSRLUbfrsrnBLEmyseqKEyO1
         gkrRs4YuNMqo7H4GOqa4HnZb3vz2TwdAKEmMcqxaWSDspLJRNag+Pv4O8tFYXNagBf
         yZ/ijC3toU9H2EHmufaz74OxJ1I12W9ymtu9lPpf93uJvo2+OWdqG1f0PChBz6mY8c
         YIlp/CGFJF9HfHNIJrfqmxiI7j+jAqQwd7eP10mTPdLdPoZXMlKFjVMRkVJ6MJrp/y
         Vhhi+/RiEOIzA==
Date:   Wed, 21 Jun 2023 16:38:48 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Minda Chen <minda.chen@starfivetech.com>
Cc:     kernel test robot <lkp@intel.com>,
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
Message-ID: <ZJLaQB7UB56+/mtN@matsya>
References: <20230619094759.21013-5-minda.chen@starfivetech.com>
 <202306192215.TvQco9m6-lkp@intel.com>
 <d4824941-85dd-d378-be5b-072907b1169d@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4824941-85dd-d378-be5b-072907b1169d@starfivetech.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-06-23, 17:29, Minda Chen wrote:
> 
> 
> On 2023/6/19 22:45, kernel test robot wrote:
> > Hi Minda,
> > 
> > kernel test robot noticed the following build errors:
> > 
> > [auto build test ERROR on robh/for-next]
> > [also build test ERROR on linus/master v6.4-rc7 next-20230619]
> > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > And when submitting patch, we suggest to use '--base' as documented in
> > https://git-scm.com/docs/git-format-patch#_base_tree_information]
> > 
> > url:    https://github.com/intel-lab-lkp/linux/commits/Minda-Chen/dt-bindings-phy-Add-StarFive-JH7110-PCIe-PHY/20230619-184756
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
> > patch link:    https://lore.kernel.org/r/20230619094759.21013-5-minda.chen%40starfivetech.com
> > patch subject: [PATCH v7 4/5] phy: starfive: Add JH7110 PCIE 2.0 PHY driver
> > config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20230619/202306192215.TvQco9m6-lkp@intel.com/config)
> > compiler: s390-linux-gcc (GCC) 12.3.0
> > reproduce: (https://download.01.org/0day-ci/archive/20230619/202306192215.TvQco9m6-lkp@intel.com/reproduce)
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202306192215.TvQco9m6-lkp@intel.com/
> > 
> > All errors (new ones prefixed by >>, old ones prefixed by <<):
> > 
> >>> ERROR: modpost: "devm_platform_ioremap_resource" [drivers/phy/starfive/phy-jh7110-pcie.ko] undefined!
> I can not find this error. devm_platform_ioremap_resource is an exported symbol

Use the config and compiler provided in the report to repro this

-- 
~Vinod

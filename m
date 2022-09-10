Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 281F65B4443
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 07:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbiIJFch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 01:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiIJFce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 01:32:34 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E48285AA9
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 22:32:31 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id p18so3631086plr.8
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 22:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date;
        bh=jopVdw1qVzMqLHMV5Kp3Rupq060qHXjQXADwkK30rz4=;
        b=eeS/MEMm9J39rEErbUPkkXnO6ez1WJCIfr9Pzn/7oqs+SkKNmGk0RPDSxbAhyAv5l6
         RS0j3nySz6wF1jKb+3TENiMFuXiJ6l2wC5f3+MIeZffgCw9rv2YSNUZ1LjUsnkilxu7x
         Hsy0uiPtutJCDCD7j/jXxwC/R9djhJ6qwcIpvLr9JrGrTd6sYVUAcI5Y9RWySCAOHZ4O
         rkRnucf299w/3lYJgFhE3JevVlSX5WGMRAyIxxF24VZXnQyaJO/OU2G74lhS9JVS/a+Q
         rCDUaALXX7LLQxU8EgxbTDlYRm7PXTVX+aT1oFSJ8mOfbmWDIX/ufmP6YO602y+4Ev2N
         RcLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=jopVdw1qVzMqLHMV5Kp3Rupq060qHXjQXADwkK30rz4=;
        b=3I/DD1k3MzeWpTDZZ9ls7txuCnC6k4mM+faJiReFDGYxQ1G7v3J6UZjqGesbBlwU+h
         cNgKtqlySemVq70R45e3wXJqGnRpejAGQa4EPJSlXI9h60KCHS6p3V3wFSa8913jSmyQ
         O26cnVaSU5TLCoUBDzqOCaHepYYdkeQogH64r+vM7ePBslHAwV8VxoM0CBmnbjsoIBiq
         y9Q+sSsIaaJz3KFEddUhEokS3n6MQvPop2FgytCo9fHwcTxHHPSWjIVDVmrUw++xZgd1
         T78QED6FgrOveuxiC5amMDvBHe284xLQDflmCkNCCJddwkfsEO3QTq2Hau/fnVMb+0Vr
         TRZQ==
X-Gm-Message-State: ACgBeo3+nESJwcdcYn9yRugIUi90I/uYRbzAjbbndGqrL3a4vI6/gEjc
        NwnJnMrfFL6ZPmo3kDaw+VmO
X-Google-Smtp-Source: AA6agR6bv5hkoOm8hmADD807C9+UIEnADoVaBd5Fa8GNi3P+GB9022gFH/ArKkjuKaUH722GpF0bjw==
X-Received: by 2002:a17:902:d2ce:b0:178:7b5:c070 with SMTP id n14-20020a170902d2ce00b0017807b5c070mr6317692plc.58.1662787950619;
        Fri, 09 Sep 2022 22:32:30 -0700 (PDT)
Received: from thinkpad ([117.217.182.47])
        by smtp.gmail.com with ESMTPSA id s2-20020a625e02000000b00528c066678csm728570pfb.72.2022.09.09.22.32.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 22:32:30 -0700 (PDT)
Date:   Sat, 10 Sep 2022 11:02:22 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     kernel test robot <lkp@intel.com>
Cc:     lpieralisi@kernel.org, robh@kernel.org, andersson@kernel.org,
        kbuild-all@lists.01.org, kw@linux.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, konrad.dybcio@somainline.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, dmitry.baryshkov@linaro.org
Subject: Re: [PATCH v2 04/11] PCI: qcom-ep: Add eDMA support
Message-ID: <20220910053222.GA8299@thinkpad>
References: <20220830165817.183571-5-manivannan.sadhasivam@linaro.org>
 <202209031046.rOZKOVqT-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202209031046.rOZKOVqT-lkp@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 03, 2022 at 10:36:53AM +0800, kernel test robot wrote:
> Hi Manivannan,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on robh/for-next]
> [also build test ERROR on linus/master v6.0-rc3 next-20220901]
> [cannot apply to helgaas-pci/next]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Manivannan-Sadhasivam/Improvements-to-the-Qcom-PCIe-Endpoint-driver/20220831-010315
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
> config: arm-allyesconfig (https://download.01.org/0day-ci/archive/20220903/202209031046.rOZKOVqT-lkp@intel.com/config)
> compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/intel-lab-lkp/linux/commit/dec4c93b2077408cecddd53950905bf2411019b0
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Manivannan-Sadhasivam/Improvements-to-the-Qcom-PCIe-Endpoint-driver/20220831-010315
>         git checkout dec4c93b2077408cecddd53950905bf2411019b0
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    drivers/pci/controller/dwc/pcie-qcom-ep.c: In function 'qcom_pcie_ep_probe':
> >> drivers/pci/controller/dwc/pcie-qcom-ep.c:672:21: error: 'struct dw_pcie' has no member named 'edma'
>      672 |         pcie_ep->pci.edma.nr_irqs = 1;

This patch depends on the eDMA series from Sergey (Sorry, I forgot to mention
this in cover letter):
[PATCH RESEND v5 00/24] dmaengine: dw-edma: Add RP/EP local DMA controllers support

But the eDMA series is still getting reviews and I don't hear any news about
respin. So in the next revision I'm gonna drop this patch.

Thanks,
Mani

>          |                     ^
> 
> 
> vim +672 drivers/pci/controller/dwc/pcie-qcom-ep.c
> 
>    658	
>    659	static int qcom_pcie_ep_probe(struct platform_device *pdev)
>    660	{
>    661		struct device *dev = &pdev->dev;
>    662		struct qcom_pcie_ep *pcie_ep;
>    663		int ret;
>    664	
>    665		pcie_ep = devm_kzalloc(dev, sizeof(*pcie_ep), GFP_KERNEL);
>    666		if (!pcie_ep)
>    667			return -ENOMEM;
>    668	
>    669		pcie_ep->pci.dev = dev;
>    670		pcie_ep->pci.ops = &pci_ops;
>    671		pcie_ep->pci.ep.ops = &pci_ep_ops;
>  > 672		pcie_ep->pci.edma.nr_irqs = 1;
>    673		platform_set_drvdata(pdev, pcie_ep);
>    674	
>    675		ret = qcom_pcie_ep_get_resources(pdev, pcie_ep);
>    676		if (ret)
>    677			return ret;
>    678	
>    679		ret = qcom_pcie_enable_resources(pcie_ep);
>    680		if (ret) {
>    681			dev_err(dev, "Failed to enable resources: %d\n", ret);
>    682			return ret;
>    683		}
>    684	
>    685		ret = dw_pcie_ep_init(&pcie_ep->pci.ep);
>    686		if (ret) {
>    687			dev_err(dev, "Failed to initialize endpoint: %d\n", ret);
>    688			goto err_disable_resources;
>    689		}
>    690	
>    691		ret = qcom_pcie_ep_enable_irq_resources(pdev, pcie_ep);
>    692		if (ret)
>    693			goto err_disable_resources;
>    694	
>    695		return 0;
>    696	
>    697	err_disable_resources:
>    698		qcom_pcie_disable_resources(pcie_ep);
>    699	
>    700		return ret;
>    701	}
>    702	
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://01.org/lkp

-- 
மணிவண்ணன் சதாசிவம்

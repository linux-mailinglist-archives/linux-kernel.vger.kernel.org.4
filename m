Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F201712E8C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 22:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244016AbjEZUzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 16:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233433AbjEZUzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 16:55:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EC24A3;
        Fri, 26 May 2023 13:55:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E1C2965399;
        Fri, 26 May 2023 20:55:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBEA9C433D2;
        Fri, 26 May 2023 20:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685134533;
        bh=wNFS8qMpN9xjGkOy46fougDPohwpIn+vlopjqdB2Sr8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QoyYdGl7arYEizSVYRRLhQ4r35A4aBdNP+dWXfwtrMdRlgKHyFslPBQH38lz9HCCG
         4dGnTzHSxH6YCZgMYEtgbWEwRPido3Ff869pggt9FMU/wrGuXMkdJvo1wWfdHCQ3SF
         D3Ia0rj187W93RTKZXe/hfrvJiF2JLdW8EtWFx2NGLTpWBan6zGUjHD9UHrmBLnedO
         3W/3sUen9JZGepNHkwuHoERxPfjv7laOaxjxNxC0Iy1fGKosXBWbV22h0B2yMI0WhV
         vnw09r1avVxeSHxVIFwxYjhUtmmuaEf5SRyM2L+eltnKysbD0xpWnyVfQnRRo5UdO2
         S8cLnY9kEcurg==
Date:   Fri, 26 May 2023 13:59:20 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Rohit Agarwal <quic_rohiagar@quicinc.com>, agross@kernel.org,
        konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        tglx@linutronix.de, maz@kernel.org, will@kernel.org,
        robin.murphy@arm.com, joro@8bytes.org, robimarko@gmail.com,
        quic_gurus@quicinc.com, llvm@lists.linux.dev,
        oe-kbuild-all@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        Imran Shaik <quic_imrashai@quicinc.com>
Subject: Re: [PATCH 6/8] arm64: dts: qcom: Add support for GCC and RPMHCC for
 SDX75
Message-ID: <20230526205920.vxibspqj7cbizxq7@ripper>
References: <1684487350-30476-7-git-send-email-quic_rohiagar@quicinc.com>
 <202305201743.PsMD38Vz-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202305201743.PsMD38Vz-lkp@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 20, 2023 at 06:08:25PM +0800, kernel test robot wrote:
> Hi Rohit,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on robh/for-next]
> [also build test ERROR on tip/irq/core joro-iommu/next linus/master v6.4-rc2 next-20230519]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Rohit-Agarwal/dt-bindings-arm-qcom-Document-SDX75-platform-and-boards/20230519-171116
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
> patch link:    https://lore.kernel.org/r/1684487350-30476-7-git-send-email-quic_rohiagar%40quicinc.com
> patch subject: [PATCH 6/8] arm64: dts: qcom: Add support for GCC and RPMHCC for SDX75
> config: arm64-randconfig-r006-20230517
> compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project b0fb98227c90adf2536c9ad644a74d5e92961111)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install arm64 cross compiling tool for clang build
>         # apt-get install binutils-aarch64-linux-gnu
>         # https://github.com/intel-lab-lkp/linux/commit/768f74f2345d9af657bd58a98e7ade22b7a5c3e2
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Rohit-Agarwal/dt-bindings-arm-qcom-Document-SDX75-platform-and-boards/20230519-171116
>         git checkout 768f74f2345d9af657bd58a98e7ade22b7a5c3e2
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 olddefconfig
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202305201743.PsMD38Vz-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from arch/arm64/boot/dts/qcom/sdx75-idp.dts:8:
> >> arch/arm64/boot/dts/qcom/sdx75.dtsi:10:10: fatal error: 'dt-bindings/clock/qcom,sdx75-gcc.h' file not found
>    #include <dt-bindings/clock/qcom,sdx75-gcc.h>
>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This error can be ignored, I will fix the problem when applying the
updated patches.

Regards,
Bjorn

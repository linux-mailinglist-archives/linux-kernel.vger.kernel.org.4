Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 610F06CC64E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 17:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233426AbjC1P3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 11:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233163AbjC1P3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 11:29:21 -0400
Received: from 189.cn (ptr.189.cn [183.61.185.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 82201AD01;
        Tue, 28 Mar 2023 08:28:06 -0700 (PDT)
HMM_SOURCE_IP: 10.64.8.41:33662.1507456959
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-114.242.206.180 (unknown [10.64.8.41])
        by 189.cn (HERMES) with SMTP id ED66E10019C;
        Tue, 28 Mar 2023 23:22:50 +0800 (CST)
Received: from  ([114.242.206.180])
        by gateway-151646-dep-7b48884fd-ljp89 with ESMTP id a7f154ba0091421fba88d50f9f096b13 for lkp@intel.com;
        Tue, 28 Mar 2023 23:22:52 CST
X-Transaction-ID: a7f154ba0091421fba88d50f9f096b13
X-Real-From: 15330273260@189.cn
X-Receive-IP: 114.242.206.180
X-MEDUSA-Status: 0
Sender: 15330273260@189.cn
Message-ID: <027cf6d5-6de2-3424-7a81-a43ab689c3d4@189.cn>
Date:   Tue, 28 Mar 2023 23:22:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v8 2/2] drm: add kms driver for loongson display
 controller
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>,
        Sui Jingfeng <15330273260@189.cn>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Koenig <christian.koenig@amd.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        Li Yi <liyi@loongson.cn>
References: <20230320100131.1277034-3-15330273260@189.cn>
 <202303281754.jWI20j2C-lkp@intel.com>
From:   Sui Jingfeng <15330273260@189.cn>
In-Reply-To: <202303281754.jWI20j2C-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.6 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FROM_LOCAL_DIGITS,FROM_LOCAL_HEX,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI,

On 2023/3/28 17:27, kernel test robot wrote:
> Hi Sui,
>
> Thank you for the patch! Perhaps something to improve:
>
> [auto build test WARNING on drm-misc/drm-misc-next]
> [also build test WARNING on linus/master v6.3-rc4 next-20230328]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Sui-Jingfeng/MAINTAINERS-add-maintainers-for-DRM-LOONGSON-driver/20230320-180408
> base:   git://anongit.freedesktop.org/drm/drm-misc drm-misc-next
> patch link:    https://lore.kernel.org/r/20230320100131.1277034-3-15330273260%40189.cn
> patch subject: [PATCH v8 2/2] drm: add kms driver for loongson display controller
> config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20230328/202303281754.jWI20j2C-lkp@intel.com/config)
> compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
> reproduce (this is a W=1 build):
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # https://github.com/intel-lab-lkp/linux/commit/80b4115f44993f4ebf47b1cb9e8f02953575b977
>          git remote add linux-review https://github.com/intel-lab-lkp/linux
>          git fetch --no-tags linux-review Sui-Jingfeng/MAINTAINERS-add-maintainers-for-DRM-LOONGSON-driver/20230320-180408
>          git checkout 80b4115f44993f4ebf47b1cb9e8f02953575b977
>          # save the config file
>          mkdir build_dir && cp config build_dir/.config
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 olddefconfig
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/accel/ drivers/gpu/drm/loongson/ drivers/iio/light/ drivers/media/pci/intel/
>
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Link: https://lore.kernel.org/oe-kbuild-all/202303281754.jWI20j2C-lkp@intel.com/
>
> All warnings (new ones prefixed by >>):
>
>>> drivers/gpu/drm/loongson/lsdc_drv.c:232:11: warning: variable 'gpu' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
>             else if (descp->chip == CHIP_LS7A2000)
>                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     drivers/gpu/drm/loongson/lsdc_drv.c:235:7: note: uninitialized use occurs here
>             if (!gpu) {
>                  ^~~
>     drivers/gpu/drm/loongson/lsdc_drv.c:232:7: note: remove the 'if' if its condition is always true
>             else if (descp->chip == CHIP_LS7A2000)
>                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     drivers/gpu/drm/loongson/lsdc_drv.c:217:21: note: initialize the variable 'gpu' to silence this warning
>             struct pci_dev *gpu;
>                                ^
>                                 = NULL
>     1 warning generated.
> --

In practice,  either  descp->chip == CHIP_LS7A2000 or descp->chip == 
CHIP_LS7A1000 will be happened at runtime.

the variable 'gpu' is guaranteed to be initialized when code run at  
drivers/gpu/drm/loongson/lsdc_drv.c:235

This warnning is almost wrong here.

>>> drivers/gpu/drm/loongson/lsdc_pll.c:188:14: warning: variable 'diff' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
>                                     else if (clock_khz < computed)
>                                              ^~~~~~~~~~~~~~~~~~~~
>     drivers/gpu/drm/loongson/lsdc_pll.c:191:9: note: uninitialized use occurs here
>                                     if (diff < min) {
>                                         ^~~~
>     drivers/gpu/drm/loongson/lsdc_pll.c:188:10: note: remove the 'if' if its condition is always true
>                                     else if (clock_khz < computed)
>                                          ^~~~~~~~~~~~~~~~~~~~~~~~~
>     drivers/gpu/drm/loongson/lsdc_pll.c:177:22: note: initialize the variable 'diff' to silence this warning
>                                     unsigned int diff;
>                                                      ^
>                                                       = 0
>     1 warning generated.

Here the robot is also wrong here in practice,

because either  if (clock_khz >= computed) or else if (clock_khz < 
computed) will be happen.

'diff' variable is guaranteed to be initialized.

>
> vim +232 drivers/gpu/drm/loongson/lsdc_drv.c
>
>     212	
>     213	static int lsdc_get_dedicated_vram(struct lsdc_device *ldev,
>     214					   const struct lsdc_desc *descp)
>     215	{
>     216		struct drm_device *ddev = &ldev->base;
>     217		struct pci_dev *gpu;
>     218		resource_size_t base, size;
>     219	
>     220		/*
>     221		 * The GPU and display controller in LS7A1000/LS7A2000 are separated
>     222		 * PCIE devices, they are two devices not one. The DC does not has a
>     223		 * dedicate VRAM bar, because the BIOS engineer choose to assign the
>     224		 * VRAM to the GPU device. Sadly, after years application, this form
>     225		 * as a convention for loongson integrated graphics. Bar 2 of the GPU
>     226		 * device contain the base address and size of the VRAM, both the GPU
>     227		 * and the DC can access the on-board VRAM as long as the DMA address
>     228		 * emitted fall in [base, base + size).
>     229		 */
>     230		if (descp->chip == CHIP_LS7A1000)
>     231			gpu = pci_get_device(PCI_VENDOR_ID_LOONGSON, 0x7A15, NULL);
>   > 232		else if (descp->chip == CHIP_LS7A2000)
>     233			gpu = pci_get_device(PCI_VENDOR_ID_LOONGSON, 0x7A25, NULL);
>     234	
>     235		if (!gpu) {
>     236			drm_warn(ddev, "No GPU device found\n");
>     237			return -ENODEV;
>     238		}
>     239	
>     240		base = pci_resource_start(gpu, 2);
>     241		size = pci_resource_len(gpu, 2);
>     242	
>     243		ldev->vram_base = base;
>     244		ldev->vram_size = size;
>     245	
>     246		drm_info(ddev, "dedicated vram start: 0x%llx, size: %uMB\n",
>     247			 (u64)base, (u32)(size >> 20));
>     248	
>     249		return 0;
>     250	}
>     251	
>

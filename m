Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4345BDCE0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 08:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbiITGGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 02:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbiITGGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 02:06:13 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B73F857E1A
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 23:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=UhnHKNdkna3kYgyVIERHZw8kuBFjL0W08TGg52zD2EY=; b=mfTpugVGPSJhc94zeaHR7cJoTu
        tqNI6pi/iti3Gfg47rxfr1SUsXHiaUFJfR6AjLTgylCjVKqxeLAa/I4CLGLTdZ2VAcAyp02Z+L9tz
        nXnsrYGblYiHNwEgWhYydopT08mv/RYDjtKOhh7JRZIX9Fqa2ArzKgI9fh0K8E3M7z1MdODREqeZg
        nnM1NfvsxctP+vaXz/qkQxrV7iFoN/uNAuDJ+POXRR02BgnAB4PNPKXaHwTOw7dxO36VxRRVQiHfl
        ZPWFdUHE3MnYzxgSl49rkHUWmyWafNZQtGhIv8HLV54YSMt0zaHFEsFCfcox3hIQcZ/4aa/35/ZLu
        TJ0xqiHg==;
Received: from [2601:1c2:d80:3110::a2e7]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oaWMf-000rUl-Qj; Tue, 20 Sep 2022 06:04:15 +0000
Message-ID: <d369f23b-8c14-1d72-8d1c-2c3791a09b1b@infradead.org>
Date:   Mon, 19 Sep 2022 23:04:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: ERROR: modpost: "vmf_insert_pfn_prot"
 [drivers/gpu/drm/ttm/ttm.ko] undefined!
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>,
        Javier Martinez Canillas <javierm@redhat.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
References: <202209181951.Wdmac1wt-lkp@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <202209181951.Wdmac1wt-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/18/22 04:08, kernel test robot wrote:
> Hi Javier,
> 
> FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

On 2022-June-19 Javier said that he would merge my patch:

https://lore.kernel.org/dri-devel/5eabd169-b8a0-fb8f-d70b-4495d3790f05@redhat.com/

What's up, Javier?


> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   a335366bad1364a07f49df9da1fdfa6d411a5f39
> commit: a0f25a6bb319aa05e04dcf51707c97c2881b4f47 drm/hisilicon/hibmc: Allow to be built if COMPILE_TEST is enabled
> date:   8 months ago
> config: m68k-randconfig-r016-20220918 (https://download.01.org/0day-ci/archive/20220918/202209181951.Wdmac1wt-lkp@intel.com/config)
> compiler: m68k-linux-gcc (GCC) 12.1.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a0f25a6bb319aa05e04dcf51707c97c2881b4f47
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout a0f25a6bb319aa05e04dcf51707c97c2881b4f47
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>, old ones prefixed by <<):
> 
>>> ERROR: modpost: "vmf_insert_pfn_prot" [drivers/gpu/drm/ttm/ttm.ko] undefined!
> 
> Kconfig warnings: (for reference only)
>    WARNING: unmet direct dependencies detected for DRM_TTM
>    Depends on [n]: HAS_IOMEM [=y] && DRM [=m] && MMU [=n]
>    Selected by [m]:
>    - DRM_TTM_HELPER [=m] && HAS_IOMEM [=y] && DRM [=m]
>    - DRM_HISI_HIBMC [=m] && HAS_IOMEM [=y] && DRM [=m] && PCI [=y] && (ARM64 || COMPILE_TEST [=y])
> 

-- 
~Randy

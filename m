Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C17EF60DABF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 07:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232830AbiJZFt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 01:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbiJZFt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 01:49:26 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 200BAA4BB7
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 22:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:References:Cc:To:Subject:From:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=W0D/wNLNwB4FVFy/oXpbKCWClTLD5X4bNAE/sco/AwA=; b=ozLJGl5boMBQDde7jg4mdemheF
        BiFPw7n7LJy5+Mp5WY6cft/54Cht9w+6vWNBLZOZl98GXKPrGEemL0GaXj+8EPPtxhvFH/sUuMG1B
        E0PfUS/ywl8+2sBEsT/un7wrFTgBg8UImGS/17EP7LmdZkyOJw2SJY2Cbs2nyMYvOH74x78AzpqFy
        fRISUHyuUeW0laArhvypwxo+sGeIHDBxPSWrwg7iMUpbW71FOQw+O+R3mrXzmV7VmeKasxZP5QPKE
        X6/1MBT4g5wWTq3STn/2xe63x++BcJ8mlvdvCLo2KxqKjQ5i91Z0MuVJ3sdrkeqC1wQHU5JLXgbTJ
        WBZgxObQ==;
Received: from [2601:1c2:d80:3110::a2e7]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1onZHv-0082fO-R2; Wed, 26 Oct 2022 05:49:16 +0000
Message-ID: <caa1e514-1fa3-229c-3772-91357240d6f4@infradead.org>
Date:   Tue, 25 Oct 2022 22:49:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: Re: drivers/net/ethernet/renesas/rswitch.c:355:71: warning: left
 shift count >= width of type
To:     kernel test robot <lkp@intel.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
References: <202210222356.2lAehSmv-lkp@intel.com>
Content-Language: en-US
In-Reply-To: <202210222356.2lAehSmv-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi k.t.r.,

On 10/22/22 08:23, kernel test robot wrote:
> tree:   https://github.com/intel-lab-lkp/linux/commits/Yoshihiro-Shimoda/net-phy-marvell10g-Add-host-speed-setting-by-an-ethernet-driver/20221020-091402
> head:   54882d9015d6bc070075b3ab4eab5cf4d75cf56e
> commit: 77bfe15a20a8c80e2150e86970e1157acfca24f8 net: ethernet: renesas: Add Ethernet Switch driver
> date:   3 days ago
> config: parisc64-allyesconfig

The attached .config file does not contain "CONFIG_64BIT".
How did you generate it?

(more below)


> compiler: hppa-linux-gcc (GCC) 12.1.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/intel-lab-lkp/linux/commit/77bfe15a20a8c80e2150e86970e1157acfca24f8
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Yoshihiro-Shimoda/net-phy-marvell10g-Add-host-speed-setting-by-an-ethernet-driver/20221020-091402
>         git checkout 77bfe15a20a8c80e2150e86970e1157acfca24f8
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=parisc SHELL=/bin/bash drivers/media/platform/chips-media/ drivers/net/ethernet/renesas/ drivers/staging/vt6655/

For 64BIT parisc builds, it would be better to use
	ARCH=parisc64

See 805ce8614958: parisc: Allow CONFIG_64BIT with ARCH=parisc
and 3dcfb729b5f4: parisc: Make CONFIG_64BIT available for ARCH=parisc64 only

To use only ARCH=parisc, you must ensure that both PA8X00=y and 64BIT=y in the .config file.


> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
>    drivers/net/ethernet/renesas/rswitch.c: In function 'rswitch_ext_desc_get_dptr':
>>> drivers/net/ethernet/renesas/rswitch.c:355:71: warning: left shift count >= width of type [-Wshift-count-overflow]
>      355 |         return __le32_to_cpu(desc->dptrl) | (dma_addr_t)(desc->dptrh) << 32;
>          |                                                                       ^~
>    drivers/net/ethernet/renesas/rswitch.c: In function 'rswitch_ext_ts_desc_get_dptr':
>    drivers/net/ethernet/renesas/rswitch.c:367:71: warning: left shift count >= width of type [-Wshift-count-overflow]
>      367 |         return __le32_to_cpu(desc->dptrl) | (dma_addr_t)(desc->dptrh) << 32;
>          |                                                                       ^~
> 
> 
> vim +355 drivers/net/ethernet/renesas/rswitch.c
> 
>    352	
>    353	static dma_addr_t rswitch_ext_desc_get_dptr(struct rswitch_ext_desc *desc)
>    354	{
>  > 355		return __le32_to_cpu(desc->dptrl) | (dma_addr_t)(desc->dptrh) << 32;
>    356	}
>    357	
> 

-- 
~Randy

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B82646370AC
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 03:56:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbiKXC4W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 21:56:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiKXC4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 21:56:20 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 547ABC8C9F;
        Wed, 23 Nov 2022 18:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=e4KULWN+ZwfHIUE2sfuFtMqgfdF1EyMRrdnKcRnZMuw=; b=mNVi1D7v0ERTQoziOMxBZ94Nrc
        iGjXC4gZQMnAUFWj6Fq3tGXKhKyrqckwMbPl+os4yez501ZUG5SQm2dM6ES6DwTjWdYneAmyaOeJZ
        cxRd9o0nVAF24dz7jgaJ6WFqZweFeMMNXShZ1dnXL2HDOXiZf4wsc6c7ifohFD75/6n8wfydfoOeW
        XruJH1USc4/OAIpUFlx/PwarNZNd7mFLQ5sUxXfrQ3gpguYpsAfwv1n8RC1tgr/NuGgMUH2pPQxQb
        UMzvhVRVupcCdwtS0/KhVKGZDO1e5DZHVzLe/4WqaDXLRFGe1F1KWTYVwQwHQPt16eUeLiU3Hv5LD
        1nWVOHjg==;
Received: from [2601:1c2:d80:3110::a2e7]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oy2PO-0043N2-5M; Thu, 24 Nov 2022 02:56:14 +0000
Message-ID: <0a3648cd-4ff8-e72a-f7d1-72d34a7ff754@infradead.org>
Date:   Wed, 23 Nov 2022 18:56:13 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: ERROR: modpost: "__divsi3_table" [lib/lz4/lz4_compress.ko]
 undefined!
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>,
        Dinh Nguyen <dinguyen@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org,
        Michael Tretter <m.tretter@pengutronix.de>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
References: <202209201648.P4wwSNCv-lkp@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <202209201648.P4wwSNCv-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[adding NIOS2 maintainer]

On 9/20/22 01:33, kernel test robot wrote:
> Hi Randy,
> 
> First bad commit (maybe != root cause):

Yes, not related.

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   521a547ced6477c54b4b0cc206000406c221b4d6
> commit: 81e005842d0b8167c059553a1c29c36d8a7a9329 media: isl7998x: select V4L2_FWNODE to fix build error
> date:   3 months ago
> config: nios2-buildonly-randconfig-r001-20220919
> compiler: nios2-linux-gcc (GCC) 12.1.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=81e005842d0b8167c059553a1c29c36d8a7a9329
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 81e005842d0b8167c059553a1c29c36d8a7a9329
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=nios2 SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>, old ones prefixed by <<):
> 
>>> ERROR: modpost: "__divsi3_table" [lib/lz4/lz4_compress.ko] undefined!

Due to -O3 optimization in lib/lz4/Makefile:

# SPDX-License-Identifier: GPL-2.0-only
ccflags-y += -O3

obj-$(CONFIG_LZ4_COMPRESS) += lz4_compress.o
obj-$(CONFIG_LZ4HC_COMPRESS) += lz4hc_compress.o
obj-$(CONFIG_LZ4_DECOMPRESS) += lz4_decompress.o

It builds fine without -O3.
-- 
~Randy

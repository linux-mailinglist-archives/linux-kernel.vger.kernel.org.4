Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A29661A11B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 20:36:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbiKDTgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 15:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiKDTgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 15:36:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D28024086
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 12:36:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 259506231C
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 19:36:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEF6FC433C1;
        Fri,  4 Nov 2022 19:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667590601;
        bh=Z0bYXd1PXXR1duu7Os23/ytIJQhUy+2FFbwAjwuBUzg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=nKnmSOwP9XUZYxIDrLBkVtgFcefi1qR7q/4w8rAslbwljlbQTH+7WImdYzthLm0Xa
         17DZ2WLVysxGlcjShYeFp7utUCDLjYXhNDVh+iopmgywheX3kA+eAmRNBLDpZtGkG8
         6J+rp3lzMMBM/KAsjFbxWrDMN5zmS41DpGanZJxl6PncE/EhVWNBsPd5S6a8vITXfI
         JtPIrE+kqQlM8nMv5ebVHZcBApE3JyZqIj3WRhs8kQ28mD74rVic41urPf0OhLmMfr
         esbt20nMyTQcA1ajha4VZKVEvxw8BACOEp7pgFBgNMYkNXpKMNdKkYoaNJ3gv/sGTE
         tb+7pksHnci+Q==
Message-ID: <402e120a-044e-12ac-7d10-cf8b3b5a1404@kernel.org>
Date:   Fri, 4 Nov 2022 15:36:39 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: ld.lld: error: undefined symbol: gpmc_omap_onenand_set_timings
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>,
        Roger Quadros <rogerq@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <202211050325.XVtPvMvy-lkp@intel.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <202211050325.XVtPvMvy-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/11/2022 15:29, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   ee6050c8af96bba2f81e8b0793a1fc2f998fcd20
> commit: 854fd9209b20837ab48c2e6714e5e44dd8ea33a2 memory: omap-gpmc: Allow building as a module
> date:   6 months ago
> config: arm-buildonly-randconfig-r004-20221104
> compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 2bbafe04fe785a9469bea5a3737f8d7d3ce4aca2)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install arm cross compiling tool for clang build
>         # apt-get install binutils-arm-linux-gnueabi
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=854fd9209b20837ab48c2e6714e5e44dd8ea33a2
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 854fd9209b20837ab48c2e6714e5e44dd8ea33a2
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>

+Cc Miquel,

Hm, I am pretty sure we already fixed it... but it seems not. I think
this needs dependency in MTD_ONENAND_OMAP2 - one is module, second
cannot be built-in.

Best regards,
Krzysztof


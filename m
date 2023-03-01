Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3AD6A6802
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 08:12:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbjCAHMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 02:12:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjCAHMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 02:12:06 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F66738EB4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 23:12:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=hdNTK70vyyBrq0w0S9ZJjHUlMH0IfCFBmg7NwxHPVlU=; b=mCaV+2msOBq5zpAOA+3MMnBsLH
        BIuwsM1epv8llHmm6mOrnIbHF8/8XtBdtEMXmB1R1GbxGBHJAOsWqK+4DAB1lfUXCC7qcdXz2ZfS2
        gYrvl++C4D0NKN+vieh2Gw4xIek4cGRS6B7cVj4KdiJPLU+cXXq4LQF9zNlA/61U4o337eMFSOul5
        CQmhO5uvdPphpTcDx39HSmU/9Rg1KhKxazt8lAo+IWbgWFo0Ltawnnylnykn57fwoZnPNrdct8Ryi
        IZozjNoWnUpsMaFyNHigQ54I1bZtHOkQD6ukojiBC31NXdZbQLyEXvgTIQCG4C3oA3DZkw+hZL9Ms
        JKwXKhxQ==;
Received: from [2601:1c2:980:9ec0::df2f]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pXGd5-00FHtb-IS; Wed, 01 Mar 2023 07:11:59 +0000
Message-ID: <89ff97ff-310d-579a-63d4-84cf093482d5@infradead.org>
Date:   Tue, 28 Feb 2023 23:11:57 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: ERROR: modpost: "iounmap" [drivers/tty/ipwireless/ipwireless.ko]
 undefined!
Content-Language: en-US
To:     Yonghong Song <yhs@meta.com>, kernel test robot <lkp@intel.com>,
        Yonghong Song <yhs@fb.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>
References: <202303010701.KWYce0Mt-lkp@intel.com>
 <1f63f410-6bfc-7b59-7a7d-8fca323ada53@meta.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <1f63f410-6bfc-7b59-7a7d-8fca323ada53@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/28/23 23:05, Yonghong Song wrote:
> 
> 
> On 2/28/23 3:22 PM, kernel test robot wrote:
>> Hi Yonghong,
>>
>> First bad commit (maybe != root cause):
>>
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> head:   e492250d5252635b6c97d52eddf2792ec26f1ec1
>> commit: dffbbdc2d9889670c30e07d05fc0dd712e8ad430 libbpf: Add enum64 parsing and new enum64 public API
>> date:   9 months ago
>> config: s390-randconfig-r021-20230227 (https://download.01.org/0day-ci/archive/20230301/202303010701.KWYce0Mt-lkp@intel.com/config )
>> compiler: s390-linux-gcc (GCC) 12.1.0
>> reproduce (this is a W=1 build):
>>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross  -O ~/bin/make.cross
>>          chmod +x ~/bin/make.cross
>>          # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=dffbbdc2d9889670c30e07d05fc0dd712e8ad430
>>          git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>          git fetch --no-tags linus master
>>          git checkout dffbbdc2d9889670c30e07d05fc0dd712e8ad430
>>          # save the config file
>>          mkdir build_dir && cp config build_dir/.config
>>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=s390 olddefconfig
>>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash
> 
> I don't think the commit 'libbpf: Add enum64 parsing and new enum64 public API' is responsible for the test failure. That commit is purely userspace and should not be the reason for kernel module symbol undefined.
> 

CONFIG_HAS_IOMEM is not set. Happens often on ARCH=s390 when CONFIG_PCI is not set.

>>
>> If you fix the issue, kindly add following tag where applicable
>> | Reported-by: kernel test robot <lkp@intel.com>
>> | Link: https://lore.kernel.org/oe-kbuild-all/202303010701.KWYce0Mt-lkp@intel.com/
>>
>> All errors (new ones prefixed by >>, old ones prefixed by <<):
>>
>>>> ERROR: modpost: "iounmap" [drivers/tty/ipwireless/ipwireless.ko] undefined!
>>>> ERROR: modpost: "ioremap" [drivers/tty/ipwireless/ipwireless.ko] undefined!
>> ERROR: modpost: "ioremap" [drivers/net/arcnet/com90xx.ko] undefined!
>> ERROR: modpost: "iounmap" [drivers/net/arcnet/com90xx.ko] undefined!
>>>> ERROR: modpost: "iounmap" [drivers/pcmcia/pcmcia.ko] undefined!
>>>> ERROR: modpost: "ioremap" [drivers/pcmcia/pcmcia.ko] undefined!
>>

-- 
~Randy

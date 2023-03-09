Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99F9E6B1B1C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 07:09:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbjCIGJa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 01:09:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjCIGJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 01:09:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC01F80909;
        Wed,  8 Mar 2023 22:09:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6680A61A0A;
        Thu,  9 Mar 2023 06:09:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 141E3C433EF;
        Thu,  9 Mar 2023 06:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678342165;
        bh=fsLhHcjhO5MajeqhhNrUkIj89nd00dnJ8w3YBl4clAw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=hrIEBIkX5gxzeBg72m0QXHTSpFepipJm7bADK0SO0OqyWMSGdo6Lv4/ih+XqQJuXy
         wc/brZvytSdfqJhQxyLhn1XgTws0mpHbCq3In1/dx/++OeWGACN/ngYUVG4IQ7Uj/D
         Ox1aybG128qoxQoy0SFMSQtb3HQ9J/kncj1pK8TZXePQb2JafflXrZ7zP+BQvJN+wn
         d29p3GKgx3ZwSJaH8/qcXpHV+UVePk2K9ezoXqIOCKKFEYFf/2j5eF1x6a80jHcHms
         k35cM/0KniwHVcYKSAA41i3b/rN30Q9rtuSL3XMzVYujEAMNf2fHiGHB99gVldEHkP
         C1DAuf5pO/I4w==
Message-ID: <d4148245-fade-e228-6e61-f004f6cff249@kernel.org>
Date:   Thu, 9 Mar 2023 07:09:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v13 2/2] clk: clk-loongson2: add clock controller driver
 support
To:     zhuyinbo <zhuyinbo@loongson.cn>, kernel test robot <lkp@intel.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, Jianmin Lv <lvjianmin@loongson.cn>,
        Liu Peibao <liupeibao@loongson.cn>, wanghongliang@loongson.cn,
        loongson-kernel@lists.loongnix.cn
References: <20230307115022.12846-2-zhuyinbo@loongson.cn>
 <202303082037.QPfBP64A-lkp@intel.com>
 <b94ee1d2-b224-f9d5-3f3c-0096634f4c93@loongson.cn>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <b94ee1d2-b224-f9d5-3f3c-0096634f4c93@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/03/2023 03:58, zhuyinbo wrote:
> 
> 在 2023/3/8 下午8:16, kernel test robot 写道:
>> Hi Yinbo,
>>
>> I love your patch! Yet something to improve:
>>
>> [auto build test ERROR on clk/clk-next]
>> [also build test ERROR on robh/for-next linus/master v6.3-rc1 next-20230308]
>> [If your patch is applied to the wrong git tree, kindly drop us a note.
>> And when submitting patch, we suggest to use '--base' as documented in
>> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>>
>> url:    https://github.com/intel-lab-lkp/linux/commits/Yinbo-Zhu/clk-clk-loongson2-add-clock-controller-driver-support/20230307-195252
>> base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
>> patch link:    https://lore.kernel.org/r/20230307115022.12846-2-zhuyinbo%40loongson.cn
>> patch subject: [PATCH v13 2/2] clk: clk-loongson2: add clock controller driver support
>> config: mips-allyesconfig (https://download.01.org/0day-ci/archive/20230308/202303082037.QPfBP64A-lkp@intel.com/config)
>> compiler: mips-linux-gcc (GCC) 12.1.0
>> reproduce (this is a W=1 build):
>>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>          chmod +x ~/bin/make.cross
>>          # https://github.com/intel-lab-lkp/linux/commit/391d6fc63ac65f5456e4755c9dd85232a6296285
>>          git remote add linux-review https://github.com/intel-lab-lkp/linux
>>          git fetch --no-tags linux-review Yinbo-Zhu/clk-clk-loongson2-add-clock-controller-driver-support/20230307-195252
>>          git checkout 391d6fc63ac65f5456e4755c9dd85232a6296285
>>          # save the config file
>>          mkdir build_dir && cp config build_dir/.config
>>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=mips olddefconfig
>>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash drivers/
>>
>> If you fix the issue, kindly add following tag where applicable
>> | Reported-by: kernel test robot <lkp@intel.com>
>> | Link: https://lore.kernel.org/oe-kbuild-all/202303082037.QPfBP64A-lkp@intel.com/
>>
>> All errors (new ones prefixed by >>):
>>
>>     drivers/clk/clk-loongson2.c: In function 'loongson2_calc_pll_rate':
>>>> drivers/clk/clk-loongson2.c:79:15: error: implicit declaration of function 'readq'; did you mean 'readl'? [-Werror=implicit-function-declaration]
>>        79 |         val = readq(loongson2_pll_base + offset);
>>           |               ^~~~~
>>           |               readl
>>     cc1: some warnings being treated as errors
> 
> The CONFIG_64BIT not enabled in your config file, I will add a depend on 
> "CONFIG_64BIT" in my clock driver to fix this compile error.

No, that's not how it should be fixed. Fix your code instead.



Best regards,
Krzysztof


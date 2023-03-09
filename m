Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2527C6B1B74
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 07:28:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbjCIG14 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 01:27:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbjCIG1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 01:27:48 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3AB87D886A;
        Wed,  8 Mar 2023 22:27:41 -0800 (PST)
Received: from loongson.cn (unknown [10.20.42.35])
        by gateway (Coremail) with SMTP id _____8AxJIRcfAlkakMKAA--.13606S3;
        Thu, 09 Mar 2023 14:27:40 +0800 (CST)
Received: from [10.20.42.35] (unknown [10.20.42.35])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxPuRSfAlkbT1QAA--.39752S3;
        Thu, 09 Mar 2023 14:27:35 +0800 (CST)
Subject: Re: [PATCH v13 2/2] clk: clk-loongson2: add clock controller driver
 support
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        kernel test robot <lkp@intel.com>,
        Michael Turquette <mturquette@baylibre.com>,
        zhuyinbo@loongson.cn, Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, Jianmin Lv <lvjianmin@loongson.cn>,
        Liu Peibao <liupeibao@loongson.cn>, wanghongliang@loongson.cn,
        loongson-kernel@lists.loongnix.cn
References: <20230307115022.12846-2-zhuyinbo@loongson.cn>
 <202303082037.QPfBP64A-lkp@intel.com>
 <b94ee1d2-b224-f9d5-3f3c-0096634f4c93@loongson.cn>
 <a16ac33d-e313-2eeb-007d-20f61d670308@loongson.cn>
 <6180156d-109c-2f41-69ee-0a854dc3772e@kernel.org>
From:   zhuyinbo <zhuyinbo@loongson.cn>
Message-ID: <e51a23e5-ad69-d415-860f-3a9ab38bfbe9@loongson.cn>
Date:   Thu, 9 Mar 2023 14:27:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <6180156d-109c-2f41-69ee-0a854dc3772e@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8CxPuRSfAlkbT1QAA--.39752S3
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoWxCFWftF4DKF1kuw4rGFWxJFb_yoWrAry7pF
        48JFZFyryrXr10qrW8Kr1DWryYqr4DJ3WUXr1DGF1xZFZFvw1Ygr409r1jgr1DWrs3GrWU
        Jrn5XryxuF1UJrUanT9S1TB71UUUUjUqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bDAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64
        kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28E
        F7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAaw2AFwI0_Jrv_JF1le2I262IYc4CY
        6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrV
        C2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE
        7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487MxkF7I0En4kS14
        v26r126r1DMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_WwCFx2IqxVCFs4IE
        7xkEbVWUJVW8JwCFI7km07C267AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I
        0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAI
        cVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcV
        CF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07joKZXUUUUU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2023/3/9 下午2:09, Krzysztof Kozlowski 写道:
> On 09/03/2023 04:18, zhuyinbo wrote:
>> 在 2023/3/9 上午10:58, zhuyinbo 写道:
>>> 在 2023/3/8 下午8:16, kernel test robot 写道:
>>>> Hi Yinbo,
>>>>
>>>> I love your patch! Yet something to improve:
>>>>
>>>> [auto build test ERROR on clk/clk-next]
>>>> [also build test ERROR on robh/for-next linus/master v6.3-rc1
>>>> next-20230308]
>>>> [If your patch is applied to the wrong git tree, kindly drop us a note.
>>>> And when submitting patch, we suggest to use '--base' as documented in
>>>> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>>>>
>>>> url:
>>>> https://github.com/intel-lab-lkp/linux/commits/Yinbo-Zhu/clk-clk-loongson2-add-clock-controller-driver-support/20230307-195252
>>>> base: https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git
>>>> clk-next
>>>> patch link:
>>>> https://lore.kernel.org/r/20230307115022.12846-2-zhuyinbo%40loongson.cn
>>>> patch subject: [PATCH v13 2/2] clk: clk-loongson2: add clock
>>>> controller driver support
>>>> config: mips-allyesconfig
>>>> (https://download.01.org/0day-ci/archive/20230308/202303082037.QPfBP64A-lkp@intel.com/config)
>>>> compiler: mips-linux-gcc (GCC) 12.1.0
>>>> reproduce (this is a W=1 build):
>>>>           wget
>>>> https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross
>>>> -O ~/bin/make.cross
>>>>           chmod +x ~/bin/make.cross
>>>>           #
>>>> https://github.com/intel-lab-lkp/linux/commit/391d6fc63ac65f5456e4755c9dd85232a6296285
>>>>           git remote add linux-review
>>>> https://github.com/intel-lab-lkp/linux
>>>>           git fetch --no-tags linux-review
>>>> Yinbo-Zhu/clk-clk-loongson2-add-clock-controller-driver-support/20230307-195252
>>>>           git checkout 391d6fc63ac65f5456e4755c9dd85232a6296285
>>>>           # save the config file
>>>>           mkdir build_dir && cp config build_dir/.config
>>>>           COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0
>>>> make.cross W=1 O=build_dir ARCH=mips olddefconfig
>>>>           COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0
>>>> make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash drivers/
>>>>
>>>> If you fix the issue, kindly add following tag where applicable
>>>> | Reported-by: kernel test robot <lkp@intel.com>
>>>> | Link:
>>>> https://lore.kernel.org/oe-kbuild-all/202303082037.QPfBP64A-lkp@intel.com/
>>>>
>>>> All errors (new ones prefixed by >>):
>>>>
>>>>      drivers/clk/clk-loongson2.c: In function 'loongson2_calc_pll_rate':
>>>>>> drivers/clk/clk-loongson2.c:79:15: error: implicit declaration of
>>>>>> function 'readq'; did you mean 'readl'?
>>>>>> [-Werror=implicit-function-declaration]
>>>>         79 |         val = readq(loongson2_pll_base + offset);
>>>>            |               ^~~~~
>>>>            |               readl
>>>>      cc1: some warnings being treated as errors
>>> The CONFIG_64BIT not enabled in your config file, I will add a depend
>>> on "CONFIG_64BIT" in my clock driver to fix this compile error.
>> My clock is for LoongArch platform, The LOONGARCH had select
>> "CONFIG_64BIT", I will add a depend on "LOONGARCH" in my clock driver to
>> fix this compile error.
> No. Fix your code instead.

but the readq that ask CONFIG_64BIT is enabled,  definition in 
include/asm-generic/io.h

so need enable CONFIG_64BIT for my clk driver.


#ifdef CONFIG_64BIT
#ifndef readq
#define readq readq
static inline u64 readq(const volatile void __iomem *addr)
{
         u64 val;

         __io_br();
         val = __le64_to_cpu(__raw_readq(addr));
         __io_ar();
         return val;
}
#endif
#endif /* CONFIG_64BIT */

>
> Best regards,
> Krzysztof


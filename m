Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC0AE6E2E31
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 03:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbjDOBZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 21:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjDOBZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 21:25:51 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CEBF63A8E;
        Fri, 14 Apr 2023 18:25:49 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.35])
        by gateway (Coremail) with SMTP id _____8CxTNoc_Tlkz7UcAA--.33343S3;
        Sat, 15 Apr 2023 09:25:48 +0800 (CST)
Received: from [10.20.42.35] (unknown [10.20.42.35])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxAeUW_TlkQfklAA--.14224S3;
        Sat, 15 Apr 2023 09:25:46 +0800 (CST)
Subject: Re: [PATCH v7 1/2] dt-bindings: spi: add loongson spi
To:     kernel test robot <lkp@intel.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, Jianmin Lv <lvjianmin@loongson.cn>,
        wanghongliang@loongson.cn, zhuyinbo@loongson.cn,
        Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn
References: <20230412045152.4694-2-zhuyinbo@loongson.cn>
 <202304141851.mUss7Eyn-lkp@intel.com>
From:   zhuyinbo <zhuyinbo@loongson.cn>
Message-ID: <d6d21a3e-0d97-222a-f195-f1804067c37f@loongson.cn>
Date:   Sat, 15 Apr 2023 09:25:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <202304141851.mUss7Eyn-lkp@intel.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxAeUW_TlkQfklAA--.14224S3
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoW7Cw1kuryfZw48GF1kKw1xXwb_yoW8Cryrpa
        1ru3Z8Gr15Xr18Ka98K3Zrua1jgrZ8Xr13WayUuryUZa9Fva4kXrs2krW3ZrnFgF1qgFyx
        JFZ3urZYg3WkJa7anT9S1TB71UUUUjUqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bD8Fc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64
        kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28E
        F7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84
        ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r4UJwAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8I
        j28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2
        WlYx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkE
        bVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487MxkF7I0En4kS14v26r
        126r1DMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_WwCFx2IqxVCFs4IE7xkE
        bVWUJVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I0E74
        80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0
        I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04
        k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7Cj
        xVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jeksgUUUUU=
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



ÔÚ 2023/4/14 ÏÂÎç6:57, kernel test robot Ð´µÀ:
> Hi Yinbo,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on broonie-spi/for-next]
> [also build test WARNING on robh/for-next krzk-dt/for-next linus/master v6.3-rc6 next-20230413]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Yinbo-Zhu/dt-bindings-spi-add-loongson-spi/20230412-125222
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
> patch link:    https://lore.kernel.org/r/20230412045152.4694-2-zhuyinbo%40loongson.cn
> patch subject: [PATCH v7 1/2] dt-bindings: spi: add loongson spi
> reproduce:
>          # https://github.com/intel-lab-lkp/linux/commit/e230989729f1d1e10c49d1903a5c76a5b8b81f95
>          git remote add linux-review https://github.com/intel-lab-lkp/linux
>          git fetch --no-tags linux-review Yinbo-Zhu/dt-bindings-spi-add-loongson-spi/20230412-125222
>          git checkout e230989729f1d1e10c49d1903a5c76a5b8b81f95
>          make menuconfig
>          # enable CONFIG_COMPILE_TEST, CONFIG_WARN_MISSING_DOCUMENTS, CONFIG_WARN_ABI_ERRORS
>          make htmldocs
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Link: https://lore.kernel.org/oe-kbuild-all/202304141851.mUss7Eyn-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>>> Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/spi/loongson,ls-spi.yaml
I will rename this path to fixup this warning.
> 


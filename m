Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C42EF5BC2DC
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 08:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbiISGev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 02:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiISGer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 02:34:47 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2892055BA;
        Sun, 18 Sep 2022 23:34:44 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4MWFH26F6DzlBkt;
        Mon, 19 Sep 2022 14:33:02 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP2 (Coremail) with SMTP id Syh0CgA3inN+DShjOEtEBA--.3753S3;
        Mon, 19 Sep 2022 14:34:40 +0800 (CST)
Subject: Re: [PATCH -next 1/3] wbt: don't show valid wbt_lat_usec in sysfs
 while wbt is disabled
To:     kernel test robot <lkp@intel.com>,
        Yu Kuai <yukuai1@huaweicloud.com>, axboe@kernel.dk
Cc:     kbuild-all@lists.01.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20220919014939.175497-2-yukuai1@huaweicloud.com>
 <202209191232.Nwt56uMD-lkp@intel.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <5b70632c-325b-2eda-a819-13be013c42c9@huaweicloud.com>
Date:   Mon, 19 Sep 2022 14:34:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <202209191232.Nwt56uMD-lkp@intel.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgA3inN+DShjOEtEBA--.3753S3
X-Coremail-Antispam: 1UD129KBjvJXoW7ZF4kZrWkuw45Ww4rJFWxXrb_yoW8tw4kpa
        yUt343K34Iqr48WayxGay7Ww1Ygr4kJa4UJryUGw45Zayj9ry0qFn7KrWrWF9agr1vkFW3
        Xr4Y9F9Yqw15AaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
        IcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
        v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
        c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
        0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_
        Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbXdbU
        UUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

ÔÚ 2022/09/19 12:28, kernel test robot Ð´µÀ:
> Hi Yu,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on next-20220916]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Yu-Kuai/blk-wbt-simple-improvment-to-enable-wbt-correctly/20220919-094019
> base:    d5538ab91d3a9a237805be6f8c6c272af2987995
> config: parisc-randconfig-r021-20220919 (https://download.01.org/0day-ci/archive/20220919/202209191232.Nwt56uMD-lkp@intel.com/config)
> compiler: hppa-linux-gcc (GCC) 12.1.0
> reproduce (this is a W=1 build):
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # https://github.com/intel-lab-lkp/linux/commit/dd5a7be692b8fc9794f29648d0805a2d65b9c4de
>          git remote add linux-review https://github.com/intel-lab-lkp/linux
>          git fetch --no-tags linux-review Yu-Kuai/blk-wbt-simple-improvment-to-enable-wbt-correctly/20220919-094019
>          git checkout dd5a7be692b8fc9794f29648d0805a2d65b9c4de
>          # save the config file
>          mkdir build_dir && cp config build_dir/.config
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=parisc SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>     block/blk-sysfs.c: In function 'queue_wb_lat_show':
>>> block/blk-sysfs.c:475:15: error: implicit declaration of function 'wbt_disabled'; did you mean 'irqs_disabled'? [-Werror=implicit-function-declaration]
>       475 |         lat = wbt_disabled(q) ? 0 : div_u64(wbt_get_min_lat(q), 1000);
>           |               ^~~~~~~~~~~~
>           |               irqs_disabled
>     cc1: some warnings being treated as errors
> 

I forgot to provide a definition while config is disabled, I'll send a
new version to fix this.

Thanks,
Kuai
> 
> vim +475 block/blk-sysfs.c
> 
>     467	
>     468	static ssize_t queue_wb_lat_show(struct request_queue *q, char *page)
>     469	{
>     470		u64 lat;
>     471	
>     472		if (!wbt_rq_qos(q))
>     473			return -EINVAL;
>     474	
>   > 475		lat = wbt_disabled(q) ? 0 : div_u64(wbt_get_min_lat(q), 1000);
>     476	
>     477		return sprintf(page, "%llu\n", lat);
>     478	}
>     479	
> 


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47A606BCC51
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 11:18:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbjCPKSB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 06:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjCPKR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 06:17:59 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C4C32B7195;
        Thu, 16 Mar 2023 03:17:56 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.133])
        by gateway (Coremail) with SMTP id _____8AxUU_T7BJkleAMAA--.6963S3;
        Thu, 16 Mar 2023 18:17:55 +0800 (CST)
Received: from [10.20.42.133] (unknown [10.20.42.133])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8AxIL_O7BJkE_MBAA--.9498S3;
        Thu, 16 Mar 2023 18:17:50 +0800 (CST)
Message-ID: <b674a6ae-05bc-c6e3-7179-293741cbe510@loongson.cn>
Date:   Thu, 16 Mar 2023 18:17:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v7 2/2] drm: add kms driver for loongson display
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
Cc:     oe-kbuild-all@lists.linux.dev, linaro-mm-sig@lists.linaro.org,
        Li Yi <liyi@loongson.cn>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org
References: <20230315211550.2620818-3-15330273260@189.cn>
 <202303161727.8HnBf6cW-lkp@intel.com>
From:   Sui jingfeng <suijingfeng@loongson.cn>
In-Reply-To: <202303161727.8HnBf6cW-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8AxIL_O7BJkE_MBAA--.9498S3
X-CM-SenderInfo: xvxlyxpqjiv03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBjvJXoWxWw4DAFWkZw1UKF4rJr13Jwb_yoW5tr1kpa
        13Aa9IkrWrXr4UGFWkGa97u3Waqws5X34UXry3Gw1Yva42vFWqgrn2kFW5ursrKFnrKFW2
        yrZ3u3WkW3ZrZaDanT9S1TB71UUUUbJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bqxYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26F4UJVW0owAa
        w2AFwI0_Jw0_GFyle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44
        I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2
        jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62
        AI1cAE67vIY487MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCa
        FVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r4a6rW5MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2
        IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI
        42IY6xIIjxv20xvE14v26ryj6F1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42
        IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280
        aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0L0ePUUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/3/16 17:53, kernel test robot wrote:
> Hi Sui,
>
> I love your patch! Perhaps something to improve:
>
> [auto build test WARNING on drm-misc/drm-misc-next]
> [also build test WARNING on linus/master v6.3-rc2 next-20230316]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Sui-Jingfeng/MAINTAINERS-add-maintainers-for-DRM-LOONGSON-driver/20230316-051724
> base:   git://anongit.freedesktop.org/drm/drm-misc drm-misc-next
> patch link:    https://lore.kernel.org/r/20230315211550.2620818-3-15330273260%40189.cn
> patch subject: [PATCH v7 2/2] drm: add kms driver for loongson display controller
> config: arm-allmodconfig (https://download.01.org/0day-ci/archive/20230316/202303161727.8HnBf6cW-lkp@intel.com/config)
> compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
> reproduce (this is a W=1 build):
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # https://github.com/intel-lab-lkp/linux/commit/ba899dba3475b9612f212e3b1daedc3d9a299458
>          git remote add linux-review https://github.com/intel-lab-lkp/linux
>          git fetch --no-tags linux-review Sui-Jingfeng/MAINTAINERS-add-maintainers-for-DRM-LOONGSON-driver/20230316-051724
>          git checkout ba899dba3475b9612f212e3b1daedc3d9a299458
>          # save the config file
>          mkdir build_dir && cp config build_dir/.config
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm olddefconfig
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/gpu/drm/loongson/
>
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Link: https://lore.kernel.org/oe-kbuild-all/202303161727.8HnBf6cW-lkp@intel.com/
>
> All warnings (new ones prefixed by >>):
>
>     drivers/gpu/drm/loongson/lsdc_gem.c: In function 'lsdc_show_buffer_object':
>>> drivers/gpu/drm/loongson/lsdc_gem.c:280:51: warning: format '%lu' expects argument of type 'long unsigned int', but argument 4 has type 'size_t' {aka 'unsigned int'} [-Wformat=]
>       280 |                 seq_printf(m, "bo[%04u]: size: %8lukB %s\n",
>           |                                                ~~~^
>           |                                                   |
>           |                                                   long unsigned int
>           |                                                %8u
>       281 |                            i,
>       282 |                            lsdc_bo_size(tbo) >> 10,
>           |                            ~~~~~~~~~~~~~~~~~~~~~~~
>           |                                              |
>           |                                              size_t {aka unsigned int}
>
>
> vim +280 drivers/gpu/drm/loongson/lsdc_gem.c
>
>     264	
>     265	int lsdc_show_buffer_object(struct seq_file *m, void *arg)
>     266	{
>     267	#ifdef CONFIG_DEBUG_FS
>     268		struct drm_info_node *node = (struct drm_info_node *)m->private;
>     269		struct drm_device *ddev = node->minor->dev;
>     270		struct lsdc_device *ldev = to_lsdc(ddev);
>     271		struct lsdc_bo *lbo;
>     272		unsigned int i = 0;
>     273	
>     274		mutex_lock(&ldev->gem.mutex);
>     275	
>     276		list_for_each_entry(lbo, &ldev->gem.objects, list) {
>     277			struct ttm_buffer_object *tbo = &lbo->tbo;
>     278			struct ttm_resource *resource = tbo->resource;
>     279	
>   > 280			seq_printf(m, "bo[%04u]: size: %8lukB %s\n",
>
Hi,

Do i need fix this?


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62C9562809B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 14:07:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237857AbiKNNHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 08:07:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237864AbiKNNHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 08:07:17 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED5D2AE3B
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 05:07:15 -0800 (PST)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4N9qM25QrvzHvQq;
        Mon, 14 Nov 2022 21:06:22 +0800 (CST)
Received: from dggpeml500002.china.huawei.com (7.185.36.158) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 14 Nov 2022 21:06:51 +0800
Received: from [10.67.103.44] (10.67.103.44) by dggpeml500002.china.huawei.com
 (7.185.36.158) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 14 Nov
 2022 21:06:51 +0800
Subject: Re: [PATCH v12 1/2] drivers/coresight: Add UltraSoc System Memory
 Buffer driver
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        kernel test robot <lkp@intel.com>,
        <mathieu.poirier@linaro.org>, <mike.leach@linaro.org>,
        <leo.yan@linaro.org>, <jonathan.cameron@huawei.com>,
        <john.garry@huawei.com>
References: <20221109135008.9485-2-hejunhao3@huawei.com>
 <202211120623.aFVBerTp-lkp@intel.com>
 <a1343ef8-19f2-e3fc-35b7-02a989e093f5@arm.com>
CC:     <oe-kbuild-all@lists.linux.dev>, <coresight@lists.linaro.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <lpieralisi@kernel.org>,
        <linuxarm@huawei.com>, <liuqi115@huawei.com>,
        <f.fangjian@huawei.com>, <prime.zeng@hisilicon.com>
From:   hejunhao <hejunhao3@huawei.com>
Message-ID: <901ee9b4-f0b3-437e-fce9-be3c6c214afe@huawei.com>
Date:   Mon, 14 Nov 2022 21:06:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <a1343ef8-19f2-e3fc-35b7-02a989e093f5@arm.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.103.44]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500002.china.huawei.com (7.185.36.158)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/11/14 18:49, Suzuki K Poulose wrote:
> On 11/11/2022 22:06, kernel test robot wrote:
>> Hi Junhao,
>>
>> I love your patch! Perhaps something to improve:
>>
>> [auto build test WARNING on soc/for-next]
>> [also build test WARNING on linus/master v6.1-rc4 next-20221111]
>> [If your patch is applied to the wrong git tree, kindly drop us a note.
>> And when submitting patch, we suggest to use '--base' as documented in
>> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>>
>> url: 
>> https://github.com/intel-lab-lkp/linux/commits/Junhao-He/Add-support-for-UltraSoc-System-Memory-Buffer/20221109-215158
>> base: https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git 
>> for-next
>> patch link: 
>> https://lore.kernel.org/r/20221109135008.9485-2-hejunhao3%40huawei.com
>> patch subject: [PATCH v12 1/2] drivers/coresight: Add UltraSoc System 
>> Memory Buffer driver
>> config: arm64-randconfig-s033-20221111
>> compiler: aarch64-linux-gcc (GCC) 12.1.0
>> reproduce:
>>          wget 
>> https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross 
>> -O ~/bin/make.cross
>>          chmod +x ~/bin/make.cross
>>          # apt-get install sparse
>>          # sparse version: v0.6.4-39-gce1a6720-dirty
>>          # 
>> https://github.com/intel-lab-lkp/linux/commit/49ede03fd874b65deca5382ea84c3377188136da
>>          git remote add linux-review 
>> https://github.com/intel-lab-lkp/linux
>>          git fetch --no-tags linux-review 
>> Junhao-He/Add-support-for-UltraSoc-System-Memory-Buffer/20221109-215158
>>          git checkout 49ede03fd874b65deca5382ea84c3377188136da
>>          # save the config file
>>          mkdir build_dir && cp config build_dir/.config
>>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 
>> make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' 
>> O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/hwtracing/coresight/
>>
>> If you fix the issue, kindly add following tag where applicable
>> | Reported-by: kernel test robot <lkp@intel.com>
>>
>> sparse warnings: (new ones prefixed by >>)
>>>> drivers/hwtracing/coresight/ultrasoc-smb.c:113:33: sparse: sparse: 
>>>> cast removes address space '__iomem' of expression
>>>> drivers/hwtracing/coresight/ultrasoc-smb.c:354:17: sparse: sparse: 
>>>> incorrect type in argument 1 (different address spaces) @@     
>>>> expected void const * @@     got void [noderef] __iomem * @@
>>     drivers/hwtracing/coresight/ultrasoc-smb.c:354:17: sparse:     
>> expected void const *
>>     drivers/hwtracing/coresight/ultrasoc-smb.c:354:17: sparse:     
>> got void [noderef] __iomem *
>>>> drivers/hwtracing/coresight/ultrasoc-smb.c:354:17: sparse: sparse: 
>>>> incorrect type in argument 1 (different address spaces) @@     
>>>> expected void const * @@     got void [noderef] __iomem * @@
>>     drivers/hwtracing/coresight/ultrasoc-smb.c:354:17: sparse:     
>> expected void const *
>>     drivers/hwtracing/coresight/ultrasoc-smb.c:354:17: sparse:     
>> got void [noderef] __iomem *
>>     drivers/hwtracing/coresight/ultrasoc-smb.c:354:17: sparse: 
>> sparse: incorrect type in argument 2 (different address spaces) 
>> @@     expected void const * @@     got void [noderef] __iomem * @@
>>     drivers/hwtracing/coresight/ultrasoc-smb.c:354:17: sparse:     
>> expected void const *
>>     drivers/hwtracing/coresight/ultrasoc-smb.c:354:17: sparse:     
>> got void [noderef] __iomem *
>>>> drivers/hwtracing/coresight/ultrasoc-smb.c:463:14: sparse: sparse: 
>>>> incorrect type in assignment (different address spaces) @@     
>>>> expected void [noderef] __iomem *base @@     got void * @@
>>     drivers/hwtracing/coresight/ultrasoc-smb.c:463:14: sparse:     
>> expected void [noderef] __iomem *base
>>     drivers/hwtracing/coresight/ultrasoc-smb.c:463:14: sparse:     
>> got void *
>>
>> vim +/__iomem +113 drivers/hwtracing/coresight/ultrasoc-smb.c
>>
>>      89
>>      90    static ssize_t smb_read(struct file *file, char __user 
>> *data, size_t len,
>>      91                loff_t *ppos)
>>      92    {
>>      93        struct smb_drv_data *drvdata = 
>> container_of(file->private_data,
>>      94                        struct smb_drv_data, miscdev);
>>      95        struct smb_data_buffer *sdb = &drvdata->sdb;
>>      96        struct device *dev = &drvdata->csdev->dev;
>>      97        ssize_t to_copy = 0;
>>      98
>>      99        mutex_lock(&drvdata->mutex);
>>     100
>>     101        if (!sdb->data_size) {
>>     102            smb_update_data_size(drvdata);
>>     103            if (!sdb->data_size)
>>     104                goto out;
>>     105        }
>>     106
>>     107        to_copy = min(sdb->data_size, len);
>>     108
>>     109        /* Copy parts of trace data when read pointer wrap 
>> around SMB buffer */
>>     110        if (sdb->rd_offset + to_copy > sdb->buf_size)
>>     111            to_copy = sdb->buf_size - sdb->rd_offset;
>>     112
>>   > 113        if (copy_to_user(data, (void *)sdb->buf_base + 
>> sdb->rd_offset,
>>     114                 to_copy)) {
>>     115            dev_dbg(dev, "Failed to copy data to user\n");
>>     116            to_copy = -EFAULT;
>>     117            goto out;
>>     118        }
>>     119
>
> Please could we replace this with copy_to_user_fromio() ?
>
> Suzuki
>
> _______________________________________________
> CoreSight mailing list -- coresight@lists.linaro.org
> To unsubscribe send an email to coresight-leave@lists.linaro.org
> .
>
Hi Suzuki,

This is a cache memory,  due to improper use of "__iomem" , the sparse 
generates warnings.
I has fix it in v13.
https://lore.kernel.org/lkml/20221114090316.63157-2-hejunhao3@huawei.com/

Best regards,
Junhao.




Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F38C874D127
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 11:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231625AbjGJJNs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 05:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbjGJJNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 05:13:46 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D188FC3;
        Mon, 10 Jul 2023 02:13:44 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Qzywh4fXMz4f3pCP;
        Mon, 10 Jul 2023 17:13:40 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgAHcLPBy6tk6WiPNg--.31210S3;
        Mon, 10 Jul 2023 17:13:38 +0800 (CST)
Subject: Re: [linus:master] [scsi/sg] fcaa174a9c: blktests.scsi/002.fail
To:     kernel test robot <oliver.sang@intel.com>
Cc:     oe-lkp@lists.linux.dev, lkp@intel.com,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Christoph Hellwig <hch@lst.de>, linux-scsi@vger.kernel.org,
        "yukuai (C)" <yukuai3@huawei.com>
References: <202307101556.ea548e4f-oliver.sang@intel.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <0d557e70-5dd1-da9b-8e8d-6155c671a93d@huaweicloud.com>
Date:   Mon, 10 Jul 2023 17:13:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <202307101556.ea548e4f-oliver.sang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAHcLPBy6tk6WiPNg--.31210S3
X-Coremail-Antispam: 1UD129KBjvJXoWxXFy7KF1rXF15Gr1kGw48Zwb_yoWrGF43pa
        9xXw12kF40qw109rn2yF1DAFyYqa98JFy5CF47GF1rZayDCryDKrySy348ZF9aqr90g3yj
        y3Wqy347Cw18JaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UWE__UUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

在 2023/07/10 15:32, kernel test robot 写道:
> 
> hi, Yu Kuai,
> 
> we noticed this commit is to fix "modprobe: FATAL: Module scsi_debug is in use."
> issue, and we found it really does this work (below (1)).
> we also found after this fix, the failed case on parent (004/005/007) could
> pass now.
> however, the blktests.scsi/002 start to fail after this change.

I thnik this should be fixed by following patch:

https://lore.kernel.org/lkml/20230706125253.GA12842@lst.de/T/#m8f46592ad2b6f3f56a242eaf9f335e0e46c8f86f

Sorry for the trouble
Kuai

> 
> a42fb5a75ccc37df fcaa174a9c995cf0af3967e5564
> ---------------- ---------------------------
>         fail:runs  %reproduction    fail:runs
>             |             |             |
>            6:6         -100%            :6     stderr.modprobe:FATAL:Module_scsi_debug_is_in_use <-- (1)
>             :6          100%           6:6     blktests.scsi/002.fail
>             :6          100%           6:6     blktests.scsi/004.pass
>             :6          100%           6:6     blktests.scsi/005.pass
>             :6          100%           6:6     blktests.scsi/007.pass
> 
> below is the detail report FYI.
> 
> 
> Hello,
> 
> kernel test robot noticed "blktests.scsi/002.fail" on:
> 
> commit: fcaa174a9c995cf0af3967e55644a1543ea07e36 ("scsi/sg: don't grab scsi host module reference")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> [test failed on linus/master 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5]
> [test failed on linux-next/master 123212f53f3e394c1ae69a58c05dfdda56fec8c6]
> 
> in testcase: blktests
> version: blktests-x86_64-154e652-1_20230620
> with following parameters:
> 
> 	disk: 1HDD
> 	test: scsi-group-00
> 
> 
> 
> compiler: gcc-12
> test machine: 4 threads Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz (Skylake) with 32G memory
> 
> (please refer to attached dmesg/kmsg for entire log/backtrace)
> 
> 
> 
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202307101556.ea548e4f-oliver.sang@intel.com
> 
> 2023-07-09 23:41:29 sed "s:^:scsi/:" /lkp/benchmarks/blktests/tests/scsi-group-00
> 2023-07-09 23:41:30 ./check scsi/001 scsi/002 scsi/004 scsi/005 scsi/006 scsi/007
> scsi/001 => sdb1 (try triggering a kernel GPF with 0 byte SG reads)
> scsi/001 => sdb1 (try triggering a kernel GPF with 0 byte SG reads) [passed]
>      runtime    ...  10.158s
> scsi/002 => sdb1 (perfom a SG_DXFER_FROM_DEV from the /dev/sg read-write interface)
> scsi/002 => sdb1 (perfom a SG_DXFER_FROM_DEV from the /dev/sg read-write interface) [failed]
>      runtime    ...  0.087s
>      --- tests/scsi/002.out	2023-06-20 16:51:09.000000000 +0000
>      +++ /lkp/benchmarks/blktests/results/sdb1/scsi/002.out.bad	2023-07-09 23:41:42.308862573 +0000
>      @@ -1,3 +1,3 @@
>       Running scsi/002
>      -PASS
>      +open: Is a directory
>       Test complete
> scsi/004 (ensure repeated TASK SET FULL results in EIO on timing out command)
> scsi/004 (ensure repeated TASK SET FULL results in EIO on timing out command) [passed]
>      runtime    ...  2.826s
> scsi/005 (test SCSI device blacklisting)
> scsi/005 (test SCSI device blacklisting)                     [passed]
>      runtime    ...  9.988s
> scsi/006 => sdb1 (toggle SCSI cache type)
> scsi/006 => sdb1 (toggle SCSI cache type)                    [passed]
>      runtime    ...  0.144s
> scsi/007 (Trigger the SCSI error handler)
> scsi/007 (Trigger the SCSI error handler)                    [passed]
>      runtime    ...  15.426s
> 
> 
> 
> To reproduce:
> 
>          git clone https://github.com/intel/lkp-tests.git
>          cd lkp-tests
>          sudo bin/lkp install job.yaml           # job file is attached in this email
>          bin/lkp split-job --compatible job.yaml # generate the yaml file for lkp run
>          sudo bin/lkp run generated-yaml-file
> 
>          # if come across any failure that blocks the test,
>          # please remove ~/.lkp and /lkp dir to run from a clean state.
> 
> 
> 


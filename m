Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E009D6C4584
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 10:00:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbjCVJAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 05:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbjCVJAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 05:00:35 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84BE650713;
        Wed, 22 Mar 2023 02:00:33 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4PhMrD5XTgz4f3pNR;
        Wed, 22 Mar 2023 17:00:28 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP3 (Coremail) with SMTP id _Ch0CgBnFCKswxpknDNwFQ--.20657S3;
        Wed, 22 Mar 2023 17:00:30 +0800 (CST)
Subject: Re: [PATCH -next 1/6] Revert "md: unlock mddev before reap
 sync_thread in action_store"
To:     Guoqing Jiang <guoqing.jiang@linux.dev>,
        Yu Kuai <yukuai1@huaweicloud.com>, logang@deltatee.com,
        pmenzel@molgen.mpg.de, agk@redhat.com, snitzer@kernel.org,
        song@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com,
        Marc Smith <msmith626@gmail.com>,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20230322064122.2384589-1-yukuai1@huaweicloud.com>
 <20230322064122.2384589-2-yukuai1@huaweicloud.com>
 <2c2599ec-ac35-6494-aedf-93ecca1969ee@linux.dev>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <d1d27b2a-96ec-319e-4690-64e781c9a473@huaweicloud.com>
Date:   Wed, 22 Mar 2023 17:00:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <2c2599ec-ac35-6494-aedf-93ecca1969ee@linux.dev>
Content-Type: multipart/mixed;
 boundary="------------C5D4DC008D5862C2A9F5301B"
X-CM-TRANSID: _Ch0CgBnFCKswxpknDNwFQ--.20657S3
X-Coremail-Antispam: 1UD129KBjvJXoW3GF4rtr4rKF13Cr1ktr4Dtwb_yoW3ZF1rpr
        4fJry5CrW8Kr18JryUJw1kJryUCw1UZasrJr1xXFy7Jw15Gr12qryUXFyjgFyUJr4rZw17
        A3WUXay0vr1UGaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUmY14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wASzI0EjI02j7AqF2xKxwAqx4xG64xvF2IE
        w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMc
        vjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1l
        FcxC0VAYjxAxZF0Ex2IqxwACI402YVCY1x02628vn2kIc2xKxwCYjI0SjxkI62AI1cAE67
        vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
        wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc4
        0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
        xVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVW8JV
        WxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJr1l6VACY4xI67k04243AbIYCTnIWIev
        Ja73UjIFyTuYvjfUO9NVDUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=1.4 required=5.0 tests=KHOP_HELO_FCRDNS,MAY_BE_FORGED,
        NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------C5D4DC008D5862C2A9F5301B
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

在 2023/03/22 15:19, Guoqing Jiang 写道:
> 
> 
> On 3/22/23 14:41, Yu Kuai wrote:
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> This reverts commit 9dfbdafda3b34e262e43e786077bab8e476a89d1.
>>
>> Because it will introduce a defect that sync_thread can be running while
>> MD_RECOVERY_RUNNING is cleared, which will cause some unexpected 
>> problems,
>> for example:
>>
>> list_add corruption. prev->next should be next (ffff0001ac1daba0), but 
>> was ffff0000ce1a02a0. (prev=ffff0000ce1a02a0).
>> Call trace:
>>   __list_add_valid+0xfc/0x140
>>   insert_work+0x78/0x1a0
>>   __queue_work+0x500/0xcf4
>>   queue_work_on+0xe8/0x12c
>>   md_check_recovery+0xa34/0xf30
>>   raid10d+0xb8/0x900 [raid10]
>>   md_thread+0x16c/0x2cc
>>   kthread+0x1a4/0x1ec
>>   ret_from_fork+0x10/0x18
>>
>> This is because work is requeued while it's still inside workqueue:
> 
> If the workqueue subsystem can have such problem because of md flag,
> then I have to think workqueue is fragile.
> 
>> t1:            t2:
>> action_store
>>   mddev_lock
>>    if (mddev->sync_thread)
>>     mddev_unlock
>>     md_unregister_thread
>>     // first sync_thread is done
>>             md_check_recovery
>>              mddev_try_lock
>>              /*
>>               * once MD_RECOVERY_DONE is set, new sync_thread
>>               * can start.
>>               */
>>              set_bit(MD_RECOVERY_RUNNING, &mddev->recovery)
>>              INIT_WORK(&mddev->del_work, md_start_sync)
>>              queue_work(md_misc_wq, &mddev->del_work)
>>               test_and_set_bit(WORK_STRUCT_PENDING_BIT, ...)
> 
> Assume you mean below,
> 
> 1551 if(!test_and_set_bit(WORK_STRUCT_PENDING_BIT, work_data_bits(work))) {
> 1552                 __queue_work(cpu, wq, work);
> 1553                 ret = true;
> 1554         }
> 
> Could you explain how the same work can be re-queued? Isn't the PENDING_BIT
> is already set in t3? I believe queue_work shouldn't do that per the 
> comment
> but I am not expert ...

This is not related to workqueue, it is just because raid10
reinitialize the work that is already queued, like I discribed later
in t3:

t2:
md_check_recovery:
  INIT_WORK -> clear pending
  queue_work -> set pending
   list_add_tail
...

t3: -> work is still pending
md_check_recovery:
  INIT_WORK -> clear pending
  queue_work -> set pending
   list_add_tail -> list is corrupted

> 
> Returns %false if @work was already on a queue, %true otherwise.
> 
>>               // set pending bit
>>               insert_work
>>                list_add_tail
>>              mddev_unlock
>>     mddev_lock_nointr
>>     md_reap_sync_thread
>>     // MD_RECOVERY_RUNNING is cleared
>>   mddev_unlock
>>
>> t3:
>>
>> // before queued work started from t2
>> md_check_recovery
>>   // MD_RECOVERY_RUNNING is not set, a new sync_thread can be started
>>   INIT_WORK(&mddev->del_work, md_start_sync)
>>    work->data = 0
>>    // work pending bit is cleared
>>   queue_work(md_misc_wq, &mddev->del_work)
>>    insert_work
>>     list_add_tail
>>     // list is corrupted
>>
>> This patch revert the commit to fix the problem, the deadlock this
>> commit tries to fix will be fixed in following patches.
> 
> Pls cc the previous users who had encounter the problem to test the
> second patch.

Ok, cc Marc. Can you try if this patchset fix the problem you reproted
in the following thread?

md_raid: mdX_raid6 looping after sync_action "check" to "idle"
transition
> 
> And can you share your test which can trigger the re-queued issue?
> I'd like to try with latest mainline such as 6.3-rc3, and your test is
> not only run against 5.10 kernel as you described before, right?
> 

Of course, our 5.10 and mainline are the same,

there are some tests:

First the deadlock can be reporduced reliably, test script is simple:

mdadm -Cv /dev/md0 -n 4 -l10 /dev/sd[abcd]

fio -filename=/dev/md0 -rw=randwrite -direct=1 -name=a -bs=4k 
-numjobs=16 -iodepth=16 &

echo -1 > /sys/kernel/debug/fail_make_request/times
echo 1 > /sys/kernel/debug/fail_make_request/probability
echo 1 > /sys/block/sda/make-it-fail

{
         while true; do
                 mdadm -f /dev/md0 /dev/sda
                 mdadm -r /dev/md0 /dev/sda
                 mdadm --zero-superblock /dev/sda
                 mdadm -a /dev/md0 /dev/sda
                 sleep 2
         done
} &

{
         while true; do
                 mdadm -f /dev/md0 /dev/sdd
                 mdadm -r /dev/md0 /dev/sdd
                 mdadm --zero-superblock /dev/sdd
                 mdadm -a /dev/md0 /dev/sdd
                 sleep 10
         done
} &

{
         while true; do
                 echo frozen > /sys/block/md0/md/sync_action
                 echo idle > /sys/block/md0/md/sync_action
                 sleep 0.1
         done
} &

Then, the problem MD_RECOVERY_RUNNING can be cleared can't be reporduced
reliably, usually it takes 2+ days to triggered a problem, and each time
problem phenomenon can be different, I'm hacking the kernel and add
some BUG_ON to test MD_RECOVERY_RUNNING in attached patch, following
test can trigger the BUG_ON:

mdadm -Cv /dev/md0 -e1.0 -n 4 -l 10 /dev/sd{a..d} --run
sleep 5
echo 1 > /sys/module/md_mod/parameters/set_delay
echo idle > /sys/block/md0/md/sync_action &
sleep 5
echo "want_replacement" > /sys/block/md0/md/dev-sdd/state

test result:

[  228.390237] md_check_recovery: running is set
[  228.391376] md_check_recovery: queue new sync thread
[  233.671041] action_store unregister success! delay 10s
[  233.689276] md_check_recovery: running is set
[  238.722448] md_check_recovery: running is set
[  238.723328] md_check_recovery: queue new sync thread
[  238.724851] md_do_sync: before new wor, sleep 10s
[  239.725818] md_do_sync: delay done
[  243.674828] action_store delay done
[  243.700102] md_reap_sync_thread: running is cleared!
[  243.748703] ------------[ cut here ]------------
[  243.749656] kernel BUG at drivers/md/md.c:9084!
[  243.750548] invalid opcode: 0000 [#1] PREEMPT SMP
[  243.752028] CPU: 6 PID: 1495 Comm: md0_resync Not tainted 
6.3.0-rc1-next-20230310-00001-g4b3965bcb967-dirty #47
[  243.755030] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), 
BIOS ?-20190727_073836-buildvm-ppc64le-16.ppc.fedoraproject.org-3.fc31 
04/01/2014
[  243.758516] RIP: 0010:md_do_sync+0x16a9/0x1b00
[  243.759583] Code: ff 48 83 05 60 ce a7 0c 01 e9 8d f9 ff ff 48 83 05 
13 ce a7 0c 01 48 c7 c6 e9 e0 29 83 e9 3b f9 ff ff 48 83 05 5f d0 a7 0c 
01 <0f> 0b 48 83 05 5d d0 a7 0c 01 e8 f8 d5 0b0
[  243.763661] RSP: 0018:ffffc90003847d50 EFLAGS: 00010202
[  243.764212] RAX: 0000000000000028 RBX: ffff88817b529000 RCX: 
0000000000000000
[  243.764936] RDX: 0000000000000000 RSI: 0000000000000206 RDI: 
ffff888100040740
[  243.765648] RBP: 00000000002d6780 R08: 0101010101010101 R09: 
ffff888165671d80
[  243.766352] R10: ffffffff8ad6096c R11: ffff88816fcfa9f0 R12: 
0000000000000001
[  243.767066] R13: ffff888173920040 R14: ffff88817b529000 R15: 
0000000000187100
[  243.767781] FS:  0000000000000000(0000) GS:ffff888ffef80000(0000) 
knlGS:0000000000000000
[  243.768588] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  243.769172] CR2: 00005599effa8451 CR3: 00000001663e6000 CR4: 
00000000000006e0
[  243.769888] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
0000000000000000
[  243.770598] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 
0000000000000400
[  243.771300] Call Trace:
[  243.771555]  <TASK>
[  243.771779]  ? kvm_clock_read+0x14/0x30
[  243.772169]  ? kvm_sched_clock_read+0x9/0x20
[  243.772611]  ? sched_clock_cpu+0x21/0x330
[  243.773023]  md_thread+0x2ec/0x300
[  243.773373]  ? md_write_start+0x420/0x420
[  243.773845]  kthread+0x13e/0x1a0
[  243.774210]  ? kthread_exit+0x50/0x50
[  243.774591]  ret_from_fork+0x1f/0x30

> Thanks,
> Guoqing
> 
> .
> 

--------------C5D4DC008D5862C2A9F5301B
Content-Type: text/plain; charset=UTF-8;
 name="0001-echo-idle.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0001-echo-idle.patch"

RnJvbSAwZjgyYTkyOThkYjRiMzcxMTg2MzAyMmRjMDgwNWM5MDhkYjNiYjk4IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBMaSBOYW4gPGxpbmFuMTIyQGh1YXdlaS5jb20+CkRh
dGU6IE1vbiwgMjAgTWFyIDIwMjMgMTY6NTM6MDggKzA4MDAKU3ViamVjdDogW1BBVENIXSBl
Y2hvIGlkbGUKClNpZ25lZC1vZmYtYnk6IFl1IEt1YWkgPHl1a3VhaTNAaHVhd2VpLmNvbT4K
LS0tCiBkcml2ZXJzL21kL21kLmMgfCAyMSArKysrKysrKysrKysrKysrKysrKysKIDEgZmls
ZSBjaGFuZ2VkLCAyMSBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9tZC9t
ZC5jIGIvZHJpdmVycy9tZC9tZC5jCmluZGV4IDU0NmIxYjgxZWIyOC4uMTk2ODEwMDY3ZjI5
IDEwMDY0NAotLS0gYS9kcml2ZXJzL21kL21kLmMKKysrIGIvZHJpdmVycy9tZC9tZC5jCkBA
IC00NzUzLDYgKzQ3NTMsNyBAQCBhY3Rpb25fc2hvdyhzdHJ1Y3QgbWRkZXYgKm1kZGV2LCBj
aGFyICpwYWdlKQogCXJldHVybiBzcHJpbnRmKHBhZ2UsICIlc1xuIiwgdHlwZSk7CiB9CiAK
K3N0YXRpYyBib29sIHNldF9kZWxheSA9IGZhbHNlOwogc3RhdGljIHNzaXplX3QKIGFjdGlv
bl9zdG9yZShzdHJ1Y3QgbWRkZXYgKm1kZGV2LCBjb25zdCBjaGFyICpwYWdlLCBzaXplX3Qg
bGVuKQogewpAQCAtNDc3NSw2ICs0Nzc2LDExIEBAIGFjdGlvbl9zdG9yZShzdHJ1Y3QgbWRk
ZXYgKm1kZGV2LCBjb25zdCBjaGFyICpwYWdlLCBzaXplX3QgbGVuKQogCQkJCW1kZGV2X3Vu
bG9jayhtZGRldik7CiAJCQkJc2V0X2JpdChNRF9SRUNPVkVSWV9JTlRSLCAmbWRkZXYtPnJl
Y292ZXJ5KTsKIAkJCQltZF91bnJlZ2lzdGVyX3RocmVhZCgmbWRkZXYtPnN5bmNfdGhyZWFk
KTsKKwkJCQlpZiAoc2V0X2RlbGF5KSB7CisJCQkJCXByaW50aygiJXMgdW5yZWdpc3RlciBz
dWNjZXNzISBkZWxheSAxMHNcbiIsIF9fZnVuY19fKTsKKwkJCQkJbWRlbGF5KDEwMDAwKTsK
KwkJCQkJcHJpbnRrKCIlcyBkZWxheSBkb25lXG4iLCBfX2Z1bmNfXyk7CisJCQkJfQogCQkJ
CW1kZGV2X2xvY2tfbm9pbnRyKG1kZGV2KTsKIAkJCQkvKgogCQkJCSAqIHNldCBSRUNPVkVS
WV9JTlRSIGFnYWluIGFuZCByZXN0b3JlIHJlc2hhcGUKQEAgLTg3MDAsNiArODcwNiwxMyBA
QCB2b2lkIG1kX2RvX3N5bmMoc3RydWN0IG1kX3RocmVhZCAqdGhyZWFkKQogCXN0cnVjdCBi
bGtfcGx1ZyBwbHVnOwogCWludCByZXQ7CiAKKwlpZiAoc2V0X2RlbGF5KSB7CisJCXByaW50
aygiJXM6IGJlZm9yZSBuZXcgd29yLCBzbGVlcCAxMHNcbiIsIF9fZnVuY19fKTsKKwkJbWRl
bGF5KDEwMDApOworCQlwcmludGsoIiVzOiBkZWxheSBkb25lXG4iLCBfX2Z1bmNfXyk7CisJ
fQorCUJVR19PTighdGVzdF9iaXQoTURfUkVDT1ZFUllfUlVOTklORywgJm1kZGV2LT5yZWNv
dmVyeSkpOworCiAJLyoganVzdCBpbmNhc2UgdGhyZWFkIHJlc3RhcnRzLi4uICovCiAJaWYg
KHRlc3RfYml0KE1EX1JFQ09WRVJZX0RPTkUsICZtZGRldi0+cmVjb3ZlcnkpIHx8CiAJICAg
IHRlc3RfYml0KE1EX1JFQ09WRVJZX1dBSVQsICZtZGRldi0+cmVjb3ZlcnkpKQpAQCAtODg5
OSw2ICs4OTEyLDcgQEAgdm9pZCBtZF9kb19zeW5jKHN0cnVjdCBtZF90aHJlYWQgKnRocmVh
ZCkKIAogCQlza2lwcGVkID0gMDsKIAorCQlCVUdfT04oIXRlc3RfYml0KE1EX1JFQ09WRVJZ
X1JVTk5JTkcsICZtZGRldi0+cmVjb3ZlcnkpKTsKIAkJaWYgKCF0ZXN0X2JpdChNRF9SRUNP
VkVSWV9SRVNIQVBFLCAmbWRkZXYtPnJlY292ZXJ5KSAmJgogCQkgICAgKChtZGRldi0+Y3Vy
cl9yZXN5bmMgPiBtZGRldi0+Y3Vycl9yZXN5bmNfY29tcGxldGVkICYmCiAJCSAgICAgICht
ZGRldi0+Y3Vycl9yZXN5bmMgLSBtZGRldi0+Y3Vycl9yZXN5bmNfY29tcGxldGVkKQpAQCAt
OTA2Nyw2ICs5MDgxLDcgQEAgdm9pZCBtZF9kb19zeW5jKHN0cnVjdCBtZF90aHJlYWQgKnRo
cmVhZCkKIAkvKiBzZXQgQ0hBTkdFX1BFTkRJTkcgaGVyZSBzaW5jZSBtYXliZSBhbm90aGVy
IHVwZGF0ZSBpcyBuZWVkZWQsCiAJICogc28gb3RoZXIgbm9kZXMgYXJlIGluZm9ybWVkLiBJ
dCBzaG91bGQgYmUgaGFybWxlc3MgZm9yIG5vcm1hbAogCSAqIHJhaWQgKi8KKwlCVUdfT04o
IXRlc3RfYml0KE1EX1JFQ09WRVJZX1JVTk5JTkcsICZtZGRldi0+cmVjb3ZlcnkpKTsKIAlz
ZXRfbWFza19iaXRzKCZtZGRldi0+c2JfZmxhZ3MsIDAsCiAJCSAgICAgIEJJVChNRF9TQl9D
SEFOR0VfUEVORElORykgfCBCSVQoTURfU0JfQ0hBTkdFX0RFVlMpKTsKIApAQCAtOTM2MSw2
ICs5Mzc2LDcgQEAgdm9pZCBtZF9jaGVja19yZWNvdmVyeShzdHJ1Y3QgbWRkZXYgKm1kZGV2
KQogCQltZGRldi0+Y3Vycl9yZXN5bmNfY29tcGxldGVkID0gMDsKIAkJc3Bpbl9sb2NrKCZt
ZGRldi0+bG9jayk7CiAJCXNldF9iaXQoTURfUkVDT1ZFUllfUlVOTklORywgJm1kZGV2LT5y
ZWNvdmVyeSk7CisJCXByaW50aygiJXM6IHJ1bm5pbmcgaXMgc2V0XG4iLCBfX2Z1bmNfXyk7
CiAJCXNwaW5fdW5sb2NrKCZtZGRldi0+bG9jayk7CiAJCS8qIENsZWFyIHNvbWUgYml0cyB0
aGF0IGRvbid0IG1lYW4gYW55dGhpbmcsIGJ1dAogCQkgKiBtaWdodCBiZSBsZWZ0IHNldApA
QCAtOTQwNSw2ICs5NDIxLDkgQEAgdm9pZCBtZF9jaGVja19yZWNvdmVyeShzdHJ1Y3QgbWRk
ZXYgKm1kZGV2KQogCQkJCSAqLwogCQkJCW1kX2JpdG1hcF93cml0ZV9hbGwobWRkZXYtPmJp
dG1hcCk7CiAJCQl9CisKKwkJCXByaW50aygiJXM6IHF1ZXVlIG5ldyBzeW5jIHRocmVhZFxu
IiwgX19mdW5jX18pOworCQkJQlVHX09OKCF0ZXN0X2JpdChNRF9SRUNPVkVSWV9SVU5OSU5H
LCAmbWRkZXYtPnJlY292ZXJ5KSk7CiAJCQlJTklUX1dPUksoJm1kZGV2LT5kZWxfd29yaywg
bWRfc3RhcnRfc3luYyk7CiAJCQlxdWV1ZV93b3JrKG1kX21pc2Nfd3EsICZtZGRldi0+ZGVs
X3dvcmspOwogCQkJZ290byB1bmxvY2s7CkBAIC05NDYzLDYgKzk0ODIsNyBAQCB2b2lkIG1k
X3JlYXBfc3luY190aHJlYWQoc3RydWN0IG1kZGV2ICptZGRldikKIAlpZiAodGVzdF9hbmRf
Y2xlYXJfYml0KE1EX0NMVVNURVJfUkVTWU5DX0xPQ0tFRCwgJm1kZGV2LT5mbGFncykpCiAJ
CW1kX2NsdXN0ZXJfb3BzLT5yZXN5bmNfZmluaXNoKG1kZGV2KTsKIAljbGVhcl9iaXQoTURf
UkVDT1ZFUllfUlVOTklORywgJm1kZGV2LT5yZWNvdmVyeSk7CisJcHJpbnRrKCIlczogcnVu
bmluZyBpcyBjbGVhcmVkIVxuIiwgX19mdW5jX18pOwogCWNsZWFyX2JpdChNRF9SRUNPVkVS
WV9ET05FLCAmbWRkZXYtPnJlY292ZXJ5KTsKIAljbGVhcl9iaXQoTURfUkVDT1ZFUllfU1lO
QywgJm1kZGV2LT5yZWNvdmVyeSk7CiAJY2xlYXJfYml0KE1EX1JFQ09WRVJZX1JFU0hBUEUs
ICZtZGRldi0+cmVjb3ZlcnkpOwpAQCAtOTk1Niw2ICs5OTc2LDcgQEAgbW9kdWxlX3BhcmFt
X2NhbGwoc3RhcnRfcm8sIHNldF9ybywgZ2V0X3JvLCBOVUxMLCBTX0lSVVNSfFNfSVdVU1Ip
OwogbW9kdWxlX3BhcmFtKHN0YXJ0X2RpcnR5X2RlZ3JhZGVkLCBpbnQsIFNfSVJVR098U19J
V1VTUik7CiBtb2R1bGVfcGFyYW1fY2FsbChuZXdfYXJyYXksIGFkZF9uYW1lZF9hcnJheSwg
TlVMTCwgTlVMTCwgU19JV1VTUik7CiBtb2R1bGVfcGFyYW0oY3JlYXRlX29uX29wZW4sIGJv
b2wsIFNfSVJVU1J8U19JV1VTUik7Cittb2R1bGVfcGFyYW0oc2V0X2RlbGF5LCBib29sLCBT
X0lSVVNSfFNfSVdVU1IpOwogCiBNT0RVTEVfTElDRU5TRSgiR1BMIik7CiBNT0RVTEVfREVT
Q1JJUFRJT04oIk1EIFJBSUQgZnJhbWV3b3JrIik7Ci0tIAoyLjMxLjEKCg==
--------------C5D4DC008D5862C2A9F5301B--


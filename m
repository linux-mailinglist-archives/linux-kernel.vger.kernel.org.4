Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 076586E3394
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 22:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbjDOUhP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 16:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbjDOUhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 16:37:13 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 860E71BDA
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 13:37:10 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-3e699254ac4so8628041cf.1
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 13:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1681591029; x=1684183029;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t2a9ohFUrTNKxbAMdXdxcEvmxB5N2rxQmTBw9UNOtCw=;
        b=N9BWcPtn2YDusrc9wxcfjb90DrieYzrKXTKGMRv15mpl293f5w3NMDvIhOY09dRWJl
         3f2nNBE2E/KOId5ijJXTwcS/yeyB03IdkxjsspesfnOamFjAhCaCuvEpkCyab2qkJFjv
         t2QP3VDKAhk0frjCuNaS1S7mPobmKo4SbL6nbuzX2hg9TdDmHaqFxhIZdERKIFKIyWby
         7yZsztuvlBVJEumRGeR+GuH4HDqdh62kP0en6fOuz2vsuJAFMnNWdKqBi/y7xX4J7hnJ
         jII+CXiBGOhhyW3Ikr1KngF/4MQcSytBh9AOKpZZURwS8KM+O+pBaq9yBiYTbqV9VfHq
         AlCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681591029; x=1684183029;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t2a9ohFUrTNKxbAMdXdxcEvmxB5N2rxQmTBw9UNOtCw=;
        b=lrMG99BRxWQBtkFyBDPXax1yBYL2T064SXEs6/65ZrPakLFujhG3NLnHZS/Aqm329a
         KYEh/Exin1dyH2cnxvojUMQDtcUp8mIEPWjHQqXBB5EeP8LpBhMsG4Bs/km9vpwOEhFc
         NCs6NW+noAElO+ireTlNKmqZmdUmuWNsqlKrsKy2X9LTwh+Low8zEuFYp3XkFGJDAw4d
         0Ee/KDB54w2Y04QOj/i2gBmFyK8g+dXxthsnR/fvDqOjYRS5qNH5pj2xU7kWQOeRvmfu
         Hrca50FTyQLxCu1slAIu92fFawySQWC5wiPSu3LDHGeAR0GZUFWhH7y4E89TJQXSpw3T
         j1kg==
X-Gm-Message-State: AAQBX9fFp37HlFvGCFFpvm/SSip28BAU5cNCOY9g/EDAu+mnHGYyNqn8
        EEEZ724XWz0XLzHHSdUD153odg==
X-Google-Smtp-Source: AKy350ZS+YdnXW5h4FYvEi92oULU6xuIAcEuSpQwjjuQzlpQIpCyHzGWnUDv+vgZN6xJ8flOyLzEpQ==
X-Received: by 2002:a05:6214:3011:b0:5ef:5132:7ad7 with SMTP id ke17-20020a056214301100b005ef51327ad7mr9923443qvb.2.1681591029430;
        Sat, 15 Apr 2023 13:37:09 -0700 (PDT)
Received: from [172.19.131.144] ([216.250.210.6])
        by smtp.gmail.com with ESMTPSA id l15-20020a05620a0c0f00b0074c658aadf1sm701544qki.41.2023.04.15.13.37.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Apr 2023 13:37:09 -0700 (PDT)
Message-ID: <e8bc6158-86b2-18e5-efea-c165e2a3f196@kernel.dk>
Date:   Sat, 15 Apr 2023 14:37:04 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: linux-next: Tree for Apr 13
Content-Language: en-US
To:     Ayush Jain <ayush.jain3@amd.com>, broonie@kernel.org,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Santosh.Shukla@amd.com, Kalpana.Shetty@amd.com,
        Narasimhan V <Narasimhan.V@amd.com>, sfr@canb.auug.org.au,
        David Howells <dhowells@redhat.com>
References: <20230413182542.1133335-1-broonie@kernel.org>
 <0c6b661c-f7ff-cf12-b7f0-00b6b2f1317b@amd.com>
 <3c4b9025-2667-ca8c-7427-502068b8168e@amd.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <3c4b9025-2667-ca8c-7427-502068b8168e@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding David, who did the splice changes. Always a good idea to CC the
person(s) involved.

On 4/14/23 1:25 AM, Ayush Jain wrote:
> Hello,
> 
> On 4/14/2023 10:41 AM, Jain, Ayush wrote:
>> Hello Broonie,
>>
>> When Running fio-test on latest linux-next tree, I noticed that test hung indefinitely, Going back I see that this problem exists since
>> next-20230316 release, After bisecting I landed on the following merge commit by Jens.
>>
>> Commit   097d3ca138f9 ("Merge branch 'for-6.4/splice' into for-next")
>>
>> Running perf I see following trace and call-stack for fio:
>>
>>   Overhead  Command  Shared Object     Symbol
>>     25.08%  fio      [kernel.vmlinux]  [k] copy_user_generic_string
>>        copy_user_generic_string
>>        __do_splice
>>        __x64_sys_splice
>>        do_syscall_64
>>        entry_SYSCALL_64_after_hwframe
>>        splice
>>        0x1c44be0
>>    ...
>>
>> On a good kernel I see the following perf trace:
>>
>>    Overhead  Command  Shared Object     Symbol
>>      49.93%  fio      fio               [.] fio_crc32
>>       7.23%  fio      fio               [.] clock_thread_fn
>>       2.10%  fio      [kernel.vmlinux]  [k] clear_page_rep
>>       1.55%  fio      fio               [.] __fill_random_buf
>>       1.35%  fio      [kernel.vmlinux]  [k] loop_queue_rq
>>       1.05%  fio      [kernel.vmlinux]  [k] copy_user_generic_string
>>       ...
>>
>> I see some splice changes being added as the part of merge
>> https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/log/?h=for-6.4/splice
>>
>> I observe this problem on 3 EPYC system(Zen1,3,4), with the following disk architecture
>>
>> Zen1: nvme0n1   931.5G Samsung SSD 970 EVO Plus 1TB
>> Zen4: nvme0n1   232.9G Samsung SSD 960 EVO 250GB
>>
>> I am running fio as follows:
>>
>>     $fio fio-simple.job --filename=/dev/test_vg/test_lv
>>
>> where test_lv is mounted as follows:
>>
>> NAME                           MAJ:MIN RM   SIZE RO TYPE  MOUNTPOINTS
>> loop0                            7:0    0  12.2G  0 loop
>> └─md127                          9:127  0  12.2G  0 raid0
>>     └─test_vg-test_lv            253:3    0   5.5G  0 lvm
>>
>> You can find fio-simple.job at
>> https://github.com/avocado-framework-tests/avocado-misc-tests/blob/master/io/disk/fiotest.py.data/fio-simple.job
>>
>> Fio Version: fio-3.34-25-g07ed
>>
> Also adding to these observations
> 
> -If we create a filesystem on the raw disk -- Test completes with a Pass
> 
> -If there is no Filesystem on the raw disk(loop, nvme) -- Test hangs with the provided trace
> 
>>
>> Regards
>> Ayush Jain
>> > On 4/13/2023 11:55 PM, broonie@kernel.org wrote:
>>> Hi all,
>>>
>>> Changes since 20230411:
>>>
>>> The sh tree gained a conflict with the mm-unstable tree.
>>>
>>> The erofs tree gained a conflict with the vfs-idmapping tree.
>>>
>>> The ext4 tree gained multiple conflicts with the mm-stable tree.
>>>
>>> The net-next tree gained a conflict with the origin tree.
>>>
>>> The bpf-next tree gained a conflict with the net-net tree.
>>>
>>> Non-merge commits (relative to Linus' tree): 10382
>>>   11028 files changed, 580165 insertions(+), 249563 deletions(-)
>>>
>>> ----------------------------------------------------------------------------
>>>
>>> I have created today's linux-next tree at
>>> git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
>>> (patches at http://www.kernel.org/pub/linux/kernel/next/ ).  If you
>>> are tracking the linux-next tree using git, you should not use "git pull"
>>> to do so as that will try to merge the new linux-next release with the
>>> old one.  You should use "git fetch" and checkout or reset to the new
>>> master.
>>>
>>> You can see which trees have been included by looking in the Next/Trees
>>> file in the source.  There is also the merge.log file in the Next
>>> directory.  Between each merge, the tree was built with a ppc64_defconfig
>>> for powerpc, an allmodconfig for x86_64, a multi_v7_defconfig for arm
>>> and a native build of tools/perf. After the final fixups (if any), I do
>>> an x86_64 modules_install followed by builds for x86_64 allnoconfig,
>>> powerpc allnoconfig (32 and 64 bit), ppc44x_defconfig, allyesconfig
>>> and pseries_le_defconfig and i386, arm64, s390, sparc and sparc64
>>> defconfig and htmldocs. And finally, a simple boot test of the powerpc
>>> pseries_le_defconfig kernel in qemu (with and without kvm enabled).
>>>
>>> Below is a summary of the state of the merge.
>>>
>>> I am currently merging 357 trees (counting Linus' and 102 trees of bug
>>> fix patches pending for the current merge release).
>>>
>>> Stats about the size of the tree over time can be seen at
>>> http://neuling.org/linux-next-size.html .
>>>
>>> Status of my local build tests will be at
>>> http://kisskb.ellerman.id.au/linux-next .  If maintainers want to give
>>> advice about cross compilers/configs that work, we are always open to add
>>> more builds.
>>>
>>> Thanks to Randy Dunlap for doing many randconfig builds.  And to Paul
>>> Gortmaker for triage and bug fixes.
>>
> 
> Regards,
> Ayush Jain

-- 
Jens Axboe



Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5417761E83E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 02:25:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbiKGBZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 20:25:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbiKGBZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 20:25:50 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE816146
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 17:25:49 -0800 (PST)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4N5D7n3nWHzRnsC;
        Mon,  7 Nov 2022 09:25:41 +0800 (CST)
Received: from [10.67.110.108] (10.67.110.108) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 7 Nov 2022 09:25:46 +0800
Message-ID: <f9f15780-7fdb-f4eb-cdca-e666fd4686a5@huawei.com>
Date:   Mon, 7 Nov 2022 09:25:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH -next v2] checkpatch: Add check for array allocator family
 argument order
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
CC:     <apw@canonical.com>, <joe@perches.com>, <dwaipayanray1@gmail.com>,
        <linux-kernel@vger.kernel.org>, <bagasdotme@gmail.com>,
        <pbonzini@redhat.com>
References: <20221104070523.60296-1-liaochang1@huawei.com>
 <CAKXUXMxi_aqnvCmYjakQzoYvYqqwrvMnFt-czLV1iUnO0TnScg@mail.gmail.com>
From:   "liaochang (A)" <liaochang1@huawei.com>
In-Reply-To: <CAKXUXMxi_aqnvCmYjakQzoYvYqqwrvMnFt-czLV1iUnO0TnScg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.108]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/11/4 16:35, Lukas Bulwahn 写道:
> On Fri, Nov 4, 2022 at 8:08 AM Liao Chang <liaochang1@huawei.com> wrote:
>>
>> These array allocator family are sometimes misused with the first and
>> second arguments switchted.
> 
> Just a nit:
> 
> s/switchted/switched/
> 
> But probably you actually mean "swapped". I think there is a slight
> difference between the two words, "switched" and "swapped". And here
> the arguments are swapped. Note: I am also not a native speaker.
> 
> For the implementation change:
> 
> Acked-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> 
> How many new findings are now identified with this extended check on
> linux-next? Could you run checkpatch on all files of linux-next and
> share the new findings? Then we can do a quick scan if some instances
> should be immediately fixed or some janitor should follow through with
> such a task.

The scan result for v6.1-rc3:

./kernel/watch_queue.c:276:     pages = kcalloc(sizeof(struct page *), nr_pages, GFP_KERNEL);
./virt/kvm/kvm_main.c:411:              mc->objects = kvmalloc_array(sizeof(void *), capacity, gfp);
./tools/objtool/check.c:288:    struct cfi_state *cfi = calloc(sizeof(struct cfi_state), 1);
./tools/objtool/check.c:517:    file->pv_ops = calloc(sizeof(struct pv_state), nr);
./kernel/bpf/bpf_local_storage.c:623:   smap->buckets = kvcalloc(sizeof(*smap->buckets), nbuckets,
./tools/perf/builtin-record.c:4076:             rec->switch_output.filenames = calloc(sizeof(char *),
./fs/btrfs/send.c:7913: sctx->clone_roots = kvcalloc(sizeof(*sctx->clone_roots),
./drivers/scsi/bfa/bfad_bsg.c:3247:     buf_base = kcalloc(sizeof(struct bfad_buf_info) +
./sound/core/seq/seq_memory.c:379:      cellptr = kvmalloc_array(sizeof(struct snd_seq_event_cell), pool->size,
./tools/lib/bpf/libbpf.c:8220:  gen = calloc(sizeof(*gen), 1);
./tools/perf/util/metricgroup.c:269:    metric_events = calloc(sizeof(void *), ids_size + 1);
./tools/perf/util/hist.c:492:           he->res_samples = calloc(sizeof(struct res_sample),
./tools/perf/util/bpf-loader.c:574:     priv = calloc(sizeof(*priv), 1);
./tools/perf/util/synthetic-events.c:1040:      synthesize_threads = calloc(sizeof(pthread_t), thread_nr);
./tools/perf/util/synthetic-events.c:1044:      args = calloc(sizeof(*args), thread_nr);
./tools/perf/util/stat-shadow.c:390:                    metric_events = calloc(sizeof(struct evsel *),
./drivers/soc/fsl/dpio/dpio-service.c:526:      ed = kcalloc(sizeof(struct qbman_eq_desc), 32, GFP_KERNEL);
./drivers/gpu/drm/nouveau/nouveau_svm.c:1000:   buffer->fault = kvcalloc(sizeof(*buffer->fault), buffer->entries, GFP_KERNEL);
./tools/testing/selftests/memfd/fuse_test.c:257:        zero = calloc(sizeof(*zero), mfd_def_size);
./tools/testing/selftests/bpf/test_progs.c:1324:        dispatcher_threads = calloc(sizeof(pthread_t), env.workers);
./tools/testing/selftests/bpf/test_progs.c:1325:        data = calloc(sizeof(struct dispatch_data), env.workers);
./tools/testing/selftests/bpf/test_progs.c:1327:        env.worker_current_test = calloc(sizeof(int), env.workers);
./tools/testing/selftests/bpf/test_progs.c:1642:                env.worker_pids = calloc(sizeof(__pid_t), env.workers);
./tools/testing/selftests/bpf/test_progs.c:1643:                env.worker_socks = calloc(sizeof(int), env.workers);
./tools/testing/selftests/arm64/fp/fp-stress.c:458:     children = calloc(sizeof(*children), tests);
./tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c:87:    link = calloc(sizeof(struct bpf_link *), prog_cnt);
./tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c:91:    prog = calloc(sizeof(struct bpf_program *), prog_cnt);

> 
> Lukas
> 
>>
>> Same issue with calloc, kvcalloc, kvmalloc_array etc.
>>
>> Bleat if sizeof is the first argument.
>>
>> Link: https://lore.kernel.org/lkml/5374345c-7973-6a3c-d559-73bf4ac15079@redhat.com/
>> Signed-off-by: Liao Chang <liaochang1@huawei.com>
>> Acked-by: Joe Perches <joe@perches.com>
>> ---
>> v2:
>> 1. Acked-by Joe Perches.
>> 2. Use lore links in Link tag.
>>
>> ---
>>  scripts/checkpatch.pl | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
>> index 1e5e66ae5a52..a9a9dc277cff 100755
>> --- a/scripts/checkpatch.pl
>> +++ b/scripts/checkpatch.pl
>> @@ -7128,7 +7128,7 @@ sub process {
>>                 }
>>
>>  # check for alloc argument mismatch
>> -               if ($line =~ /\b((?:devm_)?(?:kcalloc|kmalloc_array))\s*\(\s*sizeof\b/) {
>> +               if ($line =~ /\b((?:devm_)?((?:k|kv)?(calloc|malloc_array)(?:_node)?))\s*\(\s*sizeof\b/) {
>>                         WARN("ALLOC_ARRAY_ARGS",
>>                              "$1 uses number as first arg, sizeof is generally wrong\n" . $herecurr);
>>                 }
>> --
>> 2.17.1
>>
> .

-- 
BR,
Liao, Chang

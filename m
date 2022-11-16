Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63C5662BA40
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 11:54:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233837AbiKPKyk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 05:54:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238982AbiKPKyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 05:54:13 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E57BA57B6E
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 02:42:52 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id k22so17107474pfd.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 02:42:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8IZk7RFB/O0n6+ohiEZqm4bGa6TBsDufCMHvOUDpZ14=;
        b=QsHxxs+b2C1EcCEQ+K67j1KjF8teWsx5PrWPJe0u6dz3PfTwKHk3SvlWVOD2bBM/oj
         4EqQPF9omOyfR3cSrXyHrMIrJHjUpdMptbkXM28DXQtZ83xbt9r1CK8NIvnLvuFQSN3A
         /wvvg6pqY3/IXoglZMpQmJWKMRS7xPc6RHhvMlE1m51OUJf0SPn5HN27BGKYQ4bc1DgN
         AwQi2VKCpOzcM1QUONBUgY2zs7nLOtlpa2dAo5AIwBNUD118odGN5OSih62QE4iLlDsu
         +DDTicOKl8g/FVTkDiHeSAOaJq3rnSFEDMidBNI4wkQ2HLmimqlz82pT7KlBLb1OAalD
         3BQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8IZk7RFB/O0n6+ohiEZqm4bGa6TBsDufCMHvOUDpZ14=;
        b=0ryai72rQwcxx6ArxrkKKSBfLxYwuh5m5W0DPXgqS9g5TnlSGXBZy+Ni5vau0Q38GG
         +rrwZcHGZcQ/XT3WsUDiCGuwY3IESmgGJfIEy9g9ZTHZQo7HxPbVR+x177vUzR7cQ1fp
         oD1jrOQIhzRLAlKFi0UYqAzMxiW4t54I6Xou2R6+t6PV1hy4IDpPSMTsCKbygzzn8/SK
         jUJ5TC5Mi9OLHGDfFeRYo7JU+VFUe8sZZ7xcwPgBNqWpDG/aGBSqmW80MfaiBddRB+Ge
         oalrcIqrtLpBn/fR4O9lpRDzd24W9YTxqcJXRRQcCSTdVEtmcLrEL6//KHSLXdOf5HBK
         s1ZQ==
X-Gm-Message-State: ANoB5pktljLRz6sufhoZHpnt8VB9k52iZ830ivIUqOwtCb8uDO6X5YSh
        GNKNlBFIOvtQaFLSuzYo4RMWzQ==
X-Google-Smtp-Source: AA0mqf5Jgr0HdjgkZCndO34qAyqz/+JiwQKtEpmdp5jdjcO6IS4mcZDzpsPlQLEKwysLJwywEbWBRw==
X-Received: by 2002:a62:19cf:0:b0:565:af12:c329 with SMTP id 198-20020a6219cf000000b00565af12c329mr22594529pfz.48.1668595372213;
        Wed, 16 Nov 2022 02:42:52 -0800 (PST)
Received: from [10.87.52.26] ([139.177.225.241])
        by smtp.gmail.com with ESMTPSA id c6-20020a170902c1c600b00186616b8fbasm11841750plc.10.2022.11.16.02.42.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Nov 2022 02:42:51 -0800 (PST)
Message-ID: <d4606a20-b92b-495f-4b76-a4633cf805c7@bytedance.com>
Date:   Wed, 16 Nov 2022 18:42:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [PATCH v6 1/4] lib: objpool added: ring-array based lockless MPMC
 queue
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     davem@davemloft.net, anil.s.keshavamurthy@intel.com,
        naveen.n.rao@linux.ibm.com, rostedt@goodmis.org,
        peterz@infradead.org, akpm@linux-foundation.org,
        sander@svanheule.net, ebiggers@google.com,
        dan.j.williams@intel.com, jpoimboe@kernel.org,
        linux-kernel@vger.kernel.org, lkp@intel.com, mattwu@163.com
References: <20221102023012.6362-1-wuqiang.matt@bytedance.com>
 <20221108071443.258794-1-wuqiang.matt@bytedance.com>
 <20221108071443.258794-2-wuqiang.matt@bytedance.com>
 <20221115005409.9d83cc3299e8e2d2c32167fa@kernel.org>
Content-Language: en-US
From:   wuqiang <wuqiang.matt@bytedance.com>
In-Reply-To: <20221115005409.9d83cc3299e8e2d2c32167fa@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/11/14 23:54, Masami Hiramatsu (Google) wrote:
> On Tue,  8 Nov 2022 15:14:40 +0800
> wuqiang <wuqiang.matt@bytedance.com> wrote:
> 
>> The object pool is a scalable implementaion of high performance queue
>> for objects allocation and reclamation, such as kretprobe instances.
>>
>> With leveraging per-cpu ring-array to mitigate the hot spots of memory
>> contention, it could deliver near-linear scalability for high parallel
>> scenarios. The ring-array is compactly managed in a single cache-line
>> to benefit from warmed L1 cache for most cases (<= 4 objects per-core).
>> The body of pre-allocated objects is stored in continuous cache-lines
>> just after the ring-array.
>>
>> The object pool is interrupt safe. Both allocation and reclamation
>> (object pop and push operations) can be preemptible or interruptable.
>>
>> It's best suited for following cases:
>> 1) Memory allocation or reclamation are prohibited or too expensive
>> 2) Consumers are of different priorities, such as irqs and threads
>>
>> Limitations:
>> 1) Maximum objects (capacity) is determined during pool initializing
>> 2) The memory of objects won't be freed until the poll is finalized
>> 3) Object allocation (pop) may fail after trying all cpu slots
>> 4) Object reclamation (push) won't fail but may take long time to
>>     finish for imbalanced scenarios. You can try larger max_entries
>>     to mitigate, or ( >= CPUS * nr_objs) to avoid
>>
>> Signed-off-by: wuqiang <wuqiang.matt@bytedance.com>
>> ---
>>   include/linux/objpool.h | 153 +++++++++++++
>>   lib/Makefile            |   2 +-
>>   lib/objpool.c           | 487 ++++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 641 insertions(+), 1 deletion(-)
>>   create mode 100644 include/linux/objpool.h
>>   create mode 100644 lib/objpool.c
>>
>> diff --git a/include/linux/objpool.h b/include/linux/objpool.h
>> new file mode 100644
>> index 000000000000..7899b054b50c
>> --- /dev/null
>> +++ b/include/linux/objpool.h
>> @@ -0,0 +1,153 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +
>> +#ifndef _LINUX_OBJPOOL_H
>> +#define _LINUX_OBJPOOL_H
>> +
>> +#include <linux/types.h>
>> +
>> +/*
>> + * objpool: ring-array based lockless MPMC queue
>> + *
>> + * Copyright: wuqiang.matt@bytedance.com
>> + *
>> + * The object pool is a scalable implementaion of high performance queue
>> + * for objects allocation and reclamation, such as kretprobe instances.
>> + *
>> + * With leveraging per-cpu ring-array to mitigate the hot spots of memory
>> + * contention, it could deliver near-linear scalability for high parallel
>> + * scenarios. The ring-array is compactly managed in a single cache-line
>> + * to benefit from warmed L1 cache for most cases (<= 4 objects per-core).
>> + * The body of pre-allocated objects is stored in continuous cache-lines
>> + * just after the ring-array.
>> + *
>> + * The object pool is interrupt safe. Both allocation and reclamation
>> + * (object pop and push operations) can be preemptible or interruptable.
>> + *
>> + * It's best suited for following cases:
>> + * 1) Memory allocation or reclamation are prohibited or too expensive
>> + * 2) Consumers are of different priorities, such as irqs and threads
>> + *
>> + * Limitations:
>> + * 1) Maximum objects (capacity) is determined during pool initializing
>> + * 2) The memory of objects won't be freed until the poll is finalized
>> + * 3) Object allocation (pop) may fail after trying all cpu slots
>> + * 4) Object reclamation (push) won't fail but may take long time to
>> + *    finish for imbalanced scenarios. You can try larger max_entries
>> + *    to mitigate, or ( >= CPUS * nr_objs) to avoid
>> + */
>> +
>> +/*
>> + * objpool_slot: per-cpu ring array
>> + *
>> + * Represents a cpu-local array-based ring buffer, its size is specialized
>> + * during initialization of object pool.
>> + *
>> + * The objpool_slot is allocated from local memory for NUMA system, and to
>> + * be kept compact in a single cacheline. ages[] is stored just after the
>> + * body of objpool_slot, and then entries[]. The Array of ages[] describes
>> + * revision of each item, solely used to avoid ABA. And array of entries[]
>> + * contains the pointers of objects.
>> + *
>> + * The default size of objpool_slot is a single cache-line, aka. 64 bytes.
>> + *
>> + * 64bit:
>> + *        4      8      12     16        32                 64
>> + * | head | tail | size | mask | ages[4] | ents[4]: (8 * 4) | objects
>> + *
>> + * 32bit:
>> + *        4      8      12     16        32        48       64
>> + * | head | tail | size | mask | ages[4] | ents[4] | unused | objects
>> + *
>> + */
>> +
>> +struct objpool_slot {
>> +	uint32_t                head;	/* head of ring array */
>> +	uint32_t                tail;	/* tail of ring array */
>> +	uint32_t                size;	/* array size, pow of 2 */
>> +	uint32_t                mask;	/* size - 1 */
>> +} __attribute__((packed));
>> +
>> +/* caller-specified object initial callback to setup each object, only called once */
>> +typedef int (*objpool_init_obj_cb)(void *context, void *obj);
> 
> It seems a bit confused that this "initialize object" callback
> don't have the @obj as the first argument.

Sure, will update in next version.

>> +
>> +/* caller-specified cleanup callback for private objects/pool/context */
>> +typedef int (*objpool_release_cb)(void *context, void *ptr, uint32_t flags);
> 
> Do you have any use-case for this release callback?
> If not, until actual use-case comes up, I recommend you to defer
> implementing it.

No actual use-case for now, since both kretprobe and rethook use internal
objects. It's mainly for user-managed objects and asynchronous finilization.

I'll reconsider your advice. Thanks.

>> +
>> +/* called for object releasing: ptr points to an object */
>> +#define OBJPOOL_FLAG_NODE        (0x00000001)
>> +/* for user pool and context releasing, ptr could be NULL */
>> +#define OBJPOOL_FLAG_POOL        (0x00001000)
>> +/* the object or pool to be released is user-managed */
>> +#define OBJPOOL_FLAG_USER        (0x00008000)
> 
> Ditto.
> 
>> +
>> +/*
>> + * objpool_head: object pooling metadata
>> + */
>> +
>> +struct objpool_head {
>> +	unsigned int            obj_size;	/* object & element size */
>> +	unsigned int            nr_objs;	/* total objs (to be pre-allocated) */
>> +	unsigned int            nr_cpus;	/* num of possible cpus */
>> +	unsigned int            capacity;	/* max objects per cpuslot */
>> +	unsigned long           flags;		/* flags for objpool management */
>> +	gfp_t                   gfp;		/* gfp flags for kmalloc & vmalloc */
>> +	unsigned int            pool_size;	/* user pool size in byes */
>> +	void                   *pool;		/* user managed memory pool */
>> +	struct objpool_slot   **cpu_slots;	/* array of percpu slots */
>> +	unsigned int           *slot_sizes;	/* size in bytes of slots */
>> +	objpool_release_cb      release;	/* resource cleanup callback */
>> +	void                   *context;	/* caller-provided context */
>> +};
>> +
>> +#define OBJPOOL_FROM_VMALLOC	(0x800000000)	/* objpool allocated from vmalloc area */
>> +#define OBJPOOL_HAVE_OBJECTS	(0x400000000)	/* objects allocated along with objpool */
> 
> This also doesn't need at this moment. Please start from simple
> design for review.
> 
>> +
>> +/* initialize object pool and pre-allocate objects */
>> +int objpool_init(struct objpool_head *head, unsigned int nr_objs,
>> +		 unsigned int max_objs, unsigned int object_size,
>> +		 gfp_t gfp, void *context, objpool_init_obj_cb objinit,
>> +		 objpool_release_cb release);
>> +
>> +/* add objects in batch from user provided pool */
>> +int objpool_populate(struct objpool_head *head, void *pool,
>> +		     unsigned int size, unsigned int object_size,
>> +		     void *context, objpool_init_obj_cb objinit);
>> +
>> +/* add pre-allocated object (managed by user) to objpool */
>> +int objpool_add(void *obj, struct objpool_head *head);
>> +
>> +/* allocate an object from objects pool */
>> +void *objpool_pop(struct objpool_head *head);
>> +
>> +/* reclaim an object to objects pool */
>> +int objpool_push(void *node, struct objpool_head *head);
>> +
>> +/* cleanup the whole object pool (objects including) */
>> +void objpool_fini(struct objpool_head *head);
>> +
>> +/* whether the object is pre-allocated with percpu slots */
>> +static inline int objpool_is_inslot(void *obj, struct objpool_head *head)
>> +{
>> +	void *slot;
>> +	int i;
>> +
>> +	if (!obj || !(head->flags & OBJPOOL_HAVE_OBJECTS))
>> +		return 0;
>> +
>> +	for (i = 0; i < head->nr_cpus; i++) {
>> +		slot = head->cpu_slots[i];
>> +		if (obj >= slot && obj < slot + head->slot_sizes[i])
>> +			return 1;
>> +	}
>> +
>> +	return 0;
>> +}
> 
> Ditto.
> 
> It is too complicated to mix the internal allocated objects
> and external ones. This will expose the implementation of the
> objpool (users must understand they have to free the object
> only outside of slot)

Mixing is NOT recommended and normally it should be one of internal / user
oool / external. But as a general lib of objpool, mixing is supported just
because we don't know what use-cases real users would face.

> You can add it afterwards if it is really needed :)

Sure, I'll rethink of it. For kretprobe and rethook, a performance-oriented
version (with internal objects) should be simplely enough and pretty compact.

>> +
>> +/* whether the object is from user pool (batched adding) */
>> +static inline int objpool_is_inpool(void *obj, struct objpool_head *head)
>> +{
>> +	return (obj && head->pool && obj >= head->pool &&
>> +		obj < head->pool + head->pool_size);
>> +}
>> +
>> +#endif /* _LINUX_OBJPOOL_H */
>> diff --git a/lib/Makefile b/lib/Makefile
>> index 161d6a724ff7..e938703a321f 100644
>> --- a/lib/Makefile
>> +++ b/lib/Makefile
>> @@ -34,7 +34,7 @@ lib-y := ctype.o string.o vsprintf.o cmdline.o \
>>   	 is_single_threaded.o plist.o decompress.o kobject_uevent.o \
>>   	 earlycpio.o seq_buf.o siphash.o dec_and_lock.o \
>>   	 nmi_backtrace.o win_minmax.o memcat_p.o \
>> -	 buildid.o
>> +	 buildid.o objpool.o
>>   
>>   lib-$(CONFIG_PRINTK) += dump_stack.o
>>   lib-$(CONFIG_SMP) += cpumask.o
>> diff --git a/lib/objpool.c b/lib/objpool.c
>> new file mode 100644
>> index 000000000000..ecffa0795f3d
>> --- /dev/null
>> +++ b/lib/objpool.c
>> @@ -0,0 +1,487 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +#include <linux/objpool.h>
>> +#include <linux/slab.h>
>> +#include <linux/vmalloc.h>
>> +#include <linux/atomic.h>
>> +#include <linux/prefetch.h>
>> +
>> +/*
>> + * objpool: ring-array based lockless MPMC/FIFO queues
>> + *
>> + * Copyright: wuqiang.matt@bytedance.com
>> + */
>> +
>> +/* compute the suitable num of objects to be managed by slot */
>> +static inline unsigned int __objpool_num_of_objs(unsigned int size)
>> +{
>> +	return rounddown_pow_of_two((size - sizeof(struct objpool_slot)) /
>> +			(sizeof(uint32_t) + sizeof(void *)));
>> +}
>> +
>> +#define SLOT_AGES(s) ((uint32_t *)((char *)(s) + sizeof(struct objpool_slot)))
>> +#define SLOT_ENTS(s) ((void **)((char *)(s) + sizeof(struct objpool_slot) + \
>> +			sizeof(uint32_t) * (s)->size))
>> +#define SLOT_OBJS(s) ((void *)((char *)(s) + sizeof(struct objpool_slot) + \
>> +			(sizeof(uint32_t) + sizeof(void *)) * (s)->size))
>> +
>> +/* allocate and initialize percpu slots */
>> +static inline int
>> +__objpool_init_percpu_slots(struct objpool_head *head, unsigned int nobjs,
>> +			void *context, objpool_init_obj_cb objinit)
>> +{
>> +	unsigned int i, j, n, size, objsz, nents = head->capacity;
>> +
>> +	/* aligned object size by sizeof(void *) */
>> +	objsz = ALIGN(head->obj_size, sizeof(void *));
>> +	/* shall we allocate objects along with objpool_slot */
>> +	if (objsz)
>> +		head->flags |= OBJPOOL_HAVE_OBJECTS;
>> +
>> +	for (i = 0; i < head->nr_cpus; i++) {
>> +		struct objpool_slot *os;
>> +
>> +		/* compute how many objects to be managed by this slot */
>> +		n = nobjs / head->nr_cpus;
>> +		if (i < (nobjs % head->nr_cpus))
>> +			n++;
>> +		size = sizeof(struct objpool_slot) + sizeof(void *) * nents +
>> +		       sizeof(uint32_t) * nents + objsz * n;
>> +
>> +		/* decide memory area for cpu-slot allocation */
>> +		if (!i && !(head->gfp & GFP_ATOMIC) && size > PAGE_SIZE / 2)
>> +			head->flags |= OBJPOOL_FROM_VMALLOC;
>> +
>> +		/* allocate percpu slot & objects from local memory */
>> +		if (head->flags & OBJPOOL_FROM_VMALLOC)
>> +			os = __vmalloc_node(size, sizeof(void *), head->gfp,
>> +				cpu_to_node(i), __builtin_return_address(0));
>> +		else
>> +			os = kmalloc_node(size, head->gfp, cpu_to_node(i));
>> +		if (!os)
>> +			return -ENOMEM;
>> +
>> +		/* initialize percpu slot for the i-th cpu */
>> +		memset(os, 0, size);
>> +		os->size = head->capacity;
>> +		os->mask = os->size - 1;
>> +		head->cpu_slots[i] = os;
>> +		head->slot_sizes[i] = size;
>> +
>> +		/*
>> +		 * start from 2nd round to avoid conflict of 1st item.
>> +		 * we assume that the head item is ready for retrieval
>> +		 * iff head is equal to ages[head & mask]. but ages is
>> +		 * initialized as 0, so in view of the caller of pop(),
>> +		 * the 1st item (0th) is always ready, but fact could
>> +		 * be: push() is stalled before the final update, thus
>> +		 * the item being inserted will be lost forever.
>> +		 */
>> +		os->head = os->tail = head->capacity;
>> +
>> +		if (!objsz)
>> +			continue;
>> +
>> +		for (j = 0; j < n; j++) {
>> +			uint32_t *ages = SLOT_AGES(os);
>> +			void **ents = SLOT_ENTS(os);
>> +			void *obj = SLOT_OBJS(os) + j * objsz;
>> +			uint32_t ie = os->tail & os->mask;
>> +
>> +			/* perform object initialization */
>> +			if (objinit) {
>> +				int rc = objinit(context, obj);
>> +				if (rc)
>> +					return rc;
>> +			}
>> +
>> +			/* add obj into the ring array */
>> +			ents[ie] = obj;
>> +			ages[ie] = os->tail;
>> +			os->tail++;
>> +			head->nr_objs++;
>> +		}
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +/* cleanup all percpu slots of the object pool */
>> +static inline void __objpool_fini_percpu_slots(struct objpool_head *head)
>> +{
>> +	unsigned int i;
>> +
>> +	if (!head->cpu_slots)
>> +		return;
>> +
>> +	for (i = 0; i < head->nr_cpus; i++) {
>> +		if (!head->cpu_slots[i])
>> +			continue;
>> +		if (head->flags & OBJPOOL_FROM_VMALLOC)
>> +			vfree(head->cpu_slots[i]);
>> +		else
>> +			kfree(head->cpu_slots[i]);
>> +	}
>> +	kfree(head->cpu_slots);
>> +	head->cpu_slots = NULL;
>> +	head->slot_sizes = NULL;
>> +}
>> +
>> +/**
>> + * objpool_init: initialize object pool and pre-allocate objects
>> + *
>> + * args:
>> + * @head:    the object pool to be initialized, declared by caller
>> + * @nr_objs: total objects to be pre-allocated by this object pool
>> + * @max_objs: max entries (object pool capacity), use nr_objs if 0
>> + * @object_size: size of an object, no objects pre-allocated if 0
>> + * @gfp:     flags for memory allocation (via kmalloc or vmalloc)
>> + * @context: user context for object initialization callback
>> + * @objinit: object initialization callback for extra setting-up
>> + * @release: cleanup callback for private objects/pool/context
>> + *
>> + * return:
>> + *         0 for success, otherwise error code
>> + *
>> + * All pre-allocated objects are to be zeroed. Caller could do extra
>> + * initialization in objinit callback. The objinit callback will be
>> + * called once and only once after the slot allocation. Then objpool
>> + * won't touch any content of the objects since then. It's caller's
>> + * duty to perform reinitialization after object allocation (pop) or
>> + * clearance before object reclamation (push) if required.
>> + */
>> +int objpool_init(struct objpool_head *head, unsigned int nr_objs,
>> +		unsigned int max_objs, unsigned int object_size,
>> +		gfp_t gfp, void *context, objpool_init_obj_cb objinit,
>> +		objpool_release_cb release)
>> +{
>> +	unsigned int nents, ncpus = num_possible_cpus();
>> +	int rc;
>> +
>> +	/* calculate percpu slot size (rounded to pow of 2) */
>> +	if (max_objs < nr_objs)
> 
> This should be an error case.
> 
> 	if (!max_objs)
> 
>> +		max_objs = nr_objs;
> 
> 	else if (max_objs < nr_objs)
> 		return -EINVAL;

Got it.

> But to simplify that, I think it should use only nr_objs.
> I mean, if we can pass the @objinit, there seems no reason to
> have both nr_objs and max_objs.

I kept both them just to give user the flexibility to best meet the
requirements. For cases that objects are in imbalanced distribution
among CPUs, max_objs should be bigger enough (nr_cpus * nr_objs) to
deliver good performance, with a cost of a little more memory.

>> +	nents = max_objs / ncpus;
>> +	if (nents < __objpool_num_of_objs(L1_CACHE_BYTES))
>> +		nents = __objpool_num_of_objs(L1_CACHE_BYTES);
>> +	nents = roundup_pow_of_two(nents);
>> +	while (nents * ncpus < nr_objs)
>> +		nents = nents << 1;
>> +
>> +	memset(head, 0, sizeof(struct objpool_head));
>> +	head->nr_cpus = ncpus;
>> +	head->obj_size = object_size;
>> +	head->capacity = nents;
>> +	head->gfp = gfp & ~__GFP_ZERO;
>> +	head->context = context;
>> +	head->release = release;
>> +
>> +	/* allocate array for percpu slots */
>> +	head->cpu_slots = kzalloc(head->nr_cpus * sizeof(void *) +
>> +			       head->nr_cpus * sizeof(uint32_t), head->gfp);
>> +	if (!head->cpu_slots)
>> +		return -ENOMEM;
>> +	head->slot_sizes = (uint32_t *)&head->cpu_slots[head->nr_cpus];
>> +
>> +	/* initialize per-cpu slots */
>> +	rc = __objpool_init_percpu_slots(head, nr_objs, context, objinit);
>> +	if (rc)
>> +		__objpool_fini_percpu_slots(head);
>> +
>> +	return rc;
>> +}
>> +EXPORT_SYMBOL_GPL(objpool_init);
>> +
>> +/* adding object to slot tail, the given slot must NOT be full */
>> +static inline int __objpool_add_slot(void *obj, struct objpool_slot *os)
>> +{
>> +	uint32_t *ages = SLOT_AGES(os);
>> +	void **ents = SLOT_ENTS(os);
>> +	uint32_t tail = atomic_inc_return((atomic_t *)&os->tail) - 1;
>> +
>> +	WRITE_ONCE(ents[tail & os->mask], obj);
>> +
>> +	/* order matters: obj must be updated before tail updating */
>> +	smp_store_release(&ages[tail & os->mask], tail);
>> +	return 0;
>> +}
>> +
>> +/* adding object to slot, abort if the slot was already full */
>> +static inline int __objpool_try_add_slot(void *obj, struct objpool_slot *os)
>> +{
>> +	uint32_t *ages = SLOT_AGES(os);
>> +	void **ents = SLOT_ENTS(os);
>> +	uint32_t head, tail;
>> +
>> +	do {
>> +		/* perform memory loading for both head and tail */
>> +		head = READ_ONCE(os->head);
>> +		tail = READ_ONCE(os->tail);
>> +		/* just abort if slot is full */
>> +		if (tail >= head + os->size)
>> +			return -ENOENT;
>> +		/* try to extend tail by 1 using CAS to avoid races */
>> +		if (try_cmpxchg_acquire(&os->tail, &tail, tail + 1))
>> +			break;
>> +	} while (1);
>> +
>> +	/* the tail-th of slot is reserved for the given obj */
>> +	WRITE_ONCE(ents[tail & os->mask], obj);
>> +	/* update epoch id to make this object available for pop() */
>> +	smp_store_release(&ages[tail & os->mask], tail);
>> +	return 0;
>> +}
>> +
>> +/**
>> + * objpool_populate: add objects from user provided pool in batch
>> + *
>> + * args:
>> + * @head:  object pool
>> + * @pool: user buffer for pre-allocated objects
>> + * @size: size of user buffer
>> + * @object_size: size of object & element
>> + * @context: user context for objinit callback
>> + * @objinit: object initialization callback
>> + *
>> + * return: 0 or error code
>> + */
>> +int objpool_populate(struct objpool_head *head, void *pool,
>> +		unsigned int size, unsigned int object_size,
>> +		void *context, objpool_init_obj_cb objinit)
>> +{
>> +	unsigned int n = head->nr_objs, used = 0, i;
>> +
>> +	if (head->pool || !pool || size < object_size)
>> +		return -EINVAL;
>> +	if (head->obj_size && head->obj_size != object_size)
>> +		return -EINVAL;
>> +	if (head->context && context && head->context != context)
>> +		return -EINVAL;
>> +	if (head->nr_objs >= head->nr_cpus * head->capacity)
>> +		return -ENOENT;
>> +
>> +	WARN_ON_ONCE(((unsigned long)pool) & (sizeof(void *) - 1));
>> +	WARN_ON_ONCE(((uint32_t)object_size) & (sizeof(void *) - 1));
>> +
>> +	/* align object size by sizeof(void *) */
>> +	head->obj_size = object_size;
>> +	object_size = ALIGN(object_size, sizeof(void *));
>> +	if (object_size == 0)
>> +		return -EINVAL;
>> +
>> +	while (used + object_size <= size) {
>> +		void *obj = pool + used;
>> +
>> +		/* perform object initialization */
>> +		if (objinit) {
>> +			int rc = objinit(context, obj);
>> +			if (rc)
>> +				return rc;
>> +		}
>> +
>> +		/* insert obj to its corresponding objpool slot */
>> +		i = (n + used * head->nr_cpus/size) % head->nr_cpus;
>> +		if (!__objpool_try_add_slot(obj, head->cpu_slots[i]))
>> +			head->nr_objs++;
>> +
>> +		used += object_size;
>> +	}
>> +
>> +	if (!used)
>> +		return -ENOENT;
>> +
>> +	head->context = context;
>> +	head->pool = pool;
>> +	head->pool_size = size;
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(objpool_populate);
>> +
>> +/**
>> + * objpool_add: add pre-allocated object to objpool during pool
>> + * initialization
>> + *
>> + * args:
>> + * @obj:  object pointer to be added to objpool
>> + * @head: object pool to be inserted into
>> + *
>> + * return:
>> + *     0 or error code
>> + *
>> + * objpool_add_node doesn't handle race conditions, can only be
>> + * called during objpool initialization
>> + */
>> +int objpool_add(void *obj, struct objpool_head *head)
>> +{
>> +	unsigned int i, cpu;
>> +
>> +	if (!obj)
>> +		return -EINVAL;
>> +	if (head->nr_objs >= head->nr_cpus * head->capacity)
>> +		return -ENOENT;
>> +
>> +	cpu = head->nr_objs % head->nr_cpus;
>> +	for (i = 0; i < head->nr_cpus; i++) {
>> +		if (!__objpool_try_add_slot(obj, head->cpu_slots[cpu])) {
>> +			head->nr_objs++;
>> +			return 0;
>> +		}
>> +
>> +		if (++cpu >= head->nr_cpus)
>> +			cpu = 0;
>> +	}
>> +
>> +	return -ENOENT;
>> +}
>> +EXPORT_SYMBOL_GPL(objpool_add);
>> +
>> +/**
>> + * objpool_push: reclaim the object and return back to objects pool
>> + *
>> + * args:
>> + * @obj:  object pointer to be pushed to object pool
>> + * @head: object pool
>> + *
>> + * return:
>> + *     0 or error code: it fails only when objects pool are full
>> + *
>> + * objpool_push is non-blockable, and can be nested
>> + */
>> +int objpool_push(void *obj, struct objpool_head *head)
>> +{
>> +	unsigned int cpu = raw_smp_processor_id() % head->nr_cpus;
>> +
>> +	do {
>> +		if (head->nr_objs > head->capacity) {
>> +			if (!__objpool_try_add_slot(obj, head->cpu_slots[cpu]))
>> +				return 0;
>> +		} else {
>> +			if (!__objpool_add_slot(obj, head->cpu_slots[cpu]))
>> +				return 0;
>> +		}
>> +		if (++cpu >= head->nr_cpus)
>> +			cpu = 0;
>> +	} while (1);
>> +
>> +	return -ENOENT;
>> +}
>> +EXPORT_SYMBOL_GPL(objpool_push);
>> +
>> +/* try to retrieve object from slot */
>> +static inline void *__objpool_try_get_slot(struct objpool_slot *os)
>> +{
>> +	uint32_t *ages = SLOT_AGES(os);
>> +	void **ents = SLOT_ENTS(os);
>> +	/* do memory load of head to local head */
>> +	uint32_t head = smp_load_acquire(&os->head);
>> +
>> +	/* loop if slot isn't empty */
>> +	while (head != READ_ONCE(os->tail)) {
>> +		uint32_t id = head & os->mask, prev = head;
>> +
>> +		/* do prefetching of object ents */
>> +		prefetch(&ents[id]);
>> +
>> +		/*
>> +		 * check whether this item was ready for retrieval ? There's
>> +		 * possibility * in theory * we might retrieve wrong object,
>> +		 * in case ages[id] overflows when current task is sleeping,
>> +		 * but it will take very very long to overflow an uint32_t
>> +		 */
>> +		if (smp_load_acquire(&ages[id]) == head) {
>> +			/* node must have been udpated by push() */
>> +			void *node = READ_ONCE(ents[id]);
>> +			/* commit and move forward head of the slot */
>> +			if (try_cmpxchg_release(&os->head, &head, head + 1))
>> +				return node;
>> +		}
>> +
>> +		/* re-load head from memory continue trying */
>> +		head = READ_ONCE(os->head);
>> +		/*
>> +		 * head stays unchanged, so it's very likely current pop()
>> +		 * just preempted/interrupted an ongoing push() operation
>> +		 */
>> +		if (head == prev)
>> +			break;
>> +	}
>> +
>> +	return NULL;
>> +}
>> +
>> +/**
>> + * objpool_pop: allocate an object from objects pool
>> + *
>> + * args:
>> + * @oh:  object pool
>> + *
>> + * return:
>> + *   object: NULL if failed (object pool is empty)
>> + *
>> + * objpool_pop can be nested, so can be used in any context.
>> + */
>> +void *objpool_pop(struct objpool_head *head)
>> +{
>> +	unsigned int i, cpu;
>> +	void *obj = NULL;
>> +
>> +	cpu = raw_smp_processor_id() % head->nr_cpus;
> 
> (Not sure, do we really need this?)

V6 (this version) needs it, since it's using num_possible_cpus() to manage
the array of cpu_slots.

Last week I finished an improved version, which takes account of holes in
cpu_possible_mask. The testings are going well so far.

> Thank you,

Your advices would be greatly appreciated. Thank you for your time.

> 
>> +	for (i = 0; i < head->nr_cpus; i++) {
>> +		struct objpool_slot *slot = head->cpu_slots[cpu];
>> +		obj = __objpool_try_get_slot(slot);
>> +		if (obj)
>> +			break;
>> +		if (++cpu >= head->nr_cpus)
>> +			cpu = 0;
>> +	}
>> +
>> +	return obj;
>> +}
>> +EXPORT_SYMBOL_GPL(objpool_pop);
>> +
>> +/**
>> + * objpool_fini: cleanup the whole object pool (releasing all objects)
>> + *
>> + * args:
>> + * @head: object pool to be released
>> + *
>> + */
>> +void objpool_fini(struct objpool_head *head)
>> +{
>> +	uint32_t i, flags;
>> +
>> +	if (!head->cpu_slots)
>> +		return;
>> +
>> +	if (!head->release) {
>> +		__objpool_fini_percpu_slots(head);
>> +		return;
>> +	}
>> +
>> +	/* cleanup all objects remained in objpool */
>> +	for (i = 0; i < head->nr_cpus; i++) {
>> +		void *obj;
>> +		do {
>> +			flags = OBJPOOL_FLAG_NODE;
>> +			obj = __objpool_try_get_slot(head->cpu_slots[i]);
>> +			if (!obj)
>> +				break;
>> +			if (!objpool_is_inpool(obj, head) &&
>> +			    !objpool_is_inslot(obj, head)) {
>> +				flags |= OBJPOOL_FLAG_USER;
>> +			}
>> +			head->release(head->context, obj, flags);
>> +		} while (obj);
>> +	}
>> +
>> +	/* release percpu slots */
>> +	__objpool_fini_percpu_slots(head);
>> +
>> +	/* cleanup user private pool and related context */
>> +	flags = OBJPOOL_FLAG_POOL;
>> +	if (head->pool)
>> +		flags |= OBJPOOL_FLAG_USER;
>> +	head->release(head->context, head->pool, flags);
>> +}
>> +EXPORT_SYMBOL_GPL(objpool_fini);
>> -- 
>> 2.34.1
>>


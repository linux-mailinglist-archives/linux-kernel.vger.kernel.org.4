Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0C5771887D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 19:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbjEaR3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 13:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjEaR3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 13:29:21 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E3DAF133
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 10:29:18 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.43])
        by gateway (Coremail) with SMTP id _____8AxHevtg3dkfgcDAA--.2322S3;
        Thu, 01 Jun 2023 01:29:17 +0800 (CST)
Received: from [10.20.42.43] (unknown [10.20.42.43])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxMuXsg3dk3rWCAA--.14526S3;
        Thu, 01 Jun 2023 01:29:17 +0800 (CST)
Message-ID: <5c2faf7e-002c-dad0-c4fe-63aab04f7e87@loongson.cn>
Date:   Thu, 1 Jun 2023 01:29:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v6 6/6] drm/etnaviv: allow usperspace create cached
 coherent bo
Content-Language: en-US
To:     Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-kernel@vger.kernel.org, etnaviv@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, loongson-kernel@lists.loongnix.cn
References: <20230530160643.2344551-1-suijingfeng@loongson.cn>
 <20230530160643.2344551-7-suijingfeng@loongson.cn>
 <35c15c0912b4a9372b9c2194a46b518ce515ce3d.camel@pengutronix.de>
From:   Sui Jingfeng <suijingfeng@loongson.cn>
Organization: Loongson
In-Reply-To: <35c15c0912b4a9372b9c2194a46b518ce515ce3d.camel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxMuXsg3dk3rWCAA--.14526S3
X-CM-SenderInfo: xvxlyxpqjiv03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBjvJXoW3JF4kAr13Gr4fGw4kWw4DArb_yoWxArW3pF
        Z7AFyYkrW0vrWqkw1xZFn8Aa43Gw12gFWvk3srtas093y5tFs2gr1rKFZ8Crn8CryfGr1a
        qr1jyry5KF10yrJanT9S1TB71UUUUjUqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bDAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwA2z4
        x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8JVW8Jr1ln4kS
        14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
        1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv
        67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
        AlzVAYIcxG8wCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE
        7xkEbVWUJVW8JwCFI7km07C267AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I
        0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAI
        cVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcV
        CF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j7BMNUUUUU=
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2023/6/1 00:33, Lucas Stach wrote:
> Hi Sui Jingfeng,
>
> Am Mittwoch, dem 31.05.2023 um 00:06 +0800 schrieb Sui Jingfeng:
>> cached system RAM is coherent on loongson CPUs, and the GPU and DC allways
>> snoop the CPU's cache. write-combine caching property is not suitiable for
>> us.
>>
> As previously mentioned in the Mesa MR, I don't think this is the right
> approach.
>
> ETNA_BO_CACHED already looks coherent to userspace, as all accesses are
> bracketed via the ETNAVIV_GEM_CPU_PREP and ETNAVIV_GEM_CPU_FINI ioctls,
> which will do the necessary cache maintenance on platforms where device
> coherence isn't enforced by the hardware, so there is no need for a
> separate ETNA_BO_CACHED_COHERENT.

As far as I can see,  ETNA_BO_CACHED_COHERENT could probably help to 
bypass the overhead of

dma_sync_sgtable_for_cpu() and dma_sync_sgtable_for_device() brings to us.


I have tested long time ago, there no need call this function on our 
platform.

The glmark2 works as before if I comment out thoes two function.

Are you serious, sir?

> Instead we just need a new ETNAVIV_PARAM to inform userspace about
> hardware cache coherence being available for a specific GPU core,

Ok, let me think about for a while how to implement this.

But How about we merge this first, I create another patch to improve it

with a roughly working base first? I'm just asking if the answer is No :-)

>   in
> which case the userspace driver should switch to preferring
> ETNA_BO_CACHED over ETNA_BO_WC.

Yeah,  ETNA_BO_CACHED is enough.

ETNA_BO_CACHED_COHERENT is actually a special case of ETNA_BO_CACHED.

> Regards,
> Lucas
>
>> Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
>> ---
>>   drivers/gpu/drm/etnaviv/etnaviv_drv.c       |  2 +-
>>   drivers/gpu/drm/etnaviv/etnaviv_gem.c       | 22 +++++++++++++++++++--
>>   drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c |  9 ++++++++-
>>   include/uapi/drm/etnaviv_drm.h              | 11 ++++++-----
>>   4 files changed, 35 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.c b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
>> index 052f745cecc0..2816c654c023 100644
>> --- a/drivers/gpu/drm/etnaviv/etnaviv_drv.c
>> +++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
>> @@ -274,7 +274,7 @@ static int etnaviv_ioctl_gem_new(struct drm_device *dev, void *data,
>>   	struct drm_etnaviv_gem_new *args = data;
>>   
>>   	if (args->flags & ~(ETNA_BO_CACHED | ETNA_BO_WC | ETNA_BO_UNCACHED |
>> -			    ETNA_BO_FORCE_MMU))
>> +			    ETNA_BO_CACHED_COHERENT | ETNA_BO_FORCE_MMU))
>>   		return -EINVAL;
>>   
>>   	return etnaviv_gem_new_handle(dev, file, args->size,
>> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem.c b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
>> index b5f73502e3dd..d8b559bd33d3 100644
>> --- a/drivers/gpu/drm/etnaviv/etnaviv_gem.c
>> +++ b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
>> @@ -343,6 +343,7 @@ void *etnaviv_gem_vmap(struct drm_gem_object *obj)
>>   static void *etnaviv_gem_vmap_impl(struct etnaviv_gem_object *obj)
>>   {
>>   	struct page **pages;
>> +	pgprot_t prot;
>>   
>>   	lockdep_assert_held(&obj->lock);
>>   
>> @@ -350,8 +351,20 @@ static void *etnaviv_gem_vmap_impl(struct etnaviv_gem_object *obj)
>>   	if (IS_ERR(pages))
>>   		return NULL;
>>   
>> -	return vmap(pages, obj->base.size >> PAGE_SHIFT,
>> -			VM_MAP, pgprot_writecombine(PAGE_KERNEL));
>> +	switch (obj->flags) {
>> +	case ETNA_BO_CACHED_COHERENT:
>> +	case ETNA_BO_CACHED:
>> +		prot = PAGE_KERNEL;
>> +		break;
>> +	case ETNA_BO_UNCACHED:
>> +		prot = pgprot_noncached(PAGE_KERNEL);
>> +		break;
>> +	case ETNA_BO_WC:
>> +	default:
>> +		prot = pgprot_writecombine(PAGE_KERNEL);
>> +	}
>> +
>> +	return vmap(pages, obj->base.size >> PAGE_SHIFT, VM_MAP, prot);
>>   }
>>   
>>   static inline enum dma_data_direction etnaviv_op_to_dma_dir(u32 op)
>> @@ -545,6 +558,7 @@ static const struct drm_gem_object_funcs etnaviv_gem_object_funcs = {
>>   static int etnaviv_gem_new_impl(struct drm_device *dev, u32 size, u32 flags,
>>   	const struct etnaviv_gem_ops *ops, struct drm_gem_object **obj)
>>   {
>> +	struct etnaviv_drm_private *priv = dev->dev_private;
>>   	struct etnaviv_gem_object *etnaviv_obj;
>>   	unsigned sz = sizeof(*etnaviv_obj);
>>   	bool valid = true;
>> @@ -555,6 +569,10 @@ static int etnaviv_gem_new_impl(struct drm_device *dev, u32 size, u32 flags,
>>   	case ETNA_BO_CACHED:
>>   	case ETNA_BO_WC:
>>   		break;
>> +	case ETNA_BO_CACHED_COHERENT:
>> +		if (priv->has_cached_coherent)
>> +			break;
>> +		fallthrough;
>>   	default:
>>   		valid = false;
>>   	}
>> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c b/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c
>> index 3524b5811682..671d91d8f1c6 100644
>> --- a/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c
>> +++ b/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c
>> @@ -112,11 +112,18 @@ static const struct etnaviv_gem_ops etnaviv_gem_prime_ops = {
>>   struct drm_gem_object *etnaviv_gem_prime_import_sg_table(struct drm_device *dev,
>>   	struct dma_buf_attachment *attach, struct sg_table *sgt)
>>   {
>> +	struct etnaviv_drm_private *priv = dev->dev_private;
>>   	struct etnaviv_gem_object *etnaviv_obj;
>>   	size_t size = PAGE_ALIGN(attach->dmabuf->size);
>> +	u32 cache_flags;
>>   	int ret, npages;
>>   
>> -	ret = etnaviv_gem_new_private(dev, size, ETNA_BO_WC,
>> +	if (priv->has_cached_coherent)
>> +		cache_flags = ETNA_BO_CACHED_COHERENT;
>> +	else
>> +		cache_flags = ETNA_BO_WC;
>> +
>> +	ret = etnaviv_gem_new_private(dev, size, cache_flags,
>>   				      &etnaviv_gem_prime_ops, &etnaviv_obj);
>>   	if (ret < 0)
>>   		return ERR_PTR(ret);
>> diff --git a/include/uapi/drm/etnaviv_drm.h b/include/uapi/drm/etnaviv_drm.h
>> index af024d90453d..474b0db286de 100644
>> --- a/include/uapi/drm/etnaviv_drm.h
>> +++ b/include/uapi/drm/etnaviv_drm.h
>> @@ -90,13 +90,14 @@ struct drm_etnaviv_param {
>>    * GEM buffers:
>>    */
>>   
>> -#define ETNA_BO_CACHE_MASK   0x000f0000
>> +#define ETNA_BO_CACHE_MASK              0x000f0000
>>   /* cache modes */
>> -#define ETNA_BO_CACHED       0x00010000
>> -#define ETNA_BO_WC           0x00020000
>> -#define ETNA_BO_UNCACHED     0x00040000
>> +#define ETNA_BO_CACHED                  0x00010000
>> +#define ETNA_BO_WC                      0x00020000
>> +#define ETNA_BO_UNCACHED                0x00040000
>> +#define ETNA_BO_CACHED_COHERENT         0x00080000
>>   /* map flags */
>> -#define ETNA_BO_FORCE_MMU    0x00100000
>> +#define ETNA_BO_FORCE_MMU               0x00100000
>>   
>>   struct drm_etnaviv_gem_new {
>>   	__u64 size;           /* in */

-- 
Jingfeng


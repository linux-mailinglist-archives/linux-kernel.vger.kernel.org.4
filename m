Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6CD66FD8AD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 09:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236415AbjEJHyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 03:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236278AbjEJHyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 03:54:50 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECC4449F5
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 00:54:15 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-643995a47f7so6936820b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 00:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1683705255; x=1686297255;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7q73aRqorgOcknsCbwBW7p8VJg521sVWQzKmYQBnQok=;
        b=YaMHHRBqvYEppbP9MhGxOEuJqH2pwde8SRyoa9tntc1oCxq7iQ+Z6jHQMWQYyNlUfH
         acHzXMBdBmDaGfkjxdZqZiPQ7pbULH3tV+0JoESt2YQwhC8zYB7D5Xwe4bACkbG2bclf
         /rT4+JaAmlIp6K0OIBrat5TkqefvnGjDJqukWbvwLS5bcVnHPKyeI5YT7ABfF62erQdn
         nWlEjz9O6NZXFpihkgfzuoRn3Xt3fXCgElkkEF3h/TsiDUM8HiY+FU+EgK+1CVIdES9S
         QMg3JS7uzAdPFvOljFxfybx/ATIqXO272WGC/amB1cKOm1OFS+kfJtIsxhgd7bHx2ASZ
         /Ssw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683705255; x=1686297255;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7q73aRqorgOcknsCbwBW7p8VJg521sVWQzKmYQBnQok=;
        b=JEh4QdeP8vhsC7G/BiQKzv0hqb28ThFuf1O48u7vjJ+w9FO81oJV12imtWPI9f01TI
         DR5FEPY9uywyrsv0NWBFeGHEWEfr0ziGJO4Ucrx3kO03rG83jotctfro2pE9zN3V5kI1
         1m00XSOFrvoz3mUxv/8xRMEubzPOiuGPlP240iv+fDiCuJmsIksD7eHl6ayu8oKaGKI+
         8E0VIx9uYEZ2G/XZ6Re5h5E9kOBdy0L5XDp8GxeP6kdAs66gB+4qj50FWhhpVtaca4pr
         lW24rka1NRUtuD+H9OLibofDnDJrAUbKG6FjG7n7/dBefLzffm+G3+MA8phel0eHuxxs
         RDYQ==
X-Gm-Message-State: AC+VfDxQwrvRFibN/TqW6zdESjbSD+c7tSqyNxI3F51NTvftlVW1xUut
        lXH8Y7VA/cY8+HIxdG7WTRFqDQ==
X-Google-Smtp-Source: ACHHUZ7S5mZ25pzyjyTGOW2qmzisuZigWqCxJk/tR7QPbGt6SrtGod5RsiwLeeIB3fwbCOD6tTafnw==
X-Received: by 2002:a05:6a20:918c:b0:100:28e0:6854 with SMTP id v12-20020a056a20918c00b0010028e06854mr14651943pzd.45.1683705255396;
        Wed, 10 May 2023 00:54:15 -0700 (PDT)
Received: from [10.3.43.196] ([61.213.176.6])
        by smtp.gmail.com with ESMTPSA id 17-20020aa79251000000b006468222af91sm2986619pfp.48.2023.05.10.00.54.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 May 2023 00:54:14 -0700 (PDT)
Message-ID: <8254f1bb-dfd0-5ff0-651f-7f664bca65ba@bytedance.com>
Date:   Wed, 10 May 2023 15:52:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: Re: [PATCH] virtio_ring: use u32 for virtio_max_dma_size
Content-Language: en-US
To:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>,
        mst@redhat.com, jasowang@redhat.com
References: <20230510025437.377807-1-pizhenwei@bytedance.com>
 <1683689214.9647853-1-xuanzhuo@linux.alibaba.com>
From:   zhenwei pi <pizhenwei@bytedance.com>
In-Reply-To: <1683689214.9647853-1-xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/10/23 11:26, Xuan Zhuo wrote:
> On Wed, 10 May 2023 10:54:37 +0800, zhenwei pi <pizhenwei@bytedance.com> wrote:
>> Both split ring and packed ring use 32bits to describe the length of
>> a descriptor: see struct vring_desc and struct vring_packed_desc.
>> This means the max segment size supported by virtio is U32_MAX.
>>
>> An example of virtio_max_dma_size in virtio_blk.c:
>>    u32 v, max_size;
>>
>>    max_size = virtio_max_dma_size(vdev);  -> implicit convert
>>    err = virtio_cread_feature(vdev, VIRTIO_BLK_F_SIZE_MAX,
>>                               struct virtio_blk_config, size_max, &v);
>>    max_size = min(max_size, v);
>>
>> There is a risk during implicit convert here, once virtio_max_dma_size
>> returns 4G, max_size becomes 0.
>>
>> Fixes: e6d6dd6c875e ("virtio: Introduce virtio_max_dma_size()")
>> Cc: Joerg Roedel <jroedel@suse.de>
>> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
>> ---
>>   drivers/virtio/virtio_ring.c | 12 ++++++++----
>>   include/linux/virtio.h       |  2 +-
>>   2 files changed, 9 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
>> index c5310eaf8b46..55cfecf030a1 100644
>> --- a/drivers/virtio/virtio_ring.c
>> +++ b/drivers/virtio/virtio_ring.c
>> @@ -289,12 +289,16 @@ static bool vring_use_dma_api(const struct virtio_device *vdev)
>>   	return false;
>>   }
>>
>> -size_t virtio_max_dma_size(const struct virtio_device *vdev)
>> +u32 virtio_max_dma_size(const struct virtio_device *vdev)
> 
> 
> LGTM
> 
> But, should we change the parameter to vq, then use the dma_dev?
> 
> @Jason
> 
> Thanks.
> 

The max DMA size is a attribute of a virtio device rather than any VQ, 
so I guess virtio_max_dma_size(const struct virtio_device *vdev) is clear.

On the other hand, if changing the parameter to vq, we need select a VQ, 
then the question is:
1, which VQ to select? VQ0 or a random one? this leads confusing.
2, The virtio spec defines: Each device can have zero or more virtqueues


> 
>>   {
>> -	size_t max_segment_size = SIZE_MAX;
>> +	u32 max_segment_size = U32_MAX;
>>
>> -	if (vring_use_dma_api(vdev))
>> -		max_segment_size = dma_max_mapping_size(vdev->dev.parent);
>> +	if (vring_use_dma_api(vdev)) {
>> +		size_t max_dma_size = dma_max_mapping_size(vdev->dev.parent);
>> +
>> +		if (max_dma_size < max_segment_size)
>> +			max_segment_size = max_dma_size;
>> +	}
>>
>>   	return max_segment_size;
>>   }
>> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
>> index b93238db94e3..1a605f408329 100644
>> --- a/include/linux/virtio.h
>> +++ b/include/linux/virtio.h
>> @@ -147,7 +147,7 @@ int virtio_device_restore(struct virtio_device *dev);
>>   #endif
>>   void virtio_reset_device(struct virtio_device *dev);
>>
>> -size_t virtio_max_dma_size(const struct virtio_device *vdev);
>> +u32 virtio_max_dma_size(const struct virtio_device *vdev);
>>
>>   #define virtio_device_for_each_vq(vdev, vq) \
>>   	list_for_each_entry(vq, &vdev->vqs, list)
>> --
>> 2.20.1
>>

-- 
zhenwei pi

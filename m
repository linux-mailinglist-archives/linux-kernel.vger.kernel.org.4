Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76E7C707717
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 02:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbjERAtw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 20:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjERAtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 20:49:50 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF44740CE
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 17:49:27 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-51f6461af24so938960a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 17:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1684370967; x=1686962967;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dqs7e96VU7euNkbUd3s38dZfeIV90lulRcNptau9itQ=;
        b=irwx18AOoF/WaB2RJXI4aW0f4cVD7vyPi88o/Ve/dBK44+gMFtKbbHTz1kJvpJA39y
         2CJ1PEfUM6p046OXGOCCIV97F0hUKMFoc4z/Lj7lTPTTFa7lBPzH9cg3wHkQLL+S3zHG
         wI/xw+foLnsPBAa3MizYsUCx26R2G2JkzgKCzKLQUS1dmGnF0rVFnLzyau9ManMlblEL
         vonF9cmbgmHm3FuJcNiV2dshj4qXxG4ZfmWNZ87R69R05FDlqb3VZP1Tp0uRZKKqOF+X
         k2Rj8of2C1CuoD2t9s06R/MucCebbqFJp7u2bdjRCzgqYXe5YNFa0q0Efb0vE16Zp+Oz
         z1CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684370967; x=1686962967;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dqs7e96VU7euNkbUd3s38dZfeIV90lulRcNptau9itQ=;
        b=aX59FwhtXR57Ne75LywjvOjfOsSwn4I6EBOiz6Bv0IHa+VNxYUN5rjKbYvG1R2QSnP
         5w2HsXx6yHi+/TI8qROMfSjbmejAk2Sg0+VkYzt1YiT9f5M4VfgUdcjLdPJ2EUgb28AR
         Wxk1jkRqlxk/Au6vteoQb0MIdv98dgBjQ6xR+hvCjvGo64oL3SNvTz0vXYdDwZ03iZIh
         SHmRsY6MPg46TwGXj/Uxaa4ker+RUl2b/IU4sCPC7xbNxFWCgVi9ot2f2tmKHxq9oK3C
         Qen79VT3SU1PuFHOcgbbm1S2hkyRTIKRJXu53D3DXOlnbTwXWwnzWjkVSo4frGvHY3ie
         DHzw==
X-Gm-Message-State: AC+VfDxkaP0iDlAnvUjwcbAg13qH9KW+KLWCfdX7yLChE51jQ2/WoGmE
        wqMYa4le2oks40GDg1tfuGs0/A==
X-Google-Smtp-Source: ACHHUZ4dyrTdh4NiyhPjMeXGqf9rfFoVdnVDL1MwIvXHP9SyWPw1WqHnaVnEtF4CgJ265mMVBHLL8A==
X-Received: by 2002:a17:902:b598:b0:1ad:f26e:3a2e with SMTP id a24-20020a170902b59800b001adf26e3a2emr594531pls.50.1684370967323;
        Wed, 17 May 2023 17:49:27 -0700 (PDT)
Received: from [10.3.43.196] ([61.213.176.13])
        by smtp.gmail.com with ESMTPSA id x2-20020a170902ea8200b001ae365072ccsm3936plb.122.2023.05.17.17.49.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 17:49:26 -0700 (PDT)
Message-ID: <ee2a975f-0aa6-a46a-e9d2-7f82e313347f@bytedance.com>
Date:   Thu, 18 May 2023 08:47:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: Re: Re: [PATCH v2 1/2] virtio: abstract virtqueue related methods
Content-Language: en-US
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>, stefanha@redhat.com,
        jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20230517025424.601141-1-pizhenwei@bytedance.com>
 <20230517025424.601141-2-pizhenwei@bytedance.com>
 <ZGSEq197W8VvOWCc@infradead.org>
 <9e4702f2-5473-2139-3858-ae58817bc7b5@bytedance.com>
 <ZGSGQWqbtdwGXurf@infradead.org>
 <cc9f3aea-b8bc-f312-41bb-3fd68083aa99@bytedance.com>
 <20230517062401-mutt-send-email-mst@kernel.org>
From:   zhenwei pi <pizhenwei@bytedance.com>
In-Reply-To: <20230517062401-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/17/23 18:39, Michael S. Tsirkin wrote:
> On Wed, May 17, 2023 at 04:35:55PM +0800, zhenwei pi wrote:
>>
>>
>> On 5/17/23 15:46, Christoph Hellwig wrote:
>>> On Wed, May 17, 2023 at 03:43:03PM +0800, zhenwei pi wrote:
>>>> I have a plan to introduce 'Virtio Over Fabrics'(TCP&RDMA) as Virtio
>>>> transport, as mentioned in cover letter of this series:
>>>> 3 weeks ago, I posted a proposal 'Virtio Over Fabrics':
>>>> https://lists.oasis-open.org/archives/virtio-comment/202304/msg00442.html
>>>
>>> Just don't do it.  Please define your own protocols over RDMA or TCP
>>> for exactly the operations you need (for many they will already exist)
>>> instead of piggyg backing on virtio and making everyone else pay the
>>> price.
>>>
>>
>> Hi
>>
>> 1, `virtqueue_add_inbuf` in current version:
>> static inline int virtqueue_add_inbuf(struct virtqueue *vq,
>>                                        struct scatterlist *sg,
>>                                        unsigned int num,
>>                                        void *data,
>>                                        gfp_t gfp)
>> {
>>          if (likely(!vq->abstract))
>>                  return vring_virtqueue_add_sgs(vq, &sg, num, 0, 1, data,
>> NULL, gfp);
>>
>>          return vq->add_sgs(vq, &sg, num, 0, 1, data, NULL, gfp);
>> }
>>
>> And disassemble 'virtinput_queue_evtbuf':
>> static void virtinput_queue_evtbuf(struct virtio_input *vi,
>>                                     struct virtio_input_event *evtbuf)
>> {
>>          struct scatterlist sg[1];
>>
>>          sg_init_one(sg, evtbuf, sizeof(*evtbuf));
>>          virtqueue_add_inbuf(vi->evt, sg, 1, evtbuf, GFP_ATOMIC);
>> }
>>
>> I notice that two instructions are newly added for vring like:
>>   24d:   80 78 35 00             cmpb   $0x0,0x35(%rax)
>>   251:   75 3f                   jne    292
>>
>> Is it an expensive price...
> 
> Can we somehow only override the kick method?
> Then take the ring and send it over ...
> 

Could you please take a look at this code?
https://github.com/pizhenwei/linux/blob/virtio-of-github/drivers/virtio/virtio_fabrics.c#LL861C13-L861C23

> 
>> 2, Storage/FS specific remote protocol is quite popular, otherwise I'm not
>> familiar with other device protocols. For example, I need a remote crypto
>> device to accelerate HTTPS ... With Virtio Over Fabrics, I have a chance to
>> attach a virtio-crypto device to do this work.
>>
>> -- 
>> zhenwei pi
> 

-- 
zhenwei pi

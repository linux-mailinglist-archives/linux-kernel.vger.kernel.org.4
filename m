Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4119706316
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 10:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbjEQIjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 04:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjEQIiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 04:38:50 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7F4D3C30
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 01:38:00 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-24dec03ad8fso485281a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 01:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1684312680; x=1686904680;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/lS0VerKT/K5L5+mTBdB0d9Ml3aR+Xdun4CK+Oz2SxI=;
        b=TtyWNefnV49cwEOlKU8y2jD+mhN5zLQYPxbCTrObAYp/C192RW6uoewbVjaYQfg9yo
         i/yxj0UcotS7dAZ0cUxJpju9r9PSoW8N9SK9Qs6tAdHjtgYdO4hOoYb8eXdLhgtB/TkG
         I3TCiKLegp9VJ/F/+oLMaD3/7k3UUIliS1Wqm4UXeMOrD0ZMhZDF3ADvAn03ktJ9BQ81
         sbkq+yAqCmih3F0vxoOzpI4TYB3rtnCPrjAlbrhO7G8fxrmNRBDRB/1opljUYn6lCakP
         aVc8fi+PXGDb/FM9anQX24DlH/AO7MDJh20Pa4vKQHkP2EbLHAnB5RuC7EzAOMHLNSRy
         Sp9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684312680; x=1686904680;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/lS0VerKT/K5L5+mTBdB0d9Ml3aR+Xdun4CK+Oz2SxI=;
        b=NoXV+ibdZa5tVvfgIxoSplnaZZKmzKA/XKAigd+RMJiD10b/fMzVUbhNEATavwc4oU
         0y/vsNp3insYUn7P54xuefg+Jnm8b1ajjFVyfT242nqRQA8qhvZVSN7MQxbmLBq+aJ1J
         3XdMTU1sNzgvEuBaa2avoyYXOY7BODv6zIkEO97IAjF75RyRf/Wbx/ta8W79aXDVewvD
         HM/4rQfqS10cmqdYpJ9OyOha4PvS2peis2Ik9B3EFShBi0l1CmZT54rXGdcZ+HJ7cTfW
         fBgND95R/r6SrHweTXmUjNZUPM6zSPAmcWd9M1UxM0hMi1h5Bk7wjm2Zj1UrdD7m9RRe
         omGg==
X-Gm-Message-State: AC+VfDxlrLCBQ6Fz9FHnFvTC4bbs5X+SW2TIBuOJO9u95+scyDZ777tL
        2vPzqlRKDvJ2Aq0Khtp3EgNkEbWdrafgX0tI5Ak=
X-Google-Smtp-Source: ACHHUZ4BAUBHc0m+lbjNIyl3j50KkdyimAn6S9D1Z8XxzconpCTqA/x2z83kBTjmPp49D30NwUggRg==
X-Received: by 2002:a17:90a:dd88:b0:252:e7e2:fefe with SMTP id l8-20020a17090add8800b00252e7e2fefemr11945883pjv.2.1684312680236;
        Wed, 17 May 2023 01:38:00 -0700 (PDT)
Received: from [10.3.43.196] ([61.213.176.7])
        by smtp.gmail.com with ESMTPSA id f24-20020a17090ace1800b002405d3bbe42sm1030351pju.0.2023.05.17.01.37.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 01:37:59 -0700 (PDT)
Message-ID: <cc9f3aea-b8bc-f312-41bb-3fd68083aa99@bytedance.com>
Date:   Wed, 17 May 2023 16:35:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: Re: [PATCH v2 1/2] virtio: abstract virtqueue related methods
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     stefanha@redhat.com, mst@redhat.com, jasowang@redhat.com,
        xuanzhuo@linux.alibaba.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20230517025424.601141-1-pizhenwei@bytedance.com>
 <20230517025424.601141-2-pizhenwei@bytedance.com>
 <ZGSEq197W8VvOWCc@infradead.org>
 <9e4702f2-5473-2139-3858-ae58817bc7b5@bytedance.com>
 <ZGSGQWqbtdwGXurf@infradead.org>
From:   zhenwei pi <pizhenwei@bytedance.com>
In-Reply-To: <ZGSGQWqbtdwGXurf@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/17/23 15:46, Christoph Hellwig wrote:
> On Wed, May 17, 2023 at 03:43:03PM +0800, zhenwei pi wrote:
>> I have a plan to introduce 'Virtio Over Fabrics'(TCP&RDMA) as Virtio
>> transport, as mentioned in cover letter of this series:
>> 3 weeks ago, I posted a proposal 'Virtio Over Fabrics':
>> https://lists.oasis-open.org/archives/virtio-comment/202304/msg00442.html
> 
> Just don't do it.  Please define your own protocols over RDMA or TCP
> for exactly the operations you need (for many they will already exist)
> instead of piggyg backing on virtio and making everyone else pay the
> price.
> 

Hi

1, `virtqueue_add_inbuf` in current version:
static inline int virtqueue_add_inbuf(struct virtqueue *vq,
                                       struct scatterlist *sg,
                                       unsigned int num,
                                       void *data,
                                       gfp_t gfp)
{
         if (likely(!vq->abstract))
                 return vring_virtqueue_add_sgs(vq, &sg, num, 0, 1, 
data, NULL, gfp);

         return vq->add_sgs(vq, &sg, num, 0, 1, data, NULL, gfp);
}

And disassemble 'virtinput_queue_evtbuf':
static void virtinput_queue_evtbuf(struct virtio_input *vi,
                                    struct virtio_input_event *evtbuf)
{
         struct scatterlist sg[1];

         sg_init_one(sg, evtbuf, sizeof(*evtbuf));
         virtqueue_add_inbuf(vi->evt, sg, 1, evtbuf, GFP_ATOMIC);
}

I notice that two instructions are newly added for vring like:
  24d:   80 78 35 00             cmpb   $0x0,0x35(%rax)
  251:   75 3f                   jne    292

Is it an expensive price...

2, Storage/FS specific remote protocol is quite popular, otherwise I'm 
not familiar with other device protocols. For example, I need a remote 
crypto device to accelerate HTTPS ... With Virtio Over Fabrics, I have a 
chance to attach a virtio-crypto device to do this work.

-- 
zhenwei pi

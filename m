Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92BBA746C3F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 10:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231667AbjGDIoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 04:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231656AbjGDIoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 04:44:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9605A127
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 01:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688460196;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5wxHSZzQ3h16AMk8/bw5gkQqg1j0+pjTKVpjRmfziQs=;
        b=AQ8KTRfJHDMfbyZ6DQjkVpvqZygmBFQPESFlFdKAetYwGkoyPsnYc833tIUaRQEZXj22bS
        3aoSyDZdGHA3mqFSAMru22o81xBIPXAeUYB7x/mot/da4a1xv/7q54qKHNGi/9sjuppl9V
        3qOPkGSQLkzgkCFMbOITpffWMFbqQ4U=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-115-b0syS39oNyakSQYOaSQ38A-1; Tue, 04 Jul 2023 04:43:13 -0400
X-MC-Unique: b0syS39oNyakSQYOaSQ38A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 222A21C05EB3;
        Tue,  4 Jul 2023 08:43:13 +0000 (UTC)
Received: from [10.39.208.32] (unknown [10.39.208.32])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9E3C7F6419;
        Tue,  4 Jul 2023 08:43:09 +0000 (UTC)
Message-ID: <0630fc62-a414-6083-eed8-48b36acc7723@redhat.com>
Date:   Tue, 4 Jul 2023 10:43:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v1 0/2] vduse: add support for networking devices
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>, xieyongji@bytedance.com,
        david.marchand@redhat.com, lulu@redhat.com,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        xuanzhuo@linux.alibaba.com, eperezma@redhat.com
References: <20230627113652.65283-1-maxime.coquelin@redhat.com>
 <20230702093530-mutt-send-email-mst@kernel.org>
 <CACGkMEtoW0nW8w6_Ew8qckjvpNGN_idwpU3jwsmX6JzbDknmQQ@mail.gmail.com>
 <571e2fbc-ea6a-d231-79f0-37529e05eb98@redhat.com>
 <20230703174043-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From:   Maxime Coquelin <maxime.coquelin@redhat.com>
In-Reply-To: <20230703174043-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/3/23 23:45, Michael S. Tsirkin wrote:
> On Mon, Jul 03, 2023 at 09:43:49AM +0200, Maxime Coquelin wrote:
>>
>> On 7/3/23 08:44, Jason Wang wrote:
>>> On Sun, Jul 2, 2023 at 9:37 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>>>>
>>>> On Tue, Jun 27, 2023 at 01:36:50PM +0200, Maxime Coquelin wrote:
>>>>> This small series enables virtio-net device type in VDUSE.
>>>>> With it, basic operation have been tested, both with
>>>>> virtio-vdpa and vhost-vdpa using DPDK Vhost library series
>>>>> adding VDUSE support using split rings layout (merged in
>>>>> DPDK v23.07-rc1).
>>>>>
>>>>> Control queue support (and so multiqueue) has also been
>>>>> tested, but requires a Kernel series from Jason Wang
>>>>> relaxing control queue polling [1] to function reliably.
>>>>>
>>>>> [1]: https://lore.kernel.org/lkml/CACGkMEtgrxN3PPwsDo4oOsnsSLJfEmBEZ0WvjGRr3whU+QasUg@mail.gmail.com/T/
>>>>
>>>> Jason promised to post a new version of that patch.
>>>> Right Jason?
>>>
>>> Yes.
>>>
>>>> For now let's make sure CVQ feature flag is off?
>>>
>>> We can do that and relax on top of my patch.
>>
>> I agree? Do you prefer a features negotiation, or failing init (like
>> done for VERSION_1) if the VDUSE application advertises CVQ?
>>
>> Thanks,
>> Maxime
> 
> Unfortunately guests fail probe if feature set is inconsistent.
> So I don't think passing through features is a good idea,
> you need a list of legal bits. And when doing this,
> clear CVQ and everything that depends on it.

Since this is temporary, while cvq is made more robust, I think it is
better to fail VDUSE device creation if CVQ feature is advertised by the
VDUSE application, instead of ensuring features depending on CVQ are
also cleared.

Jason seems to think likewise, would that work for you?

Thanks,
Maxime

> 
> 
>>> Thanks
>>>
>>>>
>>>>> RFC -> v1 changes:
>>>>> ==================
>>>>> - Fail device init if it does not support VERSION_1 (Jason)
>>>>>
>>>>> Maxime Coquelin (2):
>>>>>     vduse: validate block features only with block devices
>>>>>     vduse: enable Virtio-net device type
>>>>>
>>>>>    drivers/vdpa/vdpa_user/vduse_dev.c | 15 +++++++++++----
>>>>>    1 file changed, 11 insertions(+), 4 deletions(-)
>>>>>
>>>>> --
>>>>> 2.41.0
>>>>
>>>
> 


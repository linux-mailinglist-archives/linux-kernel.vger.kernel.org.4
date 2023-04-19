Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA2BF6E8279
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 22:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231292AbjDSUSh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 16:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231658AbjDSUSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 16:18:35 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C215FD2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 13:18:33 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-5144427bad7so18845a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 13:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1681935513; x=1684527513;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bvZWJ1N6yNvRBqGXQz8TnJs0OJnTiWfSHlO4iBrhO8M=;
        b=BEliT26iov9LcAPuQgrau9zf1VtcgOoB1JsGu12bU6DGQ5+WFUv0KRukD0OpYmnVvW
         bJyaxfMfmViOdXx6wc3UJ7Tl7saJ4tzfR1KyR4lYZ+9nPSd3hydd1hBHSBjYFxdeeRnK
         U7ergnMoNOJvl+jcQf7j+hjaBJl510TU9dJX5QRDHxWicyKaPh8GqibO+HASM8u9nVUL
         vhXzZuhS4YquTc8x60ayp+d9VYF+SOyXnKdT4L23S0GMTgRF1t+D/tjfn53RGfvc65Il
         zCi/YGVSPNgqzLUTY6ANxDqAyg0p6WilaYat+wOZ+PgSODlmvhjdPSZu+BvjWoZBHrE7
         K+dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681935513; x=1684527513;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bvZWJ1N6yNvRBqGXQz8TnJs0OJnTiWfSHlO4iBrhO8M=;
        b=l59l5I0Szj/1Z1SKGjabIHlwf47QQ1mO2h0LWRmpWySrb8R2jHDgjwwAN4MIYPqkeY
         qtTjDlF8bw4fKOmpk744uaK90+ZdkD/Mvrge8Za+EgG2uyrO9Z4KcAZ5+Uqd16n5Bqw7
         MFi5YJ3X7UB+z+GuLJkDagoKAKubC3QFPpzxeY0FJlnAR/64YgzIUeNs3iRYQHo0UGTf
         S3elTP0hhFnZnhhR1D1j719rJ8XCmYrpkUAsu61M4ZqVfWicgYi9OYFXBChgOipg4CsZ
         ZEwTKdqEeMi0iYbHHHmkADJBD9IA+TtA5CSSngaGYd9lGDYrDSAdMgcIiuKgbeL8DGrm
         xBBA==
X-Gm-Message-State: AAQBX9cPb8nqvdKFTqAXD2f6s4HS9z/OGxN/VilaO0qzebOQ7IRm+dS5
        /UTnOxMjfwmxvl2f5H0GreB+Ug==
X-Google-Smtp-Source: AKy350aG0Hna+djHmBzENfUMBVtPE6gQ/3CtrN793ZrG4uogFpDSa5BVa2GWvgXVQVDVBNR025EUAg==
X-Received: by 2002:a17:903:2308:b0:19a:a815:2877 with SMTP id d8-20020a170903230800b0019aa8152877mr23336646plh.6.1681935513184;
        Wed, 19 Apr 2023 13:18:33 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id iz17-20020a170902ef9100b001a19f2f81a3sm11825243plb.175.2023.04.19.13.18.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Apr 2023 13:18:32 -0700 (PDT)
Message-ID: <c4e95c1b-43da-30b2-b120-e59fa5b68b18@kernel.dk>
Date:   Wed, 19 Apr 2023 14:18:31 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v4 4/6] io_uring: rsrc: avoid use of vmas parameter in
 pin_user_pages()
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Pavel Begunkov <asml.silence@gmail.com>,
        io-uring@vger.kernel.org
References: <cover.1681831798.git.lstoakes@gmail.com>
 <956f4fc2204f23e4c00e9602ded80cb4e7b5df9b.1681831798.git.lstoakes@gmail.com>
 <936e8f52-00be-6721-cb3e-42338f2ecc2f@kernel.dk>
 <c2e22383-43ee-5cf0-9dc7-7cd05d01ecfb@kernel.dk>
 <f82b9025-a586-44c7-9941-8140c04a4ccc@lucifer.local>
 <69f48cc6-8fc6-0c49-5a79-6c7d248e4ad5@kernel.dk>
 <bec03e0f-a0f9-43c3-870b-be406ca848b9@lucifer.local>
 <8af483d2-0d3d-5ece-fb1d-a3654411752b@kernel.dk>
 <d601ca0c-d9b8-4e5d-a047-98f2d1c65eb9@lucifer.local>
 <ZEAxhHx/4Ql6AMt2@casper.infradead.org> <ZEAx90C2lDMJIux1@nvidia.com>
 <567b593e-2ad0-9bec-4e6f-4bbb3301524c@kernel.dk>
In-Reply-To: <567b593e-2ad0-9bec-4e6f-4bbb3301524c@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/19/23 2:15 PM, Jens Axboe wrote:
> On 4/19/23 12:24?PM, Jason Gunthorpe wrote:
>> On Wed, Apr 19, 2023 at 07:23:00PM +0100, Matthew Wilcox wrote:
>>> On Wed, Apr 19, 2023 at 07:18:26PM +0100, Lorenzo Stoakes wrote:
>>>> So even if I did the FOLL_ALLOW_BROKEN_FILE_MAPPING patch series first, I
>>>> would still need to come along and delete a bunch of your code
>>>> afterwards. And unfortunately Pavel's recent change which insists on not
>>>> having different vm_file's across VMAs for the buffer would have to be
>>>> reverted so I expect it might not be entirely without discussion.
>>>
>>> I don't even understand why Pavel wanted to make this change.  The
>>> commit log really doesn't say.
>>>
>>> commit edd478269640
>>> Author: Pavel Begunkov <asml.silence@gmail.com>
>>> Date:   Wed Feb 22 14:36:48 2023 +0000
>>>
>>>     io_uring/rsrc: disallow multi-source reg buffers
>>>
>>>     If two or more mappings go back to back to each other they can be passed
>>>     into io_uring to be registered as a single registered buffer. That would
>>>     even work if mappings came from different sources, e.g. it's possible to
>>>     mix in this way anon pages and pages from shmem or hugetlb. That is not
>>>     a problem but it'd rather be less prone if we forbid such mixing.
>>>
>>>     Cc: <stable@vger.kernel.org>
>>>     Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
>>>     Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>>
>>> It even says "That is not a problem"!  So why was this patch merged
>>> if it's not fixing a problem?
>>>
>>> It's now standing in the way of an actual cleanup.  So why don't we
>>> revert it?  There must be more to it than this ...
>>
>> https://lore.kernel.org/all/61ded378-51a8-1dcb-b631-fda1903248a9@gmail.com/
> 
> Let's just kill that patch that, I can add a revert for 6.4. I had
> forgotten about that patch and guess I didn't realize that most of the
> issue do in fact just stem from that.

https://git.kernel.dk/cgit/linux-block/commit/?h=for-6.4/io_uring&id=fbd3aaf37886d3645b1bd6920f6298f5884049f8

-- 
Jens Axboe



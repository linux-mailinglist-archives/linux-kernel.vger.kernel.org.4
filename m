Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD63C65898C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 06:32:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbiL2Fb5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 00:31:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiL2Fby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 00:31:54 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0955412086
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 21:31:52 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id ge16so14565251pjb.5
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 21:31:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Pz+Fh3q8KwMyp1e1BIkdP01StsjsKBE+6Hou8VrHrnQ=;
        b=cO80+3DHnBv0fLGI/7jxhAqYmWyh9+aGwDLW3G5XSuURYE2wKkDYbJRyCpGD/MjMZ7
         poFx49z8O5PmSKiQHx8lQ1ap8UqtSJvVXllRlWaQU7EuJKBlWV2kACyLM6IvaVXDyoyB
         tOlFlgWI6mWe2ayUdunivT0YrvBd3a0/Nr0dGmA8ZXWKZtpoApIsC0fEA5h/7ElOT4B/
         oCcK8BPBJ125jL4nlCsp1iU4FiGTmDGtc13en1o0PUqycpvpp4JrXcPvxwcGqqzQiZ2E
         dXxhk6PZFh4r7T2ToyJphFENGEwPy/OW/+n77rRyOQKGa7kntyGpxvOL6y/628xLQb1j
         Pp5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pz+Fh3q8KwMyp1e1BIkdP01StsjsKBE+6Hou8VrHrnQ=;
        b=e+G9r0E6FJMckzgz4FrGsBT0KdWN0IfC7z3NT5S0az1mynwuLUDv5OQhTtjIFLoEwh
         /vzYeYgc7m+jwlyigPB96d0AEdi0mvWFrzj+XQjdaCEY7iZVya+2IhZI2L1Vws7gyIWH
         lX6L+C5cLNqjPcoU4LaS8MbdndLTdEh8bMMGFiir9OwXwV2g7x/8NrbO4cLn7Wu0QUd6
         CPCfvRQ4PXZeybWciZxFxWDovdgwWEJh02OVCXuo67HfOiczii7abZt3MbynnZ8pHhgG
         YrTKj374HfRHwWgJdwsRFCCF/7cPDgcquSWviYNefIA69T5RqEljWXqHrBztWQHid1KC
         +BwQ==
X-Gm-Message-State: AFqh2krmT8Czw0QTPo+tHYzm9Ih2KWquSD3/4oBTbudTqTcoQsOpueP6
        3wD1I+TEKUu99CM2e6j5qnk=
X-Google-Smtp-Source: AMrXdXvUgv240P0eNGdtmxMkPvqK1CST5BwBFrYXtdpYPiNftphpWn6usD75TBzHz6e3wbY1RPdolA==
X-Received: by 2002:a17:902:f60b:b0:189:e924:e279 with SMTP id n11-20020a170902f60b00b00189e924e279mr31310934plg.49.1672291912391;
        Wed, 28 Dec 2022 21:31:52 -0800 (PST)
Received: from [192.168.10.103] (ab137057.f.west.v6connect.net. [183.76.137.57])
        by smtp.gmail.com with ESMTPSA id n2-20020a170902e54200b001887e30b9ddsm11844641plf.257.2022.12.28.21.31.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Dec 2022 21:31:51 -0800 (PST)
Message-ID: <444735fd-7076-7bd3-dc5e-7135a7f3a95c@gmail.com>
Date:   Thu, 29 Dec 2022 14:31:48 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
From:   Soichiro Ueda <the.latticeheart@gmail.com>
Subject: Re: [PATCH] virtio_balloon: high order allocation
To:     David Hildenbrand <david@redhat.com>, mst@redhat.com,
        jasowang@redhat.com, akpm@linux-foundation.org
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kalutes@google.com, mhiramat@kernel.org, cwd@google.com
References: <20221223093527.12424-1-the.latticeheart@gmail.com>
 <c8ea7076-f107-c340-6b34-6b22a9369da5@redhat.com>
Content-Language: en-US
In-Reply-To: <c8ea7076-f107-c340-6b34-6b22a9369da5@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David.

> How does this affect page migration / balloon compaction etc?

I guess this patch doesn't affect balloon compaction. When allocating 
pages using alloc_pages(), it skips compaction by masking out 
__GFP_RECLAIM if the order is larger than 0.

As for page migration, in the current implementation it migrate a 
0-order page to another 0-order page. With this patch, it may migrate a 
high-order page to another same-order page.

But I noticed that the migrated high-order page is handled as 0-order 
page in virtballoon_migratepage().

 >     balloon_page_insert(vb_dev_info, newpage);

We should put the newpage into a page list of the corresponding order, 
like this.

     balloon_page_enqueue(vb_dev_info, newpage, order);

I'll fix it in the v2 patch.

Thank you,


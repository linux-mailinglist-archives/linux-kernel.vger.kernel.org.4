Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF024704262
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 02:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245599AbjEPAnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 20:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbjEPAnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 20:43:00 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35C3530FD
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 17:42:34 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-2531f846835so44831a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 17:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1684197753; x=1686789753;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m5hbCoXXCLVF8MzOJ73BXVTZCAtdnkR4Rw57AoX42iw=;
        b=Wh8br5+K13gY6AURiwlRegSvBaTL8uC7EwtJq1BLOMe7e0luIc4+ha6+12UfS735zh
         Ocl+yPlyTErcsGBqX/VGHUw+SLnGyu4XlW4Dl5Jz0HRu/i+rhzR7tW9N0L6TKK0Si8nL
         5JmMlnEr3hbtdV8SjYMk4KrqjNuM7jXts0OykrSPiss/k2yMI2Pg42JpfEy9rlkxO0nP
         FUO1pviYIAwcyT2SLF0aOJdc5+OmkdVXFnhmx0bwPdzQKXE7IlA5Tsj0kGrZWrmKhr/s
         rQSBK6FOGqfzRsw7AfObZtWEC950lfP3UeUFM0k7AK8b3viRxJI6BxK9clslOM3+d+yT
         QnOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684197753; x=1686789753;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=m5hbCoXXCLVF8MzOJ73BXVTZCAtdnkR4Rw57AoX42iw=;
        b=eEv1nVI3rIH4T8w2kj5ebzwz5DrWum8tzMUZaXJ8uxKFYv8uqq7B/uXYBa+UZS9/9p
         Ek/88OonmUAZYJv40EpnzVXdiWe0M34dH+OidyEHQlu9FWeruffBOd15oss2eXY+2h0s
         hiVKSXLIcW4ZTJKGdFP89REJniRTBB73NuErZ9ztuvbrQAx0LW++M3Fd1swmmNLOLWvQ
         pze926FNAyEqy/al6vvYiF7Wib5fqtho8GkGKNo0WxEfgtLZCs++gCbi0zBYhu92rcXM
         NAxYWJVLrLr/ENFX5gN2eWzN2rkGGrQWuwTDh0lKSsjQXY4DkuLQlKuRTl4Pn8+w1V6C
         WsrA==
X-Gm-Message-State: AC+VfDzbnrKMe6PbwlRwnlruVPZGIfBrDljN06xFjyub4ggWp9YAibAx
        d90K2BFzp3Dc8/xJqbD8QoXe3g==
X-Google-Smtp-Source: ACHHUZ6VEKvfhERfe5LC7EzstyaFNWASlsmnb1eGLL0HaEbarBYWN3row/Slh2nfhWkpgWg8E7QR4Q==
X-Received: by 2002:a17:90b:4a51:b0:247:5654:fcf3 with SMTP id lb17-20020a17090b4a5100b002475654fcf3mr35005149pjb.11.1684197753702;
        Mon, 15 May 2023 17:42:33 -0700 (PDT)
Received: from [10.200.9.178] ([139.177.225.227])
        by smtp.gmail.com with ESMTPSA id f15-20020a17090a120f00b0024e3d26f644sm243932pja.3.2023.05.15.17.42.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 May 2023 17:42:33 -0700 (PDT)
Message-ID: <9b9fb65c-ebc9-f86b-c85d-2676c1c5d0eb@bytedance.com>
Date:   Tue, 16 May 2023 08:42:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
Subject: Re: [PATCH 03/10] maple_tree: Remove __must_hold() which does not
 work
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Liam.Howlett@oracle.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        maple-tree@lists.infradead.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
References: <20230515131757.60035-1-zhangpeng.00@bytedance.com>
 <20230515131757.60035-4-zhangpeng.00@bytedance.com>
 <ZGJH3s2Z581fcbTs@casper.infradead.org>
From:   Peng Zhang <zhangpeng.00@bytedance.com>
In-Reply-To: <ZGJH3s2Z581fcbTs@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/5/15 22:55, Matthew Wilcox 写道:
> On Mon, May 15, 2023 at 09:17:50PM +0800, Peng Zhang wrote:
>> The arguments to __must_hold() seem to be wrong so they should not work,
>> remove them.
> 
> Why not fix them?
I'll fix it in v2.

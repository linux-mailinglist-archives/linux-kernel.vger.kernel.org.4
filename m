Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2166DFC14
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 19:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbjDLRAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 13:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbjDLRAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 13:00:21 -0400
Received: from out203-205-221-210.mail.qq.com (out203-205-221-210.mail.qq.com [203.205.221.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94AD58A4D
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 09:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1681318488;
        bh=6c10UxlH4LkCp7R0rruyDMs0C8VPTPNLjrwdbwagOIo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=nnlqgtF9QxMjCbUOFVb7qpnWe0J2Qnpn07cfNc6M6xdZPIZzy/Jbi7ShrlTiidenJ
         p9UdvVvVGZWwxOVDiVunhKoXb3Yh/jn12koyu3A9PKJfv6zxP205f+QF/SyOqmToCm
         DLWFxNrHxQtw9CSpjSTsHT1R9nPOycuhqX3gMy0w=
Received: from [192.168.31.3] ([106.92.97.36])
        by newxmesmtplogicsvrsza10-0.qq.com (NewEsmtp) with SMTP
        id DAD82049; Thu, 13 Apr 2023 00:54:45 +0800
X-QQ-mid: xmsmtpt1681318485ty9emqff1
Message-ID: <tencent_C3E900CCD37EF2CF49553BD4AC4120932B08@qq.com>
X-QQ-XMAILINFO: MmpliBmRb3iCqCvITsarzp+v+tIeagWROsQ1DJ7NJ9KtkOzodvs4qVMGYGQ696
         eYC36mQyTeUUfUGQcK5uAsiox8fa94FlhZ9PNeg83k4lgNlOm6LqCw0FH/aWheQ1X4hhneJFkh/V
         k77icLT4MMTKvAoOcTBheDoWtXAFoszDw+HwLqWkA/Ti52B/FCCzdrVDNHleYsTx7ckAWDJNSTKZ
         i4WPuuo/Fbhe+oH5OVhWx4wHHYXzLnxFTl5Ez+dEjCwDSexHEufpHBU2X+WJPbgrdf2J1BuxAWB8
         qsaveCJrCeFJ4TuIz+IYEY+cBbrZoeTCjls2zBOWNubEQEvl/iIayrjnOiwnUOf7Rv2v/RhDQZMM
         8j7axXGMloDfWGDgI5fV45SzintR/ROyuDGizSl6Ev+F3G4MR+IkKiZpg5cZBCSTCGdGVlrV7jDj
         /InsDex6URvSEvSNNq42XBwtXvCckEDbhGR4ApVfRQRo0JytxhWaIv1o71RcrCdyoJDKtlGGEhcr
         edfbpDcMmSgK55AyqU7U7mblqQAqmkWL5xkz2niZ2gIivWc8bWKYmCPrTjxbwpRMZJ8HxcFoyu90
         JWy1jtnnO/MBGvOIl25tzsPz5Z4yBbxOFEAGOlNgEXj9tAYTtT55M5VZ85tvtv+QNPfOP0T/UJiR
         IFR42tYlpZahjOuiZz0vPRQp01ENC6dSxCpuDv0Abhukq5RpgUtE/y/6JlhLg83/1JCQw84C+GRV
         0DzXYkZiwsP+BXIS5Njqk+WrbFh2UC5vx6AEkHr/YT0+0EECo6bsgBIYMNN+EqvbmjXEY0Ea+VtF
         UBE3oV2zdN4wuNOchAUZUh280oq/L9beFFAr3HCL3s+GJKlDLocCAt/EopE/uIgjKFbgXP/oBKNU
         aijRNTRbr4EwgMuIgN+5kPR5dxGPeR81Aq5ZDPqE+iCPWQddrIZ/rzSWRZR4ZSYdLUVtKrkXOYYs
         ZfEZUc1oq4w+krN0TZg86grLr13Esl7eaZBHRDx41iQe7iPW1h8Q==
X-OQ-MSGID: <c0e2d8ec-37f4-166b-9929-89616a883581@foxmail.com>
Date:   Thu, 13 Apr 2023 00:54:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.1
Subject: Re: [PATCH] mm: compaction: optimize compact_memory to comply with
 the admin-guide
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Oscar Salvador <osalvador@suse.de>,
        William Lam <william.lam@bytedance.com>,
        Fu Wei <wefu@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <tencent_FD958236269FD3A7996FFCF29E9BAA4EA809@qq.com>
 <20230411134801.a4aadef5aba0f51e0d44bb7a@linux-foundation.org>
From:   Wen Yang <wenyang.linux@foxmail.com>
In-Reply-To: <20230411134801.a4aadef5aba0f51e0d44bb7a@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,HELO_DYNAMIC_IPADDR,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2023/4/12 04:48, Andrew Morton 写道:
> On Wed, 12 Apr 2023 02:24:26 +0800 wenyang.linux@foxmail.com wrote:
>
>> For the /proc/sys/vm/compact_memory file, the admin-guide states:
>> When 1 is written to the file, all zones are compacted such that free
>> memory is available in contiguous blocks where possible. This can be
>> important for example in the allocation of huge pages although processes
>> will also directly compact memory as required
>>
>> But it was not strictly followed, writing any value would cause all
>> zones to be compacted. In some critical scenarios, some applications
>> operating it, such as echo 0, have caused serious problems.
> Really?  You mean someone actually did this and didn't observe the
> effect during their testing?

Thanks for your reply.

Since /proc/sys/vm/compact_memory has been well documented for over a 
decade:

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/Documentation/admin-guide/sysctl/vm.rst#n109

it is believed that only writing 1 will trigger trigger all zones to be 
compacted.

Especially for those who write applications, they may only focus on 
documentation and generally do not read kernel code.  Moreover, such 
problems are not easily detected through testing on low pressure machines.

Writing any meaningful or meaningless values will trigger it and affect 
the entire server:

# echo 1 > /proc/sys/vm/compact_memory
# echo 0 > /proc/sys/vm/compact_memory
# echo dead > /proc/sys/vm/compact_memory
# echo "hello world" > /proc/sys/vm/compact_memory

The implementation of this high-risk operation may require following the 
admin-guides.

--

Best wishes,

Wen


>> It has been slightly optimized to comply with the admin-guide.


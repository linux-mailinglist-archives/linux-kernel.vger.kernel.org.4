Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8FCC5E7147
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 03:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231896AbiIWBPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 21:15:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231886AbiIWBPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 21:15:04 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA6482740
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 18:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=rsTGS41jSRpa3ny7/TEXpba94yI95UsUdciPuDQ763I=; b=RIGqpEPBKNh+D/oBqszjqJgKNh
        uWz1lSnZzfgwj1bKzGe8vjLIpWCt9Pwq5TAmhrnia71uNx9PXHm9kzK9wG6PXZcjmiNbvkSihOIj9
        BwAH7pr9BUEI50ZqHSoAxsgQ7d5B/mUkQe4OlRJvw6nYFKxVHkaebAuHOQFdUTDZQhM3LH+/t8hAl
        N0iWwNXqwTM8XsnHJKy/p3jzAsyCU/geQbsqi5vjEl8LKHB8Uzt4XY2gWTOGfTj0NggqFzzbbtXzZ
        nW8SzS4kpqndLEWhhEhN5BvtCfzaBViq3SaHFnTZsxMdAyk10TId+tVeDqO6ypqcj7XE7Lwe337ct
        OeoODnTw==;
Received: from [2601:1c2:d80:3110::a2e7]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1obXHD-000wCR-2w; Fri, 23 Sep 2022 01:14:47 +0000
Message-ID: <d61b11b9-620e-698a-b826-22b2604a9234@infradead.org>
Date:   Thu, 22 Sep 2022 18:14:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] fs/ntfs3: fix negative shift size in
 true_sectors_per_clst()
Content-Language: en-US
To:     Joe Perches <joe@perches.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Shigeru Yoshida <syoshida@redhat.com>
Cc:     syzbot <syzbot+1631f09646bc214d2e76@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com, ntfs3@lists.linux.dev,
        LKML <linux-kernel@vger.kernel.org>
References: <000000000000f8b5ef05dd25b963@google.com>
 <4b37f037-3b10-b4e4-0644-73441c8fa0af@I-love.SAKURA.ne.jp>
 <e0173c17-3837-a619-4bcc-7a0ba4843cc4@infradead.org>
 <34b60d0ed48e4384e82a29020702ee2471092fb1.camel@perches.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <34b60d0ed48e4384e82a29020702ee2471092fb1.camel@perches.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/22/22 17:47, Joe Perches wrote:
> On Thu, 2022-09-22 at 17:38 -0700, Randy Dunlap wrote:
>> it appears that the NTFS3 maintainer is MIA again. :(
> 
> (I've no affiliation with the NTFS3 maintainer or paragon)
> 
> Perhaps the expectation of prioritized immediate turnaround is unrealistic.
> 
> It's free.  Be patient.
> 

Yes Joe, I get that.

https://lore.kernel.org/all/da20d32b-5185-f40b-48b8-2986922d8b25@stargateuniverse.net/


-- 
~Randy

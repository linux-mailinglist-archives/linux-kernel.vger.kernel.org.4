Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B85786E5028
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 20:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbjDQS26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 14:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjDQS24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 14:28:56 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2082420F
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 11:28:54 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-50671ef0c48so427749a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 11:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681756133; x=1684348133;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0lqi6e8RVymVTF7fcFUOheURxMqgPbsBHzaUXSbYH78=;
        b=LOBAzaOnsbv+xJP9yrRAQZbI6B1nC83pWaavjbDytCM09qdqR5xvP/kOGyGhyhJitE
         KeFPQxLE9aNAeW1K964mlXNqJnmye34SZhx0h6fSjZutXCXd9fORM/8rV2tklwzzLNQZ
         unFClX8U9/out3OBbsRqjF9TqIZvUyxfnirs0dD5tVubtnARlTCHDsVc9473jaXtDh9u
         yQo8XH/bcZziG8vVyG4OQ7yQJpWLA0UsdMHpOjfJB2LbZnfjTok5V2+a/6Ge25MLKsFi
         D0H0C9s5cYSU+CGEfWy7YlAoMvB6Zpw6/uropFfLFEjewyhLKYjtqFIYkDDkCX3R08Xb
         WqsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681756133; x=1684348133;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0lqi6e8RVymVTF7fcFUOheURxMqgPbsBHzaUXSbYH78=;
        b=EGs9CrJdApjX1Lf5TTffhsCTDX9bF131dXzkbwlWb/DxZVH2HoQOba+miy6c4orib2
         aYF9wVemHi07Wa+jfDSO6LKoBAt8riQzC32wOYyjU80rgno44S9dzRS2zWv9LBzei5Wl
         4qh3v0Cet//NabqJAdkq62R0zkPDmolh3IQBv7gv5ofYTTcz479AVOgNrcCUnbYjRiFW
         znzplVSjC/Vefnnw5ySJYy5e8Ga3CxLbv7Owl6nC4+jqeM1xy4Rwv+iEUTXfNxL99/OM
         hn7buQOjwk4KRSyHexH/OGpRt3jJwESNra0ATFNkULU2HlH6nj5YWOROXjUlLqrNp1/b
         aQzQ==
X-Gm-Message-State: AAQBX9fynRGyws5+/KVHJuC5+6Nf7D+87cJpqNhZoEmSDrWYb7rDTFpw
        qPqVd19SdpAnJFq3epd3rSM=
X-Google-Smtp-Source: AKy350YbvOqbJZgTK9Sfz/uzC+CuwIZ0d5X/ModBjEaxuEa/1srzK+Ja6pWa6tWd/92z8dNPYbu33w==
X-Received: by 2002:a17:906:7a45:b0:947:bff2:1c2d with SMTP id i5-20020a1709067a4500b00947bff21c2dmr11215147ejo.3.1681756133240;
        Mon, 17 Apr 2023 11:28:53 -0700 (PDT)
Received: from [192.168.10.10] ([37.252.92.4])
        by smtp.gmail.com with ESMTPSA id e17-20020a17090681d100b0094f2f1c5ea1sm3618588ejx.174.2023.04.17.11.28.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Apr 2023 11:28:52 -0700 (PDT)
Message-ID: <5dc97e10-8c64-4818-2642-dd8edb21c016@gmail.com>
Date:   Mon, 17 Apr 2023 22:28:51 +0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2] mm: khugepaged: Fix kernel BUG in
 hpage_collapse_scan_file
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>,
        Zach O'Keefe <zokeefe@google.com>
Cc:     Yang Shi <shy828301@gmail.com>, himadrispandya@gmail.com,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org, linux-mm@kvack.org,
        skhan@linuxfoundation.org,
        syzbot+9578faa5475acb35fa50@syzkaller.appspotmail.com,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>
References: <20230330155305.423051-1-ivan.orlov0322@gmail.com>
 <20230331013301.ecgkjymaf3ws6rfb@google.com>
 <CAHbLzkoJ2zvKZpqd6NqikpCc8rGR02C87f0fPq8qwb1BF3K+9Q@mail.gmail.com>
 <CAAa6QmTLXSvygQQNk=8C4pB3D2Twy1guzo=+-aXhCqNAE3Q3MA@mail.gmail.com>
 <20230416113335.caeafda1328fdd4bfe2406e8@linux-foundation.org>
From:   Ivan Orlov <ivan.orlov0322@gmail.com>
In-Reply-To: <20230416113335.caeafda1328fdd4bfe2406e8@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.04.2023 22:33, Andrew Morton wrote:
> 
> Circling back to this fix...
> 
> The BUG() is obviously real.  We're unsure that Ivan's fix is the best
> one.  We haven't identified a Fixes:, and as this report is against the 6.2
> kernel, a cc:stable will be needed.
> 
> According to the sysbot bisection
> (https://syzkaller.appspot.com/bug?id=7d6bb3760e026ece7524500fe44fb024a0e959fc),
> this is present in linux-5.19, so it might predate Zach's
> 58ac9a8993a13ebc changes.  But that bisection claim might be
> misleading.
> 
> And Zach is offline for a few months.  So can people please take a look
> and see if we can get this wrapped up?
> 
> Matthew, the assertion failure is in the
> 
> 	VM_BUG_ON(index != xas.xa_index);
> 
> which was added in 77da9389b9d5f, so perhaps you could take a look?
> 
> Thanks.

Tested today on the latest rc7, the bug still exists.

Kind regards,
Ivan Orlov.

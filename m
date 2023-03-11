Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7F826B5B75
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 13:08:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbjCKMId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 07:08:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbjCKMI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 07:08:29 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B3228E60
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 04:08:28 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id k10so30938071edk.13
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 04:08:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678536507;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=woZf4q42tHp49ueUObZVIIXGfTyB8+07d5DSIpk0Q8g=;
        b=WPYwAccQXHiJdDjnDz+rXTtABM29ygVJxLl8hQPRJFAKYpPQwHdAubyQaUwhhq3aVG
         B+JdRYGF7rL+wZ6WqZMHPh0rMZj/u9N5xj6RawCzqh8EtJ2W0FmFwKCzA9Pni0f5QHSd
         3zbn0F6SvxDYoYJy+PzY2M/YdtmUPrQghqX0osce62gXZoUGBoEuxc2FZieXxxiEnAfs
         DtKElA2SXd5WCLyFZ1YeA44sut+i0kMVLrciZRkzXHf9/+aGGgHl5Y3JIv8GQ6dfyeWr
         9D3aAYvwvnVtlYJA/HklLJLNQLNvPUFn64/RvAkXMtjRIlRse1SYMoe0qQUJK/sJN7ps
         1mmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678536507;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=woZf4q42tHp49ueUObZVIIXGfTyB8+07d5DSIpk0Q8g=;
        b=SjhlofN/MtzTkr6/oJMB0sV7jqs+rMzocm7OPlNBEWp4wmsw0KbPt/KpXHjDxGc+HW
         S8n+LN2VQypNKg8hMQqmq6lgXmmQk+oIdiWna/rIi8asSaH+Sb00SJNAkCim6G3SLKP8
         gTvphjYIC9k/VrSpht3PzREpaDV15c6sSkfFzvX5/gWhvBxp7q1+F9YaJOegq+1/76WT
         7fMNJCZlzpz/F6jTxDydX9lQuZRMyLwbEDIZL5kZQswEIHTdnl7ul8aD6TBecbrM1wAo
         48CumyPLp6cmRpJXBegAB/78h8rW7RdROeu05Q0tTvd5WmphAR67FmrhTJ6lB0aqkjEX
         ZyLQ==
X-Gm-Message-State: AO0yUKXNVdC6HreDjAXY0l0hgYh6POp5dK0CqXQEqhaW/upxPJslOgVu
        iPA2YjTrd5FtFRell8hjFIY=
X-Google-Smtp-Source: AK7set8cQ3IbVQPp5rW5j8R8T3zo8ov/GFyoNFWjqTDVvvEQiHzd/8Z7sjsG8mC30eypxr0i6sJvQA==
X-Received: by 2002:a17:906:1cd:b0:8ae:ea08:3842 with SMTP id 13-20020a17090601cd00b008aeea083842mr5139696ejj.7.1678536506741;
        Sat, 11 Mar 2023 04:08:26 -0800 (PST)
Received: from [192.168.10.15] ([37.252.81.68])
        by smtp.gmail.com with ESMTPSA id g9-20020a1709061e0900b008c607dd7cefsm1040131ejj.79.2023.03.11.04.08.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Mar 2023 04:08:26 -0800 (PST)
Message-ID: <f23b861f-25ea-785d-83b3-f66d924d663f@gmail.com>
Date:   Sat, 11 Mar 2023 16:08:24 +0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2] 9P FS: Fix wild-memory-access write in v9fs_get_acl
Content-Language: en-US
To:     Christian Schoenebeck <linux_oss@crudebyte.com>, ericvh@gmail.com,
        lucho@ionkov.net, asmadeus@codewreck.org
Cc:     v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, himadrispandya@gmail.com,
        syzbot+cb1d16facb3cc90de5fb@syzkaller.appspotmail.com
References: <20230311063411.7884-1-ivan.orlov0322@gmail.com>
 <15987509.0H6QrEVh2d@silver>
From:   Ivan Orlov <ivan.orlov0322@gmail.com>
In-Reply-To: <15987509.0H6QrEVh2d@silver>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/11/23 15:17, Christian Schoenebeck wrote:
> I would have written it in different style:
> 
>      if (buffer_size)
>          retval = -ERANGE;
>      else if (attr_size > SSIZE_MAX)
>          retval = -EOVERFLOW;
>      else
>          retval = attr_size; /* request to get the attr_size */
> 
> But the behaviour change itself makes sense, so:
> 
> Reviewed-by: Christian Schoenebeck <linux_oss@crudebyte.com>
> 
>>   	} else {
>>   		iov_iter_truncate(&to, attr_size);
>>   		retval = p9_client_read(attr_fid, 0, &to, &err);
>>
> 
> 

You are right, the condition can be simplified, thank you! I will 
rewrite it, send as v3 and mention you in 'suggested-by'.

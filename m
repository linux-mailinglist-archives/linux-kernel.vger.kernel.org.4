Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5726DE728
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 00:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbjDKWVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 18:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjDKWVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 18:21:41 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B0FF4690;
        Tue, 11 Apr 2023 15:21:38 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-632384298b3so4671580b3a.0;
        Tue, 11 Apr 2023 15:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681251698; x=1683843698;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1ETmRcnehhybnEI86n4Gc/yO28SHDGhZ9QbmN5Y7fH0=;
        b=VeHgXdmWKbb4HVSxfAYGyHfg8vMDtyztkS13Yeg9rMElbkUuXm5+7RmyBR7ryxki1P
         8atBVymkrqhajwLFudsWrLAXbKVE1+5kmdVfghAFuKHM1yHxkKfSd9taUuSK6POSybN5
         2jeiVEHdCGZN7Q56S+5JguVj8jAQT82hIJ6XXqYc0bh7zX+mY4KX4iN9t1HurwUN33YC
         UFYzgOA19qobq5h+Tncp66t4z/ej7gtDFfZwmiNl4g7Sf0EWMHB8Nl91aYyD9gvbDbqb
         uJ9UiWEneuUAZbmXNV5WJ1e92yeLIvN5jHc0ZY3H+UnH+kbKeBpHo8PEtfFj4NDFPNKN
         LD/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681251698; x=1683843698;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1ETmRcnehhybnEI86n4Gc/yO28SHDGhZ9QbmN5Y7fH0=;
        b=UjR1BjwUEfxc8E/CcXQqk7lx36cXeSDlF4tE3mRMJ1Q7yHjOW/HVl9ehsKb2ell5SP
         ABq9IpoRyWJjlhD36ml1FTLEvxUWUolYRCrO4nAyby7aJL6saBJ6N6hmnikEP3RgzP6I
         f7bmrFyWfpGjMikNIUZKWaN+fBhzp83Hf30W2svQ2CfS05+hZwtMWYa7IX9tU40uGHOE
         v9Y0NFbwCaeYqFH5/mSvmmaToJ0oZt7KULjFkfShRxu/aBc8bYD6KVYvmRDp5Z9EizMB
         1uS/5w4SmlZvoh5KH1Xjr/TmHOMgB/6uUIaPtZ6I4JDWZshNGyFtKRljTlyevMG3YgGl
         LydA==
X-Gm-Message-State: AAQBX9c9nsZYkzWqdpDRm7zNB8NKYa75c/80tKwfcebBAszrnYgC+CVe
        ehVBy5TdJHVggv2YPhkTYgs=
X-Google-Smtp-Source: AKy350ZvAkA9a6dL0VPxlq3gDDBpU0zt5qIVNcBQe5CpZDIJHV0+7tJ43p1XrzBGKXDjGd+2ioe5Bg==
X-Received: by 2002:a05:6a00:2dc:b0:5a8:c913:b108 with SMTP id b28-20020a056a0002dc00b005a8c913b108mr652852pft.9.1681251697837;
        Tue, 11 Apr 2023 15:21:37 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id c4-20020aa78e04000000b006395330344esm3784915pfr.29.2023.04.11.15.21.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Apr 2023 15:21:37 -0700 (PDT)
Message-ID: <db25c4cb-e786-d17c-d82a-c2450f4226a2@gmail.com>
Date:   Tue, 11 Apr 2023 15:21:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] Documentation: firmware: Clarify firmware path usage
Content-Language: en-US
To:     Jonathan Corbet <corbet@lwn.net>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
References: <20230402135423.3235-1-f.fainelli@gmail.com>
 <87y1mzcq9y.fsf@meer.lwn.net>
 <1f4b874b-bd1e-17ff-51dd-19bf2d73214f@gmail.com> <ZDT39frTIqpX5p9O@kroah.com>
 <87wn2i9i3l.fsf@meer.lwn.net>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <87wn2i9i3l.fsf@meer.lwn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/11/23 15:20, Jonathan Corbet wrote:
> Greg KH <gregkh@linuxfoundation.org> writes:
> 
>> On Mon, Apr 10, 2023 at 04:12:32PM -0700, Florian Fainelli wrote:
>>> I was not sure whether it was on purpose or not, Greg, will we break
>>> anyone's use case if we strip off \n from the firmware path passed via
>>> sysfs?
>>
>> I do not know, sorry.
> 
> I would be amazed if anybody is putting newlines into their firmware
> path; that would be kind of a silly thing to do.
> 
> That said, I've been amazed before.
> 
> I'll go ahead and apply the docs patch, but it still doesn't really seem
> like the right fix to me.

I will submit a patch that strips off newlines from sysfs provided 
firmware paths and if this turns out to break someone's use case it 
could still be reverted, sounds good?
-- 
Florian


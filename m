Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF996E7656
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 11:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232627AbjDSJdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 05:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232803AbjDSJdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 05:33:01 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06A72AF1B
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 02:32:37 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1a66911f5faso23483885ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 02:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1681896756; x=1684488756;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QXsVaUvbQp1yfAD4IIToN0aYGCJ2kKjYgYVm3E9naLY=;
        b=BXEKgOUrCX05j7qiFwwrzCmL4QuEmnEdaORFGDoIN5R3iGiMZYhgB4sj4RUTPaONFU
         96oxVufvNlJGU7M5PZw0UEPU63t815pXvWwcL/+BDyitUi5ZvCBCGiacdh6vBzwcojCJ
         kYeRVH2VMnTTMBu7I4rz6NPB9keGY1mzZDV9vQBC8R9KaTPCwIqDqP7zM6JRyOGjTnfw
         lSUUCKtz8hMHVU/4y0sZ3gvtP0rIf73C3bRKXIYGoDlMvXUGNCqYBwCpHJBnjwsLXRH8
         B5TDCYk8K0Cq5VRbksz5KZhjb0uL3rMlhZZEzONdC4vhVy95wAYNQZ0fkAqc2guylPEi
         rk7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681896756; x=1684488756;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QXsVaUvbQp1yfAD4IIToN0aYGCJ2kKjYgYVm3E9naLY=;
        b=QnH/xbAGyFGtkVDuX1/L9ve1JYOO6ILY7eVxzB1+aTTwuBF9Eyomw3VVLohA2UqAb8
         NRY7o4mtlEScZECddougoSig7O15tX+SS8ewuik2MgnIuWjpMeuL8uI2OPcwE12FvlbM
         u7nIixMJFHlBahbG3kYCkpARISGKrFaiI8RKaSSZIaF5LG5CKK0Fl2UuwRNGCjQavehh
         VFUYQHqapxMtYUjWjwPh8BSFJXSdAOy35ZckY441hxErzkyt7QPHPeoezHpoGPmt+QAO
         ES7EN9IFdqc2hy+X8xoWLY+LGOg1Rl2wdbDlhQgCLiwavoGC4pzUO31IOP/MCNFSmLl/
         NkZw==
X-Gm-Message-State: AAQBX9fofBIm1wTT6NklysQcLuns7vbbTwRs+0+P5/UTuCqgTrQd/cLW
        zl2GAVaYBBOCSNPTQRJIKCSHDvFcu8f8IrqvGVjDKQ==
X-Google-Smtp-Source: AKy350b3vkOtIJwELys4kl8n3V2IRLGI21Wne9SCaN1H7Lqjz9bzFAJ232fnooLWPegjPrypMwKW8Q==
X-Received: by 2002:a17:902:e892:b0:1a8:13fc:a654 with SMTP id w18-20020a170902e89200b001a813fca654mr3555501plg.25.1681896756526;
        Wed, 19 Apr 2023 02:32:36 -0700 (PDT)
Received: from [10.54.24.141] ([143.92.118.3])
        by smtp.gmail.com with ESMTPSA id b9-20020a1709027e0900b001a6db2bef16sm5231179plm.303.2023.04.19.02.32.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Apr 2023 02:32:36 -0700 (PDT)
Message-ID: <9413fc25-e7d6-718f-18f2-cf0b9ac60b9c@shopee.com>
Date:   Wed, 19 Apr 2023 17:32:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.1
Subject: Re: [PATCH 2/2] vfs: clean up d_backing_inode() function
To:     Miklos Szeredi <mszeredi@redhat.com>
Cc:     viro@zeniv.linux.org.uk, bigeasy@linutronix.de, mcgrof@kernel.org,
        xiubli@redhat.com, linux-kernel@vger.kernel.org
References: <20230419072736.172593-2-haifeng.xu@shopee.com>
 <CAOssrKfCiByavRNekRUOCv==AEvWAO6B6=tAASyYdvWj9XRhBw@mail.gmail.com>
From:   Haifeng Xu <haifeng.xu@shopee.com>
In-Reply-To: <CAOssrKfCiByavRNekRUOCv==AEvWAO6B6=tAASyYdvWj9XRhBw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/4/19 16:05, Miklos Szeredi wrote:
> If we are touching that function, I'd just get rid of it completely
> (s/d_backing_inode/d_inode/).
> 
> Thanks,
> Miklos
> 
> On Wed, Apr 19, 2023 at 9:27 AM Haifeng Xu <haifeng.xu@shopee.com> wrote:
>>
>> Using an extra variable to record the inode is unnecessary, return it
>> directly.
>>
>> Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
>> ---
>>  include/linux/dcache.h | 4 +---
>>  1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/include/linux/dcache.h b/include/linux/dcache.h
>> index 13023c7211d6..97324b6434e5 100644
>> --- a/include/linux/dcache.h
>> +++ b/include/linux/dcache.h
>> @@ -540,9 +540,7 @@ static inline struct inode *d_inode_rcu(const struct dentry *dentry)
>>   */
>>  static inline struct inode *d_backing_inode(const struct dentry *upper)
>>  {
>> -       struct inode *inode = upper->d_inode;
>> -
>> -       return inode;
>> +       return upper->d_inode;
>>  }
>>
>>  /**
>> --
>> 2.25.1
>>
> 

Yes, d_backing_inode() does the same thing with d_inode(). Thanks for your suggestion.

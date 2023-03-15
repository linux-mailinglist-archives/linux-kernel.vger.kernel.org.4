Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 936786BBD10
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 20:15:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232823AbjCOTPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 15:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232825AbjCOTPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 15:15:04 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2B9059F8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 12:15:02 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id o12so79579180edb.9
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 12:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678907701;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Baf2PWjBq0Gi105ke8Xvgo+aDqIRuJwlvCvKEijXes0=;
        b=IgoRYgXdoFFbcnmstFic5SdbUmJ4aB4OTefYhr7xvbkvxOiXJgELZ4AtJESNuyckO9
         fonCl+mqtrswLn5g3I6OO2sFZ1eCgNANiZWWCdEc28rKxS6YN0qnP2UZJOuYpZCdJwW5
         ktN3ole6iZTfr6Xryy2wO0tzSiA9r8NYnBDfUFfUq8TxzNu1LFmaN87FdmQE5XHGgNXd
         ai54sozMTeCXBlU1LmNETgi1hS8tz9/g6jlU0+2UJLqggHxQAd3my+SdE/IWQO3xpuZd
         kGt4b3JO6HN2HN+2IoV/4sFmUs7LJF94sKLKzNhPItVkMOYDaojk/1HX0HVEPbGRelCS
         CeWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678907701;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Baf2PWjBq0Gi105ke8Xvgo+aDqIRuJwlvCvKEijXes0=;
        b=GhoMBF5EPa5udImU7H37S9W9qF3v18bpNPCsLh3e1eBFYHgKjRl7YJFWtV+tLM6ZUC
         DXP+TqnCJ/5pUYiUaY+yHAGWuabQ+y3Ro8C5K52i4WbMfDBsZbGi2cB5TFR5wRqVdn8m
         VSGuSk7PQOiB2AhRK0MRdWS05Kk3YDSdlYqIhHOSfcykptEtrHptaVJ42OXW/Ch4zyhz
         4ZNrKSz5zizjODRRtggopYZmvv1nrOjH6Fdw98Jm521w5GBNpYFYF5Os8Q0zt+ooJNrm
         XfpTvVTU6JebDz6WwwhzrpFqPp34ENZ9J9PVYfb7Y4yrPo1oirUNQKP3kGHR/gESmV5Y
         bv3Q==
X-Gm-Message-State: AO0yUKW5XUBaJXCT+ZPbH8Iiz8/WF5+oEj7WDCHEoDrjY1CubagBpx+q
        rCzztrT9faXqFgyZbWX48Cb8qZLKsT4=
X-Google-Smtp-Source: AK7set+cPuOISuBxHh59JpzUoRPxwCSn2Had8EAkwD+lF5fjBSr3jycQz9V6Ibo3JnoIcpY0YLOIgg==
X-Received: by 2002:a17:906:2450:b0:8b1:7ac6:3186 with SMTP id a16-20020a170906245000b008b17ac63186mr7671132ejb.68.1678907701117;
        Wed, 15 Mar 2023 12:15:01 -0700 (PDT)
Received: from [192.168.1.16] ([41.42.177.251])
        by smtp.gmail.com with ESMTPSA id le20-20020a170906ae1400b00921c608b737sm2853528ejb.126.2023.03.15.12.14.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Mar 2023 12:15:00 -0700 (PDT)
Message-ID: <f9988309-d4f1-8e50-555d-3fd813952893@gmail.com>
Date:   Wed, 15 Mar 2023 21:14:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/2] staging: vme_user: add space around operators
To:     Ira Weiny <ira.weiny@intel.com>, gregkh@linuxfoundation.org
Cc:     outreachy@lists.linux.dev, martyn@welchs.me.uk,
        manohar.vanga@gmail.com, zoo868e@gmail.com, jerrykang026@gmail.com,
        cuigaosheng1@huawei.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
References: <b56c7b94e59a4051373af8b5d90a0685dfc9233a.1678882204.git.eng.mennamahmoud.mm@gmail.com>
 <641212c8d481f_253a1e29437@iweiny-mobl.notmuch>
Content-Language: en-US
From:   Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
In-Reply-To: <641212c8d481f_253a1e29437@iweiny-mobl.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On ١٥‏/٣‏/٢٠٢٣ ٢٠:٤٧, Ira Weiny wrote:
> Menna Mahmoud wrote:
>> add a space before and after the operator, for readability.
>>
>> Reported By checkpatch script:
>>
>> CHECK: spaces preferred around that '+' (ctx:VxV)
>> +		image->bus_resource.name = kmalloc(VMENAMSIZ+3, GFP_ATOMIC);
>>   		                                            ^
>> CHECK: spaces preferred around that '<<' (ctx:VxV)
>> +	temp_ctl &= ~(3<<4);
>>   	               ^
>> CHECK: spaces preferred around that '>>' (ctx:VxV)
>> +	cbar = (cbar & TSI148_CRCSR_CBAR_M)>>3;
>>   	                                   ^
>> CHECK: spaces preferred around that '<<' (ctx:VxV)
>> +		iowrite32be(cbar<<3, bridge->base + TSI148_CBAR);
> Similar comment to what Fabio made.
>
> But I'll add some formatting comments.
>
> It looks like you have submitted a 2 patch series which fixes all the
> checkpatch errors in the vme_user driver?

yes, each patch for specific error in multi-position.

>
> Kudos for separating out the 2 patches for the 2 different types of
> checkpatch errors!  And for submitting a series which fixes the entire
> driver!

to double check that i understood right, you mean I should create one 
patch-set for one error?

Because I have already done that in previous patch but Julia commented 
on it that no need to create patch-set

for the same error.


> But you should also include a cover letter for your series.
okay, I will include it.
>
> How are you creating this series?  Are you using 'git format-patch'?
> 'b4'?  If not using 'b4' I strongly recommend it.[*]

yes, used ' git format-patch` but I will try b4.

> Both of those tools can help with formatting a cover letter and b4 will
> help keep track of multiple versions of the series as you fix things.
>
> Ira
>
> [*] https://git.kernel.org/pub/scm/utils/b4/b4.git

Thanks,

Menna


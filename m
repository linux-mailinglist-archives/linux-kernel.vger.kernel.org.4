Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8B36B024C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 10:04:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbjCHJEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 04:04:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjCHJEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 04:04:25 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7317D659E
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 01:03:50 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id i5so17056426pla.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 01:03:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1678266230;
        h=in-reply-to:from:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bISq6Uew17tHFDmlqGdz5KQcv60gYaVd7PzMrTV6/9c=;
        b=GFJPqOI3HFUyuikS1Ykm25uTi9lcE7N+6czBKE1KTxYDEuDbCSiJiPino/KoMWHHOn
         vGoCjEEN6hXUkiL0h9GrxdXXmpAe5xxEKm2ijFUA6jYmUETnb+KsGBV9uzQu4JA3X/Ai
         Ad3oC5Fo5ggyqUirZXLUR7IHV4LuPyXbeNDJTA+w+Z9Gtaxt1kVmWRHDyQ4df9QJbmNr
         3MSj7uLPTo9NTGHUmgEhRBad4JyP0ZtrStEty9cm0xL00ykBInCGxSOf5FG0AjTc1yM3
         KiZ5tTBx4aADCdwZiL2y5cT6IiNYFdIcVkXoYEPBVopVhSzCTfVhIQYVMM/XB1WzzNet
         7vMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678266230;
        h=in-reply-to:from:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bISq6Uew17tHFDmlqGdz5KQcv60gYaVd7PzMrTV6/9c=;
        b=INCz1uhSD8Mmp+jngEo68rTrFnpS/A+YFx7E5zFvIwrX3UuhvJy45YxWA1DuMN9dKT
         4lfh2l3PpzIPTvexX8xrxtd0RJpF1sTsaCbjuXTYR5arNfQuv9SSAwp97zdoueLTaCTN
         PJe345AyGazDQEFX8L9Bju9aobBv+x49hwnqROqkRDNs1lt1FMIkFn3TqFK/pCDDoaNI
         OLBbR5xqXkjZXU+c3gyI2bSVOVYtnOzkAicW1RoX8d464hcqIc2KAq1dkmppwrDe5wuY
         bawiLSXcbkX8EagJqiwvhxhyOwonfg/792fyZ7rwpLzJAD66Zo+YvLY/I0rrbq0dBx6+
         DZaQ==
X-Gm-Message-State: AO0yUKXXYs3I7Dby+1h0ZYF3asR2oJVMW4bZF5PMRSCF7JboFKSM3+IV
        zyAk122WeGM9O/9iqtts2sxOx0l8vemeA50UmBU=
X-Google-Smtp-Source: AK7set/MewujGailG4KDinJPts5OCusuTpFjDcJwl8ktLqctbhfVOikLfldtPT/H8lXAevd7qVCDRg==
X-Received: by 2002:a17:903:228f:b0:19a:9945:a7aa with SMTP id b15-20020a170903228f00b0019a9945a7aamr21679406plh.20.1678266229911;
        Wed, 08 Mar 2023 01:03:49 -0800 (PST)
Received: from [10.54.24.141] (static-ip-147-99-134-202.rev.dyxnet.com. [202.134.99.147])
        by smtp.gmail.com with ESMTPSA id e4-20020a17090301c400b001992e74d055sm9566855plh.12.2023.03.08.01.03.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 01:03:49 -0800 (PST)
Content-Type: multipart/mixed; boundary="------------OQptv0miZd4Qez8ok0nBlcAw"
Message-ID: <6df72872-2829-47ab-552c-7ef8a6470e6f@shopee.com>
Date:   Wed, 8 Mar 2023 17:03:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH] mm: remove redundant check in handle_mm_fault
To:     Matthew Wilcox <willy@infradead.org>
Cc:     David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20230306024959.131468-1-haifeng.xu@shopee.com>
 <df3997ed-a844-597b-fbb1-154caad78543@redhat.com>
 <354360d5-dce6-a11c-ee61-d41e615bfa05@shopee.com>
 <ZAamFX/hq6Y/iNJb@casper.infradead.org>
From:   Haifeng Xu <haifeng.xu@shopee.com>
In-Reply-To: <ZAamFX/hq6Y/iNJb@casper.infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------OQptv0miZd4Qez8ok0nBlcAw
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2023/3/7 10:48, Matthew Wilcox wrote:
> On Tue, Mar 07, 2023 at 10:36:55AM +0800, Haifeng Xu wrote:
>> On 2023/3/6 21:49, David Hildenbrand wrote:
>>> On 06.03.23 03:49, Haifeng Xu wrote:
>>>> mem_cgroup_oom_synchronize() has checked whether current memcg_in_oom is
>>>> set or not, so remove the check in handle_mm_fault().
>>>
>>> "mem_cgroup_oom_synchronize() will returned immediately if memcg_in_oom is not set, so remove the check from handle_mm_fault()".
>>>
>>> However, that requires now always an indirect function call -- do we care about dropping that optimization?
>>>
>>>
>>
>> If memcg_in_oom is set, we will check it twice, one is from handle_mm_fault(), the other is from mem_cgroup_oom_synchronize(). That seems a bit redundant.
>>
>> if memcg_in_oom is not set, mem_cgroup_oom_synchronize() returns directly. Though it's an indirect function call, but the time spent can be negligible 
>> compare to the whole mm user falut preocess. And that won't cause stack overflow error.
> 
> I suggest you measure it.

test steps:
1) Run command: ./mmap_anon_test(global alloc, so the memcg_in_oom is not set)
2) Calculate the quotient of cost time and page-fault counts, run 10 rounds and average the results.

The test result shows that whether using indirect function call or not, the time spent in user fault
is almost the same, about 2.3ms.
--------------OQptv0miZd4Qez8ok0nBlcAw
Content-Type: text/plain; charset=UTF-8; name="mmap_anon_test.c"
Content-Disposition: attachment; filename="mmap_anon_test.c"
Content-Transfer-Encoding: base64

I2luY2x1ZGUgPHN5cy9tbWFuLmg+CiNpbmNsdWRlIDxzeXMvdHlwZXMuaD4KI2luY2x1ZGUg
PHN5cy90aW1lLmg+CiNpbmNsdWRlIDxpbnR0eXBlcy5oPgojaW5jbHVkZSA8dW5pc3RkLmg+
CiNpbmNsdWRlIDxzdGRsaWIuaD4KI2luY2x1ZGUgPHN0ZGlvLmg+CiNpbmNsdWRlIDxmY250
bC5oPgojaW5jbHVkZSA8Y3R5cGUuaD4KI2luY2x1ZGUgPHN0cmluZy5oPgoKI2RlZmluZSBT
SVpFICgxICogMTAyNCAqIDEwMjQgKiAxMDI0KQojZGVmaW5lIFBBR0VfU0laRSA0MDk2Cgpp
bnQ2NF90IGN1cnJlbnRfdGltZV9tcygpIHsKCXN0cnVjdCB0aW1ldmFsIHRpbWU7CglnZXR0
aW1lb2ZkYXkoJnRpbWUsIE5VTEwpOwoJaW50NjRfdCBzMSA9IChpbnQ2NF90KSh0aW1lLnR2
X3NlYykgKiAxMDAwOwoJaW50NjRfdCBzMiA9ICh0aW1lLnR2X3VzZWMgLyAxMDAwKTsKCXJl
dHVybiBzMSArIHMyOwp9CgppbnQgbWFpbihpbnQgYXJnYywgY2hhciogYXJndltdKQp7Cgl2
b2lkICogYnVmOwoJY2hhciAqIHB0cjsKCXNpemVfdCBzaXplID0gU0laRSwgc3RlcCA9IFBB
R0VfU0laRTsKCWludDY0X3Qgc3RhcnQsIGNvc3Q7CgoJYnVmID0gbW1hcChOVUxMLCBzaXpl
LCBQUk9UX1JFQUR8UFJPVF9XUklURSwgTUFQX1NIQVJFRCB8IE1BUF9BTk9OWU1PVVMsIC0x
LCAwKTsKCWlmIChidWYgPT0gIE1BUF9GQUlMRUQpIHsKCQlwcmludGYoIm1tYXAgZmFpbGVk
XG4iKTsKCX0KCglzdGFydCA9IGN1cnJlbnRfdGltZV9tcygpOwoKCWZvcihzaXplX3QgaSA9
IDA7IGkgPCBzaXplOyBpICs9IHN0ZXAgKSB7CgkJcHRyID0gKGNoYXIgKikoYnVmICsgaSk7
CgkJKnB0ciA9ICdhJzsKCX0KCgljb3N0ID0gY3VycmVudF90aW1lX21zKCkgLSBzdGFydDsK
CXByaW50ZigiY29zdDolIiBQUklkNjQgIiBtc1xuIiwgY29zdCk7CgoJbXVubWFwKGJ1Ziwg
c2l6ZSk7CgogICAgICAgIHJldHVybiAwOwp9Cg==

--------------OQptv0miZd4Qez8ok0nBlcAw--

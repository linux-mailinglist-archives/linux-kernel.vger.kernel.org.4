Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E52D167EE02
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 20:18:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232440AbjA0TSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 14:18:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjA0TSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 14:18:05 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB171265A2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 11:18:03 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id y69so2300991iof.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 11:18:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k93tzYKTMBeyLqj6KqGKxCb2OB32c5FpykAR37wgg84=;
        b=KgZJItC8fAjM5eQ4u/RplQA0TddngU7JdmdO8awhth4we+FBezJHf7Qg0X3L7KmbRC
         4dfxbTCikKbIhrhqxr2rBA7dLXCcke9XHBLYUL5wXzvDM/s0c1CsKd8zVwBChH7d0r4q
         Dkm7DSLjvwvqZ6RAyl481dqGEI1KN/uLDapAU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k93tzYKTMBeyLqj6KqGKxCb2OB32c5FpykAR37wgg84=;
        b=jBnh4H6OnC5Jr0LJvY7H8dFjuN6haBbDf4fu5yII7E2eIiF6xm4Ti4CKijDrwNnQVe
         6DHCYgY17aP9P72iVPphPcMjHhMMunUypTOM9Y9+7Yc5UgEq7xtGZPEuQSSM7D1LhJgR
         Y2vt8I9Wyc8pJVZU/F1nbwpVB3Smc0ULxx/+EuMmaiSJ0X9vpF32ZJt+If15GtdoK4x5
         x3I+vEoOACLRyUcMuVAJhMurIG6MtKkLKt0oHSeqTYFHSHSlLOJ1770AHWigRmCiTJOV
         kQY+JmatIUJV8Otw8Cx8yaUcWNVCmEVIdWIiKxOMW++1KRzrDAMUeQPx4HTs7L9IG2vS
         MeCA==
X-Gm-Message-State: AO0yUKWyrLtYweCUbS1gMEexDU0fKUWRJEJFgwMr1LnEB2ofNgYEZKfT
        1ojAkHW8WlfvIrrhMh27wnxVnw==
X-Google-Smtp-Source: AK7set9ZIbcG06bFoUTBU0fU0JBSLM1aEPqgeX6Xa/QLliKlITqE8yDoInU3/IkqlzS9SvV/UwNZDA==
X-Received: by 2002:a6b:6b0e:0:b0:70a:9fce:853c with SMTP id g14-20020a6b6b0e000000b0070a9fce853cmr915215ioc.2.1674847083110;
        Fri, 27 Jan 2023 11:18:03 -0800 (PST)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id cn19-20020a0566383a1300b0039e20ffb236sm1731469jab.162.2023.01.27.11.18.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jan 2023 11:18:02 -0800 (PST)
Message-ID: <063c51c3-c276-3b68-f130-db0751b35d42@linuxfoundation.org>
Date:   Fri, 27 Jan 2023 12:18:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] docs: add workload-tracing document to admin-guide
Content-Language: en-US
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     sshefali021@gmail.com, kstewart@linuxfoundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230127165440.19158-1-skhan@linuxfoundation.org>
 <87bkmj99yv.fsf@meer.lwn.net>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <87bkmj99yv.fsf@meer.lwn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/27/23 10:13, Jonathan Corbet wrote:
> Shuah Khan <skhan@linuxfoundation.org> writes:
> 
>> Add a new section to the admin-guide with information of interest to
>> application developers and system integrators doing analysis of the
>> Linux kernel for safety critical applications.
>>
>> This section will contain documents supporting analysis of kernel
>> interactions with applications, and key kernel subsystems expectations.
>>
>> Add a new workload-tracing document to this new section.
>>
>> Signed-off-by: Shefali Sharma <sshefali021@gmail.com>
>> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
>> ---
>>   Documentation/admin-guide/index.rst           |  11 +
>>   .../admin-guide/workload-tracing.rst          | 486 ++++++++++++++++++
>>   2 files changed, 497 insertions(+)
>>   create mode 100644 Documentation/admin-guide/workload-tracing.rst
> 
> This seems like generally good stuff, thanks.  I have a few nits...

Thanks for the review.

> 
>> +Key Points
>> +==========
>> +
>> + * Understanding system resources necessary to build and run a workload
>> +   is important.
>> + * Linux tracing and strace can be used to discover the system resources
>> +   in use by a workload. The completeness of the system usage information
>> +   depends on the completeness of coverage of a workload.
>> + * Performance and security of the operating system can be analyzed with
>> +   the help of tools such as `perf <https://man7.org/linux/man-pages/man1/perf.1.html>`_, `stress-ng <https://www.mankier.com/1/stress-ng>`_, `paxtest <https://github.com/opntr/paxtest-freebsd/blob/hardenedbsd/0.9.14-hbsd/README>`_.
>> + * Once we discover and understand the workload needs, we can focus on them
>> +   to avoid regressions and use it to evaluate safety considerations.
>> +
>> +Methodology
>> +===========
>> +
>> +`strace <https://man7.org/linux/man-pages/man1/strace.1.html>`_ is a diagnostic, instructional, and debugging tool and can be used to discover the system resources in use by a workload. Once we discover and understand the workload needs, we can focus on them to avoid regressions and use it to evaluate safety considerations. We chose strace tool to trace workloads.
> 
> I know that the 80-column limit is controversial to some; I happen to
> believe that text should certainly adhere to it for basic readability
> reasons.  But can we all agree that nearly 400 columns is too many? :)
> Please line-break the whole document properly.

Yeah that is my bad. I noticed it once the patch was in my Inbox.
I will fix them all up.

> 
>> +Install tools to build Linux kernel and tools in kernel repository. scripts/ver_linux is a good way to check if your system already has the necessary tools.
>> +::
>> +
>> +  sudo apt-get build-essentials flex bison yacc
>> +  sudo apt install libelf-dev systemtap-sdt-dev libaudit-dev libslang2-dev libperl-dev libdw-dev
>> +
>> +Browsing kernel sources
>> +::
>> +
>> +  sudo apt-get install cscope
>> +
>> +Install stress-ng and paxtest
>> +::
>> +
>> +  apt-get install stress-ng
>> +  apt-get install paxtest
> 
> For literal blocks, the "::" can go at the end of the previous line,
> which makes the document a bit more readable.

Makes sense. Will fix it.

> 
> [...]
> 
>> +SPDX-License-Identifier: CC-BY-4.0
>> +==================================
>> +This document is released under the Creative Commons Attribution 4.0 International License, available at https://creativecommons.org/licenses/by/4.0/legalcode. Pursuant to Section 5 of the license, please note that the following disclaimers apply (capitalized terms have the meanings set forth in the license). To the extent possible, the Licensor offers the Licensed Material as-is and as-available, and makes no representations or warranties of any kind concerning the Licensed Material, whether express, implied, statutory, or other. This includes, without limitation, warranties of title, merchantability, fitness for a particular purpose, non-infringement, absence of latent or other defects, accuracy, or the presence or absence of errors, whether or not known or discoverable. Where disclaimers of warranties are not allowed in full or in part, this disclaimer may not apply to You.
>> +
>> +To the extent possible, in no event will the Licensor be liable to You on any legal theory (including, without limitation, negligence) or otherwise for any direct, special, indirect, incidental, consequential, punitive, exemplary, or other losses, costs, expenses, or damages arising out of this Public License or use of the Licensed Material, even if the Licensor has been advised of the possibility of such losses, costs, expenses, or damages. Where a limitation of liability is not allowed in full or in part, this limitation may not apply to You.
>> +
>> +The disclaimer of warranties and limitation of liability provided above shall be interpreted in a manner that, to the extent possible, most closely approximates an absolute disclaimer and waiver of all liability.
>> +
>> +Note: Only the content of this RST file as found in the Linux kernel sources
>> +is available under CC-BY-4.0, as versions of this text that were processed
>> +(for example by the kernel's build system) might contain content taken from
>> +files which use a more restrictive license.
> 
> This is just the kind of license boilerplate that we have been trying
> hard to get rid of.  *Dual*-licensing with CC4 is OK, and the SPDX line
> at the top properly reflects that; this additional text shouldn't be here.
> 

Okay - I can get rid of this.

>> +..
>> +   end-of-content
> 
> ...and that seems a bit redundant somehow...:)

Yup. Correct.

thanks,
-- Shuah

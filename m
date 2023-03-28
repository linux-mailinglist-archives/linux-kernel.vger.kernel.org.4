Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA28B6CB9BF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 10:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbjC1Iqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 04:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbjC1Iqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 04:46:43 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A472F524C;
        Tue, 28 Mar 2023 01:46:30 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id w4so10955138plg.9;
        Tue, 28 Mar 2023 01:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679993190;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=anp81GhSwwfkIe9qRl4obfvPoMEkj3qI5//q6ZmwU98=;
        b=h6q8HgqeugDXNBggTwPjAWSMtpVQk3+hF/pHqompFziz3vbq0t3kevehsFC4HOhQ/3
         rzWN2lqejUoDJPnYaF4stkOIpjZiIMmVszz7nki7LxGSctzAchUQ7l3KBctYEIx/K/Tb
         5S5WVdL87rA+yB4U8IB7lqKm/AwaDGlWxJhQZ0igFTr3NwWHPPkTNn40du+Ei8GqHNwi
         ImwyojHIiK8AQYYVMh7fRiLnC/xsZ7xgNonD2SDTmh9GssW8nCOPT+VktdFY+bGhixXO
         r9yM7UKurmw+cnd6H3hd9HhGUvuN0lPjS0EsPLCNiECCdUrcFvM/BTPWrpzSYgRAZ7sA
         uiYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679993190;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=anp81GhSwwfkIe9qRl4obfvPoMEkj3qI5//q6ZmwU98=;
        b=NFSdHuS0CFWcJqv8GW0kNvPDEdHeFbH2iqm51Lzvy91uEpa8WvZchUnvSqML9AEZLQ
         W3NfESbT7GMQrz4dJDiGsrYVROrLw8gIy6Bxw8nmCVa+DNl9EwKCb235VQKrXO3cC6PH
         aUFZ7j9CJnVFWOnfHMNiWRYqmcWZv0HRo4hxs7ftc13Oxhnm/WIyOhXkaor1WfCv4s61
         5N/AT94G/qSk36fdZZ0xYvsL4ViEtVU+ssATwz39FZhkPYcmgqfGA4TzppmL2JBSqDU9
         6o9OSXoJORQnJ8GfasD4KmzJo5sbNUHOM6fcqjwDG/3ikqa4PQl95vEzmaR+LkrX5vVf
         EaNQ==
X-Gm-Message-State: AAQBX9fHXT3L1DCE0JDoTjIYc+CKy2FaWe1cnEYfbgNCqbGpWcidi00g
        beVMJqrSCel1HwKbCxDLeRk=
X-Google-Smtp-Source: AKy350aqqXGol9gD5pZ2W3ssxNhqfCa1AUPzyc1cfQuPVuc7/uCkjv54W1yMu1SHYR+Yw8txB5YVbw==
X-Received: by 2002:a17:90b:3907:b0:237:d59d:5f89 with SMTP id ob7-20020a17090b390700b00237d59d5f89mr17350646pjb.4.1679993189826;
        Tue, 28 Mar 2023 01:46:29 -0700 (PDT)
Received: from [192.168.43.80] (subs32-116-206-28-54.three.co.id. [116.206.28.54])
        by smtp.gmail.com with ESMTPSA id g11-20020a17090a640b00b0024095afa776sm1436313pjj.20.2023.03.28.01.46.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Mar 2023 01:46:29 -0700 (PDT)
Message-ID: <05a6e961-b1a3-cdb2-6baf-ec0559185a5f@gmail.com>
Date:   Tue, 28 Mar 2023 15:46:23 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v1] Documentation: Add document for false sharing
Content-Language: en-US
To:     Feng Tang <feng.tang@intel.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Joe Mario <jmario@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Eric Dumazet <edumazet@google.com>,
        Shakeel Butt <shakeelb@google.com>, dave.hansen@intel.com,
        ying.huang@intel.com, tim.c.chen@intel.com, andi.kleen@intel.com
References: <20230324071316.167337-1-feng.tang@intel.com>
 <ZB2baIDIPhxj5Vdl@debian.me> <ZCDl1o16eZDx1HW1@feng-clx>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <ZCDl1o16eZDx1HW1@feng-clx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.3 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/27/23 07:39, Feng Tang wrote:
> Hi Bagas Sanjaya,
> 
> Many thanks for the reviews!
> 
> On Fri, Mar 24, 2023 at 07:45:28PM +0700, Bagas Sanjaya wrote:
>> On Fri, Mar 24, 2023 at 03:13:16PM +0800, Feng Tang wrote:
>>> +There are many real-world cases of performance regressions caused by
>>> +false sharing, and one is a rw_semaphore 'mmap_lock' inside struct
>> "... . One of these is rw_semaphore 'mmap_lock' ..."
> 
> OK, will use this.
> 
>> But I think in English we commonly name things as "foobar struct"
>> instead of "struct foobar" (that is, common noun follow the proper noun
>> that names something).
> 
> I can change that. And IIRC, I saw 'struct XXX' and 'XXX struct' both
> frequently used in kernel. I just run '# git log | grep -w struct'
> and the majority use 'struct XXX'
> 
>>> +* A global datum accessed (shared) by many CPUs
>> Global data?
> 
> In RFC version, I used 'data' and Randy suggested 'datum'. TBH, I 
> looked it up in a dictionary :),  and found:
> 	"Data" is the Latin plural form of "datum"
> 

OK, I understand.

>>> +  #perf c2c record -ag sleep 3
>>> +  #perf c2c report --call-graph none -k vmlinux
>>
>> Are these commands really run as root?
> 
> You are right, people can run it as 'root' or a normal user. And I
> guess this won't confuse kernel developers.
> 
> My original version is kind of too long and full of explainations,
> and some kernel developer suggested that this doc is under
> 'kernel-hacking' and its audience is kernel developers, and I should
> make it clear and short, and not make it look like a wiki page or
> man page.
> 

So something like below, right?

```
$ perf <command> <args>...
$ perf <command> <args>...
```

>>> +* Replace 'write' with 'read' when possible, especially in loops.
>>> +  Like for some global variable, use compare(read)-then-write instead
>>> +  of unconditional write. For example, use:
>> "... For example, write::"
> 
> The following is a coding pattern (for bit operation, atomic, etc.),
> and I think 'use' may also be good?
> 

I tend to say "write" when the context is typing code.

>>> +
>>> +	if (!test_bit(XXX))
>>> +		set_bit(XXX);
>>> +
>>> +  instead of directly "set_bit(XXX);", similarly for atomic_t data.
>>> +
>>> +  Commit 7b1002f7cfe5 ("bcache: fixup bcache_dev_sectors_dirty_add() multithreaded CPU false sharing")
>>> +  Commit 292648ac5cf1 ("mm: gup: allow FOLL_PIN to scale in SMP")
>>> +
>>> +* Turn hot global data to 'per-cpu data + global data' when possible,
>>> +  or reasonably increase the threshold for syncing per-cpu data to
>>> +  global data, to reduce or postpone the 'write' to that global data.
>>> +
>>> +  Commit 520f897a3554 ("ext4: use percpu_counters for extent_status cache hits/misses")
>>> +  Commit 56f3547bfa4d ("mm: adjust vm_committed_as_batch according to vm overcommit policy")
>>
>> IMO it's odd to jump to specifying example commits without some sort of
>> conjuction (e.g. "for example, see commit <commit>").
> 
> I agree, and I had the same concern, but I was also afraid of that
> too many repeating of this, so the previous 
> "Following 'mitigation' section provides real-world examples." 
> in last section (which you helped to improve) was added trying
> to address this.
> 

OK.

And see you in v2!

-- 
An old man doll... just what I always wanted! - Clara


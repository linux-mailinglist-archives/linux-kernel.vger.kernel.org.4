Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5B365BBD85
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 13:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbiIRLIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 07:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiIRLIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 07:08:22 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08DD426AD2
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 04:08:21 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id z13so23392676edb.13
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 04:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date;
        bh=Oea3lZdjTibNOlHVzcym0NcZxwPywJ9NIc7pdYdsFKA=;
        b=uhm3hv5hEl6jxLpaGezD9+GEo9z87injzAGd2aaMHERYOK0bk7t2Z7gx1xsrGQaakg
         ytmW/BHICQANTPPpsJqtzhMbL5VVNvLe0ruhBOCUhkQhMC9lNke9ND84y+Fyv/tIfwHA
         GhVIilJw2yxmmDGgwkYNqLMmtZMGU4xE8jZ5OHicaScoSpNDrTx9u4hiC4NVsyk7P9Rq
         nG+EdpjOLYxF60Vvp2I1zY++82+A+ywE8Y7gEFwtRLnrGDHHOST48l2pdLuXmLs16Tos
         A8kxgSYnuwZqkeo+JjXgh2/MB7K0H0EqrRWH6igK9RfnIs0zvSRBJIPASO4VAWPl/C79
         h4/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date;
        bh=Oea3lZdjTibNOlHVzcym0NcZxwPywJ9NIc7pdYdsFKA=;
        b=aj2JHdEd5mfxxz8qbLPNoVXQ+t3wqhvSvgMBtouyZdDeqBBczFUx445olvKddqQe+v
         w6cpaiexTMlYsb8RIUB87KDK9ISOl5elpiY7nbFqg+OA+Z5CJqzTTDUyNlSCwmEnTXwy
         2Auq2Q1LEL+E411Y++25FsRyj6Q4lsKIn0KnKyOfKLraiLXdJE757ZqqU68e395/LhZk
         7lxybcD81AJvV3oXGiQxwhQleDEcuEWPC99zEhdNcvzoRV3+/MXWX+5l7m3GQDk5APW2
         +K4IYcNzETlgPgdbGY4/a3H2Fk9DojBMKE+WadLrnnZQ0p4fw8XT1DJCGACIZFVbfl7W
         3mdA==
X-Gm-Message-State: ACrzQf0htB21PPJ6rKcySUhdoqF4M9Olc2Tpf4iOlK2PKR07p2TB2yHo
        Ez8Op44mwaHF7Ia2xmfSWvHNkw==
X-Google-Smtp-Source: AMsMyM5VwUQ+Uh69CR2BN4i+hFB41Guy/pxpdhPp2IcmNvq5/LkPkvXxAz7W+BKyERlqapCNl9GQWQ==
X-Received: by 2002:aa7:d5d0:0:b0:44e:f6cc:7107 with SMTP id d16-20020aa7d5d0000000b0044ef6cc7107mr11000522eds.371.1663499299479;
        Sun, 18 Sep 2022 04:08:19 -0700 (PDT)
Received: from ?IPV6:2003:d9:9726:8300:b088:c09:537d:ce99? (p200300d997268300b0880c09537dce99.dip0.t-ipconnect.de. [2003:d9:9726:8300:b088:c09:537d:ce99])
        by smtp.googlemail.com with ESMTPSA id cz19-20020a0564021cb300b0044657ecfbb5sm17714983edb.13.2022.09.18.04.08.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Sep 2022 04:08:18 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------EF1201diUEP5cbqrvHB1wETx"
Message-ID: <b736022c-5028-a06e-5edb-f5cb526b0821@colorfullife.com>
Date:   Sun, 18 Sep 2022 13:08:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v6 1/2] percpu: Add percpu_counter_add_local and
 percpu_counter_sub_local
To:     Jiebin Sun <jiebin.sun@intel.com>, akpm@linux-foundation.org,
        vasily.averin@linux.dev, shakeelb@google.com, dennis@kernel.org,
        tj@kernel.org, cl@linux.com, ebiederm@xmission.com,
        legion@kernel.org, alexander.mikhalitsyn@virtuozzo.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     tim.c.chen@intel.com, feng.tang@intel.com, ying.huang@intel.com,
        tianyou.li@intel.com, wangyang.guo@intel.com,
        Tim Chen <tim.c.chen@linux.intel.com>,
        kernel test robot <lkp@intel.com>, 1vier1@web.de
References: <20220902152243.479592-1-jiebin.sun@intel.com>
 <20220913192538.3023708-1-jiebin.sun@intel.com>
 <20220913192538.3023708-2-jiebin.sun@intel.com>
Content-Language: en-US
From:   Manfred Spraul <manfred@colorfullife.com>
In-Reply-To: <20220913192538.3023708-2-jiebin.sun@intel.com>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------EF1201diUEP5cbqrvHB1wETx
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Jiebin,

On 9/13/22 21:25, Jiebin Sun wrote:
>   
> +/*
> + * With percpu_counter_add_local() and percpu_counter_sub_local(), counts
> + * are accumulated in local per cpu counter and not in fbc->count until
> + * local count overflows PERCPU_COUNTER_LOCAL_BATCH. This makes counter
> + * write efficient.
> + * But percpu_counter_sum(), instead of percpu_counter_read(), needs to be
> + * used to add up the counts from each CPU to account for all the local
> + * counts. So percpu_counter_add_local() and percpu_counter_sub_local()
> + * should be used when a counter is updated frequently and read rarely.
> + */
> +static inline void
> +percpu_counter_add_local(struct percpu_counter *fbc, s64 amount)
> +{
> +	percpu_counter_add_batch(fbc, amount, PERCPU_COUNTER_LOCAL_BATCH);
> +}
> +

Unrelated to your patch, and not relevant for ipc/msg as the functions 
are not called from interrupts, but:
Aren't there races with interrupts?

> *
> * This function is both preempt and irq safe. The former is due to 
> explicit
> * preemption disable. The latter is guaranteed by the fact that the 
> slow path
> * is explicitly protected by an irq-safe spinlock whereas the fast 
> patch uses
> * this_cpu_add which is irq-safe by definition. Hence there is no need 
> muck
> * with irq state before calling this one
> */
> void percpu_counter_add_batch(struct percpu_counter *fbc, s64 amount, 
> s32 batch)
> {
>        s64 count;
>
>        preempt_disable();
>        count = __this_cpu_read(*fbc->counters) + amount;
>        if (abs(count) >= batch) {
>                unsigned long flags;
>                raw_spin_lock_irqsave(&fbc->lock, flags);
>                fbc->count += count;
>                __this_cpu_sub(*fbc->counters, count - amount);
>                raw_spin_unlock_irqrestore(&fbc->lock, flags);
>        } else {
>                this_cpu_add(*fbc->counters, amount);
>        }
>        preempt_enable();
> }
> EXPORT_SYMBOL(percpu_counter_add_batch);
>
>
Race 1:

start: __this_cpu_read(*fbc->counters) = INT_MAX-1.

Call: per_cpu_counter_add_batch(fbc, 1, INT_MAX);

Result:

count=INT_MAX;

if (abs(count) >= batch) { // branch taken

before the raw_spin_lock_irqsave():

Interrupt

Within interrupt:

    per_cpu_counter_add_batch(fbc, -2*(INT_MAX-1), INT_MAX)

    count=-(INT_MAX-1);

    branch not taken

    this_cpu_add() updates fbc->counters, new value is -(INT_MAX-1)

    exit interrupt

raw_spin_lock_irqsave()

__this_cpu_sub(*fbc->counters, count - amount)

will substract INT_MAX-1 from *fbc->counters. But the value is already 
-(INT_MAX-1) -> underflow.


Race 2: (much simpler)

start: __this_cpu_read(*fbc->counters) = 0.

Call: per_cpu_counter_add_batch(fbc, INT_MAX-1, INT_MAX);

amont=INT_MAX-1;

- branch not taken.

before this_cpu_add(): interrupt

within the interrupt: call per_cpu_counter_add_batch(fbc, INT_MAX-1, 
INT_MAX)

    new value of *fbc->counters: INT_MAX-1.

    exit interrupt

outside interrupt:

this_cpu_add(*fbc->counters, amount);

<<< overflow.

Attached is an incomplete patch (untested).
If needed, I could check the whole file and add/move the required 
local_irq_save() calls.


--

     Manfred

--------------EF1201diUEP5cbqrvHB1wETx
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-lib-percpu_counter-RFC-potential-overflow-underflow.patch"
Content-Disposition: attachment;
 filename*0="0001-lib-percpu_counter-RFC-potential-overflow-underflow.pat";
 filename*1="ch"
Content-Transfer-Encoding: base64

RnJvbSA2YTFkMmE0YmViMTgwMjQxYjYzZjliZjU3NDU0YmJlMDMxOTE1ZGQxIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBNYW5mcmVkIFNwcmF1bCA8bWFuZnJlZEBjb2xvcmZ1
bGxpZmUuY29tPgpEYXRlOiBTdW4sIDE4IFNlcCAyMDIyIDEyOjE3OjI3ICswMjAwClN1Ympl
Y3Q6IFtQQVRDSF0gbGliL3BlcmNwdV9jb3VudGVyOiBbUkZDXSBwb3RlbnRpYWwgb3ZlcmZs
b3cvdW5kZXJmbG93CgpJZiBhbiBpbnRlcnJ1cHQgaGFwcGVucyBiZXR3ZWVuIF9fdGhpc19j
cHVfcmVhZCgqZmJjLT5jb3VudGVycykgYW5kCnRoaXNfY3B1X2FkZCgqZmJjLT5jb3VudGVy
cywgYW1vdW50KSwgYW5kIHRoYXQgaW50ZXJydXB0IG1vZGlmaWVzCnRoZSBwZXJfY3B1X2Nv
dW50ZXIsIHRoZW4gdGhlIHRoaXNfY3B1X2FkZCgpIGFmdGVyIHRoZSBpbnRlcnJ1cHQKcmV0
dXJucyBtYXkgdW5kZXIvb3ZlcmZsb3cuCgpUaHVzOiBEaXNhYmxlIGludGVycnVwdHMuCgpO
b3RlOiBUaGUgcGF0Y2ggaXMgaW5jb21wbGV0ZSwgaWYgdGhlIHJhY2UgaXMgcmVhbCwgdGhl
bgptb3JlIGZ1bmN0aW9ucyB0aGFuIGp1c3QgcGVyY3B1X2NvdW50ZXJfYWRkX2JhdGNoKCkg
bmVlZHMgdG8gYmUKdXBkYXRlZC4KCkVzcGVjaWFsbHksIHRoZSAhQ09ORklHX1NNUCBjb2Rl
IGxvb2tzIHdyb25nIHRvIG1lIGFzIHdlbGw6Cj4gc3RhdGljIGlubGluZSB2b2lkCj4gcGVy
Y3B1X2NvdW50ZXJfYWRkKHN0cnVjdCBwZXJjcHVfY291bnRlciAqZmJjLCBzNjQgYW1vdW50
KQo+IHsKPglwcmVlbXB0X2Rpc2FibGUoKTsKPglmYmMtPmNvdW50ICs9IGFtb3VudDsKPglw
cmVlbXB0X2VuYWJsZSgpOwo+IH0KVGhlIHVwZGF0ZSBvZiBmYmMtPmNvdW50IGlzIG5vdCBJ
UlEgc2FmZS4KClNpZ25lZC1vZmYtYnk6IE1hbmZyZWQgU3ByYXVsIDxtYW5mcmVkQGNvbG9y
ZnVsbGlmZS5jb20+Ci0tLQogbGliL3BlcmNwdV9jb3VudGVyLmMgfCA4ICsrKysrLS0tCiAx
IGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQoKZGlmZiAt
LWdpdCBhL2xpYi9wZXJjcHVfY291bnRlci5jIGIvbGliL3BlcmNwdV9jb3VudGVyLmMKaW5k
ZXggZWQ2MTBiNzVkYzMyLi4zOWRlOTRkNTliNGYgMTAwNjQ0Ci0tLSBhL2xpYi9wZXJjcHVf
Y291bnRlci5jCisrKyBiL2xpYi9wZXJjcHVfY291bnRlci5jCkBAIC04MiwxOCArODIsMjAg
QEAgRVhQT1JUX1NZTUJPTChwZXJjcHVfY291bnRlcl9zZXQpOwogdm9pZCBwZXJjcHVfY291
bnRlcl9hZGRfYmF0Y2goc3RydWN0IHBlcmNwdV9jb3VudGVyICpmYmMsIHM2NCBhbW91bnQs
IHMzMiBiYXRjaCkKIHsKIAlzNjQgY291bnQ7CisJdW5zaWduZWQgbG9uZyBmbGFnczsKIAog
CXByZWVtcHRfZGlzYWJsZSgpOworCWxvY2FsX2lycV9zYXZlKGZsYWdzKTsKIAljb3VudCA9
IF9fdGhpc19jcHVfcmVhZCgqZmJjLT5jb3VudGVycykgKyBhbW91bnQ7CiAJaWYgKGFicyhj
b3VudCkgPj0gYmF0Y2gpIHsKLQkJdW5zaWduZWQgbG9uZyBmbGFnczsKLQkJcmF3X3NwaW5f
bG9ja19pcnFzYXZlKCZmYmMtPmxvY2ssIGZsYWdzKTsKKwkJcmF3X3NwaW5fbG9jaygmZmJj
LT5sb2NrKTsKIAkJZmJjLT5jb3VudCArPSBjb3VudDsKIAkJX190aGlzX2NwdV9zdWIoKmZi
Yy0+Y291bnRlcnMsIGNvdW50IC0gYW1vdW50KTsKLQkJcmF3X3NwaW5fdW5sb2NrX2lycXJl
c3RvcmUoJmZiYy0+bG9jaywgZmxhZ3MpOworCQlyYXdfc3Bpbl91bmxvY2soJmZiYy0+bG9j
ayk7CiAJfSBlbHNlIHsKIAkJdGhpc19jcHVfYWRkKCpmYmMtPmNvdW50ZXJzLCBhbW91bnQp
OwogCX0KKwlsb2NhbF9pcnFfcmVzdG9yZShmbGFncyk7CiAJcHJlZW1wdF9lbmFibGUoKTsK
IH0KIEVYUE9SVF9TWU1CT0wocGVyY3B1X2NvdW50ZXJfYWRkX2JhdGNoKTsKLS0gCjIuMzcu
MgoK

--------------EF1201diUEP5cbqrvHB1wETx--

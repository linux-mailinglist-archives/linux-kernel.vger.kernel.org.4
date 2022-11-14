Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 761D0628206
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 15:09:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236856AbiKNOJG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 09:09:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236828AbiKNOJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 09:09:03 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5C1E22BF8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 06:09:01 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id r12so19473522lfp.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 06:09:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7bxYVgpnsGzW86VQq7hMIoZbZDot9yO7odIkSzWAAKs=;
        b=lkGMB6zU+rGNPUbuWU7J/kalVndvafqvCQHqVEAt+K5Wf6LBwsPdnEgbWIlUg2bJ+b
         w1KuXJPrLm1Gc4WbJSjr61zfxDxoSRqaMUOKA75uEZiE7rlOMbPQbX+ps4hKlrh9276u
         WtsjLF58d0exWYff01tOjyQregQZcq18u4ATTK8GUYrcWt3Dn4qBVNmVOKmve4zWc/kI
         Xbz1SqVK6lxp8/AIZeT5Ce0mho2ZkfCEYyumXwJo4CVhjyYCJ7lEEDLLNCnMjZcQdVWe
         RURUdFxjMj4IpyplbyRXuf4LrZpir5AONHNM04UzgtFZcVOYkjbu4XehLm+2JrrKaocH
         +iEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7bxYVgpnsGzW86VQq7hMIoZbZDot9yO7odIkSzWAAKs=;
        b=fOtcNeaqXUYXPsqgGVIaZwxT1Ze8nlJpa9Gh5jvheYD+0IV1x1NXsVYT9/j5RbuIoD
         KNjsVBenR4u3ZqAmAgT6/OQXeFBwtB/r36HdAEuk3SDPkPLj9I57TOBRu6q0FfODa/N1
         270qOD4zAzKFI/d9lGaJR1O+tzWxhl15I4yUJpjMHLN49uOtXpr4Z7mXGS2/d66kfwux
         lxY79HE5HVRdmLJuxQjUQX9sJm2mN6PrIVNOwYAbWCB+JsMUCOIbPPZLQ3yWJfcIA2bd
         t1GRDEGNp3eaF/xxOx52U6KqubPqbPDKVDn+NvOgjfzcS6kORDI6mOFlqRKQTZBcfV7e
         pJOg==
X-Gm-Message-State: ANoB5pn8XEVDxweFf/p8ycVxSAYlYZ3xKUx37VNpCNszIvACjWCfYC81
        AQ4ODD3Di3avg7cjQGCXzdA=
X-Google-Smtp-Source: AA0mqf7nuWOLBi416tkfsXCMX4umRIHXrAX4jMyfRJo/6WI7kSOJ9qaswZrwYjYhjoZVa2gmND6jBw==
X-Received: by 2002:a19:2d53:0:b0:499:cce2:12d9 with SMTP id t19-20020a192d53000000b00499cce212d9mr4578763lft.4.1668434940040;
        Mon, 14 Nov 2022 06:09:00 -0800 (PST)
Received: from ?IPV6:2a02:6b8:0:107:3e85:844d:5b1d:60a? ([2a02:6b8:0:107:3e85:844d:5b1d:60a])
        by smtp.gmail.com with ESMTPSA id x3-20020a056512078300b004a44ffb1050sm1847952lfr.171.2022.11.14.06.08.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 06:08:59 -0800 (PST)
Message-ID: <fda48075-783d-1833-5f1c-c10ca2880a56@gmail.com>
Date:   Mon, 14 Nov 2022 17:09:00 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 1/5] x86/mm: Recompute physical address for every page
 of per-CPU CEA mapping
To:     Sean Christopherson <seanjc@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        syzbot+ffb4f000dc2872c93f62@syzkaller.appspotmail.com,
        syzbot+8cdd16fd5a6c0565e227@syzkaller.appspotmail.com
References: <20221110203504.1985010-1-seanjc@google.com>
 <20221110203504.1985010-2-seanjc@google.com>
Content-Language: en-US
From:   Andrey Ryabinin <ryabinin.a.a@gmail.com>
In-Reply-To: <20221110203504.1985010-2-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/10/22 23:35, Sean Christopherson wrote:
> Recompute the physical address for each per-CPU page in the CPU entry
> area, a recent commit inadvertantly modified cea_map_percpu_pages() such
> that every PTE is mapped to the physical address of the first page.
> 
> Fixes: 9fd429c28073 ("x86/kasan: Map shadow for percpu pages on demand")
> Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Andrey Ryabinin <ryabinin.a.a@gmail.com>

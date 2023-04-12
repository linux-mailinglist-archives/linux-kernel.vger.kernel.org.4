Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B03A6DE911
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 03:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbjDLBsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 21:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjDLBsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 21:48:05 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EBE12683
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 18:48:04 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-246cadb31dbso190293a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 18:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1681264084;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0yWF1eWVK1XRJ0wlfD6gNpBEubetmQIbvAPgg/hmyQ4=;
        b=53zGCczZaVVS8dZxr3b/ObSB7o2kf0oybagnqHAOV1Qi1GZ3SSz8gFlpQIIiiaZtNI
         lCCaYrUpMj1zgLwxUshNRwhYj/1Ds1AcYZ2wbhrAgG1e315i6Wqwi81LFt0Z0kBhIEmx
         dL8iYxgt8meY6brUj5BpXqEiLyNIcR8xrRa11wW5fOpzKxjhFOwa81HmF5psR4MvnTR1
         fcubPNXs9d6Em7/w1BSEguYfSB4uA3fy5Qi1nAQykj8vYgH4pekfxxMJ/JOHIHv+6p/4
         ZmtmDTBtb232VCKq+UdFsv6aFf2p6rna9yGt7Ghv1EvOTIyLfMJTHWs0v00b9W31YTLR
         y7wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681264084;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0yWF1eWVK1XRJ0wlfD6gNpBEubetmQIbvAPgg/hmyQ4=;
        b=XG4aFXVb4Bv/wFOK3vlO/dHCGQBPVtZTbLvT5XfqA1N8k7tBgDI78lapW2jtaNIh1H
         D8lVi0BfAmaJE0nMF7hKfKDI9YmZGSwKvqgeTyH9ZZoQZyBLI0DQU7W0CyX+iXwgpUP1
         wom5YPnbk9Qatv8ghhOkEiraryCgk9BAVQLCg5SAC3L+mYlmkn3t644Gz+pmWE/iiNLp
         3ZRhjZnFSggCA2SA2DRsuzoP13xUxD+VbWRY55qkz3HbHPVpmPTBBlWTZ+UGoVUp1HXT
         bOjyl2QOyMuRDWc5puyGTmXPobjiareSgBqSADgVxyb7ofcEvD5wR79jA4ciPTJs8Cqn
         gCzw==
X-Gm-Message-State: AAQBX9fIgfoVelLdA01/iONqhN/AH7+6J2NWKPDoSwj/YBMj4RIr4EaB
        4PEz3VTLAaLgNslre6Snzg5DTg==
X-Google-Smtp-Source: AKy350Y/tKoJWV/JM+tWlV5jFK/lM6/YsbQGgs1x/DFTqONMenp4iMWSuK+gcLKDLOwAYipyjGyaIA==
X-Received: by 2002:a17:902:ec8b:b0:1a6:5682:af48 with SMTP id x11-20020a170902ec8b00b001a65682af48mr693635plg.0.1681264083894;
        Tue, 11 Apr 2023 18:48:03 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id j3-20020a170902690300b001a19f2f81a3sm4398633plk.175.2023.04.11.18.48.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Apr 2023 18:48:03 -0700 (PDT)
Message-ID: <46684c34-b790-dced-afc1-03cf0f5ad911@kernel.dk>
Date:   Tue, 11 Apr 2023 19:48:02 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: linux-next: build warnings after merge of the block tree
Content-Language: en-US
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20230327120017.6bb826d7@canb.auug.org.au>
 <20230327162630.wmxpycxhllt4clpt@treble>
 <20230328104719.65133586@canb.auug.org.au>
 <20230412073416.73a8ea1a@canb.auug.org.au>
 <20230411215518.u2fgi7napfcwyuce@treble>
 <4959d0b8-96fe-7fe5-8b36-7e0a266d1d17@kernel.dk>
 <20230412001400.yraku5fwsjdchxvk@treble>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230412001400.yraku5fwsjdchxvk@treble>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/11/23 6:14?PM, Josh Poimboeuf wrote:
> On Tue, Apr 11, 2023 at 04:39:39PM -0600, Jens Axboe wrote:
>>>>>>> lib/iov_iter.o: warning: objtool: .altinstr_replacement+0x0: redundant UACCESS d
>>>>>>> isable
>>>>>>> lib/iov_iter.o: warning: objtool: iovec_from_user.part.0+0xc7: call to copy_comp
>>>>>>> at_iovec_from_user.part.0() with UACCESS enabled
>>>>>>> lib/iov_iter.o: warning: objtool: __import_iovec+0x21d: call to copy_compat_iovec_from_user.part.0() with UACCESS enabled
>>>>>>>
>>>>>>> Presumably introduced by commit
>>>>>>>
>>>>>>>   6376ce56feb6 ("iov_iter: import single vector iovecs as ITER_UBUF")    
>>
>> lib/iov_iter.o attached, gzip'ed. NOTE: if you disable either of the
>> copy_compat_iovec_from_user() as per diff below (commented out), then
>> it doesn't complain. Is there some bug where it thinks we'll hit both?
>> That should not be possible.
> 
> Yeah, the problem is an inter-procedural compiler optimization which
> moves the user_access_begin() out of copy_compat_iovec_from_user() and
> into its callers.

Ah, I see.

> Which is fine, but objtool doesn't like it as it expects the uaccess
> enable to not cross function boundaries.
> 
> Do the warnings go away if you make copy_compat_iovec_from_user()
> non-static?

Yep, if I kill the static, it stops complaining.

-- 
Jens Axboe


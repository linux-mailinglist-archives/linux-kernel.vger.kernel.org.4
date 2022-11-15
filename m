Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAFFE6290E9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 04:40:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235905AbiKODkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 22:40:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232033AbiKODkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 22:40:06 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0506210FC7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 19:40:05 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id k15so12960624pfg.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 19:40:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IzdlQonh9ksiWRR0k5Cq1A47+kjhq4OFBIwy1qdcCmg=;
        b=ZLDkTjJFwaTtzx3Ef09Onguq8cMTLUu9IEYjbLoRUGzk6ulTDfFw+ni0uy1n1Utjjj
         HJHHJjd4XNpN6yIrAbr8fMM5mGQ3ERZuduvwoNToYgXUJ2F7mhGkSD7hHYG95gvFtaRj
         Ih510ouJY4TlIBwaj4F63HFxqAFxe92iA/vGZVp/00tgZd56F9LOzQXyeQBXyWrqvqD5
         +tJjfQsDPmI3BgrCZQk1RIArWN9leJGs4MsqSi5cWwsFimv+oMiMsBgpB/+PsX90xuAk
         jrLGuydsKvTIVXVNpOkKN2TRoeLGpP+WzLG1DhDTmHV9R3Wu/FefvswkfajppVg6jenm
         eOjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IzdlQonh9ksiWRR0k5Cq1A47+kjhq4OFBIwy1qdcCmg=;
        b=HVCmj1oErPEc4d+z57FTUQWLO9qcgEoESl5UKPqFp9TaYWmyN2jH4m1MCO7LFG585J
         o0rTtvWoLH+6CXIoU/80oWZ7gcwhQSb9IxVuycyHmM9fReEwgmCkl/cmA20sEx6fyun5
         VQr17+QznvrRgdf4oBZouL0l6XJC1QBVMIVLp9clu497kDgNDJwHhTZI/gxU2gSQ1k/l
         sA67yuxiEwt/3h8MrDTYOnIBWON1+qhME67XT8OciPog65Pczg8XGqYy3RZP0zmqDpCP
         apw55cPB94UX7Vdp7cyYoqniCxdVYvKue2g0UVmA7pnB2lqUpJIp7X77XRizCktaT31K
         zRww==
X-Gm-Message-State: ANoB5plmVreW/J5DiovRWHov5k6m2DUmrBXnqTXakHG04RRU7WC8eMJX
        y8Z/FWd/VtxL7qzL2zvWD2zsIA==
X-Google-Smtp-Source: AA0mqf6btc+EJX1sgkPBLfYXPRpcR1cqU2L9+Cbc/TvjhYzVhQRiZmUsPGAYH2NmA3RNvpVLWxaQYg==
X-Received: by 2002:aa7:8396:0:b0:56b:f3b2:5543 with SMTP id u22-20020aa78396000000b0056bf3b25543mr16810448pfm.65.1668483604557;
        Mon, 14 Nov 2022 19:40:04 -0800 (PST)
Received: from [10.255.4.35] ([139.177.225.229])
        by smtp.gmail.com with ESMTPSA id x13-20020a63f70d000000b0046f469a2661sm6586284pgh.27.2022.11.14.19.39.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 19:40:04 -0800 (PST)
Message-ID: <ba8aa36a-d0d7-b716-a9c7-02c6d5a60712@bytedance.com>
Date:   Tue, 15 Nov 2022 11:39:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [RFC PATCH] getting misc stats/attributes via xattr API
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org, Dave Chinner <david@fromorbit.com>,
        Theodore Ts'o <tytso@mit.edu>, Karel Zak <kzak@redhat.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Christian Brauner <brauner@kernel.org>,
        linux-kernel@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        LSM <linux-security-module@vger.kernel.org>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        chenying.kernel@bytedance.com
References: <YnEeuw6fd1A8usjj@miu.piliscsaba.redhat.com>
 <e57733cd-364d-84e0-cfe0-fd41de14f434@bytedance.com>
 <CAJfpegsVsnjUy2N+qO-j4ToScwev01AjwUA0Enp_DxroPQS30A@mail.gmail.com>
Content-Language: en-US
From:   Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <CAJfpegsVsnjUy2N+qO-j4ToScwev01AjwUA0Enp_DxroPQS30A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/14/22 8:35 PM, Miklos Szeredi wrote:
> On Mon, 14 Nov 2022 at 10:00, Abel Wu <wuyun.abel@bytedance.com> wrote:
>>
>> Hi Miklos and anyone interested in this proposal, is there any update on
>> this? Sorry that I didn't find any..
> 
> No update.
> 
> Which part are you interested in?

We noticed that atop(1) can introduce a burst cpu usage once number of
processes becoming large. It is mostly due to the overhead of massive
syscalls. There are similar cases like monitor agents recording system
status and consuming resources in modern data centers. So it would be
nice to get a bunch of info in one syscall.

> 
> Getting mount attributes?  Or a generic key-value retrieval and
> storage interface?

The latter.

> 
> For the first one there are multiple proposals, one of them is adding
> a new system call using binary structs.  The fsinfo(2) syscall was
> deemed overdesigned and rejected.  Something simpler would probably be
> fairly uncontroversial.
> 
> As for the other proposal it seems like some people would prefer a set
> of new syscalls, while some others would like to reuse the xattr
> syscalls.  No agreement seems to have been reached.

So the divergence comes from 'how' rather than 'why', right?

Thanks & Best,
	Abel

> 
> Also I think a notification system for mount related events is also a
> much needed component.   I've tried to explore using the fsnotify
> framework for this, but the code is pretty convoluted and I couldn't
> get prototype working.
> 
> Thanks,
> Miklos

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22AA85E662D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 16:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231509AbiIVOwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 10:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbiIVOwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 10:52:00 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E15ED4DD3;
        Thu, 22 Sep 2022 07:51:58 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|siddhesh@gotplt.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 6E14F42137;
        Thu, 22 Sep 2022 14:45:10 +0000 (UTC)
Received: from pdx1-sub0-mail-a304 (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 4990E41FEE;
        Thu, 22 Sep 2022 14:45:09 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1663857909; a=rsa-sha256;
        cv=none;
        b=0LmZkMVID3cHw88umcSwqyfbTs9dctjU5meekkjxzhu396zqRZWmIVWll6DLCFmzMLK/YW
        lhNuOAg8Msfgu8/QMivqD4UNAL6/hWqFu3zI+9NjObyJbIvws/bzIg5e1ekCQDqS6VAA+M
        rkmYDf/sh2guVYn5na9BCpu61Nw0de7HDGGChBgt3ngqQvpMV+1nRla1dWhJMZW884ynif
        iIyphQNFCZPTDZNuNcMis6FA+O1jYpK1D6RoGqD1c7mQiGOkH1eMmRUY5PHC1VSFsS7lLU
        SrYqU1LQdDnwOKYJNCWAsCbZY/jB2pqAQ9LSF2Lf59REB8aEkQ4n7JOTjxyMaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1663857909;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=xghhsyINLuqLaVcS7ccFn+Lr2S2KTsZvKraPs0CAUyo=;
        b=L/PRgfU5hubvi8kLooeywHrVVWr/2x/cQnzQprVES98eilwHA1mW+SbCiqGZia3dyoYq8+
        8gz2xClRnlSlW5eSnZwMt0Y8uQM57qg4bmdP//q8HX4KKUDu7FOTHzHCoXDyE1oe20yjVv
        wwNzWmjZqOfi8ikgHjra3ImTKZ6Zn49W7e6UkqAcDUoMnVEkXr6BYFtfKzJZcYe9LsOSf/
        sP9pY2CK4L3lPnYjIG2VPqupdnVc2ZYbtITZQOAyuZZUXrcQncfLjeiUATPdx/9GrweWJL
        fzkwkdBxIH8lJCjssz3i/d2FrwB6WmqcITt4sHTu3MSLB9CB2L8RguObMfD6jQ==
ARC-Authentication-Results: i=1;
        rspamd-f776c45b8-n6pdg;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=siddhesh@gotplt.org
X-Sender-Id: dreamhost|x-authsender|siddhesh@gotplt.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|siddhesh@gotplt.org
X-MailChannels-Auth-Id: dreamhost
X-Wiry-Versed: 583809950bb2ad8d_1663857909818_554295810
X-MC-Loop-Signature: 1663857909818:4056437340
X-MC-Ingress-Time: 1663857909818
Received: from pdx1-sub0-mail-a304 (pop.dreamhost.com [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.120.183.79 (trex/6.7.1);
        Thu, 22 Sep 2022 14:45:09 +0000
Received: from [192.168.0.182] (bras-vprn-toroon4834w-lp130-16-184-147-84-238.dsl.bell.ca [184.147.84.238])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: siddhesh@gotplt.org)
        by pdx1-sub0-mail-a304 (Postfix) with ESMTPSA id 4MYJ3Q3x1Zz3m;
        Thu, 22 Sep 2022 07:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gotplt.org;
        s=dreamhost; t=1663857908;
        bh=xghhsyINLuqLaVcS7ccFn+Lr2S2KTsZvKraPs0CAUyo=;
        h=Date:Subject:To:Cc:From:Content-Type:Content-Transfer-Encoding;
        b=sDuand+a/XJS5s78apGW69loriemQlZJQ7rpOUgRf24nsWGEKRpES6+MRu23z28g9
         bKACu3T0LzFp3cVqyL+qnrcVMgit+Fo3mE5cxMwb0vxpP3y9I50ub3lmeC9etjP7sE
         0ximi6cWqSLtvkGdwQwEavRdrkcGSnrSx8SNAAgcEAQLdiJ+sOdvkjzWcGZ26jlP3a
         hEqFXgfYLOC0knlo2rtskNHSwm8bhU/Bc/RWt5A3Ts0Sdn5c2Nxi0SQLAkQXjC2fjG
         ccmOVzTQAWodpCYvzVC2p5PPPpSmhmTzc7Q82Yrg06dgO9X3XECC0k+4g5OPaMAASe
         w3YkuN+avYk9Q==
Message-ID: <450c41a1-9713-0928-338a-3f3d659b9894@gotplt.org>
Date:   Thu, 22 Sep 2022 10:45:05 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 4/4] fortify: Use __builtin_dynamic_object_size() when
 available
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-hardening@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>, llvm@lists.linux.dev,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        linux-kernel@vger.kernel.org
References: <20220920192202.190793-1-keescook@chromium.org>
 <20220920192202.190793-5-keescook@chromium.org>
 <9d80e0a3-3fcc-0676-4529-79743f418557@gotplt.org>
 <202209212032.5F392F42@keescook>
From:   Siddhesh Poyarekar <siddhesh@gotplt.org>
In-Reply-To: <202209212032.5F392F42@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-09-21 23:33, Kees Cook wrote:
> On Wed, Sep 21, 2022 at 07:43:17AM -0400, Siddhesh Poyarekar wrote:
>> On 2022-09-20 15:22, Kees Cook wrote:
>>> Since the commits starting with c37495d6254c ("slab: add __alloc_size
>>> attributes for better bounds checking"), the compilers have runtime
>>> allocation size hints available in some places. This was immediately
>>> available to CONFIG_UBSAN_BOUNDS, but CONFIG_FORTIFY_SOURCE needed
>>> updating to explicitly make use the hints via the associated
>>> __builtin_dynamic_object_size() helper. Detect and use the builtin when
>>> it is available, increasing the accuracy of the mitigation. When runtime
>>> sizes are not available, __builtin_dynamic_object_size() falls back to
>>> __builtin_object_size(), leaving the existing bounds checking unchanged.
>>
>> I don't know yet what the overhead is for __builtin_dynamic_object_size vs
>> __builtin_object_size, were you able to measure it somehow for the kernel?
>> If there's a significant tradeoff, it may make sense to provide a user
>> override.
> 
> So far I've not seen any measurable performance difference, but I just
> may not be creative enough yet.
> 
> So far, the tunable is building a kernel with or without FORTIFY_SOURCE
> and UBSAN_BOUNDS. :)
> 

The overhead should only be noticeable in, e.g. fortified calls inside a 
hot loop.  In theory expressions to compute sizes could be arbitrarily 
complex, but I haven't seen any cases yet that were large enough to be a 
bother.  I reckon if we find such use cases, it'll be in the kernel but 
even then it may not be worth downgrading fortification across all 
sources just for those specific hot paths.  So I agree, the user 
override isn't critically necessary.

FWIW,

Reviewed-by: Siddhesh Poyarekar <siddhesh@gotplt.org>

Thanks,
Sid

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D03F71FACA
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 09:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234126AbjFBHOP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 03:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232239AbjFBHOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 03:14:08 -0400
X-Greylist: delayed 104 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 02 Jun 2023 00:14:06 PDT
Received: from smtpq4.tb.ukmail.iss.as9143.net (smtpq4.tb.ukmail.iss.as9143.net [212.54.57.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14E77132
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 00:14:05 -0700 (PDT)
Received: from [212.54.57.97] (helo=smtpq2.tb.ukmail.iss.as9143.net)
        by smtpq4.tb.ukmail.iss.as9143.net with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        (envelope-from <smf-linux@virginmedia.com>)
        id 1q4yxR-0007ts-Pk
        for linux-kernel@vger.kernel.org; Fri, 02 Jun 2023 09:12:21 +0200
Received: from [212.54.57.105] (helo=csmtp1.tb.ukmail.iss.as9143.net)
        by smtpq2.tb.ukmail.iss.as9143.net with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        (envelope-from <smf-linux@virginmedia.com>)
        id 1q4yxP-0005a0-Ud
        for linux-kernel@vger.kernel.org; Fri, 02 Jun 2023 09:12:19 +0200
Received: from Moira ([82.0.204.144])
        by cmsmtp with SMTPA
        id 4yxOqXMO0zx3m4yxOq2pao; Fri, 02 Jun 2023 09:12:19 +0200
X-SourceIP: 82.0.204.144
X-Authenticated-Sender: smf-linux@virginmedia.com
X-Spam: 0
X-Authority: v=2.4 cv=AJMelZwL c=1 sm=1 tr=0 ts=64799653 cx=a_exe
 a=7KlAsy3RGnwpW11VTsQBiw==:117 a=7KlAsy3RGnwpW11VTsQBiw==:17
 a=IkcTkHD0fZMA:10 a=of4jigFt-DYA:10 a=e5mUnYsNAAAA:8 a=Frlf4u0NsMQjUqWB7K0A:9
 a=QEXdDO2ut3YA:10 a=Vxmtnl_E_bksehYqCbjh:22
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virginmedia.com;
        s=meg.feb2017; t=1685689939;
        bh=9EoG3Ymv1xxJO4OrF3iWrxZxfJMXhMsXIBDRxtNTzfs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=pU3jG/GkCBBXUUzXFjRPOHWGmHngdqxylMBKx6aCnl+Bsx79J0VjPfdYfs8YHhBnV
         yVZfQWzw9tsVA9OTd5yfPkdPTV+M+HLaB4pKWLTGO4yQ6G3SGJnLeKO9rdRkzFTL7W
         ulGfdHuVWmCA0NUX1tjQlPHYedU44+WEZPc7tHEv5D3x3o6djqOOSldIzPVvQ/PIH4
         /5ZcsTzmuI/5cGFVVBJf/D4+mN6Gm+ayhfwJYwwWqVRisAqOEUkfnishlWvu/JfSa3
         E1QpLRjqLk51nXe9O05cf9MBtHnDPfB0ImSxLunOtuEox0LSg8n1fi7GgvPkHnsezQ
         ryNOfhWnrTF6Q==
Message-ID: <33a192fc-9279-6681-32ed-2046ed2e3ce1@virginmedia.com>
Date:   Fri, 2 Jun 2023 08:12:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: Fwd: Started to get "memfd_create() without MFD_EXEC nor
 MFD_NOEXEC_SEAL"
Content-Language: en-GB
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Vlastimil Babka <vbabka@suse.cz>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Jeff Xu <jeffxu@google.com>,
        Daniel Verkamp <dverkamp@chromium.org>,
        David Herrmann <dh.herrmann@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Hugh Dickins <hughd@google.com>, Jann Horn <jannh@google.com>,
        Jorge Lucangeli Obes <jorgelo@chromium.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <69dad53e-9363-c551-111a-d0051bb0265f@gmail.com>
 <38f847ed-69dc-d5da-5822-bd9da753fc30@suse.cz>
 <202306010710.7F5C39B7A@keescook>
 <74b8e4c0-a557-b047-4507-c243c9aad216@gmail.com>
From:   Stuart Foster <smf-linux@virginmedia.com>
Organization: Linux Development
In-Reply-To: <74b8e4c0-a557-b047-4507-c243c9aad216@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfCSb7Kr7YK7fDk5I8YK/NfMO+h6QittNrtGhdPZVOvh/sIsLJN6kIS+gP2UXJIMTQj/7hnRpIfc3DVmGUJZJAArBJdTzkp8/sv3FqMrE5FN6HOEfi7wF
 AdpBSq2DHmD3isDkrcFlSt/6qEeul0faS6wra1JNWFwfUt+uleBAzIwzOP4MBXmFHQgTEdOsmT42YHGec/UKyCCIAaYMotU4bFi/PIizsghUihLY+NtABs2s
 OuQSycOIDIplliUeupZww0IM8N0zG7wSZ/3vEQM+QQD1rMYR2n7ORxq+/yQNX7EjJOQsk/+59uvfMyl69Ur2Njz6tBpw/a4HTgBEe/NhVxyky0U3ZJUp/kxw
 sygTLKIURaHmPdd5SuvWLPgnwVAGT6Hr/jmHbBE3gxDjIRRA+3p1y7MCdV7THa2QZ3I1952s0r2seyNgqWYiegkVHd5WSx6Heq4PbWl9ePWNPBvUV2QfOOFc
 kGmbNhATyGfw9EX0C/lzF5P7OPtqivmlYge56gPUeTYQCiqPEu5gEy/r0KQOmkBTjGhms6phRSnoVmv+Hza0RZrG17BQzHml5f+87Z6EivtfaE4XBnt6tDcr
 SbGJc5YrTylX7detjf8m+uJkSK1sad28YNKLKLoCKFSNSsydEqPaX4R8UsgX8dJyUZE=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/06/2023 03:15, Bagas Sanjaya wrote:
> On 6/1/23 21:12, Kees Cook wrote:
>>> Hm indeed it seems to have introduced 2 new flags and immediately warn if
>>> any process doesn't use them. Maybe it would make sense for some of the
>>> non-default values of vm.memfd_noexec, but it's too early to warn
>>> unconditionally everywhere, no?
>>
>> This is pretty standard for getting new options like this noticed by
>> userspace -- there is no regression in _behavior_. It's just a reminder
>> to fix userspace code.
>>
> 
> Telling regzbot:
> 
> #regzbot invalid: not a kernel regression, but userspace fix is needed
> 
> Thanks.
> 

Issue raised with XOrg:

https://gitlab.freedesktop.org/xorg/xserver/-/issues/1553


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2E6774E6CE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 08:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbjGKGHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 02:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbjGKGHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 02:07:50 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0977F1BC;
        Mon, 10 Jul 2023 23:07:47 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qJ6XJ-0006TS-7b; Tue, 11 Jul 2023 08:07:45 +0200
Message-ID: <e6c6b7b0-f5f1-603f-5f19-0f651d13739f@leemhuis.info>
Date:   Tue, 11 Jul 2023 08:07:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US, de-DE
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
References: <cover.1689008220.git.linux@leemhuis.info>
 <d30686781c47c83927e0a41f6a1167a679fa822c.1689008220.git.linux@leemhuis.info>
 <2023071003-slab-underling-2b50@gregkh>
From:   Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: [RFC PATCH v1 1/3] docs: stable-kernel-rules: mention other
 usages for stable tag comments
In-Reply-To: <2023071003-slab-underling-2b50@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1689055667;bfe6727a;
X-HE-SMSGID: 1qJ6XJ-0006TS-7b
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.07.23 21:43, Greg KH wrote:
> On Mon, Jul 10, 2023 at 07:10:11PM +0200, Thorsten Leemhuis wrote:
>> Document how to delay backporting or send a note to the stable team
>> using shell-style inline comments attached to stable tags.
>>
>> CC: Greg KH <gregkh@linuxfoundation.org>
>> CC: Sasha Levin <sashal@kernel.org>
>> CC: Jonathan Corbet <corbet@lwn.net>
>> Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
>> ---
>>  Documentation/process/stable-kernel-rules.rst | 22 ++++++++++++++++---
>>  1 file changed, 19 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/process/stable-kernel-rules.rst b/Documentation/process/stable-kernel-rules.rst
>> index 51df1197d5ab..6e4026dd6882 100644
>> --- a/Documentation/process/stable-kernel-rules.rst
>> +++ b/Documentation/process/stable-kernel-rules.rst
>> @@ -55,9 +55,10 @@ To have the patch automatically included in the stable tree, add the tag
>>  
>>       Cc: stable@vger.kernel.org
>>  
>> -in the sign-off area. Once the patch is merged it will be applied to
>> -the stable tree without anything else needing to be done by the author
>> -or subsystem maintainer.
>> +in the sign-off area; to accompany a note to the stable team, use a shell-style
> 
> Is that how a ';' is really used?  I never can remember, so it's an
> honest question here :)

Ha, better ask a native speaker or your favorite internet search engine
for advice and not someone from Germany that in school was always bad at
both German and English. ;)

But to answer the question: I think it is used this way in English "to
connect related, but independent clauses". But the relation is not that
strong or important here; I also tend use semicolons a bit too much, so
I'll just drop it for v2.

> [...]
> This looks great to me, so I'll be glad to take it.

thx!

Ciao, Thorsten

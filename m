Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 520C374AA66
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 07:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232298AbjGGFYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 01:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjGGFYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 01:24:46 -0400
Received: from smtp.smtpout.orange.fr (smtp-30.smtpout.orange.fr [80.12.242.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD0D171D
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 22:24:44 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id HdxOqZv2Mv997HdxPqkQHT; Fri, 07 Jul 2023 07:24:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1688707481;
        bh=7lGGdENEqz/j3hddOtM6jrD7+VEvkBHFSPUjfBz4mYM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=Rk/nNfxq9oTImDfxt0Dt9F7Yh/cc+d1SM7h5jRNEWD/5vXMidEWBxAKbf5DI5Pc3y
         fPV4W9FBe+r/0KKpxmqpNgFeGYM8FVU5oY+n0tbn1eAxRpwllFQC8BI9Frf5llqwwW
         Zm3qTLqIe6gYfwvxoRaZFNyWYjYxbcXwcW9pfcV/8dq96xDoVMS3QETZjuNY0Ovvun
         +qc4RyuMp3I+8UkXTwragu9B06J6eRVMPnXcpA3CAxcnZTqAnwij+A5OO4KzRNClGI
         pJtnzeeLAihu7gBnUVvm9lVjp74YBl2GgJHKxDyIRRSMRLOBmjLnReysB6JRxnLkOQ
         FKuUddqdZc5bw==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 07 Jul 2023 07:24:41 +0200
X-ME-IP: 86.243.2.178
Message-ID: <0d8a89fb-b1ef-9a15-8731-4160b1287e14@wanadoo.fr>
Date:   Fri, 7 Jul 2023 07:24:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogW1BBVENIIHYxXSBuZXQ6dGlwYzpSZW1vdmUgcmVw?=
 =?UTF-8?Q?eated_initialization?=
To:     =?UTF-8?B?546L5piOLei9r+S7tuW6leWxguaKgOacr+mDqA==?= 
        <machel@vivo.com>
Cc:     Jon Maloy <jmaloy@redhat.com>, Ying Xue <ying.xue@windriver.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "tipc-discussion@lists.sourceforge.net" 
        <tipc-discussion@lists.sourceforge.net>,
        LKML <linux-kernel@vger.kernel.org>,
        "opensource.kernel" <opensource.kernel@vivo.com>,
        Jakub Kicinski <kuba@kernel.org>
References: <20230706134226.9119-1-machel@vivo.com>
 <20230706084729.12ed5725@kernel.org>
 <a409e348-0d15-e7f6-5d97-1ebe8341027a@wanadoo.fr>
 <SG2PR06MB3743FFC941CC9B242113A8A4BD2DA@SG2PR06MB3743.apcprd06.prod.outlook.com>
Content-Language: fr, en-GB
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <SG2PR06MB3743FFC941CC9B242113A8A4BD2DA@SG2PR06MB3743.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 07/07/2023 à 03:24, 王明-软件底层技术部 a écrit :
> Hi CJ
> : )
> So what you're saying is there's no repeat initialization problem here.

Hi,

First, top posting is usually not the better way to answer email.


Anyway, in your patch, you have:
  	n = &grp->members.rb_node;
  	while (*n) {
  		tmp = container_of(*n, struct tipc_member, tree_node);
-		parent = *n;
-		tmp = container_of(parent, struct tipc_member, tree_node);
  		nkey = (u64)tmp->node << 32 | tmp->port;
  		if (key < nkey)
  			n = &(*n)->rb_left;

You are right, 'tmp' is initialized twice. It is even initialized twice, 
with the same walue.

But in your patch, you also remove "parent = *n;"
So now, 'parent' is never updated in the function, and when 
rb_link_node() is called after the while loop, it is NULL.

So your patch changed the behaviour of the code and looks broken.

Something like:
  	while (*n) {
  		tmp = container_of(*n, struct tipc_member, tree_node);
		parent = *n;
-		tmp = container_of(parent, struct tipc_member, tree_node);
  		nkey = (u64)tmp->node << 32 | tmp->port;
  		if (key < nkey)
  			n = &(*n)->rb_left;

would look good to me but, as said by Jakub in the thread, is really 
unlikely to be applied.

The risk of breaking code (as you un-intentionally did) is higher than 
the value of removing a redundant initialization.

Reviewing such patches also consume maintainers' time to check for such 
potential errors and sometimes it is safer to leave things as-is in 
order not to waste time and avoid potential troubles.

CJ


> 
> -----邮件原件-----
> 发件人: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> 发送时间: 2023年7月7日 1:14
> 收件人: 王明-软件底层技术部 <machel@vivo.com>
> 抄送: Jon Maloy <jmaloy@redhat.com>; Ying Xue <ying.xue@windriver.com>; David S. Miller <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>; Paolo Abeni <pabeni@redhat.com>; netdev@vger.kernel.org; tipc-discussion@lists.sourceforge.net; linux-kernel@vger.kernel.org; opensource.kernel <opensource.kernel@vivo.com>; Jakub Kicinski <kuba@kernel.org>
> 主题: Re: [PATCH v1] net:tipc:Remove repeated initialization
> 
> [你通常不会收到来自 christophe.jaillet@wanadoo.fr 的电子邮件。请访问 https://aka.ms/LearnAboutSenderIdentification，以了解这一点为什么很重要]
> 
> Le 06/07/2023 à 17:47, Jakub Kicinski a écrit :
>> On Thu,  6 Jul 2023 21:42:09 +0800 Wang Ming wrote:
>>> The original code initializes 'tmp' twice, which causes duplicate
>>> initialization issue.
>>> To fix this, we remove the second initialization of 'tmp' and use
>>> 'parent' directly forsubsequent operations.
>>>
>>> Signed-off-by: Wang Ming <machel@vivo.com>
>>
>> Please stop sending the "remove repeated initialization" patches to
>> networking, thanks.
>>
>>
> 
> The patch also looks just bogus, as 'parent' is now always NULL when:
>      rb_link_node(&m->tree_node, parent, n);
> 
> is called after the while loop.
> 
> CJ


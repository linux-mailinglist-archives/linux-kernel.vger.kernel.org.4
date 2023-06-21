Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6377C73812C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 13:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbjFUKlB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 06:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbjFUKkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 06:40:15 -0400
Received: from tretyak2.mcst.ru (tretyak2.mcst.ru [212.5.119.215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D62062101;
        Wed, 21 Jun 2023 03:39:15 -0700 (PDT)
Received: from tretyak2.mcst.ru (localhost [127.0.0.1])
        by tretyak2.mcst.ru (Postfix) with ESMTP id 8B30710239C;
        Wed, 21 Jun 2023 13:39:10 +0300 (MSK)
Received: from frog.lab.sun.mcst.ru (frog.lab.sun.mcst.ru [176.16.4.50])
        by tretyak2.mcst.ru (Postfix) with ESMTP id 81FED102390;
        Wed, 21 Jun 2023 13:38:15 +0300 (MSK)
Received: from [172.16.7.18] (gang [172.16.7.18])
        by frog.lab.sun.mcst.ru (8.13.4/8.12.11) with ESMTP id 35LAcEJg022490;
        Wed, 21 Jun 2023 13:38:14 +0300
Message-ID: <f687fe6f-3330-a9c5-4760-f753638c7b03@mcst.ru>
Date:   Wed, 21 Jun 2023 13:49:28 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
From:   "Igor A. Artemiev" <Igor.A.Artemiev@mcst.ru>
Subject: Re: [lvc-project] [PATCH] netfilter: ebtables: remove unnecessary
 NULL check
To:     Florian Westphal <fw@strlen.de>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        "David S . Miller" <davem@davemloft.net>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
References: <20230620152549.2109063-1-Igor.A.Artemiev@mcst.ru>
 <20230620163806.GB3799@breakpoint.cc>
Content-Language: en-US
In-Reply-To: <20230620163806.GB3799@breakpoint.cc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Anti-Virus: Kaspersky Anti-Virus for Linux Mail Server 5.6.39/RELEASE,
         bases: 20111107 #2745587, check: 20230621 notchecked
X-AV-Checked: ClamAV using ClamSMTP
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/20/23 19:38, Florian Westphal wrote:
> Igor Artemiev <Igor.A.Artemiev@mcst.ru> wrote:
>> In ebt_do_table() 'private->chainstack' cannot be NULL
>> and the 'cs' pointer is dereferenced below, so it does not make
>> sense to compare 'private->chainstack' with NULL.
> ?  Why do you think that?
>
The 'cs' pointer is dereferenced below without checking, as it is 
assumed to always be initialized with 
'private->chainstack[smp_processor_id()]'.
>> +	cs = private->chainstack[smp_processor_id()];
> Looks like NULL deref to me.  Did you test this?
>
No, I didn't test this.

Thanks,
Igor


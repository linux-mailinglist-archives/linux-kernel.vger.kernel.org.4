Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D159F6F9ECB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 06:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232273AbjEHEwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 00:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjEHEwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 00:52:33 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C18659E2;
        Sun,  7 May 2023 21:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=G8lBxUMmBUc6zMeTEBtbH9yED1SWLZMFoPA2eo1ufi8=; b=jB/hnKlKvwGXM/LC4y2OXDPeQm
        j7mLo/7MJWCy3eAqQ0hWbiFHSDWqLjd6fv1r93FKqjT2OvXw4RzwbIRyXDs9c4WWhmrfOrg4qec3B
        06nAk7dCYeBJym6Nd4lXmqkW462CD7s52cVXkjw9EVPmphp/+28fAffaoP3OVhiYP2dVo8HXyAFXy
        6FCDU/6n81x6RUgySlipF8jt4n9ANHcOQlnioJljwTCeg/+mk8ZrVBosvcO5oRu9X/6oZiXA3Xvew
        Q8Qmyaru9L0M9VZl/ri+4blL2hKARgz73yodJwfijbk4nkWjlzpsBkS1tDgO8YAlLC3vtKrQZsP/W
        gtVjq08w==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pvsrJ-00HGBR-2k;
        Mon, 08 May 2023 04:52:25 +0000
Message-ID: <cccc2dc5-b4d5-3b2b-bd23-b63c20b1023a@infradead.org>
Date:   Sun, 7 May 2023 21:52:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: linux-next: build warnings after merge of Linus' tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20230508144947.3ac1dfe9@canb.auug.org.au>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230508144947.3ac1dfe9@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/7/23 21:49, Stephen Rothwell wrote:
> Hi all,
> 
> While building Linus' tree, today's linux-next build (htmldocs)
> produced these warnings:
> 
> kernel/sched/core.c:11496: warning: Cannot understand  * @cid_lock: Guarantee forward-progress of cid allocation.
>  on line 11496 - I thought it was a doc line
> kernel/sched/core.c:11505: warning: Cannot understand  * @use_cid_lock: Select cid allocation behavior: lock-free vs spinlock.
>  on line 11505 - I thought it was a doc line
> 
> Introduced by commit
> 
>   223baf9d17f2 ("sched: Fix performance regression introduced by mm_cid")
> 

I have sent a patch:
  https://lore.kernel.org/lkml/20230428031111.322-1-rdunlap@infradead.org
but haven't seen any replies to it (possibly due to the merge window or travel).

-- 
~Randy

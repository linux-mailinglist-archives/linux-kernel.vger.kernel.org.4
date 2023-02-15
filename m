Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15FD069811E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 17:44:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjBOQod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 11:44:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjBOQob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 11:44:31 -0500
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F72F1F488;
        Wed, 15 Feb 2023 08:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1676479465;
        bh=kmtq4zGHdgepWTWaPMveFEfqRnLWAe/3nhgtsf8RMNk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Wgumu0O9tM5BQ6dMRiQPNYuaJT2IDqtSu8PT1z7EYU+vUxI8dT2W4A+SjK2jFDcaq
         J8wETnpScrW7OUNYKl2I7pepQdAJTQ5yXDIgdrkYg2XeoDDgkA16OyH1Vwy6oqXM11
         BtzUp9zMqQmazNsJRubogWaUMA3tweaNbfpqFD75rJd45gL8QkNHE3pmTw1q1yOvQ4
         4q1eXrsufPU9uviZJPyN00FhCVSIjAxXXxReY11lCXLfcrPFWbTHNasRxgX//14f3+
         95xDz/uzrwv2EnLfFlq00Q57IOG0W960Jt56ZezL3ugOGo66S7Yt9/7xyjSKE5qmvd
         qTBvtqnQkWvOg==
Received: from [172.16.0.188] (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4PH3nj3tMpzlcC;
        Wed, 15 Feb 2023 11:44:25 -0500 (EST)
Message-ID: <b53cba22-815b-7344-5787-1eb26e613a16@efficios.com>
Date:   Wed, 15 Feb 2023 11:44:24 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 1/1] rseq.2: New man page for the rseq(2) API
Content-Language: en-US
To:     Alejandro Colomar <alx.manpages@gmail.com>,
        "G. Branden Robinson" <g.branden.robinson@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-man <linux-man@vger.kernel.org>
References: <20230214195442.937586-1-mathieu.desnoyers@efficios.com>
 <669eb324-aef6-0583-c8a4-f54a93ee4d6d@gmail.com>
 <20230215012054.twzw4k5et6hxvi2j@illithid>
 <82ced680-8c2c-75b7-4368-16e602353f32@gmail.com>
 <20230215022150.pxuhdbx2zdwjpems@illithid>
 <a5eea3fa-11be-21f6-4e7b-617cb7ff428d@gmail.com>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <a5eea3fa-11be-21f6-4e7b-617cb7ff428d@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-02-14 22:07, Alejandro Colomar wrote:
> Hi Branden,
> 
> On 2/15/23 03:21, G. Branden Robinson wrote:
>> At 2023-02-15T02:52:03+0100, Alejandro Colomar wrote:
>>> On 2/15/23 02:20, G. Branden Robinson wrote:
>>>> [CC list violently trimmed; for those who remain, this is mostly man
>>>> page style issues]
>>>
>>> Ironically, you trimmed linux-man@  :D
>>
>> I didn't!  It wasn't present in the mail to which I repled.
> 
> Hmm, you're right, Mathieu didn't CC linux-man@.  I guessed somewhere
> in that big list it would be there, but it wasn't.  Thanks for CCing it.
> 
>>
>> This did puzzle me.  I guess it was an oversight.  You might want to
>> re-send that message of yours, and/or Mathieu's, if it lacked it too.

My bad. The list I used was from a script I last updated when I was 
trying to get Michael's attention a few years ago. I've trimmed it and 
included linux-man@.

I will use that new email list for my next post taking your comments 
into account.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36EBD6EA157
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 03:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232930AbjDUB6c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 21:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjDUB6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 21:58:30 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEACF183
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 18:58:29 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 52B635C01C1;
        Thu, 20 Apr 2023 21:58:27 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute6.internal (MEProxy); Thu, 20 Apr 2023 21:58:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1682042307; x=1682128707; bh=xU
        AZyNdG+JjO3VI3lilfJ4OkHzwV6FlCSaYK+jkyBLU=; b=SFiUs2RUqjEY+paB1V
        c9YuPX4X0hGuVuxgfWxdUEnxr712U5djrjYQUQRI5lPalZd8ZMbtH8enfGk7vl2W
        4ypuF2nylPWI3Z+arGzsQXCoMwX5EX8h7hluGeFGW0A1Zw+32atV6cBrQ6V3+MXH
        NL6PPTPx7QPtuBP+nTGMsHFWwKRsjLs4MFDdn+m6ws/tTn0kVYAVoPMMOXE66Znh
        eoXa03U3xlMIpp1TFzgZwOUTagHnQ2jZEoymw6mf2li7yxrZVlRgqfI3plSw/2j8
        vaI68SimrLi9hB92/mbT3w7L4vPsb/wrqfKXPx5fFdv2MfRqax0DdUAlK+YaH7Kn
        AJ6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1682042307; x=1682128707; bh=xUAZyNdG+JjO3
        VI3lilfJ4OkHzwV6FlCSaYK+jkyBLU=; b=PxDoaUAOZc7aLv+qZ0XpARiL1Enum
        4TPr03XdXFp9wQ/2pP3YCWPBoHQM8Jvf1PU09JCM7nEtiUNhSMYZqRnTvjdlZ4i+
        ysE40BVyUhMZwfjMbI45UplPZ8scLyMdS7vmLtNaGYBtY2CypOsgQ/aBshaZ/NgU
        /Lw3dhTfyYKY+4HI1y7SIpxzv/jqAnAcIe6a71JZn8ZG63uWZNX5VMhTGFXRMTq5
        wF1rJ79WAs4R/WnzBZKNEwbP+yjmTxpnGJd16wUAudq8Tfqk5qfbOUOoR16ugvBA
        vkzSfYN7Q5p1q3UddmlgxduoWE/im1T1uPtYRkI3lV4zx9cMZbyx2K0Yw==
X-ME-Sender: <xms:wu1BZOv4cgeshDILQhNPRdrMFNeijBR68tYB5ZqHjNop38Jp3Qen-g>
    <xme:wu1BZDc6MQJYbX_zTkFRZ9wUS1BWfJzEte7vZdvL6BYbBM48o6pbJZaWKmzK6ezYP
    R02ebmXB2Q08e6puQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfedtfedgheefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    goufhushhpvggtthffohhmrghinhculdegledmnecujfgurhepofgfggfkjghffffhvfev
    ufgtsehttdertderredtnecuhfhrohhmpedftehnughrvgifucflvghffhgvrhihfdcuoe
    grnhgurhgvfiesrghjrdhiugdrrghuqeenucggtffrrghtthgvrhhnpeekvdelkeeiiedv
    teejvdffteetgeduudeiteejtdeigfffveeitdekfedtgfelleenucffohhmrghinhepsh
    houhhrtggvfhhorhhgvgdrnhgvthenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpegrnhgurhgvfiesrghjrdhiugdrrghu
X-ME-Proxy: <xmx:wu1BZJyLV33AXMVWF3pTi-xKtR9q9vzaP3-qDvRinb_6VU6MkD3Rzw>
    <xmx:wu1BZJMFaEZxpEUU6otNXB1q-GnsR_VV3piUUKEdGvUFY52TIJ16Uw>
    <xmx:wu1BZO81FEkYl2n33aHqy25Rc_ntLY8QFN7QHGtOwxqn7Swn7727Rw>
    <xmx:w-1BZFZgJSVDmeSN8p8BbqdsUMk4Cm5njRzywsfRW290xsuH1uoB8g>
Feedback-ID: idfb84289:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 742C71700089; Thu, 20 Apr 2023 21:58:26 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-372-g43825cb665-fm-20230411.003-g43825cb6
Mime-Version: 1.0
Message-Id: <996b59f0-ea87-4008-a908-35b29b550b1b@app.fastmail.com>
In-Reply-To: <ZEEr0r/6/lLiwlsy@minyard.net>
References: <20230419150032.3483229-1-govert.overgaauw@prodrive-technologies.com>
 <ZEEr0r/6/lLiwlsy@minyard.net>
Date:   Fri, 21 Apr 2023 11:28:05 +0930
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Corey Minyard" <minyard@acm.org>,
        "Govert Overgaauw" <govert.overgaauw@prodrive-technologies.com>,
        vernon.mauery@linux.intel.com
Cc:     openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, "Zev Weiss" <zev@bewilderbeest.net>
Subject: Re: [Openipmi-developer] [PATCH] ipmi: ipmi-bmc: Improve errno returned to
 userspace
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Corey,

On Thu, 20 Apr 2023, at 21:40, Corey Minyard wrote:
> Andrew, what do you think?

I'm a bit short on details of the IPMI KCS state machine and expectations of userspace in this exact case.

I've added Vernon who is one of the IPMI maintainers for OpenBMC.

I've also added Zev who's an interested party, and openbmc@ for good measure.

Andrew

>
> -corey
>
> On Wed, Apr 19, 2023 at 05:00:32PM +0200, Govert Overgaauw via 
> Openipmi-developer wrote:
>> While the KCS driver is not in KCS_PHASE_WAIT_READ state it returns
>> -EINVAL to userspace on a write call. change this to -EAGAIN to indicate
>> that the error is related to the state and not the argument.
>> 
>> Signed-off-by: Govert Overgaauw <govert.overgaauw@prodrive-technologies.com>
>> ---
>>  drivers/char/ipmi/kcs_bmc_cdev_ipmi.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/drivers/char/ipmi/kcs_bmc_cdev_ipmi.c b/drivers/char/ipmi/kcs_bmc_cdev_ipmi.c
>> index cf670e891966..4c7400faf333 100644
>> --- a/drivers/char/ipmi/kcs_bmc_cdev_ipmi.c
>> +++ b/drivers/char/ipmi/kcs_bmc_cdev_ipmi.c
>> @@ -405,7 +405,7 @@ static ssize_t kcs_bmc_ipmi_write(struct file *filp, const char __user *buf,
>>  		kcs_bmc_write_data(priv->client.dev, priv->data_out[0]);
>>  		ret = count;
>>  	} else {
>> -		ret = -EINVAL;
>> +		ret = -EAGAIN;
>>  	}
>>  	spin_unlock_irq(&priv->lock);
>>  
>> -- 
>> 2.30.2
>> 
>> 
>> 
>> _______________________________________________
>> Openipmi-developer mailing list
>> Openipmi-developer@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/openipmi-developer

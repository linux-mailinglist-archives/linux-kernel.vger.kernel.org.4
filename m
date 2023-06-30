Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF2F774320E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 03:01:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231953AbjF3BBd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 21:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231282AbjF3BBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 21:01:30 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A1C2EC
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 18:01:27 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 7C8803200564;
        Thu, 29 Jun 2023 21:01:24 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute6.internal (MEProxy); Thu, 29 Jun 2023 21:01:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1688086884; x=1688173284; bh=wA
        bEe/5fxRFHIGtjp6fsuq4DKoHUotvs5QCm3RZOtq0=; b=RhoCDTMf298Ij8oP7n
        Jr8ethIj9rc62aZpBYuvtvDrUyEsB61vUHrapqZVjZwXklsqcV4tOBaDlMizQ5Cc
        zW4HbJPlyvmo+5NInQZ6eIymqmSwyRwEEGOieqeV/G6Kgo0FuFdFa+Qwt6ne3Qsx
        vOucxgvOxzhSLU0I4b/1l7g7G2fZ4D8/yDEFRHLwFFvhBs9iMW6xCjstO+vjPwSP
        +j51RI1bO2svpyj7m0rKOSs8f5XDmCCfsR7cR56eavwOVq8y9EPs322H7X+SUJQ3
        L0xS1SGBfyB7dO3da3YbP+RXhfWt2ayuUp06H9mB531O+OTLBOiAXpPH1YuvUfyF
        Irlg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1688086884; x=1688173284; bh=wAbEe/5fxRFHI
        Gtjp6fsuq4DKoHUotvs5QCm3RZOtq0=; b=kVDSEgHC1ht0TZmKGAo1buKWubCxe
        ZrP4cam1PcEo4gYzKRMgeChr3CPa3LAdPCoSeSlQ5mHw3hmjGYOqVPzLZL4zs5Ut
        xCZZ/CewPh3EcQ5YQk7+Oukm5iuk9LBFdXZBKvMur/W9hbTQ4/lphsVj++NLMNfm
        i15qTLhr8PN+Q859AeH3Y4Dy9nIYNm9gjqDA7S1ws4Axki3/GimPcfodk4iVgq+8
        aJFN0nCtgpB7XSfFdebWbc/SYHUote1rx/4x97A97wPD8hLPv+5sv/rq3fubKutJ
        B2y1G4H/IIYxsfsUPgQA/wSqaW3FToOH8bMB4Mdn9XN55vsSSDj+qXgEA==
X-ME-Sender: <xms:YymeZGuVLipz3sNK0XNc6KCa4LO8OEpze4T9YcoexODzFv2QaBJSpA>
    <xme:YymeZLfcraAE1NcKIHrjqZ2FvMh2H403ut9EmKDuW3zIzd8T6sE53tpWnAFpNqWiw
    gFlAGEKPyZzYOlJFQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrtdehgdegfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetnhgu
    rhgvficulfgvfhhfvghrhidfuceorghnughrvgifsegrjhdrihgurdgruheqnecuggftrf
    grthhtvghrnhepkedvkeejkefgjeduffetteegjeekteetudevtdfftdeluddthfehveef
    teekieetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eprghnughrvgifsegrjhdrihgurdgruh
X-ME-Proxy: <xmx:YymeZBy8Z8DRxTWNk-oyuQqXNxFz-Hl8EcqqL82lUUFSDxlnfKbg8Q>
    <xmx:YymeZBOs3xUk890_IiEZfhPqXxEtLNVsgwru8MOnNhMwv96bMJG62A>
    <xmx:YymeZG8anZyjHVY6GYYv-ZbJ7g9Ls17DxuxJy1cJapNdXxlPRoO71w>
    <xmx:ZCmeZMkGy4Qy5FOXysqcCONQHoYFvsUi1ENgOBvIHLEW0nrOWX2_Jg>
Feedback-ID: idfb84289:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id B19CE1700089; Thu, 29 Jun 2023 21:01:23 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-499-gf27bbf33e2-fm-20230619.001-gf27bbf33
Mime-Version: 1.0
Message-Id: <9691d898-22a9-4902-871d-73f5dafabf86@app.fastmail.com>
In-Reply-To: <ZJwd0UDKYcK9AvSf@mail.minyard.net>
References: <20230627152449.36093-1-dg573847474@gmail.com>
 <ZJwd0UDKYcK9AvSf@mail.minyard.net>
Date:   Fri, 30 Jun 2023 10:31:02 +0930
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Corey Minyard" <minyard@acm.org>
Cc:     openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org,
        "Chengfeng Ye" <dg573847474@gmail.com>
Subject: Re: [PATCH] ipmi: fix potential deadlock on &kcs_bmc->lock
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Corey, Chengfeng,

On Wed, 28 Jun 2023, at 21:17, Corey Minyard wrote:
> Indeed, this looks like an issue.
>
> Andrew, any opinions on this?  The attached patch will work, the other
> option would be to disable interrupts when calling
> kcs_bmc_handle_event() in the timer handler.  But then you have to worry
> about RT.

Right, I think we'd do best to not over-complicate things.
spin_lock_irq{save,restore}() are the intuitive choice to me.

I'll follow up with R-b/T-b tags once I've booted the patch
and done some testing.

Andrew

>
> -corey
>
> On Tue, Jun 27, 2023 at 03:24:49PM +0000, Chengfeng Ye wrote:
>> As kcs_bmc_handle_event() is executed inside both a timer and a hardirq,
>> it should disable irq before lock acquisition otherwise deadlock could
>> happen if the timmer is preemtped by the irq.
>> 
>> Possible deadlock scenario:
>> aspeed_kcs_check_obe() (timer)
>>     -> kcs_bmc_handle_event()
>>     -> spin_lock(&kcs_bmc->lock)
>>         <irq interruption>
>>         -> aspeed_kcs_irq()
>>         -> kcs_bmc_handle_event()
>>         -> spin_lock(&kcs_bmc->lock) (deadlock here)
>> 
>> This flaw was found using an experimental static analysis tool we are
>> developing for irq-related deadlock.
>> 
>> The tentative patch fix the potential deadlock by spin_lock_irqsave()
>> 
>> Signed-off-by: Chengfeng Ye <dg573847474@gmail.com>
>> ---
>>  drivers/char/ipmi/kcs_bmc.c | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>> 
>> diff --git a/drivers/char/ipmi/kcs_bmc.c b/drivers/char/ipmi/kcs_bmc.c
>> index 03d02a848f3a..8b1161d5194a 100644
>> --- a/drivers/char/ipmi/kcs_bmc.c
>> +++ b/drivers/char/ipmi/kcs_bmc.c
>> @@ -56,12 +56,13 @@ irqreturn_t kcs_bmc_handle_event(struct kcs_bmc_device *kcs_bmc)
>>  {
>>  	struct kcs_bmc_client *client;
>>  	irqreturn_t rc = IRQ_NONE;
>> +	unsigned long flags;
>>  
>> -	spin_lock(&kcs_bmc->lock);
>> +	spin_lock_irqsave(&kcs_bmc->lock, flags);
>>  	client = kcs_bmc->client;
>>  	if (client)
>>  		rc = client->ops->event(client);
>> -	spin_unlock(&kcs_bmc->lock);
>> +	spin_unlock_irqrestore(&kcs_bmc->lock, flags);
>>  
>>  	return rc;
>>  }
>> -- 
>> 2.17.1
>>

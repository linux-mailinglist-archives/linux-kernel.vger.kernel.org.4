Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 173EB7483AD
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 14:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231917AbjGEMBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 08:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231535AbjGEMBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 08:01:12 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA3F0173E
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 05:01:08 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 619303200998;
        Wed,  5 Jul 2023 08:01:05 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute6.internal (MEProxy); Wed, 05 Jul 2023 08:01:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1688558464; x=1688644864; bh=gs
        8pUAUyk3tjY2m3dpAZbW9EqQL6qlhOTo+TnwZTPQ4=; b=VSL62ROuvrT+2oOifs
        L+p5t/MsHe1Rw6ptTINyhHIhEZoNuAsablhuuh12RBJKKWhTAl7OfjX2UWG4NdgW
        qXMrl2LatmGcpy4ZpMi8uQOD8X9ycnWmwqSq+6VyNRz1nrvR4E/Ob5ytZ2orkep+
        OryZZMztMkO2AZtX/UVvp7LzSNJQZMRy+0kE4IgRNApUONAi22lacQKrA7ro8Y/2
        7o+sVX9J4498S/h97Qb6/BJsDWoyeXrsXn1q4B+SfYlRbUbAP9SRHFbUn2qXabOw
        IimLetmnVzGaj6aA5ig3+qEo4lvzt/0jgQx1Utl5Z6h4aI/JNteh5Q7Bz/voiGI3
        CT1g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1688558464; x=1688644864; bh=gs8pUAUyk3tjY
        2m3dpAZbW9EqQL6qlhOTo+TnwZTPQ4=; b=H3ZVOjqrRcnI1izVZJr9eW1ONxcoM
        q4zIqk4ORW6zVNQwsmceONZeTTUiMt8cMH44dtRF6niV9KTrbdDc+h2y32UH+5iH
        aUjAx/Mik4FAjJLo3o8npxnvn9uKgv+/KAjpS6Gf5B4PIe0pIiPmVHmiKKeLbLvz
        lZ/TX06bZ9D+wmBeN88/MY91De/e3WDLw8sYm2c2b6YuJhOBfYxBQwf9jDLI2dLA
        gePfjsI3C4++HSWrYCJJiNfbwQUiASMEZ4dKM41nqP1lH0/he05dLJHgynXH8EBM
        ef/eWun+87E00UhO5d6j/fbQdc0nuSqB/HffYwlQvudTAQbztK7xHpnsQ==
X-ME-Sender: <xms:gFulZI7V78e3JClewMRQMBQYWTQNiPADvmf4DFc6XKqJGhUdfjhZ2Q>
    <xme:gFulZJ6d2eUa-oFmNFH9XqutwTwK9HX5zSIyrRoL0rWMBdPZbe_GWkxExkT2MGP9v
    LGqMdbNYIG8VQKljg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudejgddtvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetnhgu
    rhgvficulfgvfhhfvghrhidfuceorghnughrvgifsegrjhdrihgurdgruheqnecuggftrf
    grthhtvghrnhepkedvkeejkefgjeduffetteegjeekteetudevtdfftdeluddthfehveef
    teekieetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eprghnughrvgifsegrjhdrihgurdgruh
X-ME-Proxy: <xmx:gFulZHdoTKpnsklmTAJPbJwrl9ePIS1i8BNTDNBi49sTwvwc28HrKA>
    <xmx:gFulZNLQ-uwkNnVZo7QBKPTkhV9Hi5RRDLI_VBKm3uExqmXYXgY7sA>
    <xmx:gFulZMJZQxjJjE1Nib3EMkG9LHOI1SI5EWrOBcCVl2GVKsEgeQYmpg>
    <xmx:gFulZGhkuAurMhawnITDdgsT0SRFWz7HtVMDIlxVMPskwm056IukXA>
Feedback-ID: idfb84289:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 4788817000A4; Wed,  5 Jul 2023 08:01:04 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-527-gee7b8d90aa-fm-20230629.001-gee7b8d90
Mime-Version: 1.0
Message-Id: <34c75a2f-2daa-49be-bdca-a3fff5ed5a4a@app.fastmail.com>
In-Reply-To: <ZKQsY3DXXDbxy0om@mail.minyard.net>
References: <20230627152449.36093-1-dg573847474@gmail.com>
 <ZJwd0UDKYcK9AvSf@mail.minyard.net>
 <9691d898-22a9-4902-871d-73f5dafabf86@app.fastmail.com>
 <ZKQsY3DXXDbxy0om@mail.minyard.net>
Date:   Wed, 05 Jul 2023 21:30:38 +0930
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



On Tue, 4 Jul 2023, at 23:57, Corey Minyard wrote:
> On Fri, Jun 30, 2023 at 10:31:02AM +0930, Andrew Jeffery wrote:
>> Hi Corey, Chengfeng,
>> 
>> On Wed, 28 Jun 2023, at 21:17, Corey Minyard wrote:
>> > Indeed, this looks like an issue.
>> >
>> > Andrew, any opinions on this?  The attached patch will work, the other
>> > option would be to disable interrupts when calling
>> > kcs_bmc_handle_event() in the timer handler.  But then you have to worry
>> > about RT.
>> 
>> Right, I think we'd do best to not over-complicate things.
>> spin_lock_irq{save,restore}() are the intuitive choice to me.
>> 
>> I'll follow up with R-b/T-b tags once I've booted the patch
>> and done some testing.
>
> Thanks.  This is in my for-next tree, I'd like to get this in the merge
> window, which I believe ends this Sunday.
>

I've successfully booted an IBM Rainier machine with this patch 
applied. Rainier is a Power10-based platform managed by an AST2600 BMC. 
The boot process makes heavy use of one of the KCS devices as part of 
an MCTP transport binding implementation between the BMC and host 
firmware.

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
Tested-by: Andrew Jeffery <andrew@aj.id.au>

Thanks,

Andrew

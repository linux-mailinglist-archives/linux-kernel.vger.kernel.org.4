Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D27E96C7E4A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 13:50:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231765AbjCXMuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 08:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbjCXMul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 08:50:41 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6337C3;
        Fri, 24 Mar 2023 05:50:40 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 3BB943200A08;
        Fri, 24 Mar 2023 08:50:40 -0400 (EDT)
Received: from imap52 ([10.202.2.102])
  by compute5.internal (MEProxy); Fri, 24 Mar 2023 08:50:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1679662239; x=1679748639; bh=0i
        PYyvYnm1AEnXuoGimRYpODjqiX75LCp0xlyX7nFAE=; b=WWNYrMotO9neL7JvKt
        pqkQSLtU2bDgE0Pqw+/uoCIWZqH40RjwlU36+KbNs9EUarOTd+etVk3xlPVtMIJa
        dy53rRiPrDrI90GAjCG6O0jc8xeyl1EBx/nkHEL13Zl43eVUdFsrOoQMEQKaamro
        zyYcnb/PPmC2XqmD08PU1Rpx2eYO79o1hVuz02H2O0TIJ9gZMyVKO7vViBA9kht9
        awhtyIoAY3vnim01+9Eq/dpoZ59DIDfGwRTJa/6ELZi+DgzP0XcCezj4E3pC1RJY
        TRXq2mx3+oTcxw/k2gP9EwNTyaXFtYP3dKpRZl8cER6neTAhy8DgAisXn8V0Lyic
        XvCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1679662239; x=1679748639; bh=0iPYyvYnm1AEn
        XuoGimRYpODjqiX75LCp0xlyX7nFAE=; b=Rxo0Q/2dEJs4isNP1RMPXnWioHheE
        SSWR/wdHyh1MvnKUuVFaPZ9uwmdch3ezrgTytitS63V6ddLIirDeaYWAd+RL+siy
        4zaYwOe4VN4YwXTRoSuNibhf+xb21Hg86rbnN0G3Nkjbmyaiau6aWgnnyR4V7qR+
        Fn7IML/hYZazcTtvCWDHFAhzddaQza90QfP9/xucE74O4gjIk5XJKOvZpIJ92zVT
        qeF3baI7uWE4xcna4IgNFmk+sBHbuMf5k6zXHtCNqIoSUPlSGzB6NJWOiSfsmO44
        8ZGOEu3JiePhwTbZ0129mTMjowrYTY22Hgym6q2EsnAfXi5tubPr1Vlsw==
X-ME-Sender: <xms:n5wdZJx7hANKXck7D2UkvyV5UsGeyAZy9EdB7Dn79vUVQJQeR3jN2w>
    <xme:n5wdZJTlPAodL8CTPuQ8hyAEDhmBca--r1ZdGsS7Iipz9lWDEYWQ6HKMXLNiywx-d
    oTIfkEuILZ3q_WXLYc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdegiedggeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfofgr
    rhhkucfrvggrrhhsohhnfdcuoehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssg
    drtggrqeenucggtffrrghtthgvrhhnpeeiueefjeeiveetuddvkeetfeeltdevffevudeh
    ffefjedufedvieejgedugeekhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggr
X-ME-Proxy: <xmx:n5wdZDUQAQb7-vKidLHSbaOlx1WzDxRfX6kXmDZ20AaEZ6dGzjcrbw>
    <xmx:n5wdZLjwwq4_m_50IMRHoqROaHru0Nym6RpzH7sc-_o5lQq9bxYjYQ>
    <xmx:n5wdZLCSKUNfNO-sgpT6SfUpGuC4YA8jzqX-JxwnlQw1V6xUy6htoA>
    <xmx:n5wdZA5bksg3ktQ7J035GemBpUHNQoEFQEGyGkEzwjAY2IMc8gkhUw>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 6568BC60091; Fri, 24 Mar 2023 08:50:39 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-236-g06c0f70e43-fm-20230313.001-g06c0f70e
Mime-Version: 1.0
Message-Id: <16c47819-dbcc-4a9d-9124-7d440cfbf1d6@app.fastmail.com>
In-Reply-To: <ZBwikZ0wyQ1LGYBc@kuha.fi.intel.com>
References: <mpearson-lenovo@squebb.ca>
 <20230321190136.449485-1-mpearson-lenovo@squebb.ca>
 <ZBwikZ0wyQ1LGYBc@kuha.fi.intel.com>
Date:   Fri, 24 Mar 2023 08:50:19 -0400
From:   "Mark Pearson" <mpearson-lenovo@squebb.ca>
To:     "Heikki Krogerus" <heikki.krogerus@linux.intel.com>
Cc:     "Greg KH" <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: ucsi: acpi: Remove notifier before destroying handler
Content-Type: text/plain
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heikki,

On Thu, Mar 23, 2023, at 5:57 AM, Heikki Krogerus wrote:
> On Tue, Mar 21, 2023 at 03:01:36PM -0400, Mark Pearson wrote:
>> Was debugging another issue (since fixed) and noticed that the acpi
>> notify_handler should be removed before the ucsi object is destroyed.
>> 
>> This isn't fixing any issues that I'm aware of - but I assume could
>> potentially lead to a race condition if you were really unlucky?
>> 
>> Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
>> ---
>>  drivers/usb/typec/ucsi/ucsi_acpi.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>> 
>> diff --git a/drivers/usb/typec/ucsi/ucsi_acpi.c b/drivers/usb/typec/ucsi/ucsi_acpi.c
>> index ce0c8ef80c04..be3bf4f996d3 100644
>> --- a/drivers/usb/typec/ucsi/ucsi_acpi.c
>> +++ b/drivers/usb/typec/ucsi/ucsi_acpi.c
>> @@ -176,12 +176,12 @@ static int ucsi_acpi_remove(struct platform_device *pdev)
>>  {
>>  	struct ucsi_acpi *ua = platform_get_drvdata(pdev);
>>  
>> -	ucsi_unregister(ua->ucsi);
>> -	ucsi_destroy(ua->ucsi);
>> -
>>  	acpi_remove_notify_handler(ACPI_HANDLE(&pdev->dev), ACPI_DEVICE_NOTIFY,
>>  				   ucsi_acpi_notify);
>>  
>> +	ucsi_unregister(ua->ucsi);
>> +	ucsi_destroy(ua->ucsi);
>> +
>>  	return 0;
>>  }
>
> Calling ucsi_desctroy() after removing the notifier makes sense to me,
> but do you also need to unregister the instance after that?
>
> You may still be in the middle of init or resume, so I think we need
> to accept notifications until we are sure those have finished, i.e.
> ucsi_unregister() has finished.
>

That makes sense - I hadn't considered that.
I'll post an updated patch with the acpi_remove_notify_handler between the two calls.

Thanks for the review
Mark

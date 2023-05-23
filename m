Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18E0370DCCE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 14:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236850AbjEWMnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 08:43:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbjEWMni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 08:43:38 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55104126;
        Tue, 23 May 2023 05:43:25 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id C1D475C0109;
        Tue, 23 May 2023 08:43:24 -0400 (EDT)
Received: from imap52 ([10.202.2.102])
  by compute5.internal (MEProxy); Tue, 23 May 2023 08:43:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1684845804; x=1684932204; bh=T1
        MWb/FQuEkKGbUcSLnZFlOChdRoeh1rPiZ8D1iDg7s=; b=jDGTn9ARhWjlTiqwqF
        PTw6p9SbuJMAlGh+F95TTFpdM3jWlJbbTQ3xfg/phQ9ZbmRmOw3UwPc9csHGRLQX
        gQ5YAn4600Hb6ZMnoAMA0zQ7ALvkvwVqCp9gUIhBhV8yKDk7s3m9Fc9H/U5A3RtX
        41cbIw4i0pTVUyW4W7UZ96+/qGFCg9P9BK/Kc6oXKK4hbDD87KMkgricEzovBP9R
        LEUSajXglTFLnB8QYLZgcYIZ/OgWkR0EMzywrMO0CT8MrecxDXj13cBNMdaLX6q9
        aaDGQCvPRmRCHv8OkZ/hT6ywGAA2HUS/BdFiZkfNC6zAWIAvX+H46f7D2iNO2aoJ
        Smqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1684845804; x=1684932204; bh=T1MWb/FQuEkKG
        bUcSLnZFlOChdRoeh1rPiZ8D1iDg7s=; b=Xzx+mYWyoBbmrrsGLda0z4u3qTvW8
        TVBT+tGavyFkrt4Z6YJmYgf5oq7qplxKC5zgsvJ9gED0PvAFXzY0zYpY3fIzvvPb
        YxTevVuoCVkTtoVMfI50yI9uWHCaPsLA7Z26dRE8i+SgOEhnJrn3zPWT+len9WkU
        AvtPQ3FeW7E6vAVRDyvBddEWxl/uXts4Lb90+eExhnVazNK/jVs02++kBPucX6ls
        g6oNoUFkPwdU0BsTSoNCJ1gWVFM5VJZOCG9uqw2y1ZhoP3u0egDSesw0dXq/Fh4B
        7M5Bd7JMsENq6UVglQV8wYfANYpOXRmxzc16M+2UBjfFNkiud9T8HD6KA==
X-ME-Sender: <xms:7LRsZASdTNA_EZvDj692rOlgMU_vpuHV8EGXNkf1I0wH_gAn8_carA>
    <xme:7LRsZNyOVgWEqeipAzIhQy-zojOQMG1Z5ZSzmPhI10-bQ3HpqWjRFLTH4wkSZwXS9
    X1ffk8jDZ-of8NkIps>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeejfedghedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfofgr
    rhhkucfrvggrrhhsohhnfdcuoehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssg
    drtggrqeenucggtffrrghtthgvrhhnpeethefgfedtvefgheeljeegudejteekveeuhffh
    jeetueeuueeivdfgieehgffhheenucffohhmrghinheplhgvnhhovhhotggurhhtrdgtoh
    hmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhhp
    vggrrhhsohhnqdhlvghnohhvohesshhquhgvsggsrdgtrg
X-ME-Proxy: <xmx:7LRsZN3TZHxRsqxVrapkMIyASqI14WGaHLu0mPzc7z6jlvFvbhueIQ>
    <xmx:7LRsZEAv5se3inqINeQu1lvCvtYqkAPpGAN86C_qdWvZvJ6ar40PAg>
    <xmx:7LRsZJhiuTYobllz_cOfOp7Jyg_y_i99tCWUWZTRowMHxnL5DwQgHA>
    <xmx:7LRsZJbim2ttm1iLWLuLuA7IgE6kIlFPF_j9EvTJnMvnjqchhqoIWw>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 9BBB6C60091; Tue, 23 May 2023 08:43:24 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-441-ga3ab13cd6d-fm-20230517.001-ga3ab13cd
Mime-Version: 1.0
Message-Id: <9e748368-1af6-45a4-8e33-34f056e3b473@app.fastmail.com>
In-Reply-To: <ce7d7bef-c342-fb1a-8a7a-463ffcfd2896@redhat.com>
References: <mpearson-lenovo@squebb.ca>
 <20230517181945.3725-1-mpearson-lenovo@squebb.ca>
 <20230517181945.3725-2-mpearson-lenovo@squebb.ca>
 <ce7d7bef-c342-fb1a-8a7a-463ffcfd2896@redhat.com>
Date:   Tue, 23 May 2023 08:43:04 -0400
From:   "Mark Pearson" <mpearson-lenovo@squebb.ca>
To:     "Hans de Goede" <hdegoede@redhat.com>
Cc:     "markgross@kernel.org" <markgross@kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] platform/x86: think-lmi: Correct System password interface
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

Thanks Hans

On Tue, May 23, 2023, at 6:46 AM, Hans de Goede wrote:
> Hi Mark,
>
> On 5/17/23 20:19, Mark Pearson wrote:
>> The system password identification was incorrect. This means that if
>> the password was enabled it wouldn't be detected correctly; and setting
>> it would not work.
>> 
>> Correct these mistakes.
>> 
>> Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
>> ---
>>  drivers/platform/x86/think-lmi.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>> 
>> diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/think-lmi.c
>> index d9341305eba9..b8431d3b137f 100644
>> --- a/drivers/platform/x86/think-lmi.c
>> +++ b/drivers/platform/x86/think-lmi.c
>> @@ -171,7 +171,7 @@ MODULE_PARM_DESC(debug_support, "Enable debug command support");
>>  #define TLMI_POP_PWD (1 << 0)
>>  #define TLMI_PAP_PWD (1 << 1)
>>  #define TLMI_HDD_PWD (1 << 2)
>> -#define TLMI_SYS_PWD (1 << 3)
>> +#define TLMI_SYS_PWD (1 << 6)
>>  #define TLMI_CERT    (1 << 7)
>>  
>>  #define to_tlmi_pwd_setting(kobj)  container_of(kobj, struct tlmi_pwd_setting, kobj)
>> @@ -1504,7 +1504,7 @@ static int tlmi_analyze(void)
>>  		tlmi_priv.pwd_power->valid = true;
>>  
>>  	if (tlmi_priv.opcode_support) {
>> -		tlmi_priv.pwd_system = tlmi_create_auth("sys", "system");
>> +		tlmi_priv.pwd_system = tlmi_create_auth("smp", "system");
>
> "smp" ?

Yes - that is what is common across all the platforms.
https://docs.lenovocdrt.com/#/bios/wmi/wmi_guide?id=change-a-bios-password

I never quite got a straight answer on the origins of the 'sys' account - I think it may have been originally intended but never used? Or maybe it's always been wrong.

I should change the define to be TLMI_SMP_PWD instead actually for clarity. I'll fix that.

>
> Also this is not explained in the commit message.
>

Ack - will update the commit message to include this.

Thanks
Mark

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C41EC70E198
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 18:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237406AbjEWQUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 12:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237033AbjEWQUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 12:20:15 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0653E6;
        Tue, 23 May 2023 09:20:07 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 38EA75C0152;
        Tue, 23 May 2023 12:20:07 -0400 (EDT)
Received: from imap52 ([10.202.2.102])
  by compute5.internal (MEProxy); Tue, 23 May 2023 12:20:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1684858807; x=1684945207; bh=Gu
        IADg7oNM6Ae1CJV+KgYpaHGE8faxHX3ThGhn38yhc=; b=V2NnyTXc2I08aHpbn8
        UW69wnsKiKPxRmnehYwAle8uMnJOI60AyMaWfbIumwd96QAE8ta77uqsXuhTqrN6
        3jbI5gSuJFMHqaDzWNVKDYUIHLYRfBdhDwlC1mB/rD0uS+uQ8wVAl8SbCHRjnrtt
        8l6PTwAlVsg8emBgb9lzYniDfCISLhm8nz+3bvlOsUK4LhpKyW9boFtHfteS/JVc
        esakQLlkhrl9PMeZhjc0wuqwQyiCRk3+LkWOnB/V0sHrYKNFKJhGOHEaEqFLv2LM
        zMh8/maGHoVu8pHAwiv1yaGZlwFAdYmd3E5LKX6BXofH7dSs5/B3bLauom9sSHt9
        Q7SA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1684858807; x=1684945207; bh=GuIADg7oNM6Ae
        1CJV+KgYpaHGE8faxHX3ThGhn38yhc=; b=Q24IwPV8NlV6nfzFRM8/JsoHsHyMz
        ZoJszdNkMNG4h9cxnz9MjGzz/2eoRbyLa+YUHNblROW5KUvjYDl+t5fpmm6kGTJ3
        MTLOhp3ZCmUQeNPMXlzcSfoiuyysrOYacG4Ipn7RUyF4DL2jBBvhaki1CfT2ZrvT
        b+rC/pSHeuDcyvMy5Gp2bFrZuwGofzxBa3YX7ylh4o0e8GE0A+NU9XekWIAJhDU3
        ltYYpKhR0FWU1bitCJuY4x9JngVrEvaIthiMwC0zirptmfhAVMxTnPJwh1iqdi1Z
        9zHC/ybxlETNVAICDbAxKqohMRJrxoSap1LzJ6Rh5BaIxMEOevD+qk/xQ==
X-ME-Sender: <xms:t-dsZF8V9BWGlLzWVaRiAOpcdBswCMGU4i1QPCjqHRTiB-XlJkXgBQ>
    <xme:t-dsZJuPqgFyo7i_SDK_OG_ef1rgSMlGODPl1YSx8lrXbI9qj2PzftxslyJ_l6Ozk
    BgDPT5RfDf3cnbg2FA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeejfedgleejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfofgr
    rhhkucfrvggrrhhsohhnfdcuoehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssg
    drtggrqeenucggtffrrghtthgvrhhnpeethefgfedtvefgheeljeegudejteekveeuhffh
    jeetueeuueeivdfgieehgffhheenucffohhmrghinheplhgvnhhovhhotggurhhtrdgtoh
    hmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhhp
    vggrrhhsohhnqdhlvghnohhvohesshhquhgvsggsrdgtrg
X-ME-Proxy: <xmx:t-dsZDC_6LZJAdc4QYvosQBSkn0WHr_CX-ia0ZXD_HNGGIT13qrriQ>
    <xmx:t-dsZJfzASLPYGFjHWir2--h1uM8i0mMpMRuH90YmfJoa_qkW7sXAw>
    <xmx:t-dsZKMlJvme632irJDmQEBQ7Kl2QZXQXfOX-yJPsYiG2OHFAc1_gw>
    <xmx:t-dsZM06tbH-Jre4DWsM-fetB5-S1GBrkYO9eU50yuXnp3eaxrYj3Q>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id F11A3C60093; Tue, 23 May 2023 12:20:06 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-441-ga3ab13cd6d-fm-20230517.001-ga3ab13cd
Mime-Version: 1.0
Message-Id: <5e3f821d-1de2-4c48-be65-a3f89be00f33@app.fastmail.com>
In-Reply-To: <1cf8ac78-e036-69ef-3d1d-74b0a0825bb2@redhat.com>
References: <mpearson-lenovo@squebb.ca>
 <20230517181945.3725-1-mpearson-lenovo@squebb.ca>
 <20230517181945.3725-2-mpearson-lenovo@squebb.ca>
 <ce7d7bef-c342-fb1a-8a7a-463ffcfd2896@redhat.com>
 <9e748368-1af6-45a4-8e33-34f056e3b473@app.fastmail.com>
 <1cf8ac78-e036-69ef-3d1d-74b0a0825bb2@redhat.com>
Date:   Tue, 23 May 2023 12:19:46 -0400
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



On Tue, May 23, 2023, at 9:27 AM, Hans de Goede wrote:
> Hi,
>
> On 5/23/23 14:43, Mark Pearson wrote:
>> Thanks Hans
>> 
>> On Tue, May 23, 2023, at 6:46 AM, Hans de Goede wrote:
>>> Hi Mark,
>>>
>>> On 5/17/23 20:19, Mark Pearson wrote:
>>>> The system password identification was incorrect. This means that if
>>>> the password was enabled it wouldn't be detected correctly; and setting
>>>> it would not work.
>>>>
>>>> Correct these mistakes.
>>>>
>>>> Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
>>>> ---
>>>>  drivers/platform/x86/think-lmi.c | 4 ++--
>>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/think-lmi.c
>>>> index d9341305eba9..b8431d3b137f 100644
>>>> --- a/drivers/platform/x86/think-lmi.c
>>>> +++ b/drivers/platform/x86/think-lmi.c
>>>> @@ -171,7 +171,7 @@ MODULE_PARM_DESC(debug_support, "Enable debug command support");
>>>>  #define TLMI_POP_PWD (1 << 0)
>>>>  #define TLMI_PAP_PWD (1 << 1)
>>>>  #define TLMI_HDD_PWD (1 << 2)
>>>> -#define TLMI_SYS_PWD (1 << 3)
>>>> +#define TLMI_SYS_PWD (1 << 6)
>>>>  #define TLMI_CERT    (1 << 7)
>>>>  
>>>>  #define to_tlmi_pwd_setting(kobj)  container_of(kobj, struct tlmi_pwd_setting, kobj)
>>>> @@ -1504,7 +1504,7 @@ static int tlmi_analyze(void)
>>>>  		tlmi_priv.pwd_power->valid = true;
>>>>  
>>>>  	if (tlmi_priv.opcode_support) {
>>>> -		tlmi_priv.pwd_system = tlmi_create_auth("sys", "system");
>>>> +		tlmi_priv.pwd_system = tlmi_create_auth("smp", "system");
>>>
>>> "smp" ?
>> 
>> Yes - that is what is common across all the platforms.
>> https://docs.lenovocdrt.com/#/bios/wmi/wmi_guide?id=change-a-bios-password
>
> Ok, so smp stands for System Management Password I guess ? Might be 
> good to spell
> that out somehwere, e.g. in a comment.
>

Yes - and will do.

Mark

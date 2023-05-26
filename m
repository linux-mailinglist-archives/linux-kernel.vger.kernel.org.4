Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D9EE7127EA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 16:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243729AbjEZOAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 10:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbjEZOAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 10:00:44 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF97DF;
        Fri, 26 May 2023 07:00:42 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 467CB5C0247;
        Fri, 26 May 2023 10:00:40 -0400 (EDT)
Received: from imap52 ([10.202.2.102])
  by compute5.internal (MEProxy); Fri, 26 May 2023 10:00:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1685109640; x=1685196040; bh=X7
        oR6fDag5Xrq2T43+f0dNcMZz0J3Tq+Q2Y71CiFeKI=; b=487qGy8RLRQLCz4qyG
        bQBfrXdi5LdqwMp+3LsNW6oLiYWnlpCvUdk4xc2FYC4fvoJymPO3J7nbrjlTGKt1
        HOmhwqlZ3tgks9Vcn1Vd/JSWKLVrwYNdyFe/Wap9tVaeQcGFXrhoUaS8eatkGQ69
        VpNhFqkODHTpbRUbeQU/qUiR/+YJyxXNItb5EkQlz4yNZwDErXBv7A6svben1Pez
        2WblubT8gVTy4ss6Kbnv9gyUzIVE+ebiZGGDea720be4/riom3aEAB/8pjhr7d0R
        MGJqweXH1yrB3B+OH66/C95AtCVUYZUUb72PdECAxyrlPa6TWibhNF6gQyyfADBQ
        1UqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1685109640; x=1685196040; bh=X7oR6fDag5Xrq
        2T43+f0dNcMZz0J3Tq+Q2Y71CiFeKI=; b=Ao72C2i+VTw+Ksf1R+jTiHA7spFzd
        uN5bVWaObW8wr00bCGtiUIW5SJCOcam10ZuaPOdBiuebdVMeEybYOInufhIQo/0n
        /135GowXRfjUhHxypdzqDz4h6U52WGpold8N6K/TlczU9WePSKosm0ouRgR65CkK
        ltHRF2kn71Z4sgZ8O6Yb8GJWccnr+UiWA10IlF48hcq+j3tg2kd46kynxkqIqUPb
        1wvn0hgS3tNx0RGu3QNU49g63mft7QpLfrii3EYARU1wZMIGl7GiGwTsqyJqlp4Z
        sZhT2OqSzOlhOVjZumFz6yVFQ/2T5i5vNFreZWHANIAAlZOEilKCnAYAg==
X-ME-Sender: <xms:h7twZN3ZHeGMpQ7kNNEz-peOgZACytVbL0veUjYGGswZQQURgTM-yA>
    <xme:h7twZEFtJHGJ_kwlpZeRY4jkhaMhz5PKAnoDKa77qYjlYXL3sNQ2FHRfkhvYFG12v
    NSiW2bbEeM_JH8CYM8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeejledgjedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfofgr
    rhhkucfrvggrrhhsohhnfdcuoehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssg
    drtggrqeenucggtffrrghtthgvrhhnpeeiueefjeeiveetuddvkeetfeeltdevffevudeh
    ffefjedufedvieejgedugeekhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggr
X-ME-Proxy: <xmx:h7twZN5C9_OADoBP7KPzciuzbWXx5lW8BbU8cN7iVGabdti6M2E9jQ>
    <xmx:h7twZK1Y5nP1x3QzA0TpAMrZ0p6i9dgaJ460aVs4hrbo5Ut34axfVQ>
    <xmx:h7twZAH0fk5OoN-mmyVPRa495hkn4X8JfEghD0vxgLiJCmpfqyxVdg>
    <xmx:iLtwZKPsHGEMFPp-jnUem5F18A1nivzPSF-5H9zYg0uoS1iIV478iw>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 0E7B6C60091; Fri, 26 May 2023 10:00:38 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-441-ga3ab13cd6d-fm-20230517.001-ga3ab13cd
Mime-Version: 1.0
Message-Id: <33ca3ba1-e770-4c75-81fc-60dc2561c68d@app.fastmail.com>
In-Reply-To: <4b49873e-48ae-1164-739f-78d96ca3a7bb@redhat.com>
References: <mpearson-lenovo@squebb.ca>
 <20230525193132.3727-1-mpearson-lenovo@squebb.ca>
 <20230525193132.3727-5-mpearson-lenovo@squebb.ca>
 <6e05df16-7125-a634-6b99-3cf3079d3d5d@redhat.com>
 <f6b0b842-3ef0-4c48-afca-6d9953993c9e@app.fastmail.com>
 <4b49873e-48ae-1164-739f-78d96ca3a7bb@redhat.com>
Date:   Fri, 26 May 2023 10:00:18 -0400
From:   "Mark Pearson" <mpearson-lenovo@squebb.ca>
To:     "Hans de Goede" <hdegoede@redhat.com>
Cc:     "markgross@kernel.org" <markgross@kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] platform/x86: think-lmi: mutex protection around multiple WMI
 calls
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



On Fri, May 26, 2023, at 4:12 AM, Hans de Goede wrote:
> Hi,
>
> On 5/25/23 21:50, Mark Pearson wrote:
>> 
>> 
>> On Thu, May 25, 2023, at 3:41 PM, Hans de Goede wrote:
>>> Hi Mark,
>>>
>>> On 5/25/23 21:31, Mark Pearson wrote:
>>>> Add mutex protection around cases where an operation needs multiple
>>>> WMI calls - e.g. setting password.
>>>>
>>>> Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
>>>> ---
>>>> Changes in V2: New commit added after review of other patches in series.
>>>>
>>>>  drivers/platform/x86/think-lmi.c | 46 ++++++++++++++++++++++++--------
>>>>  1 file changed, 35 insertions(+), 11 deletions(-)
>>>>
>>>> diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/think-lmi.c
>>>> index 64cd453d6e7d..f3e1e4dacba2 100644
>>>> --- a/drivers/platform/x86/think-lmi.c
>>>> +++ b/drivers/platform/x86/think-lmi.c
>>>> @@ -14,6 +14,7 @@
>>>>  #include <linux/acpi.h>
>>>>  #include <linux/errno.h>
>>>>  #include <linux/fs.h>
>>>> +#include <linux/mutex.h>
>>>>  #include <linux/string.h>
>>>>  #include <linux/types.h>
>>>>  #include <linux/dmi.h>
>>>> @@ -195,6 +196,7 @@ static const char * const level_options[] = {
>>>>  };
>>>>  static struct think_lmi tlmi_priv;
>>>>  static struct class *fw_attr_class;
>>>> +static DEFINE_MUTEX(tlmi_mutex);
>>>>  
>>>>  /* ------ Utility functions ------------*/
>>>>  /* Strip out CR if one is present */
>>>> @@ -463,23 +465,32 @@ static ssize_t new_password_store(struct kobject *kobj,
>>>>  			sprintf(pwd_type, "%s", setting->pwd_type);
>>>>  		}
>>>>  
>>>> +		mutex_lock(&tlmi_mutex);
>>>>  		ret = tlmi_opcode_setting("WmiOpcodePasswordType", pwd_type);
>>>> -		if (ret)
>>>> +		if (ret) {
>>>> +			mutex_unlock(&tlmi_mutex);
>>>>  			goto out;
>>>> -
>>>> +		}
>>>>  		if (tlmi_priv.pwd_admin->valid) {
>>>>  			ret = tlmi_opcode_setting("WmiOpcodePasswordAdmin",
>>>>  					tlmi_priv.pwd_admin->password);
>>>> -			if (ret)
>>>> +			if (ret) {
>>>> +				mutex_unlock(&tlmi_mutex);
>>>>  				goto out;
>>>> +			}
>>>>  		}
>>>>  		ret = tlmi_opcode_setting("WmiOpcodePasswordCurrent01", setting->password);
>>>> -		if (ret)
>>>> +		if (ret) {
>>>> +			mutex_unlock(&tlmi_mutex);
>>>>  			goto out;
>>>> +		}
>>>>  		ret = tlmi_opcode_setting("WmiOpcodePasswordNew01", new_pwd);
>>>> -		if (ret)
>>>> +		if (ret) {
>>>> +			mutex_unlock(&tlmi_mutex);
>>>>  			goto out;
>>>> +		}
>>>>  		ret = tlmi_simple_call(LENOVO_OPCODE_IF_GUID, "WmiOpcodePasswordSetUpdate;");
>>>> +		mutex_unlock(&tlmi_mutex);
>>>>  	} else {
>>>>  		/* Format: 'PasswordType,CurrentPw,NewPw,Encoding,KbdLang;' */
>>>>  		auth_str = kasprintf(GFP_KERNEL, "%s,%s,%s,%s,%s;",
>>>
>>>
>>> I haven't take a really close / good look yet. But at a first glance
>>> I think it would be cleaner to just take the mutex at the top
>>> and unlock it after the out label to which all the existing goto-s
>>> already go ?
>>>
>> I did consider that - and it was in my first implementation; but then I got concerned
>> about if the mutex_unlock could potentially get called without mutex_lock having been 
>> called beforehand. I couldn't find any good reference as to whether that was safe or not.
>> 
>> I ended up deciding that a few extra brackets and unlock calls wasn't that ugly and was 'safer'...and 
>> so went that route.
>> 
>> Happy to change it - but do you happen to know if it's safe to call unlock without a lock? If it is then
>> that implementation is cleaner.
>
> It is not allowed to unlock without a lock. But if you put the lock 
> directly after the malloc for which the out: does the free then there 
> should be no goto out paths which don't have the lock.
>
> E.g. for new_password_store() put it here:
>
>         new_pwd = kstrdup(buf, GFP_KERNEL);
>         if (!new_pwd)
>                 return -ENOMEM;
>
> 	mutex_lock(&tlmi_mutex);
>
> 	/* Strip out CR if one is present, setting password won't work if it 
> is present */
> 	...
>
> This does mean also taking the lock in the case where the new password 
> store is done with a single WMI call, but that is not an issue. It 
> makes things a tiny bit slower but WMI calls already are not fast and 
> it is not like we are going to change the password / settings 100-times 
> per second.
>
> And the same thing can be done in current_value_store():
>
>         new_setting = kstrdup(buf, GFP_KERNEL);
>         if (!new_setting)
>                 return -ENOMEM;
>
> 	mutex_lock(&tlmi_mutex);
>
>         /* Strip out CR if one is present */
>         ...
>

Yeah - you're right.
For some reason I was trying to do the lock only in the block of code that needed locking...but it makes more sense to do it earlier. I'll update.
Thanks!
Mark

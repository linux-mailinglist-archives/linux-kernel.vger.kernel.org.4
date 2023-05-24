Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DFF970FDC5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 20:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235553AbjEXSVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 14:21:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236738AbjEXSVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 14:21:34 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9639197;
        Wed, 24 May 2023 11:21:24 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 10A713200900;
        Wed, 24 May 2023 14:21:20 -0400 (EDT)
Received: from imap52 ([10.202.2.102])
  by compute5.internal (MEProxy); Wed, 24 May 2023 14:21:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1684952480; x=1685038880; bh=8n
        +IaACCh27iHdXNW61G4VevMtyUcvcfnjZ1YrA0koc=; b=KqOCSdZ5YUv4mmgOHf
        kYbggNn3wN+1mm4PTofyVOyKgUuvCo7vxLQuTcAY70f8cgoKrgZgvH/PbhL953zQ
        vOUUWGNVJo6VYxQWH38I377Ftb8N/P97u1Z9CFj+UT03Sk9+kVhNsoK8TZ6agGGn
        24X+kUwBM2aFWK/hTZ1SUa9HNm73HXG5nSANAoqR6IBXfoKuujb2/Q/uE2317MzI
        s6oh/QHyfoLLbqK2GBPQBdQXDC4NoNqpJIobsRndCFFfg/pYfYolW23xpe2Lsizd
        qqQ2Y067azKCmd0aDUZjhrCMOjLKtKAEjHOnm0pMuxVyrM6EkHFOG+IsmE6VilZa
        9QFg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1684952480; x=1685038880; bh=8n+IaACCh27iH
        dXNW61G4VevMtyUcvcfnjZ1YrA0koc=; b=MldM9qZm6OhWPsXGkL0VBnaZuYGZP
        gf99J8vJoDBcgoxpGvjKLjuFdBOXJ/XRm6Qpy7/Ggm/X2uG9LNsUWwV5gy8CSnai
        kXNuuSO1diQDsemCLIT0l6Q9lnrGVO1CZhEMXSct0R6BeecWEPKqcxLyrxfCbrmn
        k09kHxNwIrMuwVIQ4uuW45r4/T/gSXnTP/n7R4aj353nrN4IovAYrZV6EMrLGBXS
        sESRl4NjmIlBBBwZbTqFpaB5L2BCFTh/drdkCrkxJ5W6T3jLwn0WtSsHJp5X4MeV
        QfBIWRRv+90KSPjLjnactkU+zGpm9t92ke1niluTifZLBhmBScSNSCj8g==
X-ME-Sender: <xms:oFVuZCjNka_Imn4qup0lSC_qfuLzv1zQqzTOZ9V9wzBrzFqNqVcP0w>
    <xme:oFVuZDBmPNgQOglVVNfv9GeJoJlgQf959kzz2fzBMbomlvo3Uo3ZRSBo6xshVhBV1
    auN7MlhhSh-a51Bfoc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeejhedguddvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdfo
    rghrkhcurfgvrghrshhonhdfuceomhhpvggrrhhsohhnqdhlvghnohhvohesshhquhgvsg
    gsrdgtrgeqnecuggftrfgrthhtvghrnhepteehgfeftdevgfehleejgedujeetkeevuefh
    hfejteeuueeuiedvgfeihefghfehnecuffhomhgrihhnpehlvghnohhvohgtughrthdrtg
    homhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehm
    phgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggr
X-ME-Proxy: <xmx:oFVuZKH6JiF4HZqekEpONS8HypflHSZd8ou1wzg3sXYTlY8eCmedvg>
    <xmx:oFVuZLTIFBJUWrp67EQE_XKNeWd-8h9CSEqZlrpC5qzGCxFjx7f0Bw>
    <xmx:oFVuZPzwXrlA1dj51AidMUNuRnvXHhQKzds-0zVJkf3yp3fa6oVkTg>
    <xmx:oFVuZIq2sCaw-i6IF_4wurXHqAJDdC291HbRVKhRL7jDZJbj6OsR8w>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 56CC0C60091; Wed, 24 May 2023 14:21:20 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-441-ga3ab13cd6d-fm-20230517.001-ga3ab13cd
Mime-Version: 1.0
Message-Id: <71d0ddfa-ccca-43ee-aaac-6daf6b876824@app.fastmail.com>
In-Reply-To: <04415f83-64fa-4d70-91fa-4425e163b350@app.fastmail.com>
References: <mpearson-lenovo@squebb.ca>
 <20230517181945.3725-1-mpearson-lenovo@squebb.ca>
 <b79fa66c-b8bc-125c-ccfa-9dae727022e9@redhat.com>
 <04415f83-64fa-4d70-91fa-4425e163b350@app.fastmail.com>
Date:   Wed, 24 May 2023 14:20:59 -0400
From:   "Mark Pearson" <mpearson-lenovo@squebb.ca>
To:     "Hans de Goede" <hdegoede@redhat.com>
Cc:     "markgross@kernel.org" <markgross@kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] platform/x86: think-lmi: Enable opcode support on BIOS
 settings
Content-Type: text/plain
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLACK autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

On Tue, May 23, 2023, at 8:36 AM, Mark Pearson wrote:
> Thanks Hans,
>
> On Tue, May 23, 2023, at 6:46 AM, Hans de Goede wrote:
>> Hi Mark,
>>
>> On 5/17/23 20:19, Mark Pearson wrote:
>>> Whilst reviewing some documentation from the FW team on using WMI on
>>> Lenovo system I noticed that we weren't using Opcode support when
>>> changing BIOS settings in the thinkLMI driver.
>>> 
>>> We should be doing this to ensure we're future proof as the old
>>> non-opcode mechanism has been deprecated.
>>> 
>>> Tested on X1 Carbon G10 and G11.
>>> 
>>> Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
>>> ---
>>>  drivers/platform/x86/think-lmi.c | 23 ++++++++++++++++++++++-
>>>  1 file changed, 22 insertions(+), 1 deletion(-)
>>> 
>>> diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/think-lmi.c
>>> index 1138f770149d..d9341305eba9 100644
>>> --- a/drivers/platform/x86/think-lmi.c
>>> +++ b/drivers/platform/x86/think-lmi.c
>>> @@ -1001,7 +1001,28 @@ static ssize_t current_value_store(struct kobject *kobj,
>>>  				tlmi_priv.pwd_admin->save_signature);
>>>  		if (ret)
>>>  			goto out;
>>
>>> -	} else { /* Non certiifcate based authentication */
>>> +	} else if (tlmi_priv.opcode_support) {
>>> +		/* If opcode support is present use that interface */
>>> +		set_str = kasprintf(GFP_KERNEL, "%s,%s;", setting->display_name,
>>> +					new_setting);
>>> +		if (!set_str) {
>>> +			ret = -ENOMEM;
>>> +			goto out;
>>> +		}
>>> +
>>> +		ret = tlmi_simple_call(LENOVO_SET_BIOS_SETTINGS_GUID, set_str);
>>> +		if (ret)
>>> +			goto out;
>>> +
>>> +		if (tlmi_priv.pwd_admin->valid && tlmi_priv.pwd_admin->password[0]) {
>>> +			ret = tlmi_opcode_setting("WmiOpcodePasswordAdmin",
>>> +					tlmi_priv.pwd_admin->password);
>>> +			if (ret)
>>> +				goto out;
>>> +		}
>>> +
>>> +		ret = tlmi_save_bios_settings("");
>>
>> I'm a bit confused about how this works. You are calling the same
>> LENOVO_SET_BIOS_SETTINGS_GUID as the old non opcode based authentication method
>> without any auth string.
>>
>> And then afterwards you are calling LENOVO_OPCODE_IF_GUID with
>> "WmiOpcodePasswordAdmin:<passwd>"
>>
>> Won't the initial LENOVO_SET_BIOS_SETTINGS_GUID get rejected since
>> it does not include an auth-string and you have not authenticated
>> yet using the opcode mechanism either. IOW shouldn't the opcode
>> auth call go first ?
>>
>> And how does this work timing wise, vs races with userspace doing
>> multiple sysfs writes at once.
>>
>> If the authentication done afterwards really acks the last
>> LENOVO_SET_BIOS_SETTINGS_GUID call then a userspace based
>> attacker could try to race and overwrite the last
>> LENOVO_SET_BIOS_SETTINGS_GUID call before the ack happens... ?
>>
>> If this code really is correct I think we need to introduce
>> a mutex to avoid this race.
>>
>> And this also needs some comments to explain what is going on.
>
> Agreed - and looking at it now....I'm questioning it myself. This was 
> tested so it works...but I wonder if that was more luck than judgement.
> Let me do some checking - I think I may have messed up here.
>

Looked at this and the code is correct - even if it is a bit weird :)
https://docs.lenovocdrt.com/#/bios/wmi/wmi_guide?id=set-and-save-a-bios-setting-on-newer-models

The save_bios_settings would fail if a password was not set (if it's required).

With regards to race conditions - that does seem somewhat unlikely in real life but I can add a mutex around this to catch that condition. I think I should probably do the same in a couple of other places (e.g. certificate_store and new_password_store) where multiple WMI calls are needed to complete an operation. 

Is it OK if I do that as a separate commit on the end of the series or would you rather it was included in this commit? As the scope is, I think, more than just this function I'm leaning towards a separate commit but let me know what best practice is.

Thanks
Mark

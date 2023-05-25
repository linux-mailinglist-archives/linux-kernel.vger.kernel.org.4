Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C03F710DA8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 15:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241376AbjEYNzE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 09:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234743AbjEYNzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 09:55:01 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C0F318C;
        Thu, 25 May 2023 06:54:59 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id A8BB55C0093;
        Thu, 25 May 2023 09:54:56 -0400 (EDT)
Received: from imap52 ([10.202.2.102])
  by compute5.internal (MEProxy); Thu, 25 May 2023 09:54:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1685022896; x=1685109296; bh=Uv
        ue7ajMd8MxeYSdotGZOhFpU8pvzu3B/msd3RoEfu8=; b=JiaBp8/gpDPH9tAMtM
        DLJrnNmsNoc9gRjoyQTADE/7NKbFuz+gYoobZHIaGb3Xx9CH/ex95ILMmYyKWN5p
        XuCCG9pBU8beZXqf3+pU9Xko5FBpV9bZYm/GWEsuJN3jOIESiLB3hSm6hVfRFm/c
        CjCZWfNzX4LoOKn45vMuRWc4QFpIiLuaEYNCyb0rCxl3kmuBGaZp3NOfXvvP2LlG
        HcCC93JeoIVFNQC5ObPiHq3TzQVRENaYC7zkZuUfpIDYxScNUUwNxWYZHfV5EyfT
        cNzxZhr0qeUgSQZNAEzXuO87UjJNc1+dS/ArhWJmOaZa6feKQcgvwH0TRuuKTQkL
        1OkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1685022896; x=1685109296; bh=Uvue7ajMd8Mxe
        YSdotGZOhFpU8pvzu3B/msd3RoEfu8=; b=U1NGmojm8mPdu2COhYfsHPBvGUGpF
        QedOQB89L0YxuqtGGof8SrI4wZCmszOldCgcfx0rv5euMVD+t/1EjFr7osGM9EgD
        McrKTwbaHmg31XTA+7U4aGiOxvq7zq4cF3qEtgxGsHfIFT0Rd0qJ/TPd5sroFUPY
        B40ANhIjhz/1MPNAwIAEtEQ2CCfHL4P+p75NrI7P6GQGJf+GVJKyRVrRXel8g3vz
        K0o7lfWQGx+SBT/slxv5j2pZDc/z1q7jTkrZJBd3xe2O3LKrWhd3eM92u75/li6r
        NAWDuX03JMOfRoSkp8qRrwV3mSIKNF6dcU7Wmbx2aD4QXvE5xQa+KNdQw==
X-ME-Sender: <xms:sGhvZHoQY28oU1g1zyePmg7a9o2o8UtB8v_lKh99LDeEZglzkBgKNA>
    <xme:sGhvZBq8abJKs2tuWpCvoWRQXN09tET5fyyiBw-9fw7K6SnhKUEqRnrO0kTNaWY5Y
    Xc8zMZptmJVR2mXqTA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeejjedgieelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfofgr
    rhhkucfrvggrrhhsohhnfdcuoehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssg
    drtggrqeenucggtffrrghtthgvrhhnpeethefgfedtvefgheeljeegudejteekveeuhffh
    jeetueeuueeivdfgieehgffhheenucffohhmrghinheplhgvnhhovhhotggurhhtrdgtoh
    hmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhhp
    vggrrhhsohhnqdhlvghnohhvohesshhquhgvsggsrdgtrg
X-ME-Proxy: <xmx:sGhvZEPLXOFKuODWeSjHdwkIaKj_wcaEvXJupdb43wadxP-Lhk-8pQ>
    <xmx:sGhvZK4pyBOpyqdy0ezDYIwFOCH4LiB9v3NEhKySvBYoZJH9gZpHqg>
    <xmx:sGhvZG7XV860O2ZclRXkdMmx27eDgrcKvyYYaGKh660fVUNXKEOapw>
    <xmx:sGhvZMR8LRK_5cPoVjbjyi80-kSAD2Mq4vfGKt-bfXGp5y4k_WB3-Q>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 6A839C60091; Thu, 25 May 2023 09:54:56 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-441-ga3ab13cd6d-fm-20230517.001-ga3ab13cd
Mime-Version: 1.0
Message-Id: <edd69d45-4d84-4982-aa57-2b420ce0b374@app.fastmail.com>
In-Reply-To: <a27660bd-fa7c-20c5-b7f2-f2ff20fe6cb8@redhat.com>
References: <mpearson-lenovo@squebb.ca>
 <20230517181945.3725-1-mpearson-lenovo@squebb.ca>
 <b79fa66c-b8bc-125c-ccfa-9dae727022e9@redhat.com>
 <04415f83-64fa-4d70-91fa-4425e163b350@app.fastmail.com>
 <71d0ddfa-ccca-43ee-aaac-6daf6b876824@app.fastmail.com>
 <a27660bd-fa7c-20c5-b7f2-f2ff20fe6cb8@redhat.com>
Date:   Thu, 25 May 2023 09:54:35 -0400
From:   "Mark Pearson" <mpearson-lenovo@squebb.ca>
To:     "Hans de Goede" <hdegoede@redhat.com>
Cc:     "markgross@kernel.org" <markgross@kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] platform/x86: think-lmi: Enable opcode support on BIOS
 settings
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

On Thu, May 25, 2023, at 5:52 AM, Hans de Goede wrote:
> Hi Mark,
>
> On 5/24/23 20:20, Mark Pearson wrote:
>> Hi Hans,
>> 
>> On Tue, May 23, 2023, at 8:36 AM, Mark Pearson wrote:
>>> Thanks Hans,
>>>
>>> On Tue, May 23, 2023, at 6:46 AM, Hans de Goede wrote:
>>>> Hi Mark,
>>>>
>>>> On 5/17/23 20:19, Mark Pearson wrote:
>>>>> Whilst reviewing some documentation from the FW team on using WMI on
>>>>> Lenovo system I noticed that we weren't using Opcode support when
>>>>> changing BIOS settings in the thinkLMI driver.
>>>>>
>>>>> We should be doing this to ensure we're future proof as the old
>>>>> non-opcode mechanism has been deprecated.
>>>>>
>>>>> Tested on X1 Carbon G10 and G11.
>>>>>
>>>>> Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
>>>>> ---
>>>>>  drivers/platform/x86/think-lmi.c | 23 ++++++++++++++++++++++-
>>>>>  1 file changed, 22 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/think-lmi.c
>>>>> index 1138f770149d..d9341305eba9 100644
>>>>> --- a/drivers/platform/x86/think-lmi.c
>>>>> +++ b/drivers/platform/x86/think-lmi.c
>>>>> @@ -1001,7 +1001,28 @@ static ssize_t current_value_store(struct kobject *kobj,
>>>>>  				tlmi_priv.pwd_admin->save_signature);
>>>>>  		if (ret)
>>>>>  			goto out;
>>>>
>>>>> -	} else { /* Non certiifcate based authentication */
>>>>> +	} else if (tlmi_priv.opcode_support) {
>>>>> +		/* If opcode support is present use that interface */
>>>>> +		set_str = kasprintf(GFP_KERNEL, "%s,%s;", setting->display_name,
>>>>> +					new_setting);
>>>>> +		if (!set_str) {
>>>>> +			ret = -ENOMEM;
>>>>> +			goto out;
>>>>> +		}
>>>>> +
>>>>> +		ret = tlmi_simple_call(LENOVO_SET_BIOS_SETTINGS_GUID, set_str);
>>>>> +		if (ret)
>>>>> +			goto out;
>>>>> +
>>>>> +		if (tlmi_priv.pwd_admin->valid && tlmi_priv.pwd_admin->password[0]) {
>>>>> +			ret = tlmi_opcode_setting("WmiOpcodePasswordAdmin",
>>>>> +					tlmi_priv.pwd_admin->password);
>>>>> +			if (ret)
>>>>> +				goto out;
>>>>> +		}
>>>>> +
>>>>> +		ret = tlmi_save_bios_settings("");
>>>>
>>>> I'm a bit confused about how this works. You are calling the same
>>>> LENOVO_SET_BIOS_SETTINGS_GUID as the old non opcode based authentication method
>>>> without any auth string.
>>>>
>>>> And then afterwards you are calling LENOVO_OPCODE_IF_GUID with
>>>> "WmiOpcodePasswordAdmin:<passwd>"
>>>>
>>>> Won't the initial LENOVO_SET_BIOS_SETTINGS_GUID get rejected since
>>>> it does not include an auth-string and you have not authenticated
>>>> yet using the opcode mechanism either. IOW shouldn't the opcode
>>>> auth call go first ?
>>>>
>>>> And how does this work timing wise, vs races with userspace doing
>>>> multiple sysfs writes at once.
>>>>
>>>> If the authentication done afterwards really acks the last
>>>> LENOVO_SET_BIOS_SETTINGS_GUID call then a userspace based
>>>> attacker could try to race and overwrite the last
>>>> LENOVO_SET_BIOS_SETTINGS_GUID call before the ack happens... ?
>>>>
>>>> If this code really is correct I think we need to introduce
>>>> a mutex to avoid this race.
>>>>
>>>> And this also needs some comments to explain what is going on.
>>>
>>> Agreed - and looking at it now....I'm questioning it myself. This was 
>>> tested so it works...but I wonder if that was more luck than judgement.
>>> Let me do some checking - I think I may have messed up here.
>>>
>> 
>> Looked at this and the code is correct - even if it is a bit weird :)
>> https://docs.lenovocdrt.com/#/bios/wmi/wmi_guide?id=set-and-save-a-bios-setting-on-newer-models
>> 
>> The save_bios_settings would fail if a password was not set (if it's required).
>
> Ok, can you add some comments to the next revision explaining this ?
> (no need to write a novel, just some short comments)

Of course - no problem :)

>
>> With regards to race conditions - that does seem somewhat unlikely in real life but I can add a mutex around this to catch that condition. I think I should probably do the same in a couple of other places (e.g. certificate_store and new_password_store) where multiple WMI calls are needed to complete an operation. 
>
> Ack for also adding the mutex in other places where there is more
> then 1 WMI call involved.
>
>> Is it OK if I do that as a separate commit on the end of the series or would you rather it was included in this commit? As the scope is, I think, more than just this function I'm leaning towards a separate commit but let me know what best practice is.
>
> Adding this in a separate commit is fine with me.

Thanks. I'll work on that and get a v2 series out shortly

Mark

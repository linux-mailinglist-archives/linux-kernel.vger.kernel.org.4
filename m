Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DA5B6D287C
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 21:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbjCaTKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 15:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjCaTKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 15:10:46 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 859CE22217;
        Fri, 31 Mar 2023 12:10:45 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 46C0F5C017F;
        Fri, 31 Mar 2023 15:10:43 -0400 (EDT)
Received: from imap52 ([10.202.2.102])
  by compute5.internal (MEProxy); Fri, 31 Mar 2023 15:10:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1680289843; x=1680376243; bh=G+/bpOkPmdBpQLtlNxb/JtpYIgiz1IPTfTS
        zllJWTtg=; b=FYOG4pzApMQtiHwRGBIugvlQbwv6tvXwr27eYb0X0SA2Bf6BqCl
        uMpTONrqRG7qzokCE7olwLqXfulM3rAMuMF+wWnIcD/Y2f/B6EzKXl6VTjfr0Jwq
        nPurH6wY4oObq0wesBrvpmOGRM8WWkOPadu1DXawGz3W4Uk0pDtfA38DdiyaeWT6
        8O5P6TpCOT/si1xaqEPpioIVjNHKjs6C+anro5QBWmK2w1TmfryRsS++Q+CdwqRr
        PWzF/2iFs9BWWXTTe/zXnPvrhhxigAvoU9dAG2N3g0QeUVsjz+pjHHiTG0Zadg48
        P/FJZCdzb7TWQ7z3CSok46Y4srwCd0HCb7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1680289843; x=1680376243; bh=G+/bpOkPmdBpQLtlNxb/JtpYIgiz1IPTfTS
        zllJWTtg=; b=ZKfBNBQjIxrsNo0h3JZpa4Q2P6RAC7RWqRIJanmX7nn8WrsMIfU
        0biKGF5vj8ltbgGoNJZnFBy8uLln1cbzlcZjVDbtKf2rCc0uQUOKYgMevLqcXbEC
        1isNvUFZWaUKp/IQEr3F1aHbuR9w7AkP5c2j9T+Yk/mB5qg7Y6TUfJi447tl6Zlw
        peJv7MgOytWvZANTjOETNhJsgMvaW340CSP73+6LM/9h9cArzYKBh1SpHwpkVVx8
        wuhoNZZGSzum9R5ar4YcnXNY07o5bbgP+SVbayCwhIqtU0AVLeqLdxpEFgXQFjxY
        9ufiiTyQfVoYQrgAfYIXETrnHxebR/CQ7yA==
X-ME-Sender: <xms:MzAnZHyG4qyEG3uhEfEzIc-mtPvpFvRNaMiVu5CeNFMw3x9i0jdUBA>
    <xme:MzAnZPTGjOskHvhuqL3J1g0a6d1jfNoFOD5n0k5IEO_Q8DiCP9ZGskuAPLcPbvsN8
    bBa9536kCofrVhLkmc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeiuddgudefvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedf
    ofgrrhhkucfrvggrrhhsohhnfdcuoehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvg
    gssgdrtggrqeenucggtffrrghtthgvrhhnpeefjeegvddugedvkeehvdfffeejhfeutdfh
    tdehheekffduvdfgteejgeejueefgfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhhpvggr
    rhhsohhnqdhlvghnohhvohesshhquhgvsggsrdgtrg
X-ME-Proxy: <xmx:MzAnZBVGAL6Dl_3VSz2WbV7xI28Ff-QOkKKwucokLXf4Bty3CJ_eXQ>
    <xmx:MzAnZBghVDtpTWhkONyR-xoThDMDuJXAKD5B_5FDJoVyTndVDMcc0w>
    <xmx:MzAnZJBr8Wa4szn4dhpej9U3c8y4Q8AZJtooZjUHdgtQ7Sc378FIFg>
    <xmx:MzAnZL2CLsapEo2qUHCd6HSGb6704VpVhGN23jjSfKj5AdQBLG3xSQ>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 06185C60093; Fri, 31 Mar 2023 15:10:43 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-238-g746678b8b6-fm-20230329.001-g746678b8
Mime-Version: 1.0
Message-Id: <a1896b4a-1843-4946-ab6f-63132a03e009@app.fastmail.com>
In-Reply-To: <d1750883-3eba-c824-3f89-9568345709b8@redhat.com>
References: <5059b11b-8b6e-394b-338f-49e1339067fa@alu.unizg.hr>
 <d011a1d7-34ab-5f54-fcc7-d727abc7ec9b@alu.unizg.hr>
 <ZCLa3_HnLQA0GQKS@kroah.com>
 <b50f9460-ac54-e997-f9b9-3c47a9b87aae@alu.unizg.hr>
 <df26ff45-8933-f2b3-25f4-6ee51ccda7d8@gmx.de>
 <16862c45-2ffd-a2f2-6719-020c5d515800@alu.unizg.hr>
 <4f65a23f-4e04-f04f-e56b-230a38ac5ec4@gmx.de>
 <01e920bc-5882-ba0c-dd15-868bf0eca0b8@alu.unizg.hr>
 <8b478e6d-7482-2cbb-ee14-b2dc522daf35@alu.unizg.hr>
 <9f757a7b-6ac9-804a-063f-4cc2c6fc3f54@alu.unizg.hr>
 <de54f828-e2c6-4c10-92ce-ca86fb5c5fb4@t-8ch.de>
 <6a5dc4de-b315-1e6d-e5e2-5b95521a37c7@alu.unizg.hr>
 <2c1d0b9b-0e71-b616-6486-52e741d25afb@redhat.com>
 <9c142ac2-9340-4a9b-8541-99f613772340@app.fastmail.com>
 <4dc118c2-0dde-bd5e-ea41-427ed33e4545@alu.unizg.hr>
 <b06d1d1f-7cd5-4532-ac49-d449ef68bbcb@app.fastmail.com>
 <bccb52fa-e1c9-482c-a024-9a02179728b2@t-8ch.de>
 <b2d0461b-a32b-50e0-640d-9e789bb5da30@alu.unizg.hr>
 <1059aa55-9370-4b8d-8c6c-7fdfd9ac0c70@app.fastmail.com>
 <d1750883-3eba-c824-3f89-9568345709b8@redhat.com>
Date:   Fri, 31 Mar 2023 15:10:22 -0400
From:   "Mark Pearson" <mpearson-lenovo@squebb.ca>
To:     "Hans de Goede" <hdegoede@redhat.com>,
        "Mirsad Goran Todorovac" <mirsad.todorovac@alu.unizg.hr>,
        =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Cc:     "Armin Wolf" <W_Armin@gmx.de>,
        "Greg KH" <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org,
        "markgross@kernel.org" <markgross@kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>
Subject: Re: [BUG] [RFC] systemd-devd triggers kernel memleak apparently in
 drivers/core/dd.c: driver_register()
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, Mar 31, 2023, at 3:04 PM, Hans de Goede wrote:
> Hi,
>
> On 3/31/23 20:54, Mark Pearson wrote:
>> Hi all,
>>=20
>> On Wed, Mar 29, 2023, at 5:50 PM, Mirsad Goran Todorovac wrote:
>>> On 29. 03. 2023. 21:21, Thomas Wei=C3=9Fschuh wrote:
>>>>
>>>> Mar 29, 2023 14:00:22 Mark Pearson <mpearson-lenovo@squebb.ca>:
>>>>
>>>>> Thanks Mirsad
>>>>>
>>>>> On Wed, Mar 29, 2023, at 2:49 PM, Mirsad Goran Todorovac wrote:
>>>>> <snip>
>>>>>>
>>>>>> Here is the patch proposal according to what Mark advised (using
>>>>>> different name for optitem):
>>>>>>
>>>>>> diff --git a/drivers/platform/x86/think-lmi.c
>>>>>> b/drivers/platform/x86/think-lmi.c
>>>>>> index c816646eb661..ab17254781c4 100644
>>>>>> --- a/drivers/platform/x86/think-lmi.c
>>>>>> +++ b/drivers/platform/x86/think-lmi.c
>>>>>> @@ -929,8 +929,10 @@ static ssize_t current_value_show(struct kob=
ject
>>>>>> *kobj, struct kobj_attribute *a
>>>>>>
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* validate and =
split from `item,value` -> `value` */
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 value =3D strpbr=
k(item, ",");
>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!value || value =3D=3D =
item || !strlen(value + 1))
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!value || value =3D=3D =
item || !strlen(value + 1)) {
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 kfree(item);
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>>>
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D sysfs_em=
it(buf, "%s\n", value + 1);
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kfree(item);
>>>>>> @@ -1380,7 +1382,6 @@ static struct tlmi_pwd_setting
>>>>>> *tlmi_create_auth(const char *pwd_type,
>>>>>>
>>>>>> =C2=A0 static int tlmi_analyze(void)
>>>>>> =C2=A0 {
>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 acpi_status status;
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int i, ret;
>>>>>>
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (wmi_has_guid=
(LENOVO_SET_BIOS_SETTINGS_GUID) &&
>>>>>> @@ -1417,8 +1418,8 @@ static int tlmi_analyze(void)
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char *p;
>>>>>>
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tlmi_priv.setting[i] =3D NULL;
>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 status =3D tlmi_setting(i, &item, LENOVO_BIOS_SETTING=
_GUID);
>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 if (ACPI_FAILURE(status))
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 ret =3D tlmi_setting(i, &item, LENOVO_BIOS_SETTING_GU=
ID);
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 if (ret)
>>>>>
>>>>> Really minor, but tweak to be this and save a line of code?
>>>>
>>>> This hunk is actually from another commit and should not be needed =
here.
>>>>
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git=
/commit/drivers/platform/x86/think-lmi.c?id=3Dda62908efe80f132f691efc2ac=
e4ca67626de86b
>>>
>>> Thank you, Thomas,
>>>
>>> Indeed, my mistake.
>>>
>>> I have accepted Armin's suggestion to test if that patch closed the =
leak, and I
>>> have just quoted it, never claiming authorship.
>>>
>>> I ought to apologise if I made confusion here.
>>>
>>> I was a bit euphoric about the leak being fixed, so forgive me for t=
his blatant
>>> mistake. Of course, putting it here would cause a patch collision, s=
o it was a
>>> stupid thing to do, and I would never do it in a formal patch submis=
sion ...
>>>
>>> Thanks, anyway for correction.
>>>
>>> Best regards,
>>> Mirsad
>>>
>>=20
>> I have the patches ready to fix this issue - I just wanted to check t=
hat I wouldn't be stepping on anybodies toes or if there is a protocol f=
or doing this.
>>  - I will add Reported-by tag for Mirsad and Suggested-by for Armin.
>>  - I've identified Fixes tags for the two commits that caused the iss=
ue.
>> Let me know if there's anything else I should do - otherwise I'll get=
 them sent out ASAP.
>
> This sounds to me like you have covered all the bases.
>
> Note Armin did send out a related fix earlier today,
> which I guess is duplicate with one of your patches:
>
> https://patchwork.kernel.org/project/platform-driver-x86/patch/2023033=
1180912.38392-1-W_Armin@gmx.de/
>
> So maybe add Armin's patch on top of pdx86/fixes and
> use that as a base for your series (dropping your
> likely duplicate patch) ?
>
Makes sense - will do
Thanks!
Mark

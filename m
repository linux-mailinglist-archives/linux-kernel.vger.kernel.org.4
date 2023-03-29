Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 973E16CEF49
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 18:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbjC2QZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 12:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjC2QZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 12:25:23 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2286218D;
        Wed, 29 Mar 2023 09:25:22 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id E2D2D320082A;
        Wed, 29 Mar 2023 12:25:20 -0400 (EDT)
Received: from imap52 ([10.202.2.102])
  by compute5.internal (MEProxy); Wed, 29 Mar 2023 12:25:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1680107120; x=1680193520; bh=Yf3WK5kVKo7TDV/7QTg8j0vR1ROaxaMtl+t
        ueRtt0BQ=; b=M2WoqFLG22kbIb7zpEZ2SfLcxtQzJefimOcjFDIBt0DH6rT4aPb
        s15eFWVjIcoyhEeGZaaoKWC1eGPkcP3VgFmNwOpTKwYJopIF9K9yxTQX1o6Ups+P
        FATATPK4aUgwO5NMRzxnjAzmLxz9814sskyWm+brnGuAqBOJDrfwzRNFkPNO72O4
        OH0zLkshyzYAdq4Grx0zYWScqtsjeejUGOkvb/sQ5n3YZCW6+Jo5EoyxaI1Ue3/N
        Sm2gIcOYQgRmAqCrW9XgsHMN0oagLr0Cacq3tYwCmQ/oIsnVOILP6uTXH/j9k2/Q
        J58hN9pfgBempUGt1bM6Km42h5d3xg+OhqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1680107120; x=1680193520; bh=Yf3WK5kVKo7TDV/7QTg8j0vR1ROaxaMtl+t
        ueRtt0BQ=; b=dsOfy4BwJ/CghZYlQz+rDJwBwbGddja8WEpaUi1nq8Clnn6yyco
        mvCZ4s+I87XhUoO0HmgUEo4GHTL20geCNihTkdicfWhsRaEhNJ33etWT9u1qWrsk
        XaoTyiC0QXkPZa6Q5BHdOZQeKarBCm76wCLJH2iXQ+t+q/muf/FiQewUkJTftUjy
        0AKR3bNBl2BR3EKJnqBd9BumQ1wgfAzpK0d2mgp7UK1TuekfV2FAk/oompHbwhkQ
        CmlRC+K1rr4kWMdk/CcD0zFEqwsea/Y5KOeI1P3kVyrqhzyYUqa5L+wMtsYdbRP5
        4u/iPeSq/7b1Zedq1cNZaBOPAB2KFFppVCA==
X-ME-Sender: <xms:b2YkZM1RbOyQhcwiHiEjnh12_7IJfFOTyhoE9B4-j9gR2e7uWxO2Ow>
    <xme:b2YkZHEej3LGzqb42SqLs5NWyXjnbt_6W22OhFfmMAofg4FHlhkD67e5iahmDqovS
    -s_9Fs-ZoFMMml2FNM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdehiedguddtvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedf
    ofgrrhhkucfrvggrrhhsohhnfdcuoehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvg
    gssgdrtggrqeenucggtffrrghtthgvrhhnpefhfeegudeftefgteelgfekgfdvjeelleev
    gffhjeffhfdtiedtjeefkedvuefgkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdr
    tggr
X-ME-Proxy: <xmx:b2YkZE7U1WFTvlu9jgAAVHm0TF4zEN5ad6hZfj9NFsBbWS2RV24pVQ>
    <xmx:b2YkZF3llGXPELmB1Mv1YnOZZoh-R7WQHFQUn3ivwS0xHvOl30Gc0w>
    <xmx:b2YkZPH6dlpHDAxSzpI8HcTkxj-3bTli8bDoN2iLDsFgsy2s1tE0CQ>
    <xmx:cGYkZE7EdXz0aKxgNMVQrmtaIF9IEerj4XxbUewgB1y3WFWT24yeSw>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id D174FC60091; Wed, 29 Mar 2023 12:25:19 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-238-g746678b8b6-fm-20230329.001-g746678b8
Mime-Version: 1.0
Message-Id: <9c142ac2-9340-4a9b-8541-99f613772340@app.fastmail.com>
In-Reply-To: <2c1d0b9b-0e71-b616-6486-52e741d25afb@redhat.com>
References: <5059b11b-8b6e-394b-338f-49e1339067fa@alu.unizg.hr>
 <ZCLPaYGKHlFQGKYQ@kroah.com>
 <542c13f5-4cdd-7750-f10a-ef64bb7e8faa@alu.unizg.hr>
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
Date:   Wed, 29 Mar 2023 12:24:59 -0400
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
Subject: Re: [BUG] [BISECTED] [CORRECTION] systemd-devd triggers kernel memleak
 apparently in drivers/core/dd.c: driver_register()
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On Wed, Mar 29, 2023, at 11:46 AM, Hans de Goede wrote:
> Hi,
>
> On 3/29/23 16:18, Mirsad Goran Todorovac wrote:
>> On 29.3.2023. 15:35, Thomas Wei=C3=9Fschuh wrote:
>>>
>>> Mar 29, 2023 08:31:31 Mirsad Goran Todorovac <mirsad.todorovac@alu.u=
nizg.hr>:
>>>
<snip>
>>=20
>> diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/=
think-lmi.c
>> index c816646eb661..e8c28f4f5a71 100644
>> --- a/drivers/platform/x86/think-lmi.c
>> +++ b/drivers/platform/x86/think-lmi.c
>> @@ -1469,6 +1469,7 @@ static int tlmi_analyze(void)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kstrndup(optstart, optend =
- optstart,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 GF=
P_KERNEL);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kfree(item);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 /*
>>=20
>> You were 3 minutes faster ;-)
>>=20
>> The build with this patch is finished. Apparently, that was the culpr=
it, for now
<snip>
>>=20
>>=20
>> So, the "tlmi_setting" memory leak appears to be fixed by this diff.
>>=20
My only concern here is it looks like I was dumb and used the variable n=
ame 'item' twice in the same function. I guess the compiler is smart eno=
ugh to handle it but I'd like to change the name to make it clearer whic=
h 'item' is being freed in each context.

In that block I would change it to be:
char *optitem, *optstart, *optend;
and fix all the pieces in the block to then be correct too (with the nee=
ded free)

>> The next step is to add Armin-suggested patch:
>>=20
>> diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/=
think-lmi.c
>> index c816646eb661..1e77ecb0cba8 100644
>> --- a/drivers/platform/x86/think-lmi.c
>> +++ b/drivers/platform/x86/think-lmi.c
>> @@ -929,8 +929,10 @@ static ssize_t current_value_show(struct kobject=
 *kobj, struct kobj_attribute *a
>>=20
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* validate and split from=
 `item,value` -> `value` */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 value =3D strpbrk(item, ",=
");
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!value || value =3D=3D item=
 || !strlen(value + 1))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!value || value =3D=3D item=
 || !strlen(value + 1)) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 kfree(item);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>=20
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D sysfs_emit(buf, "%=
s\n", value + 1);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kfree(item);
>>=20
This looks good to me - thank you!

>> and Thomas' correction for the return type of the tlmi_setting() func=
tion:
>>=20
>> diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/=
think-lmi.c
>> index 86b33b74519be..c924e9e4a6a5b 100644
>> --- a/drivers/platform/x86/think-lmi.c
>> +++ b/drivers/platform/x86/think-lmi.c
>> @@ -1353,7 +1353,6 @@ static struct tlmi_pwd_setting *tlmi_create_aut=
h(const char *pwd_type,
>>=20
>> =C2=A0static int tlmi_analyze(void)
>> =C2=A0{
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 acpi_status status;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int i, ret;
>>=20
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (wmi_has_guid(LENOVO_SE=
T_BIOS_SETTINGS_GUID) &&
>> @@ -1390,8 +1389,8 @@ static int tlmi_analyze(void)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 char *p;
>>=20
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 tlmi_priv.setting[i] =3D NULL;
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 status =3D tlmi_setting(i, &item, LENOVO_BIOS_SETTING_GU=
ID);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 if (ACPI_FAILURE(status))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 ret =3D tlmi_setting(i, &item, LENOVO_BIOS_SETTING_GUID);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 if (ret)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 br=
eak;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 if (!item)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 br=
eak;
>>=20
>> A build on top of 6.3-rc4+ fcd476ea6a88 commit is on the way, with al=
l three included.
>
> Good work on catching these issues, thank you all for your work on thi=
s.
>
Seconded - thank you for flagging and catching this. These were my mista=
kes :(

> I assume that these fixes will be posted as a proper 3 patch
> patch-series (one patch per fix) once you are done testing?
>
Let me know if you are happy to propose the changes as a patch-series. I=
f you don't have time I can help and get these in ASAP as I was the orig=
inal culprit.

Happy to help out with testing too as I have access to HW. Let me know.

Mark

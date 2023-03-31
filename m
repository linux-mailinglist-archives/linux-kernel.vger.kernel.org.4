Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 987F66D283A
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 20:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233076AbjCaSy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 14:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233176AbjCaSyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 14:54:55 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87BA422210;
        Fri, 31 Mar 2023 11:54:54 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id EC17F5C00F0;
        Fri, 31 Mar 2023 14:54:53 -0400 (EDT)
Received: from imap52 ([10.202.2.102])
  by compute5.internal (MEProxy); Fri, 31 Mar 2023 14:54:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1680288893; x=1680375293; bh=Bizw76QOPWTwHoZq0VJkFTSvTLruV1nPT/l
        8ZQLfYdQ=; b=BzD+QIC89w1M/1gB5xNoUW/8EObc250cDikQ3RlswbDML9F1Wst
        RvLWzMXbtZ3T7S74OVksQQhmQVG8JdPULO5+T1t9ip3VPzQfeO6zcN5KRR9i7By5
        29Q6YvWEqIJ8i9R8H52gEd5TyVbHQN7+mXgAvzFp54Gzdjk7W01RqvVHQbMuAcCp
        XZdlmf/BqCjZ9UklbbP3BRKwtpxeo5PoWzHe1L71Kn9y39AYPzzuCluaJfPOGM3g
        Muo0JwwgkpWvPpjOLdNxFOky51j06myPVW/iQmtCsqBr0lKmQvu0uTWBmJrAvonq
        pZlFUYmlr3L/sLy3/2H1fKSey8J//2HcSbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1680288893; x=1680375293; bh=Bizw76QOPWTwHoZq0VJkFTSvTLruV1nPT/l
        8ZQLfYdQ=; b=QkmTxAfYbGfW+aWHYfu6k3c/GHX11yWudeP0Bui1X9cyo1ah+4d
        kO+DigKqGBeP0qHVmiounZzTKACftzcpyVLzgjr2POuFGsf6zmQ9JqU0Mq64ZHq1
        7jzxak9gxIcbTyT0R3aHyOaJsYitaRfW74Xscxmya611I3hqAExZcQX9nIeXephE
        Dt9gAcwc9lcfdYAyJzm6e1FI+18hbzVuVSXfylfrtggn+F/r2CofW5B3+Cx+Q/7R
        w/mVESnl8gMAZrmNzGQ4j/D1Ozf3UBGLwxAY3x/frNrOhO/MWgox/ygKW/H7/vO8
        FZg6YufDsGN51Hi9y/8/Wku5LisPofUFDmw==
X-ME-Sender: <xms:fSwnZPJoJ9cg3KnRiTWrONzeCw91w-s-IqE2M-YKeOigxXHIPtkWGg>
    <xme:fSwnZDI3H-faUymX-6EATSfSXeGi-9qc0OfwRIk-jkCBx_QfmTFBPKXPFUz2wZLAB
    y_tze3LGPECM3vsyzU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeiuddguddvlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedf
    ofgrrhhkucfrvggrrhhsohhnfdcuoehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvg
    gssgdrtggrqeenucggtffrrghtthgvrhhnpeefjeegvddugedvkeehvdfffeejhfeutdfh
    tdehheekffduvdfgteejgeejueefgfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhhpvggr
    rhhsohhnqdhlvghnohhvohesshhquhgvsggsrdgtrg
X-ME-Proxy: <xmx:fSwnZHvEWalJlPLDO6AL_7Ov5jNJJF7xoTA8-un8taM6DM70rNhc6Q>
    <xmx:fSwnZIaWBtIYq7iQskjKWGoLrZBtQmumhMvSNRl2-azGbnv1HabWgA>
    <xmx:fSwnZGY_1ot9xtJLzwX71Tlf8SzW3C7ZX8t3nHm8uvIuOy3uSFEzYw>
    <xmx:fSwnZLPu6OhaLX15OavEpvdja9sauK8KBl7dUDxL_M2d8tMjPk_eoQ>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 4D112C60093; Fri, 31 Mar 2023 14:54:53 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-238-g746678b8b6-fm-20230329.001-g746678b8
Mime-Version: 1.0
Message-Id: <1059aa55-9370-4b8d-8c6c-7fdfd9ac0c70@app.fastmail.com>
In-Reply-To: <b2d0461b-a32b-50e0-640d-9e789bb5da30@alu.unizg.hr>
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
 <9c142ac2-9340-4a9b-8541-99f613772340@app.fastmail.com>
 <4dc118c2-0dde-bd5e-ea41-427ed33e4545@alu.unizg.hr>
 <b06d1d1f-7cd5-4532-ac49-d449ef68bbcb@app.fastmail.com>
 <bccb52fa-e1c9-482c-a024-9a02179728b2@t-8ch.de>
 <b2d0461b-a32b-50e0-640d-9e789bb5da30@alu.unizg.hr>
Date:   Fri, 31 Mar 2023 14:54:33 -0400
From:   "Mark Pearson" <mpearson-lenovo@squebb.ca>
To:     "Mirsad Goran Todorovac" <mirsad.todorovac@alu.unizg.hr>,
        =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Cc:     "Hans de Goede" <hdegoede@redhat.com>,
        "Armin Wolf" <W_Armin@gmx.de>,
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

Hi all,

On Wed, Mar 29, 2023, at 5:50 PM, Mirsad Goran Todorovac wrote:
> On 29. 03. 2023. 21:21, Thomas Wei=C3=9Fschuh wrote:
>>=20
>> Mar 29, 2023 14:00:22 Mark Pearson <mpearson-lenovo@squebb.ca>:
>>=20
>>> Thanks Mirsad
>>>
>>> On Wed, Mar 29, 2023, at 2:49 PM, Mirsad Goran Todorovac wrote:
>>> <snip>
>>>>
>>>> Here is the patch proposal according to what Mark advised (using
>>>> different name for optitem):
>>>>
>>>> diff --git a/drivers/platform/x86/think-lmi.c
>>>> b/drivers/platform/x86/think-lmi.c
>>>> index c816646eb661..ab17254781c4 100644
>>>> --- a/drivers/platform/x86/think-lmi.c
>>>> +++ b/drivers/platform/x86/think-lmi.c
>>>> @@ -929,8 +929,10 @@ static ssize_t current_value_show(struct kobje=
ct
>>>> *kobj, struct kobj_attribute *a
>>>>
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* validate and sp=
lit from `item,value` -> `value` */
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 value =3D strpbrk(=
item, ",");
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!value || value =3D=3D it=
em || !strlen(value + 1))
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!value || value =3D=3D it=
em || !strlen(value + 1)) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 kfree(item);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D sysfs_emit=
(buf, "%s\n", value + 1);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kfree(item);
>>>> @@ -1380,7 +1382,6 @@ static struct tlmi_pwd_setting
>>>> *tlmi_create_auth(const char *pwd_type,
>>>>
>>>> =C2=A0 static int tlmi_analyze(void)
>>>> =C2=A0 {
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 acpi_status status;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int i, ret;
>>>>
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (wmi_has_guid(L=
ENOVO_SET_BIOS_SETTINGS_GUID) &&
>>>> @@ -1417,8 +1418,8 @@ static int tlmi_analyze(void)
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 char *p;
>>>>
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 tlmi_priv.setting[i] =3D NULL;
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 status =3D tlmi_setting(i, &item, LENOVO_BIOS_SETTING=
_GUID);
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 if (ACPI_FAILURE(status))
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 ret =3D tlmi_setting(i, &item, LENOVO_BIOS_SETTING_GU=
ID);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 if (ret)
>>>
>>> Really minor, but tweak to be this and save a line of code?
>>=20
>> This hunk is actually from another commit and should not be needed he=
re.
>>=20
>> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/c=
ommit/drivers/platform/x86/think-lmi.c?id=3Dda62908efe80f132f691efc2ace4=
ca67626de86b
>
> Thank you, Thomas,
>
> Indeed, my mistake.
>
> I have accepted Armin's suggestion to test if that patch closed the le=
ak, and I
> have just quoted it, never claiming authorship.
>
> I ought to apologise if I made confusion here.
>
> I was a bit euphoric about the leak being fixed, so forgive me for thi=
s blatant
> mistake. Of course, putting it here would cause a patch collision, so =
it was a
> stupid thing to do, and I would never do it in a formal patch submissi=
on ...
>
> Thanks, anyway for correction.
>
> Best regards,
> Mirsad
>

I have the patches ready to fix this issue - I just wanted to check that=
 I wouldn't be stepping on anybodies toes or if there is a protocol for =
doing this.
 - I will add Reported-by tag for Mirsad and Suggested-by for Armin.
 - I've identified Fixes tags for the two commits that caused the issue.
Let me know if there's anything else I should do - otherwise I'll get th=
em sent out ASAP.

Thanks
Mark

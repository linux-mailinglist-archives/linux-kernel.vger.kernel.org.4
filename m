Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4DFD6C1434
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 14:59:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231358AbjCTN7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 09:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbjCTN7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 09:59:07 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD59C136E5;
        Mon, 20 Mar 2023 06:59:04 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id A00C632008C0;
        Mon, 20 Mar 2023 09:59:03 -0400 (EDT)
Received: from imap52 ([10.202.2.102])
  by compute5.internal (MEProxy); Mon, 20 Mar 2023 09:59:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1679320743; x=1679407143; bh=RcFAA+JH7hHzquVrgWhPoE2JbQgsxayCGJV
        rJ9IKzK4=; b=pdyGtudY62tGvSoWAr8MYWqjMZN0Lz8ijJcuZbCzAkTJbM2Yzx7
        GQiPqc1FS4vaxeqOo/c4aObmk6hgyhtWG67BksE33LAngGUC4G0R6za+Go+CaYdL
        jfn9qGAibNlJAnH4xSm2raPMP0Prtx9Lgukmn7CNJuRpnb+OY5kjo2YA1lNg0Qfw
        FXDGLngm/X7gFJDYXS+HbWdFrZ2LFoEsDRM7p6uPZLAET0RW23sTNllxNxbiTrQr
        SbCkSkXIwxifZBY6t7/cKpqaSD0JZLmMOAcmglfuGAEQe9ku0w3vJHEho7uWegQ9
        5cQVmftqEwsZMThetAQ3UubRYdfeLTNd1Bg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1679320743; x=1679407143; bh=RcFAA+JH7hHzquVrgWhPoE2JbQgsxayCGJV
        rJ9IKzK4=; b=v1jv+d9JCCPF+V5tU5NYoca13K/ohd6CQ9dB/MSn/GgncchKb9b
        WRHPsNv2yfxwd76kNk/346PLPNkpKR71ZbmMfYcbodHQgyVnXok4gRdY488pZMmR
        YUEhjrylfxptJAM5DRgF8BqmpDGez7xejufBbtR/n/6dFNuRO/I18QmemzTrJCyv
        OtDMRhaJ3IeFK7QLQqWkiIfex4xXDeuzTTCSUS2cAnMkiNV4vX07XM0uLfbnbTry
        H5IbJn/8PXbK+n1XKSDdAEHsYWnaZbJCY1xZQCuE4PBp7Ub8qcWMlxU0DVTqxgK7
        E4UoVb9wrlMBGyf9WHMXU5jAcacwrPFOIwg==
X-ME-Sender: <xms:pmYYZL5Hmx8D_ZstQUoC8cOfzvUnzLbAjj6n02NeXvtONMT-3fw9YQ>
    <xme:pmYYZA5csCZZ1BxcJIzzahfusDWf5paTV0f9rm2m3lZDqohkLXzBTao69bkjUqxNs
    Ye9KseumyIgXGyZjAU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdefkedgheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfo
    rghrkhcurfgvrghrshhonhdfuceomhhpvggrrhhsohhnqdhlvghnohhvohesshhquhgvsg
    gsrdgtrgeqnecuggftrfgrthhtvghrnhepfeejgedvudegvdekhedvffefjefhuedthfdt
    heehkeffuddvgfetjeegjeeufefgnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmphgvrghr
    shhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggr
X-ME-Proxy: <xmx:pmYYZCceFORcq38em0H_Pv2bOrUShdhKxyRoMPXa3QZx53PjoQtd4w>
    <xmx:pmYYZMJMfxJn5Wr9uoD1sBd8qdiOl2H1GaBqgc-8XyYFni3sdmO_Vg>
    <xmx:pmYYZPK-RXqN0yieOOF5WS4JvSVrhX130l-svH6vbXTX6inFUYIg0g>
    <xmx:p2YYZFjCwiwl5fiBlcBqirz35TX3h8l0ZIUmJ7_v19w-7zsOGNNwdA>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 801D2C60091; Mon, 20 Mar 2023 09:59:02 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-221-gec32977366-fm-20230306.001-gec329773
Mime-Version: 1.0
Message-Id: <b8c775a1-0934-4d6b-ab13-bbccc2be50c7@app.fastmail.com>
In-Reply-To: <087797f9-9303-cbf2-dcdc-c78a10f92118@redhat.com>
References: <mpearson-lenovo@squebb.ca>
 <20230320003221.561750-1-mpearson-lenovo@squebb.ca>
 <8b6dd11e-f166-37e4-8ed4-f92b94b3a7ac@redhat.com>
 <087797f9-9303-cbf2-dcdc-c78a10f92118@redhat.com>
Date:   Mon, 20 Mar 2023 09:58:42 -0400
From:   "Mark Pearson" <mpearson-lenovo@squebb.ca>
To:     "Hans de Goede" <hdegoede@redhat.com>,
        =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc:     "markgross@kernel.org" <markgross@kernel.org>,
        "Mark Pearson" <markpearson@lenovo.com>,
        =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
        =?UTF-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>,
        linux-kernel@vger.kernel.org,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>
Subject: Re: [PATCH v4 1/4] platform/x86: think-lmi: add missing type attribute
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, Mar 20, 2023, at 9:57 AM, Hans de Goede wrote:
> Hi,
>
> On 3/20/23 14:56, Hans de Goede wrote:
>> Hi Mark,
>>=20
>> It seems that while adding linux-kernel@vger.kernel.org you have drop=
ped
>> platform-driver-x86@vger.kernel.org. For future patches please Cc bot=
h.
>>=20
>> platform-driver-x86@vger.kernel.org needs to be Cc-ed for patches
>> to show up in patchwork:
>> https://patchwork.kernel.org/project/platform-driver-x86/list/
>>=20
>> Which I use as my primary means of tracking which patches I need
>> to review / merge (note no need to resend this series I have it
>> on my radar).
>>=20
>> More importantly you seem to not have Cc-ed
>> Thomas Wei=C3=9Fschuh on this version ?
>
> Never mind, I just noticed that Thomas has 2 email addresses
> and you did Cc their other address...

Yep - and no idea how I missed pdx86 mailing list....must have been a co=
py paste error :( Sorry - not deliberate.

Mark

>
> Regards,
>
> Hans
>
>
>
>> On 3/20/23 01:32, Mark Pearson wrote:
>>> This driver was missing the mandatory type attribute...oops.
>>>
>>> Add it in along with logic to determine whether the attribute is an
>>> enumeration type or a string by parsing the possible_values attribut=
e.
>>>
>>> Upstream bug https://bugzilla.kernel.org/show_bug.cgi?id=3D216460
>>>
>>> Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
>>> ---
>>> Changes in v4:
>>>  - Unchanged. Sending to linux-kernel mailing list as recommended
>>> Changes in v3:
>>>  - Rebased on latest pdx86, review_hans branch
>>> Changes in v2:=20
>>>  - Simplify the code and move type determination into show function
>>>  - Don't use Fixes with URL in commit info
>>>
>>>  drivers/platform/x86/think-lmi.c | 17 +++++++++++++++++
>>>  1 file changed, 17 insertions(+)
>>>
>>> diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86=
/think-lmi.c
>>> index cc66f7cbccf2..a765bf8c27d8 100644
>>> --- a/drivers/platform/x86/think-lmi.c
>>> +++ b/drivers/platform/x86/think-lmi.c
>>> @@ -947,6 +947,20 @@ static ssize_t possible_values_show(struct kobj=
ect *kobj, struct kobj_attribute
>>>  	return sysfs_emit(buf, "%s\n", setting->possible_values);
>>>  }
>>> =20
>>> +static ssize_t type_show(struct kobject *kobj, struct kobj_attribut=
e *attr,
>>> +		char *buf)
>>> +{
>>> +	struct tlmi_attr_setting *setting =3D to_tlmi_attr_setting(kobj);
>>> +
>>> +	if (setting->possible_values) {
>>> +		/* Figure out what setting type is as BIOS does not return this */
>>> +		if (strchr(setting->possible_values, ','))
>>> +			return sysfs_emit(buf, "enumeration\n");
>>> +	}
>>> +	/* Anything else is going to be a string */
>>> +	return sysfs_emit(buf, "string\n");
>>> +}
>>> +
>>>  static ssize_t current_value_store(struct kobject *kobj,
>>>  		struct kobj_attribute *attr,
>>>  		const char *buf, size_t count)
>>> @@ -1036,10 +1050,13 @@ static struct kobj_attribute attr_possible_v=
alues =3D __ATTR_RO(possible_values);
>>> =20
>>>  static struct kobj_attribute attr_current_val =3D __ATTR_RW_MODE(cu=
rrent_value, 0600);
>>> =20
>>> +static struct kobj_attribute attr_type =3D __ATTR_RO(type);
>>> +
>>>  static struct attribute *tlmi_attrs[] =3D {
>>>  	&attr_displ_name.attr,
>>>  	&attr_current_val.attr,
>>>  	&attr_possible_values.attr,
>>> +	&attr_type.attr,
>>>  	NULL
>>>  };
>>>

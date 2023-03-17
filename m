Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4696BEA39
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 14:38:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbjCQNiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 09:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjCQNiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 09:38:12 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D123DC97D9;
        Fri, 17 Mar 2023 06:37:51 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id E654D3200917;
        Fri, 17 Mar 2023 09:37:50 -0400 (EDT)
Received: from imap52 ([10.202.2.102])
  by compute5.internal (MEProxy); Fri, 17 Mar 2023 09:37:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1679060270; x=1679146670; bh=Qjjn2kuuO3ncKAaMCKVx4y8KDMy9CPpZX4b
        Mcqf7GVs=; b=nV4u4DyzAjUxvlg2Hg1H493wLcsFSo/erbs+DT8tVJvx2KDy6Wk
        T5NrY8KfOgROgdn5tbbvugTcqWD8uEZGU6t6HxPEigAaiW0YvQ3i+FJjg16gl+hv
        uxJ/NQ7ka4KVp1bGgpZeUaJIeaX3Ih9LdFPzdI4Le/AhQM0FLK4iQTpQCn64COEJ
        faIQGtvVUWV/1YVPfo1C8x4j+IwrpTS1PPE9jKlelZ8VnCFfbOEX1ySiRaEr/7tS
        dAnTkKqQPjIql+CpcNUen57HwhhwWWmOn7wkPsdiU5aRBsPE0eY93AGdc8vS2VZD
        kGj6DkLwmYbOvBu1GUTAv1ZZw2khKQ5aQeA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1679060270; x=1679146670; bh=Qjjn2kuuO3ncKAaMCKVx4y8KDMy9CPpZX4b
        Mcqf7GVs=; b=kjwPdJYQllpi86HB3CYpaPcFzkw/G7WyYYDRgfHe/hB+wLZxnJA
        keBXYRzwAdSpbz8VIaAm6PC0g5Iu5bAUuGFMXQgv7priOPYnmQP5t/4k4/ITD41+
        qkvLmB7VhNSu3cKSTbq1zeQEZl51Fy0iO0eyVyNFwgKVjP6i109sBGOY9dmgMMcs
        5fpitqgLK4gRTeBh3/0YVxnTBbxbJOHtaG7Zfj8pjgOULp1lu2Cz/3yHR2i7/BF1
        pIvWToTnmtUapqtJ0/mtfIlBi2w7YrgZgip9+5VckQVJuBtoUTHVJ12gIEIvNKZX
        OWX2oT7SBgSDFqqn33xN2euuhenvCCU0NyQ==
X-ME-Sender: <xms:Lm0UZEbXm6KBv4EQbmhbS9dzEmpdoXwbqv8WX5wn-xAOm8G-fed4bQ>
    <xme:Lm0UZPaoQbCpnCs0jLcbpdcvMKgC7XYivyFu5PkHjQoGkLF_zYzJUg9ZfXf5r1m7U
    NVJHOUdQ33a2xXKpik>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdefvddgheefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfo
    rghrkhcurfgvrghrshhonhdfuceomhhpvggrrhhsohhnqdhlvghnohhvohesshhquhgvsg
    gsrdgtrgeqnecuggftrfgrthhtvghrnhepfeejgedvudegvdekhedvffefjefhuedthfdt
    heehkeffuddvgfetjeegjeeufefgnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenuc
    evlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehmphgvrghr
    shhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggr
X-ME-Proxy: <xmx:Lm0UZO9M6hfgz2Tw8WcV-0Lqu49jyYe1dI34CSWL7rirkmvPn9qNPw>
    <xmx:Lm0UZOrnGCOeg_86MkZRvIE-X-F_xRDYvTayNnw9aGQpj1m760jOEA>
    <xmx:Lm0UZPq-8kW3KKa0Yk4Fj9TwznAzu1zuXirU5X2lkDR7qN9FF91mqQ>
    <xmx:Lm0UZOXCDdJlVpokXuY15ksLwMsDsuH9fj-NjeGrCo3JIWBy5gZc-Q>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 2EE87C60093; Fri, 17 Mar 2023 09:37:50 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-221-gec32977366-fm-20230306.001-gec329773
Mime-Version: 1.0
Message-Id: <dd77e7df-022f-4299-8827-4622c1d2d1f3@app.fastmail.com>
In-Reply-To: <1af9e9c5-681b-483e-620f-c1866fafd6db@redhat.com>
References: <20230314-think-lmi-sysfs_ops-v1-1-9d4f1cf9caec@weissschuh.net>
 <1af9e9c5-681b-483e-620f-c1866fafd6db@redhat.com>
Date:   Fri, 17 Mar 2023 09:37:19 -0400
From:   "Mark Pearson" <mpearson-lenovo@squebb.ca>
To:     "Hans de Goede" <hdegoede@redhat.com>,
        =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        "Mark Pearson" <markpearson@lenovo.com>,
        "markgross@kernel.org" <markgross@kernel.org>
Cc:     "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] platform/x86: think-lmi: Remove custom kobject sysfs_ops
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Thomas,

Tested on a couple of my platforms - all looked good.

Tested-by: mpearson-lenovo@squebb.ca

Mark

On Thu, Mar 16, 2023, at 10:44 AM, Hans de Goede wrote:
> Hi,
>
> On 3/14/23 01:07, Thomas Wei=C3=9Fschuh wrote:
>> think-lmi defines its own sysfs_ops that are identical to the standard
>> kobj_sysfs_ops. Use the standard definitions.
>>=20
>> Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
>
> Thank you for your patch, I've applied this patch to my review-hans=20
> branch:
> https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers=
-x86.git/log/?h=3Dreview-hans
>
> Note it will show up in my review-hans branch once I've pushed my
> local branch there, which might take a while.
>
> Once I've run some tests on this branch the patches there will be
> added to the platform-drivers-x86/for-next branch and eventually
> will be included in the pdx86 pull-request to Linus for the next
> merge-window.
>
> Regards,
>
> Hans
>
>
>> ---
>>=20
>> This has only been compile-tested.
>> ---
>>  drivers/platform/x86/think-lmi.c | 31 ++-----------------------------
>>  1 file changed, 2 insertions(+), 29 deletions(-)
>>=20
>> diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/=
think-lmi.c
>> index 86b33b74519b..2b5ae68ffce8 100644
>> --- a/drivers/platform/x86/think-lmi.c
>> +++ b/drivers/platform/x86/think-lmi.c
>> @@ -1047,33 +1047,6 @@ static const struct attribute_group tlmi_attr_=
group =3D {
>>  	.attrs =3D tlmi_attrs,
>>  };
>> =20
>> -static ssize_t tlmi_attr_show(struct kobject *kobj, struct attribute=
 *attr,
>> -				    char *buf)
>> -{
>> -	struct kobj_attribute *kattr;
>> -
>> -	kattr =3D container_of(attr, struct kobj_attribute, attr);
>> -	if (kattr->show)
>> -		return kattr->show(kobj, kattr, buf);
>> -	return -EIO;
>> -}
>> -
>> -static ssize_t tlmi_attr_store(struct kobject *kobj, struct attribut=
e *attr,
>> -				     const char *buf, size_t count)
>> -{
>> -	struct kobj_attribute *kattr;
>> -
>> -	kattr =3D container_of(attr, struct kobj_attribute, attr);
>> -	if (kattr->store)
>> -		return kattr->store(kobj, kattr, buf, count);
>> -	return -EIO;
>> -}
>> -
>> -static const struct sysfs_ops tlmi_kobj_sysfs_ops =3D {
>> -	.show	=3D tlmi_attr_show,
>> -	.store	=3D tlmi_attr_store,
>> -};
>> -
>>  static void tlmi_attr_setting_release(struct kobject *kobj)
>>  {
>>  	struct tlmi_attr_setting *setting =3D to_tlmi_attr_setting(kobj);
>> @@ -1091,12 +1064,12 @@ static void tlmi_pwd_setting_release(struct k=
object *kobj)
>> =20
>>  static const struct kobj_type tlmi_attr_setting_ktype =3D {
>>  	.release        =3D &tlmi_attr_setting_release,
>> -	.sysfs_ops	=3D &tlmi_kobj_sysfs_ops,
>> +	.sysfs_ops	=3D &kobj_sysfs_ops,
>>  };
>> =20
>>  static const struct kobj_type tlmi_pwd_setting_ktype =3D {
>>  	.release        =3D &tlmi_pwd_setting_release,
>> -	.sysfs_ops	=3D &tlmi_kobj_sysfs_ops,
>> +	.sysfs_ops	=3D &kobj_sysfs_ops,
>>  };
>> =20
>>  static ssize_t pending_reboot_show(struct kobject *kobj, struct kobj=
_attribute *attr,
>>=20
>> ---
>> base-commit: eeac8ede17557680855031c6f305ece2378af326
>> change-id: 20230314-think-lmi-sysfs_ops-e849a18299bb
>>=20
>> Best regards,

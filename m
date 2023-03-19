Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D161A6C02E4
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 16:45:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbjCSPp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 11:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjCSPpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 11:45:25 -0400
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.161])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CDFA193C1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 08:45:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1679240705; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=lYES3QlF3QmrXZYcdoDCPhNWQdSqgrKzVJbPyPgMJkqa+9Fnmd/EC3fBFiuwkwTrgo
    brVJOQlxo+JYx6HDas+DlXD9AxPpohDZdg8b4+8a8k02BC+aKGbgv2PswgnbYB0gb3TD
    xZK9yXU63j36KI//Vi7rl2r00m5oI+/WXYngYQY9FHT33Yjge2sRAFTdxMD6+T1E4do4
    LcxxcQDdJWkYnNGu5F1ASAFzYfwLK+PR+ReF5fHoNUYLA84EBUQ1AJ/rX/3pndsrSriz
    OUXyslMEbJZyhBCfepF5okiOf2EFHOvZFEPCQ2unk+zrTXt/KrYCrJ2CfWTLMMMEi1dj
    TrPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1679240705;
    s=strato-dkim-0002; d=strato.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=9wQs119PXqsvkmTqga6J7BT0j7oJCOBDr6Npuah27t4=;
    b=HlSFXCMUHYA5Bj4kE9RrwHKxhJ/h/pLnyFglNZYNqXs2367KtjxdjybE8UxYcHnm6c
    HG4U2FP5nVznDQTJTC5XhujEnLyMlJcj1yOSvPxBR7+Ma8kXweV9t1pVn/sTI9k5R1pj
    iDpmH7odbPUgwh+CVwwYIxSV/wNlITml8iIFprUyd1qXDsEvvpmBhHD8/alNdozAeNDP
    yk1swfv8HM4pmJgHqfeJTvRwbyD5Q2UrhDFbOjeHCP52wqtZf1MHRNIBMC9Oj7fvbQ7b
    KuBml7UWrNiFZ9+rIand82i3mJxS4KPOCCmUwTdjHIVIcs9xycQKT0Ps0/Mi2eP9eEf+
    zb4w==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1679240704;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=9wQs119PXqsvkmTqga6J7BT0j7oJCOBDr6Npuah27t4=;
    b=W1DndjcWUKeGrKdri+7ffA6mu+nzNh9OnRN3fbFlrHmqPGBaCT2TTNWHVzZUB1CbE8
    OaCIVHIgwU5TuhUFhN8hG/gRtumrZtAQksPoTv0KgHHA/Jtx76IbCZGVAaOKJfzW7W4s
    CHwsTXsftVZWBqBIW0AvecJZDAApNZm+3JPmxoz6nDEBjMOpgH9uPcaVtmPTwIsBpxBG
    jIcBS897DDoJfA7xG/QPU3QiR8TYRUgk6igVHPHJ/ZWC92TPU1wanx60deICJE+/aINq
    ifxUJdgAwb1VRc7B5R3eDU1G3XIjNDD2lNIMhlrG592omJ1QK+/AEcGtAWpMQkqPJ1he
    4Yvw==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj5Apz9PSN6LgsXcGZjDY="
Received: from imac.fritz.box
    by smtp.strato.de (RZmta 49.3.1 DYNA|AUTH)
    with ESMTPSA id R24ce1z2JFj4Cbc
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
    Sun, 19 Mar 2023 16:45:04 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.21\))
Subject: Re: [PATCH] iio: adc: palmas_gpadc: fix NULL dereference on rmmod
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20230319153203.54a40887@jic23-huawei>
Date:   Sun, 19 Mar 2023 16:45:03 +0100
Cc:     =?utf-8?Q?Patrik_Dahlstr=C3=B6m?= <risca@dalakolonin.se>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org,
        linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>,
        Pradeep Goudagunta <pgoudagunta@nvidia.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <5EE49843-DF4D-427F-A628-80D657D643E6@goldelico.com>
References: <20230313205029.1881745-1-risca@dalakolonin.se>
 <20230318163033.161d6fd5@jic23-huawei>
 <20230318192253.GB3605556@dalakolonin.se>
 <20230319153203.54a40887@jic23-huawei>
To:     Jonathan Cameron <jic23@kernel.org>
X-Mailer: Apple Mail (2.3445.104.21)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

> Am 19.03.2023 um 16:32 schrieb Jonathan Cameron <jic23@kernel.org>:
>=20
> On Sat, 18 Mar 2023 20:22:53 +0100
> Patrik Dahlstr=C3=B6m <risca@dalakolonin.se> wrote:
>=20
>> On Sat, Mar 18, 2023 at 04:30:33PM +0000, Jonathan Cameron wrote:
>>> On Mon, 13 Mar 2023 21:50:29 +0100
>>> Patrik Dahlstr=C3=B6m <risca@dalakolonin.se> wrote:
>>>=20
>>>> Calling dev_to_iio_dev() on a platform device pointer is undefined =
and
>>>> will make adc NULL.
>>>>=20
>>>> Signed-off-by: Patrik Dahlstr=C3=B6m <risca@dalakolonin.se> =20
>>>=20
>>> Hi Patrik,
>>>=20
>>> Looks good so applied to the fixes-togreg branch of iio.git.
>>>=20
>>> Whilst we are here, this would be a trivial driver to take fully =
device
>>> managed.  The only slightly messy bit is that it would need
>>> a devm_add_action_or_reset() + custom callback to handle the
>>> device_wakeup_enable().
>>>=20
>>> On the off chance you can test it I'll send a patch in a few mins.
>>> Note that will depend on this one going up stream first and that
>>> I haven't done more than build test it. =20
>> I got the patch and it looks good, but it will take a few days before =
I
>> have the time to test it.
>>=20
>> I have some more patches coming for this driver to configure the adc
>> thresholds from userspace,

Yes, that is a useful feature.

>> employing the iio channel event subsystem, but
>> they need a bit more work. In particular, to ensure backwards =
compatibility
>> with the adc_wakeupX_data platform data. However, I don't see this =
platform
>> data being used by anyone.
>> How important is it to retain support for adc_wakeupX_data?
>=20
> It's a somewhat unusual feature, so I doubt it was implemented without =
someone
> needing it.  However as you observe there is no upstream user.
>=20
> As it is causing you problems, I'd just rip out the =
palmas_adc_platform_data
> completely and see if anyone objects.  You can do that as a standalone =
patch
> prior to posting your events stuff if you like.  Or hopefully
> H. Nikolaus Schaller might be able to give us some background on why
> that feature is there but not used.

I also have no idea.

The original author was Pradeep Goudagunta <pgoudagunta@nvidia.com> and =
I just copied it from

	=
https://android.googlesource.com/kernel/tegra/+/aaabb2e045f31e5a970109ffda=
ae900dd403d17e/drivers/staging/iio/adc/palmas_gpadc.c

polished the code and made it compile & work some years ago.

So it may have been useful in a some Tegra Android kernel from 2013. =
Maybe it is
for special power management (at least that is how I interpret the =
"wakeup").

But I found some hint which device it is good for:

	=
https://lore.kernel.org/all/1379509642-19227-2-git-send-email-ldewangan@nv=
idia.com/T/

"PALMAS PMIC is used on Dalmore platform."

	=
https://docs.nvidia.com/gameworks/content/devices/dalmore_devkit_main.htm

And there seems to be an upstream DTS: =
arch/arm/boot/dts/tegra114-dalmore.dts
but without gpadc support. That is quite common that upstream DTS are =
incomplete
so we can't deduce that there are no users of a feature.

BR,
Nikolaus

>=20
>>>=20
>>> Thanks,
>>>=20
>>> Jonathan =20
>>=20
>> Thank you for going the extra mile :)
>=20
> No problem.  I jumped on the opportunity to get it tested - takes way =
longer
> than writing a little patch like that ;)
>=20
> Jonathan
>=20
>>>=20
>>>=20
>>>> ---
>>>> drivers/iio/adc/palmas_gpadc.c | 2 +-
>>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>>>=20
>>>> diff --git a/drivers/iio/adc/palmas_gpadc.c =
b/drivers/iio/adc/palmas_gpadc.c
>>>> index 61e80bf3d05e..6db6f3bc768a 100644
>>>> --- a/drivers/iio/adc/palmas_gpadc.c
>>>> +++ b/drivers/iio/adc/palmas_gpadc.c
>>>> @@ -638,7 +638,7 @@ static int palmas_gpadc_probe(struct =
platform_device *pdev)
>>>>=20
>>>> static int palmas_gpadc_remove(struct platform_device *pdev)
>>>> {
>>>> -	struct iio_dev *indio_dev =3D dev_to_iio_dev(&pdev->dev);
>>>> +	struct iio_dev *indio_dev =3D dev_get_drvdata(&pdev->dev);
>>>> 	struct palmas_gpadc *adc =3D iio_priv(indio_dev);
>>>>=20
>>>> 	if (adc->wakeup1_enable || adc->wakeup2_enable) =20
>>>=20
>=20


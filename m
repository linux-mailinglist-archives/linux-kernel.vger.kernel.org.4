Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 611FD5EA49D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 13:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238893AbiIZLsQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 07:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238456AbiIZLpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 07:45:52 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D43674BB0;
        Mon, 26 Sep 2022 03:47:26 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 38A425C00EE;
        Mon, 26 Sep 2022 06:46:21 -0400 (EDT)
Received: from imap47 ([10.202.2.97])
  by compute2.internal (MEProxy); Mon, 26 Sep 2022 06:46:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=cc:cc:content-transfer-encoding:content-type:date:date:from
        :from:in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1664189181; x=
        1664275581; bh=xG1RrAvxILnVKM/HGf/WpAaQQFDiliy1vQfp8uerkes=; b=c
        Krrc6XCOduvSe0NiILOQo9COvzVPKyqin8iJpRyJIDV21yXv6kwY3HBeMCQNKTR3
        KtjAm21aiUOhlZnN0LJCISeujQ+aVHc8Dcx1y5eGRtEADkpArB31AYpy1MKGPeo6
        xlF7rocMh/XhYUuTakNtx8v+htQup7S0R9t0MuGPT+nVE9YE075TkSMXNwVMbvqy
        QMYNhpgXCsE0fz5YqoHWvT727AY3BfHZxyUKJzOo0fOdbumCpNEUQPJH1UKsWhVA
        JuLaRIkZXe7b3HulTnd71+NFHVEZl+WF3/197sbE2gvvNqPFkTc0xwvPBgjL9Fdj
        AWHYak4VkBOpWbjHxqtjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1664189181; x=
        1664275581; bh=xG1RrAvxILnVKM/HGf/WpAaQQFDiliy1vQfp8uerkes=; b=V
        3q3SQht4hnlAaN/LjuD/7JawNMAMo9N2vs2JcJi3TDiWCVH7KnjlS/YePc0+NIyW
        +2lBmp8wluqDNESNhzC/ldt0rWwTLgFsjupW+uIU+K8tC4vlKbl39agV26aNNF2v
        QPTvJAXDkRNmfFTIiesZRzl9Rr2JNBU2h8NfriBevUKDS/OVh+Pkt2GSxA2nt+8v
        KIc9vAWWlNvxSs3vQdd8hHFzt+cvML+IJDKQTG+Qd7Zax0AP7Utlo8S7J6/6qe9L
        fh0OGLRKPDENE/Ati4+4AoSAlIDIcczUi5j3wPsTfySYSqjs1LqnvIGZGIYxgBZu
        xFc1gqX56O7QOKzhlr5Sg==
X-ME-Sender: <xms:_IIxYzj4aOxzqBw6kkIH2DIk0OrByu_KVNsaiv1vOw_HkSgaqc87-g>
    <xme:_IIxYwAcSqOmIdId2ar3V4SCoNgu0_luHvDjO0mwvDelk8RWPQYePlU8WF2eBhNlk
    ahX931q8Y8JStoYoLs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeegvddgfeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfu
    vhgvnhcurfgvthgvrhdfuceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtf
    frrghtthgvrhhnpeegffdtgfdtlefhhfdujeevheekgfdujeegudevteevudefleefjeel
    tefhjeehleenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshhvvghnsehsvhgvnhhpvghtvghr
    rdguvghv
X-ME-Proxy: <xmx:_IIxYzFEFuN2yfR_g_eQEyHPkA3Ty6FQXzbPwIbdX7pOlZBTEEKTWw>
    <xmx:_IIxYwR7zlEa6WIez3km9eW4oR04jt4P7C85SWfPJG-1nitLDvebjA>
    <xmx:_IIxYwy9Y3OB3czY4YN8dqYkexEEEumvZ8kK4U5Ar69MxIm4s3k9_A>
    <xmx:_YIxY3nbZP1tD-vQhDffl9_BW31y3rZho0m9_4OUBq0z35mjb3td-Q>
Feedback-ID: i51094778:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id B56A5A6007C; Mon, 26 Sep 2022 06:46:20 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-935-ge4ccd4c47b-fm-20220914.001-ge4ccd4c4
Mime-Version: 1.0
Message-Id: <5748396a-fe0b-413c-b8ac-d24d959091bc@app.fastmail.com>
In-Reply-To: <331b5644-e204-8915-cd08-bd4fabbfcb49@gmail.com>
References: <20220403164907.662860-1-andrew.smirnov@gmail.com>
 <Yyw0K/hcTZ02UP+A@smile.fi.intel.com>
 <691c3073-5105-9a2b-e6f2-ea0a4b8aaea8@gmail.com>
 <CAHQ1cqGFFJ0gRbdN+DH0iJhcKc=eee8uNoDyfHEy00-CMgstiw@mail.gmail.com>
 <Yy3iAHLlS2emAmWn@smile.fi.intel.com>
 <CAHQ1cqHWZeVHp6QmsDw5bjVq=nknRVG5iETB0n4fMMLWginbLg@mail.gmail.com>
 <966ef528-455c-5180-fc63-ea77cb933af1@gmail.com>
 <331b5644-e204-8915-cd08-bd4fabbfcb49@gmail.com>
Date:   Mon, 26 Sep 2022 12:45:17 +0200
From:   "Sven Peter" <sven@svenpeter.dev>
To:     "Ferry Toth" <fntoth@gmail.com>,
        "Andrey Smirnov" <andrew.smirnov@gmail.com>,
        "Andy Shevchenko" <andriy.shevchenko@intel.com>
Cc:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Felipe Balbi" <balbi@kernel.org>,
        "Thinh Nguyen" <thinhn@synopsys.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Thinh Nguyen" <Thinh.Nguyen@synopsys.com>
Subject: Re: [PATCH v4] usb: dwc3: Don't switch OTG -> peripheral if extcon is present
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, Sep 25, 2022, at 21:21, Ferry Toth wrote:
> Hi,
>
> Promising results below.
>
> Op 24-09-2022 om 23:29 schreef Ferry Toth:
>> Hi,
>>
>> One more test
>>
>> Op 23-09-2022 om 20:23 schreef Andrey Smirnov:
>>> On Fri, Sep 23, 2022 at 9:42 AM Andy Shevchenko
>>> <andriy.shevchenko@intel.com> wrote:
>>>> On Thu, Sep 22, 2022 at 04:32:55PM -0700, Andrey Smirnov wrote:
>>>>> On Thu, Sep 22, 2022 at 3:23 AM Ferry Toth <fntoth@gmail.com> wrot=
e:
>>>>>> On 22-09-2022 12:08, Andy Shevchenko wrote:
>>>>>> On Sun, Apr 03, 2022 at 09:49:07AM -0700, Andrey Smirnov wrote:
>>>> FYI: For now I sent a revert, but if we got a solution quicker we=20
>>>> always
>>>> can choose the course of actions.
>>>>
>>> I think we have another problem. This patch happened in parallel to =
mine
>>>
>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/c=
ommit/?h=3Dv6.0-rc6&id=3Dab7aa2866d295438dc60522f85c5421c6b4f1507=20
>>>
>>>
>>> so my changes didn't have that fix in mind and I think your revert
>>> will not preserve that fix. Can you update your revert to take care =
of
>>> that too, please?
>>>
>>> I'm really confused how the above commit could be followed up by:
>>>
>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/c=
ommit/drivers/usb/dwc3/drd.c?h=3Dv6.0-rc6&id=3D0f01017191384e3962fa31520=
a9fd9846c3d352f=20
>>>
>>>
>>> the diffs in dwc3_drd_init seem contradictory
>>>
>>>>>> If the extcon device exists, get the mode from the extcon device.=
 If
>>>>>> the controller is DRD and the driver is unable to determine the m=
ode,
>>>>>> only then default the dr_mode to USB_DR_MODE_PERIPHERAL.
>>>>>>
>>>>>> According to Ferry (Cc'ed) this broke Intel Merrifield platform.=20
>>>>>> Ferry, can you
>>>>>> share bisect log?
>>>>>>
>>>>>> I can but not right now. But what I did was bisect between 5.18.0=20
>>>>>> (good) and 5.19.0 (bad) then when I got near the culprit (~20=20
>>>>>> remaining) based on the commit message I tried=20
>>>>>> 0f01017191384e3962fa31520a9fd9846c3d352f "usb: dwc3: Don't switch=20
>>>>>> OTG -> peripheral if extcon is present" (bad) and commit before=20
>>>>>> that (good).
>>>>>>
>>>>>> The effect of the patch is that on Merrifield (I tested with Inte=
l=20
>>>>>> Edison Arduino board which has a HW switch to select between host=20
>>>>>> and device mode) device mode works but in host mode USB is=20
>>>>>> completely not working.
>>>>>>
>>>>>> Currently on host mode - when working - superfluous error message=
s=20
>>>>>> from tusb1210 appear. When host mode is not working there are no=20
>>>>>> tusb1210 messages in the logs / on the console at all. Seemingly=20
>>>>>> tusb1210 is not probed, which points in the direction of a=20
>>>>>> relation to extcon.
>>>>>>
>>>>>> Taking into account the late cycle, I would like to revert the=20
>>>>>> change. And
>>>>>> Ferry and I would help to test any other (non-regressive) approac=
h).
>>>>>>
>>>>>> I have not yet tested if a simple revert fixes the problem but=20
>>>>>> will tonight.
>>>>>>
>>>>>>
>>>>>> I would be happy to test other approaches too.
>>>>>
>>>>> It's a bit hard for me to suggest an alternative approach without
>>>>> knowing how things are breaking in this case. I'd love to order on=
e of
>>>>> those boards to repro and fix this on my end, but it looks like th=
is
>>>>> HW is EOLed and out of stock in most places. If you guys know how =
to
>>>>> get my hands on those boards I'm all ears.
>>>> There are still some second hand Intel Edison boards flying around
>>>> (but maybe cost a bit more than expected) and there are also
>>>> Dell Venue 7 3740 tablets based on the same platform/SoC. The latter
>>>> option though requires more actions in order something to be boot
>>>> there.
>>>>
>>> OK, I'll check e-bay just in case.
>>>
>>>> In any case, it's probably quicker to ask Ferry or me for testing.
>>>> (Although currently I have no access to the board to test OTG, it's
>>>> =C2=A0 remote device which I can only power on and off and it has a=
lways
>>>> =C2=A0 be in host mode.)
>>>>
>>>>> Barring that, Ferry can you dig more into this failure? E.g. is it=20
>>>>> this hunk
>>>>>
>>>>> @@ -85,7 +86,7 @@ static int dwc3_get_dr_mode(struct dwc3 *dwc)
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * mode. If the controller supports =
DRD but the=20
>>>>> dr_mode is not
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * specified or set to OTG, then set=
 the mode to=20
>>>>> peripheral.
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 if (mode =3D=3D USB_DR_MODE_OTG &&
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 if (mode =3D=3D USB_DR_MODE_OTG && !dwc->edev &&
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (!IS_ENABLED(CONF=
IG_USB_ROLE_SWITCH) ||
>>>>> !device_property_read_bool(dwc->dev, "usb-role-switch")) &&
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 !DWC3_VER_IS_PRIO=
R(DWC3, 330A))
>>>>> @@ -1632,6 +1633,51 @@ static void dwc3_check_params(struct dwc3 *=
dwc)
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>> =C2=A0 }
>>>>>
>>>>> that's problematic or moving
>>>> I think you wanted to revert only this line and test?
>>> Yes.
>>>
>>>>> =C2=A0 static int dwc3_probe(struct platform_device *pdev)
>>>>> =C2=A0 {
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct device=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *dev =3D &pdev->d=
ev;
>>>>> @@ -1744,6 +1790,13 @@ static int dwc3_probe(struct platform_devic=
e=20
>>>>> *pdev)
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto err2;
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>>
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dwc->edev =3D dwc3_get_extco=
n(dwc);
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (IS_ERR(dwc->edev)) {
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 ret =3D PTR_ERR(dwc->edev);
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 dev_err_probe(dwc->dev, ret, "failed to get=20
>>>>> extcon\n");
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 goto err3;
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>> +
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D dwc3_get_=
dr_mode(dwc);
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto err3;
>>>>>
>>>>> to happen earlier?
>>
>> I tried moving dwc3_get_extcon after dwc3_get_dr_mode like so::
>>
>> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
>> index 8c8e32651473..3bf370def546 100644
>> --- a/drivers/usb/dwc3/core.c
>> +++ b/drivers/usb/dwc3/core.c
>> @@ -1843,6 +1843,10 @@ static int dwc3_probe(struct platform_device=20
>> *pdev)
>> =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 goto err2;
>> =C2=A0=C2=A0=C2=A0=C2=A0 }
>>
>> +=C2=A0=C2=A0=C2=A0 ret =3D dwc3_get_dr_mode(dwc);
>> +=C2=A0=C2=A0=C2=A0 if (ret)
>> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 goto err3;
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0 dwc->edev =3D dwc3_get_extcon(dwc);
>> =C2=A0=C2=A0=C2=A0=C2=A0 if (IS_ERR(dwc->edev)) {
>> =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 ret =3D PTR_ERR(dwc->edev=
);
>> @@ -1850,10 +1854,6 @@ static int dwc3_probe(struct platform_device=20
>> *pdev)
>> =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 goto err3;
>> =C2=A0=C2=A0=C2=A0=C2=A0 }
>>
>> -=C2=A0=C2=A0=C2=A0 ret =3D dwc3_get_dr_mode(dwc);
>> -=C2=A0=C2=A0=C2=A0 if (ret)
>> -=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 goto err3;
>> -
>> =C2=A0=C2=A0=C2=A0=C2=A0 ret =3D dwc3_alloc_scratch_buffers(dwc);
>> =C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
>> =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 goto err3;
>
> After trying to understand the code a bit, I successfully tested the=20
> following move:
>
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index 8c8e32651473..4a38cff8cb16 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -1843,13 +1843,6 @@ static int dwc3_probe(struct platform_device *p=
dev)
>  =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 goto err2;
>  =C2=A0=C2=A0=C2=A0=C2=A0 }
>
> -=C2=A0=C2=A0=C2=A0 dwc->edev =3D dwc3_get_extcon(dwc);
> -=C2=A0=C2=A0=C2=A0 if (IS_ERR(dwc->edev)) {
> -=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 ret =3D PTR_ERR(dwc->edev);
> -=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 dev_err_probe(dwc->dev, ret, "f=
ailed to get extcon\n");
> -=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 goto err3;
> -=C2=A0=C2=A0=C2=A0 }
> -
>  =C2=A0=C2=A0=C2=A0=C2=A0 ret =3D dwc3_get_dr_mode(dwc);
>  =C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
>  =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 goto err3;
> @@ -1867,6 +1860,13 @@ static int dwc3_probe(struct platform_device *p=
dev)
>  =C2=A0=C2=A0=C2=A0=C2=A0 dwc3_check_params(dwc);
>  =C2=A0=C2=A0=C2=A0=C2=A0 dwc3_debugfs_init(dwc);
>
> +=C2=A0=C2=A0=C2=A0 dwc->edev =3D dwc3_get_extcon(dwc);
> +=C2=A0=C2=A0=C2=A0 if (IS_ERR(dwc->edev)) {
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 ret =3D PTR_ERR(dwc->edev);
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 dev_err_probe(dwc->dev, ret, "f=
ailed to get extcon\n");
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 goto err5;
> +=C2=A0=C2=A0=C2=A0 }
> +
>  =C2=A0=C2=A0=C2=A0=C2=A0 ret =3D dwc3_core_init_mode(dwc);
>  =C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
>  =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 goto err5;
>
> This moves dwc3_get_extcon() until after dwc3_core_init() but just=20
> before dwc3_core_init_mode(). AFAIU initially dwc3_get_extcon() was=20
> called from within dwc3_core_init_mode() but only for case=20
> USB_DR_MODE_OTG. So with this change order of events is more or less=20
> unchanged.
>
> Due to move I modified goto to err5, not sure if that is correct.

err5 is correct there, that failure path starts to clean up what dwc3_co=
re_init did.

>
> Thoughts? Can we get something like this in quick or should we revert =
first?

I don't know anything about that platform and following this thread is a=
 bit hard
for me since I lack context so this is a total guess: dwc3_core_init bri=
ngs up the
PHYs and also soft resets the core. Could any of these two things intera=
ct with your
extcon and somehow break it?


Sven

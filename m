Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 629D8698D78
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 07:58:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbjBPG6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 01:58:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjBPG6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 01:58:38 -0500
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C77C2DBCD;
        Wed, 15 Feb 2023 22:58:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1676530698; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=hthfDL44YXKR+IRSBeMk6k/NcDvOmLlxKj3Uf+30lv3ytJ3Jc5W07Cu+SmgQt3aLD/
    jT3V6yoJdiOJB/ZMCBlYZML0CtAv8ApT66gIneDnvWFh9da8VQyvt/hCWCkZeNlNE1Xo
    f7ARHzvOzwawtwQxlETFo2VfPdcNm3fPUk3aLObaMyLvlqXPzYoSrd1OGCzyMVoc/VVS
    QmqaiRnB3XhQnUwgxKjz3VRiP0JbApuUzbSMQiHNYIPDBE07Xktvd7o1dLvK6FdN9a+2
    9VaIfYQF53ADYPHUh/AJ1ZHOC8siPluu3RqPWqQipdvrJmoYg3DR0hykpl0+m00ULUJy
    cmIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1676530698;
    s=strato-dkim-0002; d=strato.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=ZBHlQFwAUfRBpUV+H1jo5cLO4/0meUShd8PmBjJei4E=;
    b=Z5jBQ13qIE253TEtSQzHAdpNVgpAwWRxoXP/EksLcZ0RfmwaaEYlMoOg7h9e/EHl+l
    TnNZoFH0v/e6xc8HiXL6iBSCbk63NAqoczpVhUVkfI9vsJ0xX6HPqnkavC8tuV5ocpSs
    RBdpPT9ACaV+aYhG9hNN2ydoZYt7byonxNNk68h426GhsYHglVuNSq4gTS1C7YrxR5wL
    Shf9w9Q7kTC9Wvkj/xlAjoPnwJMzyV61zMO6jt2QFuJPHGyxvifc5CRH14v9BpFfNggv
    AQXJDOkSaIVbBEp+WtjfwrUcyLcVlDsv77foZg648nx9OQGodRrbCYIb63hoaSxgCuO1
    sPhw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1676530698;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=ZBHlQFwAUfRBpUV+H1jo5cLO4/0meUShd8PmBjJei4E=;
    b=Gl9bgpaD8R6g2Srzg36t4SgyOz0mZtHSS35KaCmd8aHxpIiNeh+tub0jy+SdaBdCgO
    KUYs6pNZ0x4dj1YqrXDDAUOZ4nter4cRTG/mYN/T0WDer+FbFrX6UBjUozBaQccYyX8C
    RO2wCc82n2u1TjLCceZYxk9XHfESc73mgInb4PF3oRHKmusxZhtFtk8eZ9oOiCL6HoH3
    sR4bwUyC3bWAY36mVKaxQ/AympeFk+x5XMQIw7rVZ6cKMmPwD/ulrqacNZ29GR37y7Yz
    voW3NE9Rcy/ApKfON4BmikWb++Bqz6uR8b/AzNW741dzcq9ZBsIFl21MKZhXMPMCQNHl
    NGzg==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj5Apz9PSN6LgsXcGfq2U="
Received: from imac.fritz.box
    by smtp.strato.de (RZmta 49.3.0 DYNA|AUTH)
    with ESMTPSA id 326d57z1G6wHdzG
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
    Thu, 16 Feb 2023 07:58:17 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.21\))
Subject: Re: [RFC 0/3] Make WLAN and Bluetooth basically work for CI20
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <4485f880f7b41bdb833d1153682530cd4bc3ed94.camel@crapouillou.net>
Date:   Thu, 16 Feb 2023 07:58:16 +0100
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Riccardo Mottola <riccardo.mottola@libero.it>,
        Paul Boddie <paul@boddie.org.uk>,
        linux-mips <linux-mips@vger.kernel.org>,
        OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS 
        <devicetree@vger.kernel.org>,
        linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <809FC192-DBC6-45A7-AF91-A30179E6830C@goldelico.com>
References: <cover.1676482318.git.hns@goldelico.com>
 <e1f92dc94a3e3df7c4bb32b441802cb333ccb6db.camel@crapouillou.net>
 <B1706E39-202F-417C-A7A4-B07482B787B0@goldelico.com>
 <4485f880f7b41bdb833d1153682530cd4bc3ed94.camel@crapouillou.net>
To:     Paul Cercueil <paul@crapouillou.net>
X-Mailer: Apple Mail (2.3445.104.21)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

> Am 15.02.2023 um 22:19 schrieb Paul Cercueil <paul@crapouillou.net>:
>=20
> Hi Nikolaus,
>=20
> Le mercredi 15 f=C3=A9vrier 2023 =C3=A0 21:32 +0100, H. Nikolaus =
Schaller a
> =C3=A9crit :
>> Hi Paul,
>> I wasn't aware of your work and it could have saved me a lot of time
>> to
>> experiment and try to make my patch set work.
>>=20
>> But we are still lucky, as we can merge ideas and find the really
>> best solution.
>>=20
>> Anyways you can take my patch 1/3 and 3/3 and we have only to discuss
>> details of 2/3.
>>=20
>> Interesting is your setup of several fixed regulators using
>> regulator-settling-time-us
>> to take care of power up sequencing. What I don't understand is the
>> fixedregulator-5
>> which has no controlling gpio but is always on. What is it needed
>> for? Maybe just to
>> be used to silence v(q)mmc-supply warnings etc.?
>=20
> It's wired to the various inputs of the ACT8600 chip. The driver will
> complain if they are not connected to anything. And while we're at it,
> it will also silence the v(q)mmc-supply warnings, yes.
>=20
>> But you do not really switch or enable/disable power of the SDIO or
>> bluetooth UART
>> interface?
>=20
> The badly named "bt_power" regulator powers on the chip, while the
> "wifi_io" regulator controls the voltage on the VDDIO pins. So these
> are enabled/disabled when needed.
>=20
>> Is it necessary to add a compatible of "ingenic,iw8103-fmac"? If it
>> works with the
>> standard "brcm,bcm4329-fmac" driver (note that I have "brcm,bcm4330-
>> fmac" because that
>> is how the module identifies itself) there seems to be no need for
>> another compatible
>> and a special bindings documentation.
>=20
> The chip has a different name so we can't guarantee that it works
> exactly like the BCM4330. So that was my reason behind using a new
> compatible string with a fallback.

Ok, that would be a good reason.

>=20
> However I sent a patch to add the new compatible string to the
> documentation and it got refused and I was told to just use the
> brcm,bcm4330-fmac, so I'll just do that.
>=20
>> For bluetooth you could add brcm,bt-pcm-int-params =3D [01 02 00 01
>> 01]; so that we
>> can eventually add some PCM stream to the sound setup.
>=20
> Sure, does that work though?

Well, I don't know. We have no sound setup.

> One (unrelated) note about Bluetooth, I didn't get it to work =
properly;
> it works enough to detect my keyboard and allow me to pair with it
> (typing the password on the BT keyboard) but it will never connect
> properly after that.

I haven't tested it that way in my setup.

>=20
>> Finally you have made node labels more consistent by calling them
>> wifi* while I made
>> them wlan0*... Well, just a matter of taste.
>=20
> Actually the node names should use as much as possible the generic
> names specified in the devicetree specification
> (https://www.devicetree.org/specifications/) and "wifi" is one of
> those.

I meant the node labels, not the node names.

BTW: Wi-Fi is a trademark of the Wi-Fi Alliance and means certification
while WLAN means the function. Of course the first must be compatible
to 802.11 and other standards while a WLAN could use some different
technology.

>=20
>> Then I tried to take your tree, add my defconfig (because it seems as
>> if you have not
>> updated configs), but I could only see=20
>>=20
>> [    0.929072] Bluetooth: hci0: BCM: firmware Patch file not found,
>> tried:
>> [    0.935704] Bluetooth: hci0: BCM: 'brcm/BCM4330B1.img,ci20.hcd'
>> [    0.941683] Bluetooth: hci0: BCM: 'brcm/BCM4330B1.hcd'
>> [    0.946827] Bluetooth: hci0: BCM: 'brcm/BCM.img,ci20.hcd'
>> [    0.952278] Bluetooth: hci0: BCM: 'brcm/BCM.hcd'
>>=20
>> and then the kernel is stuck.
>>=20
>> So what is your defconfig that I can test your build?
>=20
> I test with the OpenDingux userspace so my defconfig is probably very
> different from yours. What are you using?

upstream ci20_defconfig + my patch 3/3.
Otherwise I test with Debian user-space.

Can you share your defconfig just for testing purposes?

>=20
> About the crash: make sure you have the *very* latest WiFi firmware
> from
> =
https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.gi=
t/

The BCM4330B1.hcd firmware is missing there. I get mine from

https://github.com/armbian/firmware/raw/master/brcm

And it works with my setup but not yours. So I think something
else is missing or wrong. Note that it is loaded from the SD card
but the kernel is stuck earlier.

> I do remember that one particular version of the firmware will crash
> the kernel. You also don't need the .hcd firmware for Bluetooth to
> (somewhat) work.

Yes, I know. There may also be some race if the drivers are compiled
into the kernel that the bluetooth subsystem searches for the .hcd
files before the mmc subsystem has found and SD card. Then we have no
firmware even if it is stored.

BR,
Nikolaus

>>>=20
>>>>=20
>>>> Tested on CI20 with v6.2-rc6.
>>>>=20
>>>> H. Nikolaus Schaller (3):
>>>>   MIPS: DTS: jz4780: add #clock-cells to rtc_dev
>>>>   MIPS: DTS: CI20: fixes for WiFi/Bluetooth
>>>>   MIPS: configs: ci20: enable drivers we need for WiFi/Bluetooth
>>>>=20
>>>>  arch/mips/boot/dts/ingenic/ci20.dts    | 77
>>>> ++++++++++++++++++++++--
>>>> --
>>>>  arch/mips/boot/dts/ingenic/jz4780.dtsi |  2 +
>>>>  arch/mips/configs/ci20_defconfig       | 18 +++++-
>>>>  3 files changed, 84 insertions(+), 13 deletions(-)


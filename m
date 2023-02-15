Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5F02698595
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 21:32:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbjBOUcd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 15:32:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjBOUcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 15:32:32 -0500
X-Greylist: delayed 10811 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 15 Feb 2023 12:32:30 PST
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.160])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 749241F924;
        Wed, 15 Feb 2023 12:32:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1676493134; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=c6kKfFEaVhARkTWKed0n2we39U1m5hB9SoMzc20QyZcuXOKtglbLNeDAlE+a6yy7Me
    zoWNO2VWMNvlShOjpTk8cDFYGsf4+WnhMuLSxTH4CE1RjuTdGjwy+M3j7+XbD+qKOrom
    4S/Hc3cFI+iXWjZbHl2jfx9+g5uS3vG5L1vyqUpMFyg2YTGxYGCD4SvSkNlYw+1yXLur
    PDqD2uc7QS9WERJqmlSJwbtfHZhQJCgNeHcgQbnJIbVcehbfLokRIo6/QzLcKYZQwJb1
    93pp4yLsRaMGPuNQL5fFzQ/+/IMmQu2FuwOhadrRVH72impMG8YnoII40OP02iuJ5gsn
    O0Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1676493134;
    s=strato-dkim-0002; d=strato.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=3ZvG9gZRr9OgQCB1CpRwmbXj1W/KWiUgadtstnnRU/o=;
    b=nSuNIQnxvCf4oHXpaxQ+qvoBdSdqJ8soo4115oRDNHHUoIyVQBF93YKAoCsSN7BXqy
    fTFopd3NPIxzVNEstQ+KZGIIb27ZzfAWD0ZDynT+L0mwGS2NI2h4HJx2XG1yqeeXfScn
    FlLHBhxnOMSDmXbZXovLQ/IsHtVAu3n6LjHnzk1nC57TGdTyGtS6x3qrYi3VPTPckmFV
    0v9L36U2NSGIOhEcIOJA0jWqhhlGVEoxnsQ7ZlSMYBJKCOwSyQcsvD4RrSFF0lR7B98V
    q7Ln+BC9tEi6H1z2EkwPuFUNE8W5WcQk6MkPSqMNoro0UPK+w5q1SaVtgWfGvVe7vrV5
    sfCg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1676493134;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=3ZvG9gZRr9OgQCB1CpRwmbXj1W/KWiUgadtstnnRU/o=;
    b=fKux/Ap3DWaGqx13pMo2uoHTu52Tjb9ZkZpDqzgymqGoq+adJXQ+iwokP+XlTy/MQ5
    8p+LTfSPPagUxVN88DopzZa3majg8NqZL92HBcP+SMAg/Bs011pbLmMnVYI4rzka4Mkj
    tepFRIY1swYC7neh7OnDaA+vWNaZN5SC9ijR0crSLvfh2SlPRnCoLxCngMhL4bT04Ach
    0rl2EWSqy9LEAS1LtW7r0RHJGiUHk2FoKmdMORaCnkasdzWRokF74rmoURKm10T1D+Xe
    AhJfDkExB3k+Mq+aqVCKrcFbsMNLuN+xvde1e5cB45VO5HT8HML4GMCl7k8bS7/DUW3j
    f+Rg==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj5Apz9PSN6LgsXcGZhzY="
Received: from imac.fritz.box
    by smtp.strato.de (RZmta 49.3.0 DYNA|AUTH)
    with ESMTPSA id 326d57z1FKWDa2P
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
    Wed, 15 Feb 2023 21:32:13 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.21\))
Subject: Re: [RFC 0/3] Make WLAN and Bluetooth basically work for CI20
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <e1f92dc94a3e3df7c4bb32b441802cb333ccb6db.camel@crapouillou.net>
Date:   Wed, 15 Feb 2023 21:32:13 +0100
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
Message-Id: <B1706E39-202F-417C-A7A4-B07482B787B0@goldelico.com>
References: <cover.1676482318.git.hns@goldelico.com>
 <e1f92dc94a3e3df7c4bb32b441802cb333ccb6db.camel@crapouillou.net>
To:     Paul Cercueil <paul@crapouillou.net>
X-Mailer: Apple Mail (2.3445.104.21)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,
I wasn't aware of your work and it could have saved me a lot of time to
experiment and try to make my patch set work.

But we are still lucky, as we can merge ideas and find the really best =
solution.

Anyways you can take my patch 1/3 and 3/3 and we have only to discuss =
details of 2/3.

Interesting is your setup of several fixed regulators using =
regulator-settling-time-us
to take care of power up sequencing. What I don't understand is the =
fixedregulator-5
which has no controlling gpio but is always on. What is it needed for? =
Maybe just to
be used to silence v(q)mmc-supply warnings etc.?
But you do not really switch or enable/disable power of the SDIO or =
bluetooth UART
interface?

Is it necessary to add a compatible of "ingenic,iw8103-fmac"? If it =
works with the
standard "brcm,bcm4329-fmac" driver (note that I have =
"brcm,bcm4330-fmac" because that
is how the module identifies itself) there seems to be no need for =
another compatible
and a special bindings documentation.

For bluetooth you could add brcm,bt-pcm-int-params =3D [01 02 00 01 01]; =
so that we
can eventually add some PCM stream to the sound setup.

Finally you have made node labels more consistent by calling them wifi* =
while I made
them wlan0*... Well, just a matter of taste.

Then I tried to take your tree, add my defconfig (because it seems as if =
you have not
updated configs), but I could only see=20

[    0.929072] Bluetooth: hci0: BCM: firmware Patch file not found, =
tried:
[    0.935704] Bluetooth: hci0: BCM: 'brcm/BCM4330B1.img,ci20.hcd'
[    0.941683] Bluetooth: hci0: BCM: 'brcm/BCM4330B1.hcd'
[    0.946827] Bluetooth: hci0: BCM: 'brcm/BCM.img,ci20.hcd'
[    0.952278] Bluetooth: hci0: BCM: 'brcm/BCM.hcd'

and then the kernel is stuck.

So what is your defconfig that I can test your build?

BR and thanks,
Nikolaus


> Am 15.02.2023 um 18:55 schrieb Paul Cercueil <paul@crapouillou.net>:
>=20
> Hi Nikolaus,
>=20
> Le mercredi 15 f=C3=A9vrier 2023 =C3=A0 18:31 +0100, H. Nikolaus =
Schaller a
> =C3=A9crit :
>> RFC V1 2023-02-15 18:31:58:
>> With the applied patch
>>=20
>> rtc: jz4740: Register clock provider for the CLK32K pin
>>=20
>> by Paul Cercueil <paul@crapouillou.net> it is now possible to make
>> the
>> CI20 WiFi and Bluetooth setup do something reasonable.
>>=20
>> This series adds #clock-cells to the jz4780 and fixes the device tree
>> for
>> the CI20. It contains two ugly workarounds since BL_WAKE and WL_WAKE
>> can not
>> be controlled as shutdown-gpios or device-wakeup-gpios by the
>> drivers.
>> We also update the power setup and sequencing and add a clock chain
>> for
>> the 32 kHz clock.
>> Finally, we enable some required CONFIGs for the CI20.
>=20
> I do have my own patchset that I wanted to send in time for 6.3-rc1,
> but the RTC patchset was merged very late so I was waiting for -rc1 to
> be out before sending it to Thomas.
>=20
> I think my DT changes are better as I have no workarounds. I need to
> clean up the commits (and have proper commit messages) but you can =
find
> my current work there:
> https://github.com/OpenDingux/linux/commits/for-upstream-ci20
>=20
> Cheers,
> -Paul
>=20
>>=20
>> Tested on CI20 with v6.2-rc6.
>>=20
>> H. Nikolaus Schaller (3):
>>   MIPS: DTS: jz4780: add #clock-cells to rtc_dev
>>   MIPS: DTS: CI20: fixes for WiFi/Bluetooth
>>   MIPS: configs: ci20: enable drivers we need for WiFi/Bluetooth
>>=20
>>  arch/mips/boot/dts/ingenic/ci20.dts    | 77 ++++++++++++++++++++++--
>> --
>>  arch/mips/boot/dts/ingenic/jz4780.dtsi |  2 +
>>  arch/mips/configs/ci20_defconfig       | 18 +++++-
>>  3 files changed, 84 insertions(+), 13 deletions(-)
>>=20
>=20


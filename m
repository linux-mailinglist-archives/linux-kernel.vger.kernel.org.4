Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E22FC73BF6B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 22:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbjFWUWB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 16:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjFWUV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 16:21:59 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08390135;
        Fri, 23 Jun 2023 13:21:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1687551704; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=n3p0iIFqFlIeU3YT07Ka9I5kPcfJ/lWf+U+CjzC2uu3NXdj0fOIyy3e1YhpDUnzEDJ
    ZooOv6b0+bu4MCxxF8xLFy5L07idbslDrruuyrk1TFjpUIM9C5vfs8GKnPIhqmVCQKt3
    byLGUZLmTnmKbVZ0ybhTzPNPlFSKgJW+92hRMtsaItiIRQ+GREbHX7oLDl+BruNw5NM8
    7CfHWwaTPzHtAFHTCjfr/es5SoNtc6do9MjjM76r1KHR+/Y2JD605eP+q+1nO5XmJ1c4
    mqY1iZWjfVnlS16KXQBe0KY1inuQxQ19nB8vld0oXoqMaKhyPOEQUVuPJR/2YhkESmhG
    PJtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1687551704;
    s=strato-dkim-0002; d=strato.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=LOpYibRto7PKDM00pfmo/wRgXp1aBo9Y7vqetlPbBao=;
    b=dbO/qAycPr/lur0ixwHtvnvj78tYDOg7GCNiEZ5QmZzlXRotzowVGsvU+v86nqW03i
    lG+ius/zwOpjuq07UHXu/RokRunokrKKwsOOm/EU8CC9Py9Qxm19IM+uK25Lg2H7Gpy+
    3qQyKgKs9egVN+oG1XMAPHvhUtesdTKC2mGkSdZLFzc3TJGl3zi1m3kjz+XW5HqRlvfo
    ILV+Qj8d++1UtKwkyd5oH4RfG3Tn2Gd0n70EmVSGoY02+ncP2WFPmo+4y6DzuQ5WjVw6
    HLTdSOceS9IJNJ6z3Fbl1VOvBNZlfurHnig0U1WsPef5dMcD4oxDp0t2R2Mi5Ws3+vhR
    mmtQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1687551704;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=LOpYibRto7PKDM00pfmo/wRgXp1aBo9Y7vqetlPbBao=;
    b=qvGN9HbZy+enyrzlau2IAPG25t+W/DumgkIPptbxGnGwNdyq9/8qMNCOem27CYIwMv
    DURXQDoyzqa9v1/4VmVY6Ly7wY+Fpv7lF8wkwIa/hMkH7GtT7bcaxUfWSOy8vkceEl3P
    U9dr6klN/m7CPE6tjCVZL4DonFAtb2krjF3O0r+y8qjIOAKPOF0sLTTpvvLdvvc+bwRN
    2WQ8VqbRJbGYImlIFMHzmScezoMPKRY/Mahk7MGTm+AuNUGsaV9kdyG89FnqcJ1efkXv
    sHdFDAHqu/C5I55xILK+nbvHj7zPQM31Tuu0nhCcVNWrmV34KzZmWXvTYB3UPGP7eYLK
    Trtg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1687551704;
    s=strato-dkim-0003; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=LOpYibRto7PKDM00pfmo/wRgXp1aBo9Y7vqetlPbBao=;
    b=JMRmmH2GvSe1QkzXMlMQqqYi0E/H4b2XTL6ieLRrMIMmR3b3Lk1O1azH6hk1LNWgl9
    19WQ9Fo8B81IBf4tvxBg==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj5Apz9PSN6LgsXcGfq2U="
Received: from smtpclient.apple
    by smtp.strato.de (RZmta 49.6.0 DYNA|AUTH)
    with ESMTPSA id jaf17fz5NKLhb8J
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
    Fri, 23 Jun 2023 22:21:43 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.3\))
Subject: Re: [PATCH] MIPS: DTS: CI20: Raise VDDCORE voltage to 1.125 volts
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <62577492be3665a9a4ba66077d13fa1bef5e6ee3.camel@crapouillou.net>
Date:   Fri, 23 Jun 2023 22:21:42 +0200
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-mips@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        list@opendingux.net
Content-Transfer-Encoding: quoted-printable
Message-Id: <B3B433F7-08E1-4AF4-8853-C001FEEF9CA2@goldelico.com>
References: <20230622175934.71601-1-paul@crapouillou.net>
 <59F0E1F0-C518-48D8-8AB9-97CA143DD36E@goldelico.com>
 <62577492be3665a9a4ba66077d13fa1bef5e6ee3.camel@crapouillou.net>
To:     Paul Cercueil <paul@crapouillou.net>
X-Mailer: Apple Mail (2.3696.120.41.1.3)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

> Am 23.06.2023 um 18:31 schrieb Paul Cercueil <paul@crapouillou.net>:
>=20
> Hi Nikolaus,
>=20
> Le vendredi 23 juin 2023 =C3=A0 18:13 +0200, H. Nikolaus Schaller a =
=C3=A9crit :
>> Hi Paul, Thomas,
>> here are my test results.
>>=20
>>> Am 22.06.2023 um 19:59 schrieb Paul Cercueil
>>> <paul@crapouillou.net>:
>>>=20
>>> Commit 08384e80a70f ("MIPS: DTS: CI20: Fix ACT8600 regulator node
>>> names") caused the VDDCORE power supply (regulated by the ACT8600's
>>> DCDC1 output) to drop from a voltage of 1.2V configured by the
>>> bootloader, to the 1.1V set in the Device Tree.
>>>=20
>>> According to the documentation, the VDDCORE supply should be
>>> between
>>> 0.99V and 1.21V; both values are therefore within the supported
>>> range.
>>>=20
>>> However, VDDCORE being 1.1V results in the CI20 being very
>>> unstable,
>>> with corrupted memory, failures to boot, or reboots at random.
>>=20
>> ... and damaging the file system on SD card.
>>=20
>>> The
>>> reason might be succint drops of the voltage below the minimum
>>> required.
>>=20
>> 1. with your patches (except this one) on top of upstream v6.4-rc7
>> and
>> ci20_defconfig I can still not boot with 1.100V.
>>=20
>> 2. but also not at 1.125V as by this patch.
>> [    0.647637] DCDC1: Bringing 1200000uV into 1125000-1125000uV
>>=20
>> 3. my board needs 1.150V as minimum, reporting:
>> [    0.647627] DCDC1: Bringing 1200000uV into 1150000-1150000uV
>=20
> Heh. I was fearing this would be the case.
>=20
>>=20
>> That is good news that it does not need 1.200V at the upper limit.
>>=20
>> 4. next, with this setup I can see the bluetooth chip (with default
>> MAC
>> address 43:30:B1:00:00:00), but it is not useable (maybe my user
>> space).
>>=20
>> And there no WiFi. Rather, I have to disable the brcmfmac driver or
>> otherwise I can't even complete boot (hangs in a later stage) at all.
>=20
> Most likely it's because of an invalid firmware file. It happened to =
me
> with every single firmware file (including the one in the linux-
> firmware repository at that time) except the one found on the CI20's
> Debian image.
>=20
> Since then Broadcom guys updated the firmware in linux-firmware to the
> newest one they had, which works fine.

Well, I have used exactly the same /lib/firmware directory in both =
cases.
Even the same SD card... Nothing removed, replaced or changed with the
firmware file.

I.e. I have just swapped kernel, dtb and modules on the same SD card.

So the difference is inside one of these, not the firmware but I have =
not
yet searched for the detail...

>=20
>> 5. finally the mysterious result:
>>=20
>> With all this merged with the letux-os kernel (and manually fixing
>> minor
>> merge conflicts) and using letux_defconfig I can boot. Even with
>> 1.100V
>> in the device tree, checked with /sys/kernel/debug):
>>=20
>> root@letux:~# cat /sys/kernel/debug/regulator/regulator_summary=20
>>  regulator                      use open bypass  opmode voltage
>> current     min     max
>> ---------------------------------------------------------------------
>> ------------------
>>  regulator-dummy                  3    2      0 unknown     0mV   =20
>> 0mA     0mV     0mV=20
>>     13500000.usb-vusb_a           1                               =20
>> 0mA     0mV     0mV
>>     13500000.usb-vusb_d           1                               =20
>> 0mA     0mV     0mV
>>  eth0_power                       1    1      0 unknown  3300mV   =20
>> 0mA  3300mV  3300mV=20
>>     16000000.dm9000-vcc           1                               =20
>> 0mA     0mV     0mV
>>  otg_power                        1    2      0 unknown  5000mV   =20
>> 0mA  5000mV  5000mV=20
>>     1000003c.usb-phy-vcc          1                               =20
>> 0mA     0mV     0mV
>>     usb_phy-vcc                   0                               =20
>> 0mA     0mV     0mV
>>  vcc_33v                          8    9      0 unknown  3300mV   =20
>> 0mA  3300mV  3300mV=20
>>     13450000.mmc-vqmmc            1                               =20
>> 0mA     0mV     0mV
>>     13450000.mmc-vmmc             1                               =20
>> 0mA  3300mV  3400mV
>>     DCDC1                         1    0      0 standby  1100mV   =20
>> 0mA  1100mV  1100mV=20
>>     DCDC2                         1    0      0 standby  1500mV   =20
>> 0mA  1500mV  1500mV=20
>>     DCDC3                         1    0      0 unknown  3300mV   =20
>> 0mA  3300mV  3300mV=20
>>     LDO5                          1    0      0 unknown  2500mV   =20
>> 0mA  2500mV  2500mV=20
>>     LDO6                          1    1      0  normal  1800mV   =20
>> 0mA  1800mV  1800mV=20
>>        13460000.mmc-vqmmc         1                               =20
>> 0mA     0mV     0mV
>>     LDO7                          0    0      0 unknown  2800mV   =20
>> 0mA  2800mV  2800mV=20
>>     LDO8                          0    0      0 unknown  1500mV   =20
>> 0mA  1500mV  1500mV=20
>>  SUDCDC_REG4                      2    1      0  normal  5000mV   =20
>> 0mA  5000mV  5000mV=20
>>     bt_power                      2    1      0 unknown  3300mV   =20
>> 0mA  3300mV  3300mV=20
>>        wifi_power                 2    1      0 unknown  3300mV   =20
>> 0mA  3300mV  3300mV=20
>>           13460000.mmc-vmmc       1                               =20
>> 0mA  3300mV  3400mV
>>  LDO_REG9                         1    0      0 unknown  3300mV   =20
>> 0mA  3300mV  3300mV=20
>>  LDO_REG10                        1    0      0 unknown  1200mV   =20
>> 0mA  1200mV  1200mV=20
>> root@letux:~# uname -a
>> Linux letux 6.4.0-rc7-letux-ci20+ #13881 SMP PREEMPT Fri Jun 23
>> 17:23:42 CEST 2023 mips GNU/Linux
>> root@letux:~#=20
>>=20
>> And I there have WiFi working fine.
>>=20
>> But no Bluetooth interface at all (although driver is compiled).
>>=20
>> A potential hint could be that DCDC1 is enabled a little later during
>> boot than with ci20_defconfig:
>>=20
>> [    1.077926] DCDC1: Bringing 1200000uV into 1100000-1100000uV
>> [    1.096997] DCDC1: 1100 mV, enabled
>>=20
>> And another test with trying 1.000V hangs immediately after this:
>>=20
>> [    1.032846] DCDC1: Bringing 1200000uV into 1000000-1000000uV
>>=20
>> Maybe it is a too big step during operation.
>=20
> 1.0V is about as low as you can get with theorically perfect power
> supply, I doubt that you can use this voltage in the real world.

Indeed. There may be some more mV drop. I haven't tried 1.050V (yet).

>=20
> It's strange that your letux kernel can set 1.1V and be stable, while
> you need 1.15V with the upstream kernel. I wonder what could be the
> cause.

Yes, that is a mysterium...

>=20
>>=20
>> For the records:
>>=20
>> - I just swapped the clean compiled uImage, kernel modules and
>> ci20.dtb
>>   between all these tests (and fsck the SD card before).
>>=20
>> - we have some experimental SMP patches by Yanjie Zhou (and other
>> nice
>>   stuff not pushed upstream) in the Letux kernel so that any of thes
>>   may have an influence.
>>=20
>> So I'd say let's postpone this 1.125V patch until your other patches
>> arrive upstream. Then I will rebase our Letux kernel anyways and then
>> I can analyse a little easier what makes all these differences
>> (because
>> then no merge and manual conflict resolution is involved any more and
>> there are better chances for a bisect to be helpful).
>=20
> Thomas already merged it, so I guess we have 1.125V now.
>=20
> Which is better than nothing; instead of not working on both our
> boards, at least now v6.4 will work on one of them ;)

And it will not break LetuxOS if rebased. That is what we need for =
further
analysis.

>=20
> Note that I was testing my patches on top of the vanilla kernel,
> without any local patches.

I do the same but have a better result with adding my local patches.
So they must improve something even more (except than making Bluetooth =
worse)...
But I don't know what it is.

Something for future analysis.

BR and thanks for building a basis,
Nikolaus


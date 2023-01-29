Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53A9B6800B4
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 19:19:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235260AbjA2STM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 13:19:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjA2STL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 13:19:11 -0500
X-Greylist: delayed 1664 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 29 Jan 2023 10:19:06 PST
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FA081ADDD;
        Sun, 29 Jan 2023 10:19:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1675016337; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=jR4XqX2heFIwYs8dSht8rwP6UrGkDJtz/7lqjfkkm7sysqqKM6C2mWLM9UXNaM7x4U
    XHYXJ3mgK9tMeG7lI3gfNnLOPKOL16YKRX6FASt8wpXu6kog4c018Sqj5hsy3vW1glvQ
    tYwse7cAS/5+tb+cSR0fmP0c9JIdAEFPqbxAC4lG8aeAJ2YITmbsWqVf8jWGBsosdiD0
    V901ZgeAUMG3HxwSLt/HFTS4+hZt3tSXgaPsTHrcBVrD36gZO2nv/FWCW0x4j7fgsbOb
    iDUwfoJf1H2v8FX5a92UHSeiw/PI3sv1RSIo1/m3mO7qZxAFtbCr6LVU+ejZ7Fe1KaKN
    2Frw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1675016337;
    s=strato-dkim-0002; d=strato.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=bQK4TOXHELKm1NXiEVtFgabvRcj0kJMt8RqN4zxQy00=;
    b=T1hrOQiUoV7RviwldVOZUrLP2DjrqtVqUaJZgzTluDe0CdpPnF9rA9Z3myiyCdLvbz
    4CHwuBKPJEo3l5Kzq3ciSDJJCq16512rtVo0TNncWjuN+tn4ckIgA2ft33yFaaJCxbAL
    Pap+tMt8jXWGlvBoUlpOlNDiRquj/C7LZ0QrTrzRlM4/3Xpd7NkrSHMfCJ3VPahyf5u7
    t8rO/O0QCPzKg06egRIjK5ZXJ0kS+BEKwUyZLxDb2g79DR+4YehSUgIKaKKQqz2sJQWh
    pFdE1o1sQyIdS8TTQsaOpKmvoz0XJWrZBu5cGMUya8AS0B3thV2we4rhdeoxCLkejOj7
    i6dA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1675016337;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=bQK4TOXHELKm1NXiEVtFgabvRcj0kJMt8RqN4zxQy00=;
    b=l7E9sA0JPuKUpfX4oX94zyltv9cPYWCnEv8gX1xLHavBjLDhhYAA/yLansBC7BsXei
    z047whA/HDTmVjnSd5PJVsMXR4U72MIs2OS9L6JOfgSUikQPD8Ym7Zm7dIFEXTkqj0kg
    mgFtw6SQIRCXSJ9J4+mZGbxPkzU5RWednyRyI/HZT+c1q5jquCENxGCxtzTbsJBzDWX0
    qmquFk1KThC4CKRBZh8BeuSB/Tcu1C9ugCzs8O3YNu5B4nU2ZGE6Ew+Vqogs8t8ZT1a5
    9qmF062yzoo4V52mdr161Bh4czwsA7Z9Z2wcfjiBkLAAdaWkETjnhQGoXD0P4KuEvHgp
    1GYw==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBp5hRw/qviAxtjc36ma4eiubtXs9esqPws6rHb0jX3cNS8btzqGxo="
Received: from [IPv6:2001:9e8:a5d3:9100:945c:b4b1:5ad3:81db]
    by smtp.strato.de (RZmta 49.2.2 AUTH)
    with ESMTPSA id e4ab20z0TIIvI0u
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
    Sun, 29 Jan 2023 19:18:57 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.21\))
Subject: Re: [PATCH] MIPS: DTS: CI20: fix otg power gpio
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <d2d59f33dca05239b73b4221262086bfb1ce9e98.camel@crapouillou.net>
Date:   Sun, 29 Jan 2023 19:18:56 +0100
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        =?utf-8?B?5ZGo55Cw5p2w?= <zhouyanjie@wanyeetech.com>,
        linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <53AA669D-00F8-4F4B-A1BF-E81243DCF4DF@goldelico.com>
References: <1e102159b4be526af88883374d112d558e3ac3f5.1675014494.git.hns@goldelico.com>
 <d2d59f33dca05239b73b4221262086bfb1ce9e98.camel@crapouillou.net>
To:     Paul Cercueil <paul@crapouillou.net>
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

Hi Paul,

> Am 29.01.2023 um 19:08 schrieb Paul Cercueil <paul@crapouillou.net>:
>=20
> Hi Nikolaus,
>=20
> Le dimanche 29 janvier 2023 =C3=A0 18:48 +0100, H. Nikolaus Schaller a
> =C3=A9crit :
>> According to schematics it is PF15 and not PF14 (MIC_SW_EN).
>> Seems as if it was hidden and not noticed during testing since
>> there is no sound DT node.
>>=20
>> Fixes: 158c774d3c64 ("MIPS: Ingenic: Add missing nodes for Ingenic
>> SoCs and boards.")
>> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
>=20
> Looking at the schematics it looks like you are correct. So:
> Acked-by: Paul Cercueil <paul@crapouillou.net>

Thanks!

>=20
> I'm curious though, it is connected to the "SYS_POWER_IND" trace in =
the
> schematic, which seems to also switch the main led between red and
> blue, is that the case?

Yes, the LED changes between blue and red with this patch.

BR,
Nikolaus

>=20
> Cheers,
> -Paul
>=20
>> ---
>>  arch/mips/boot/dts/ingenic/ci20.dts | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/arch/mips/boot/dts/ingenic/ci20.dts
>> b/arch/mips/boot/dts/ingenic/ci20.dts
>> index 9819abb2465dd..a276488c0f752 100644
>> --- a/arch/mips/boot/dts/ingenic/ci20.dts
>> +++ b/arch/mips/boot/dts/ingenic/ci20.dts
>> @@ -115,7 +115,7 @@ otg_power: fixedregulator@2 {
>>                 regulator-min-microvolt =3D <5000000>;
>>                 regulator-max-microvolt =3D <5000000>;
>> =20
>> -               gpio =3D <&gpf 14 GPIO_ACTIVE_LOW>;
>> +               gpio =3D <&gpf 15 GPIO_ACTIVE_LOW>;
>>                 enable-active-high;
>>         };
>>  };
>=20


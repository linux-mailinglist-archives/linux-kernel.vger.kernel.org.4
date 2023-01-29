Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B592680109
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 19:57:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbjA2S5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 13:57:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjA2S5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 13:57:15 -0500
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B8AD1E292;
        Sun, 29 Jan 2023 10:57:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1675018618; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=D7+Q5H9Sy2YLl4Cy4y2TxrTVjhYJyk4EzwrnwjN2ubZlCIleSgU37W0hp6a6Ok3Pvg
    stsg/5vIfkHzEIGUgK2LeMFKGXbF4Uef55R0e7x9wuwil28aD+NGUOIaIAQdLiKb/VyM
    p84lbtizOrMeG5XKR0jhMlUOg4Iw9csVb2KkH+Z6tlQ5ywcAibht81n2VJwq0s4/cz8C
    qJUkNDaKSBd7AiAp3aDw9Po47OrSEbTXXL4XM7B6GwBW/A38ovHP6ScDieTuZqgFrk9v
    JLfMGqwDDcqm6jY/3HapRGMnBE8XG97Nu7X2f9eNSIJvN7WguB1iE5uqfiUDeEclICgV
    xvtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1675018618;
    s=strato-dkim-0002; d=strato.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=LPIqDQYn2hf9EUbIgbzUQVHfystaaYtw9KOkG/VEKBY=;
    b=c5yhbU3YuVAWLq3zMTXs7KIWVjJ1rKUL2sOfIob5hAwUCld/Qjbqy39L3JZQlqkcob
    0+rO+yE48uD5JCoV6kf9yv+Cbv7SPEYq/MDIRKCZf8wTfajEcFc4TnUo3WGWHWaJTnuI
    eIOJe31V8I0sQps/4HYPgb7zb/NXnn7BZeilAGBnJbVMENPY9EPGSHnAkuqCpifChkjq
    XNJwNHppd9dhI6bbc3i3ykMJNxnEM45ysbRDE0n4ip2i/jg3dJG29+dPFmTsu388QQ3U
    pb5qH3jorPSJ2f1cTDxVxyayZKrCd8j/15SVbkSD1KBAQUUtADUxIozej5NVvUHxEeme
    3SSg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1675018618;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=LPIqDQYn2hf9EUbIgbzUQVHfystaaYtw9KOkG/VEKBY=;
    b=H+HDha0Rm/Rb/2/twuuI1jhTbsoM3fD64CsqM0ejFnU4NMay3ZodZSaHrsq9ufurm1
    3L7WiBU8d4RcJvVUW29DOZGcQ3GntqNtpcJgUqIc6+F+9R2+JqJXIo0FrRYt+OFXynf2
    W+TJ5qM51JvRAPizY/HpvrJxVXhTGQd3elx4pIFdlWimKhgKDTyZPt2l6twh6CP2YPVL
    wGfY9an+b0F6OIRRwgiH/5S4R0Q1DHbR8s83OeBDkA3MjADIIrooB9JQ4QZ817p0QKIj
    SvD0rsktZaHve9+JBGLW9g+FsxZH3dMvsRO7XKCzUB3NldiXVns8bIADT2Pt+ZRFKX4u
    3X+g==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj5Apz9PSN6LgsXcGZijY="
Received: from imac.fritz.box
    by smtp.strato.de (RZmta 49.2.2 SBL|AUTH)
    with ESMTPSA id e4ab20z0TIuvI48
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
    Sun, 29 Jan 2023 19:56:57 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.21\))
Subject: Re: [PATCH] MIPS: DTS: CI20: fix otg power gpio
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <b7745c417d5ac46efa273f1fc45217bb6254ea4f.camel@crapouillou.net>
Date:   Sun, 29 Jan 2023 19:56:56 +0100
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        =?utf-8?B?5ZGo55Cw5p2w?= <zhouyanjie@wanyeetech.com>,
        linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <5279D4E4-3B47-49A4-AD68-DB4B5C121594@goldelico.com>
References: <1e102159b4be526af88883374d112d558e3ac3f5.1675014494.git.hns@goldelico.com>
 <b7745c417d5ac46efa273f1fc45217bb6254ea4f.camel@crapouillou.net>
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



> Am 29.01.2023 um 19:47 schrieb Paul Cercueil <paul@crapouillou.net>:
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
> I missed it, but every time you have a Fixes: tag, you also need to =
add
> below:
> Cc: stable@vger.kernel.org

Ah, yes. I missed this too. Checkpatch could have warned but doesn't...

> unless the bug you fix is in one of the RCs (and not in a released
> kernel).
>=20
> I think you should send a V2 with this tag (and my ACK).

Will do asap.

BR and thanks,
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


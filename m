Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D218573B8BB
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 15:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231590AbjFWNZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 09:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231433AbjFWNZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 09:25:04 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 432FD2685;
        Fri, 23 Jun 2023 06:25:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1687526689; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=bySgyJ6ZrbBc47/LZE7vddUx2bn+w5T1ECspj8LsRFrRCs575Zsl4FASqYrvRiR1wP
    r2CLuQKrW1gbzx4leTgv9clOGtaPTGCjGgJ9r9lmOnzjvQdXY5dtjVL6u51kinYPykPv
    byvQreHt4uxNDCcLbrC0fMeV17JcnopGNCtNxLXHH9q1hKCKSBUYHx3gi//Q46tWCWM5
    Zc/NvY5KpeQgzxZwi0bH7FB43gZ9rOt4TeOmp5wM5ppMGRb9pdG5gldrT7plYfAsywVN
    sTvGj9Fyhako1V6+BkC81dXiAfsTOhU7dCvL18xEBbJwLANMMPPYvnkRLEbHLv3ye9ST
    DJvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1687526689;
    s=strato-dkim-0002; d=strato.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=1DO+5L9LQoISwuSxosnZjAZQG93qinrKBvdOnzsgsTo=;
    b=Q8uzILoCIh2hyywnVDd83jCt9DQO3ZUhEmUKueKYASAHvANrAdJBRRPgGNJToahVDl
    Sg2TfVN94HFk6ePW42jwwzY2mkU+Q4nW8o8RHYpnlYH8haMg2qCEzzJqk+qxMR3a1foH
    zBxKY4hdoR4LLPiWxljBxme3a6FPTRyrjZHMikdrfqTXTfy0stWgqp+C/YqXd5wqhMLt
    G0udmvpyKBtt9vdNZBD8ZVECH3Rv/ylngAWywJZi2F4QwZ0Sx1DyAnLLZATZiUu25Q5g
    gc35ukYS8JaArjh3/Swi0xVcvUVHjyx4cHSdMuX16xLqvfte6KF4G9vSI6f8Xx+xDug5
    7kYw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1687526689;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=1DO+5L9LQoISwuSxosnZjAZQG93qinrKBvdOnzsgsTo=;
    b=JVLiJNPe89CNGOhIvWw/k+M+VPmYHWboV4Kvwq99aq4g2247M04oxGXvBI7jBized2
    K4IbMDOwCOkktY4DD1M4RLORpjPaHTqR0kO8B2d8eyITefa+NUgLEPm3c/nXQJWOS3O7
    h5ZduK1eNc3HaEDIsj3/1GJ96c9eNNnuaMzneYcHwjaemhlcpW3Kr0HYDyL6oGts3Kir
    vzpoT3ewJfSaUriJvFR9ZzF8e+8q/1WAJ4kAfMHuTkYRJ4JKFqApPn81DgOPK2sshxaK
    SmHurQwgSZy7i0rto40OlAIJLmMrrjGVuWGM4KHrWeKCZ7ZDQZiSRFh8zfLtl2fOCMny
    +ZtA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1687526689;
    s=strato-dkim-0003; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=1DO+5L9LQoISwuSxosnZjAZQG93qinrKBvdOnzsgsTo=;
    b=OofOF4bf5ap7lH64oTpSShbrn8BwSRgR6xtVK5nBSzIahklrdTN8Uni0BUbc2IKHVq
    n1m1CfyJcS9xarSKnRBA==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj5Apz9PSN6LgsXcGfq2U="
Received: from imac.fritz.box
    by smtp.strato.de (RZmta 49.6.0 DYNA|AUTH)
    with ESMTPSA id jaf17fz5NDOnZd8
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
    Fri, 23 Jun 2023 15:24:49 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.21\))
Subject: Re: [PATCH] MIPS: DTS: CI20: Raise VDDCORE voltage to 1.125 volts
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20230623130938.GC11636@alpha.franken.de>
Date:   Fri, 23 Jun 2023 15:23:48 +0200
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-mips@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        list@opendingux.net
Content-Transfer-Encoding: quoted-printable
Message-Id: <8024618C-BB30-46CD-8B2F-299C04308974@goldelico.com>
References: <20230622175934.71601-1-paul@crapouillou.net>
 <20230623130938.GC11636@alpha.franken.de>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
X-Mailer: Apple Mail (2.3445.104.21)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,
you are again too fast. Please let people enough time to test and =
comment patches.

I have started ca. 1 hour ago to do more tests on this topic and am =
currently in the middle of testing this.

At the moment it looks as if I would recommend not to apply it now. =
Since I have no problems with 1.10V with the letux-os distribution =
kernel (which adds some other patches and uses a different defconfig) =
but only with upstream and ci20_defconfig. So a proper solution may be =
completely different.

Best regards,
Nikolaus


> Am 23.06.2023 um 15:09 schrieb Thomas Bogendoerfer =
<tsbogend@alpha.franken.de>:
>=20
> On Thu, Jun 22, 2023 at 07:59:34PM +0200, Paul Cercueil wrote:
>> Commit 08384e80a70f ("MIPS: DTS: CI20: Fix ACT8600 regulator node
>> names") caused the VDDCORE power supply (regulated by the ACT8600's
>> DCDC1 output) to drop from a voltage of 1.2V configured by the
>> bootloader, to the 1.1V set in the Device Tree.
>>=20
>> According to the documentation, the VDDCORE supply should be between
>> 0.99V and 1.21V; both values are therefore within the supported =
range.
>>=20
>> However, VDDCORE being 1.1V results in the CI20 being very unstable,
>> with corrupted memory, failures to boot, or reboots at random. The
>> reason might be succint drops of the voltage below the minimum =
required.
>>=20
>> Raising the minimum voltage to 1.125 volts seems to be enough to =
address
>> this issue, while still keeping a relatively low core voltage which
>> helps for power consumption and thermals.
>>=20
>> Fixes: 08384e80a70f ("MIPS: DTS: CI20: Fix ACT8600 regulator node =
names")
>> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>=20
>> ---
>> Cc: H. Nikolaus Schaller <hns@goldelico.com>
>> ---
>> arch/mips/boot/dts/ingenic/ci20.dts | 4 ++--
>> 1 file changed, 2 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/arch/mips/boot/dts/ingenic/ci20.dts =
b/arch/mips/boot/dts/ingenic/ci20.dts
>> index cec0caa2350c..a141a699b790 100644
>> --- a/arch/mips/boot/dts/ingenic/ci20.dts
>> +++ b/arch/mips/boot/dts/ingenic/ci20.dts
>> @@ -298,8 +298,8 @@ act8600: act8600@5a {
>>=20
>> 		regulators {
>> 			vddcore: DCDC1 {
>> -				regulator-min-microvolt =3D <1100000>;
>> -				regulator-max-microvolt =3D <1100000>;
>> +				regulator-min-microvolt =3D <1125000>;
>> +				regulator-max-microvolt =3D <1125000>;
>> 				vp1-supply =3D <&vcc_33v>;
>> 				regulator-always-on;
>> 			};
>> --=20
>> 2.40.1
>=20
> applied to mips-next.
>=20
> Thomas.
>=20
> --=20
> Crap can work. Given enough thrust pigs will fly, but it's not =
necessarily a
> good idea.                                                [ RFC1925, =
2.3 ]


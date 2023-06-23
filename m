Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B44373BC68
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 18:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232270AbjFWQOe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 12:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232184AbjFWQO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 12:14:29 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 606CF2711;
        Fri, 23 Jun 2023 09:14:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1687536858; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=osUdcl8MJu6jJsPLPDRqGAOSsZs70O2+E7e3ygIL5kq/ePsZt6Dweq3wbPmBmyrgSr
    RO6G6+VfOk61LczH5GnqVaDnaIcTI1HOs/Mn448Jw0gaMSX8JyufTgaD5vpbykiKbi6h
    aCLFP/jFqdk0Ju1Gm/f/yuR+KpSkRa2WUneMoK1HvLGX3BDHQ9hH8IDOUIMvFI4SCvmf
    a0hUD7teuxQuF1wSGkr9ADLTeLSA2oQ1RDKgWUqFn+APGb6MIeYRk2lAJ5Jm+3UVfevj
    A1G1DFArmt4Ed9VDKet4qt+3dQx21Y4XAE0+P9mnftvfhoFr17O/EarIpFoeAsxKHD+n
    dwMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1687536858;
    s=strato-dkim-0002; d=strato.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=KpBExheUMRdVCkQAUPzl1K67OZVQYc6gXpL1M+jXXoY=;
    b=TPhjulZFoRKF79nUldir/AxsHV8FN7Peowg7rQ/nT+3ZMMHbF3q47w2izRjGGilxJh
    KUMnsvpGJXBVlvx1+zuM5ZXWlkGkeGY6qbiQbn3hLRMB7USL8dj/Vqj4F7kzUjwYWCW3
    E/tbcVdmZMRym4WEBRszYO4jojndEdHVXAs7jc6r/8O0ISpAY3XQ8yCzZy9lSWvCWhaQ
    rlYa1NdHhszOu3wML8kAKPFpC3VyRzkIJ3eVeKVIei+5sc/aDfZlwQfshMP2qv5bGS7k
    QQWMGOtVMkjfACVkxYaVVojdga9xbirOFCLM6lIcJJEIyhaRqVRu8sXXOkBlihiTGEcL
    UF5w==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1687536858;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=KpBExheUMRdVCkQAUPzl1K67OZVQYc6gXpL1M+jXXoY=;
    b=q7MBChHkJOMHkmGNuHEiBPNhRltEWZUettyRWW5YlPMWf7Depmn81GUPtl3Tpbdjvm
    rhzkgd9lSuz03V9GZ8gCSILtXsH1SD8NfsQvlPfodFKcE40d4zkoLS8RjXMxA3b2K7mT
    M7BjuHCisMUChmRv7hTCNDrZ4o8SA42IvsY3Mk20/PrYe6lmPnKJrZ7H4P9r1cLquocb
    TqQKi4nIwYdo5/isUYI0VTO7we3RfyhEaF8C6BkO8IWxal96FSow5aAGjL/MdPKgV0pJ
    oUt1YkYEMUOb3oHVIVCpbsLimGet5d5lHdHg0Isc4t4AqFtxcJTjUFV+a9CPfkhj0qAa
    Nn4A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1687536858;
    s=strato-dkim-0003; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=KpBExheUMRdVCkQAUPzl1K67OZVQYc6gXpL1M+jXXoY=;
    b=+440NP/Cx8lPskk/wOyVk2hRHzkd+/r548PQHd9UwofCkc+o9JCPgJraDO517QFeo9
    rJLyLccsGBiSzobA3/DA==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj5Apz9PSN6LgsXcGfq2U="
Received: from imac.fritz.box
    by smtp.strato.de (RZmta 49.6.0 DYNA|AUTH)
    with ESMTPSA id jaf17fz5NGEHa3h
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
    Fri, 23 Jun 2023 18:14:17 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.21\))
Subject: Re: [PATCH] MIPS: DTS: CI20: Raise VDDCORE voltage to 1.125 volts
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20230622175934.71601-1-paul@crapouillou.net>
Date:   Fri, 23 Jun 2023 18:13:16 +0200
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-mips@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        list@opendingux.net
Content-Transfer-Encoding: quoted-printable
Message-Id: <59F0E1F0-C518-48D8-8AB9-97CA143DD36E@goldelico.com>
References: <20230622175934.71601-1-paul@crapouillou.net>
To:     Paul Cercueil <paul@crapouillou.net>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
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

Hi Paul, Thomas,
here are my test results.

> Am 22.06.2023 um 19:59 schrieb Paul Cercueil <paul@crapouillou.net>:
>=20
> Commit 08384e80a70f ("MIPS: DTS: CI20: Fix ACT8600 regulator node
> names") caused the VDDCORE power supply (regulated by the ACT8600's
> DCDC1 output) to drop from a voltage of 1.2V configured by the
> bootloader, to the 1.1V set in the Device Tree.
>=20
> According to the documentation, the VDDCORE supply should be between
> 0.99V and 1.21V; both values are therefore within the supported range.
>=20
> However, VDDCORE being 1.1V results in the CI20 being very unstable,
> with corrupted memory, failures to boot, or reboots at random.

... and damaging the file system on SD card.

> The
> reason might be succint drops of the voltage below the minimum =
required.

1. with your patches (except this one) on top of upstream v6.4-rc7 and
ci20_defconfig I can still not boot with 1.100V.

2. but also not at 1.125V as by this patch.
[    0.647637] DCDC1: Bringing 1200000uV into 1125000-1125000uV

3. my board needs 1.150V as minimum, reporting:
[    0.647627] DCDC1: Bringing 1200000uV into 1150000-1150000uV

That is good news that it does not need 1.200V at the upper limit.

4. next, with this setup I can see the bluetooth chip (with default MAC
address 43:30:B1:00:00:00), but it is not useable (maybe my user space).

And there no WiFi. Rather, I have to disable the brcmfmac driver or
otherwise I can't even complete boot (hangs in a later stage) at all.

5. finally the mysterious result:

With all this merged with the letux-os kernel (and manually fixing minor
merge conflicts) and using letux_defconfig I can boot. Even with 1.100V
in the device tree, checked with /sys/kernel/debug):

root@letux:~# cat /sys/kernel/debug/regulator/regulator_summary=20
 regulator                      use open bypass  opmode voltage current  =
   min     max
=
--------------------------------------------------------------------------=
-------------
 regulator-dummy                  3    2      0 unknown     0mV     0mA  =
   0mV     0mV=20
    13500000.usb-vusb_a           1                                 0mA  =
   0mV     0mV
    13500000.usb-vusb_d           1                                 0mA  =
   0mV     0mV
 eth0_power                       1    1      0 unknown  3300mV     0mA  =
3300mV  3300mV=20
    16000000.dm9000-vcc           1                                 0mA  =
   0mV     0mV
 otg_power                        1    2      0 unknown  5000mV     0mA  =
5000mV  5000mV=20
    1000003c.usb-phy-vcc          1                                 0mA  =
   0mV     0mV
    usb_phy-vcc                   0                                 0mA  =
   0mV     0mV
 vcc_33v                          8    9      0 unknown  3300mV     0mA  =
3300mV  3300mV=20
    13450000.mmc-vqmmc            1                                 0mA  =
   0mV     0mV
    13450000.mmc-vmmc             1                                 0mA  =
3300mV  3400mV
    DCDC1                         1    0      0 standby  1100mV     0mA  =
1100mV  1100mV=20
    DCDC2                         1    0      0 standby  1500mV     0mA  =
1500mV  1500mV=20
    DCDC3                         1    0      0 unknown  3300mV     0mA  =
3300mV  3300mV=20
    LDO5                          1    0      0 unknown  2500mV     0mA  =
2500mV  2500mV=20
    LDO6                          1    1      0  normal  1800mV     0mA  =
1800mV  1800mV=20
       13460000.mmc-vqmmc         1                                 0mA  =
   0mV     0mV
    LDO7                          0    0      0 unknown  2800mV     0mA  =
2800mV  2800mV=20
    LDO8                          0    0      0 unknown  1500mV     0mA  =
1500mV  1500mV=20
 SUDCDC_REG4                      2    1      0  normal  5000mV     0mA  =
5000mV  5000mV=20
    bt_power                      2    1      0 unknown  3300mV     0mA  =
3300mV  3300mV=20
       wifi_power                 2    1      0 unknown  3300mV     0mA  =
3300mV  3300mV=20
          13460000.mmc-vmmc       1                                 0mA  =
3300mV  3400mV
 LDO_REG9                         1    0      0 unknown  3300mV     0mA  =
3300mV  3300mV=20
 LDO_REG10                        1    0      0 unknown  1200mV     0mA  =
1200mV  1200mV=20
root@letux:~# uname -a
Linux letux 6.4.0-rc7-letux-ci20+ #13881 SMP PREEMPT Fri Jun 23 17:23:42 =
CEST 2023 mips GNU/Linux
root@letux:~#=20

And I there have WiFi working fine.

But no Bluetooth interface at all (although driver is compiled).

A potential hint could be that DCDC1 is enabled a little later during =
boot than with ci20_defconfig:

[    1.077926] DCDC1: Bringing 1200000uV into 1100000-1100000uV
[    1.096997] DCDC1: 1100 mV, enabled

And another test with trying 1.000V hangs immediately after this:

[    1.032846] DCDC1: Bringing 1200000uV into 1000000-1000000uV

Maybe it is a too big step during operation.

For the records:

- I just swapped the clean compiled uImage, kernel modules and ci20.dtb
  between all these tests (and fsck the SD card before).

- we have some experimental SMP patches by Yanjie Zhou (and other nice
  stuff not pushed upstream) in the Letux kernel so that any of thes
  may have an influence.

So I'd say let's postpone this 1.125V patch until your other patches
arrive upstream. Then I will rebase our Letux kernel anyways and then
I can analyse a little easier what makes all these differences (because
then no merge and manual conflict resolution is involved any more and
there are better chances for a bisect to be helpful).

Best regards,
Nikolaus


>=20
> Raising the minimum voltage to 1.125 volts seems to be enough to =
address
> this issue, while still keeping a relatively low core voltage which
> helps for power consumption and thermals.
>=20
> Fixes: 08384e80a70f ("MIPS: DTS: CI20: Fix ACT8600 regulator node =
names")
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>=20
> ---
> Cc: H. Nikolaus Schaller <hns@goldelico.com>
> ---
> arch/mips/boot/dts/ingenic/ci20.dts | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/mips/boot/dts/ingenic/ci20.dts =
b/arch/mips/boot/dts/ingenic/ci20.dts
> index cec0caa2350c..a141a699b790 100644
> --- a/arch/mips/boot/dts/ingenic/ci20.dts
> +++ b/arch/mips/boot/dts/ingenic/ci20.dts
> @@ -298,8 +298,8 @@ act8600: act8600@5a {
>=20
> 		regulators {
> 			vddcore: DCDC1 {
> -				regulator-min-microvolt =3D <1100000>;
> -				regulator-max-microvolt =3D <1100000>;
> +				regulator-min-microvolt =3D <1125000>;
> +				regulator-max-microvolt =3D <1125000>;
> 				vp1-supply =3D <&vcc_33v>;
> 				regulator-always-on;
> 			};
> --=20
> 2.40.1
>=20


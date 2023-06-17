Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DCB873405D
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 12:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234308AbjFQKq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 06:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234298AbjFQKqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 06:46:00 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 768BE10F7;
        Sat, 17 Jun 2023 03:45:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1686998745; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=EsrNNKykNruT/Z6vXMkVby4XVMgK5ed/ePXZff5aVLXLiGG4HZOHML3ID/oYm4peOP
    jRkIvL/1GQNLPBMUzh6a+jLQH3CPg6eUbPcqX903ndxclYFeJknpkEy67njI95X52Evv
    +i4oh406cg3WXHKjjMn6a6iyI7qLfi38pOGLviL+k4IgAq+RT3uO05LgSpZCyZseESw9
    SMaovUQ2C3QbKcd2aUqgaqHwzNYfbdDIxXuhwR13GGPOqMO8Ped/s0hNCLNA7rVxH8RT
    Oy7Eb0IUSqX5XBO/G1K7e+bWoo25UyU0i0G2xLwiOwYiKAGDMm0y/PET5fRN80BzVF40
    D82g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1686998745;
    s=strato-dkim-0002; d=strato.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=Zo1aYoXQPVQhd4Ack1fHIk+3jiMLxZtS4fgIWvguVR8=;
    b=Gmjckf+beQ75KMu3ygJ6AocwYs7wP0jKcd4zUKSqwlLLG+dJ888dCrDAAST4r138Ol
    ZNeK+EGQY56go5Srex+LW8H8oed+t/nrtxyg8oHc/sO16Q7HUb2TijZG+InBuxTCESGn
    JuWmgBnw0iuxFEVpysMk40EV0fpDxQak3xmJ9l5al2pthvHyzcHWevMpfjV/b6lyEiGa
    xm5GDkao1h0qguRrKr6/6NGLgcoyQl6saxGIe0ycow1h5eQjeuVjz2pIosi5J8v0+jfO
    k62ECHbm8rvIUarqP3/28DrX9MWTG0N4QeoLJzDlhFVhS4W9X01oivpalDy9lOZ5JHC0
    LQYQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1686998745;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=Zo1aYoXQPVQhd4Ack1fHIk+3jiMLxZtS4fgIWvguVR8=;
    b=M0w0vMpCzyYilxF5WgambLdjEIJy5j8LDhZ4diUPSwLEmX3VxQYkG34ojD9B/bZxTl
    fZnVTEsWVq0jezNfagr7DPxDiYOent+jGdIXaD7e5ZMwCkiNTfps/HnfcgGHLF7CfBNk
    PebQkwux6nKH7BedtGbmbJC71ISMp+/4MrsH006iPlTizuRf/gHpDHuTJ5r5ENDPO376
    /BtowAZb99jewaq71y0y2gZjl6EPzFJo5akO/QNskHMFX5os+IaDJZNWNoRJfpnqbq4c
    2bZMFotS2gM27gZd1kXRYghObCAr8UirzYssK/W6LgLpf+W3VJ4VYiDO4b6QVQXMZ+kS
    aerA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1686998745;
    s=strato-dkim-0003; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=Zo1aYoXQPVQhd4Ack1fHIk+3jiMLxZtS4fgIWvguVR8=;
    b=a8JbrUwhjV4lZW1szwNF2WzwVYZHyJ3zBRhoZ/howI367UFstEjbbKrFrkYNKGTXkd
    ZkrNvwc35jOQr8Zi1MCQ==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj5Apz9PSN6LgsXcGeqHQ="
Received: from imac.fritz.box
    by smtp.strato.de (RZmta 49.6.0 DYNA|AUTH)
    with ESMTPSA id jaf17fz5HAjjAg3
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
    Sat, 17 Jun 2023 12:45:45 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.21\))
Subject: Re: [PATCH 0/9] MIPS: CI20: Add WiFi / Bluetooth support
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <5EF6B0D2-2B84-4C98-B799-88062E035EC1@goldelico.com>
Date:   Sat, 17 Jun 2023 12:45:44 +0200
Cc:     list@opendingux.net, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Conor Dooley <conor+dt@kernel.org>, linux-mips@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Boddie <paul@boddie.org.uk>
Content-Transfer-Encoding: quoted-printable
Message-Id: <43DCEEA5-C013-44BE-85C7-D61A980B0EA5@goldelico.com>
References: <20230615084006.79194526F801@goldelico.com>
 <C1924536-FA97-4E75-9D22-99E5AF24EE5B@goldelico.com>
 <A8EBCBA4-D9BA-4C2F-9C91-38128D06EDBA@goldelico.com>
 <AA802E24-A97B-42B6-90A4-5ECB1E4D9294@goldelico.com>
 <5EF6B0D2-2B84-4C98-B799-88062E035EC1@goldelico.com>
To:     Paul Cercueil <paul@crapouillou.net>
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

Hi Paul,

> Am 16.06.2023 um 22:21 schrieb H. Nikolaus Schaller =
<hns@goldelico.com>:

> - But renaming the DT nodes (e.g. SUDCDC1 -> DCDC1) (with or without =
regulator_name) makes
> boot hang with strange errors which indicate that the processor power =
supply is not stable.
> Once a while it did even automatically reboot. In most cases there are =
some EXT4 errors
> afterwards.

I am coming closer, I think. I have now touched only the DCDC1 node =
name.

a) with "SUDCDC1" -> "DCDC1" (bad bood):

regulator_of_get_init_node() returns the child node

Then:
[    0.666962] act8865 0-005a: Looking up vp1-supply from device tree
[    0.673191] DCDC1: supplied by vcc_33v
[    0.727070] DCDC1: Bringing 1200000uV into 1100000-1100000uV
[    0.739398] DCDC1: 1100 mV, enabled

b) without patch/series or reverted (good boot):

regulator_of_get_init_node() returns NULL

Then:
[    1.016487] DCDC1: at 1200 mV, enabled
[    1.020578] act8865 0-005a: Looking up vp1-supply from device tree
[    1.026917] DCDC1: supplied by vcc_33v

So at least for my board the patched series seems to reduce DCDC1 =
voltage
to 1.1V which may trigger the boot and stability problems on my board =
while
it is fine for yours. This could explain the hardware dependency.

Now I have no data sheets or information which voltages are the right =
ones
and where the 1200mV come from (most likely some default programmed
into the PMU chip).

And the issue seems to be that without matching the node names the
voltages in the device tree may have been ignored completely all the
time... Now it sets up voltages, which should happen. But different
ones for my board which breaks boot.

Finally I did risk (I have no replacement CI20 board and they are no =
longer
on sale... RS part# was 125-3305 Mouser 456-VL-62851) to run a test with
rename to "DCDC1" but changing the voltage to 1200mV. And this version =
boots.

Still without WiFi/Bluetooth but that may be related to missing rename
of the other regulators.

So I tried renaming all regulators as by your [PATCH 2/9], and now I
see something from WiFi (haven't installed firmware yet) and the =
Bluetooth chip:

[    1.977876] mmc1: new high speed SDIO card at address 0001

[   11.341994] Bluetooth: hci0: BCM: chip id 62
[   11.348811] Bluetooth: hci0: BCM: features 0x0f
[   11.376698] Bluetooth: hci0: BCM4330B1
[   11.380662] Bluetooth: hci0: BCM4330B1 (002.001.003) build 0000
[   11.392053] Bluetooth: hci0: BCM4330B1 'brcm/BCM4330B1.hcd' Patch

[   12.145330] brcmfmac mmc1:0001:1: Direct firmware load for =
brcm/brcmfmac4330-sdio.img,ci20.bin failed with error -2
[   12.208001] brcmfmac mmc1:0001:1: Direct firmware load for =
brcm/brcmfmac4330-sdio.clm_blob failed with error -2

Unfortunatley systemd bailed out starting Bluetooth service but
failed to provide a login:

In summary it looks like a potential fix could be to replace the DCDC1
min/max range by 1.0 - 1.2V instead of 1.1 - 1.1V but we need deeper
understanding first. Usually this has something to do with dynamic =
voltage
scaling depending on processor clock and lower voltages are only allowed
for lower frequencies but max. clock requires the highest possible =
voltage.
AFAIK we have no cpufreq integrated and therefore always run at max. =
speed.

BR,
Nikolaus

PS: here is what I read back from the regulator voltages (for DCDC1  =
min/max =3D 1.2V):

root@letux:~# cat /sys/kernel/debug/regulator/regulator_summary
 regulator                      use open bypass  opmode voltage current  =
   min     max
=
--------------------------------------------------------------------------=
-------------
 regulator-dummy                  1    0      0 unknown     0mV     0mA  =
   0mV     0mV=20
 eth0_power                       1    1      0 unknown  3300mV     0mA  =
3300mV  3300mV=20
    16000000.dm9000-vcc           1                                 0mA  =
   0mV     0mV
 otg_power                        0    0      0 unknown  5000mV     0mA  =
5000mV  5000mV=20
 vcc_33v                          4    9      0 unknown  3300mV     0mA  =
3300mV  3300mV=20
    13450000.mmc-vqmmc            1                                 0mA  =
   0mV     0mV
    13450000.mmc-vmmc             1                                 0mA  =
3300mV  3400mV
    DCDC1                         1    0      0 standby  1200mV     0mA  =
1200mV  1200mV=20
    DCDC2                         0    0      0 standby  1500mV     0mA  =
   0mV     0mV=20
    DCDC3                         0    0      0 unknown  3300mV     0mA  =
   0mV     0mV=20
    LDO5                          0    0      0 unknown  2500mV     0mA  =
   0mV     0mV=20
    LDO6                          0    0      0  normal  1800mV     0mA  =
1800mV  1800mV=20
    LDO7                          0    0      0 unknown  3300mV     0mA  =
   0mV     0mV=20
    LDO8                          0    0      0 unknown  3300mV     0mA  =
   0mV     0mV=20
 SUDCDC_REG4                      0    0      0  normal  5000mV     0mA  =
   0mV     0mV=20
 LDO_REG9                         1    0      0 unknown  3300mV     0mA  =
3300mV  3300mV=20
 LDO_REG10                        1    0      0 unknown  1200mV     0mA  =
1200mV  1200mV=20
 bt_power                         0    0      0 unknown  3300mV     0mA  =
3300mV  3300mV=20
root@letux:~#=20

This matches device tree except DCDC1, LDO7 and LDO8 (camera).


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8FA47186A8
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 17:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233086AbjEaPrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 11:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232537AbjEaPrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 11:47:14 -0400
Received: from w4.tutanota.de (w4.tutanota.de [81.3.6.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45243132;
        Wed, 31 May 2023 08:47:12 -0700 (PDT)
Received: from tutadb.w10.tutanota.de (unknown [192.168.1.10])
        by w4.tutanota.de (Postfix) with ESMTP id DD6571060171;
        Wed, 31 May 2023 15:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1685548030;
        s=s1; d=bens.haus;
        h=From:From:To:To:Subject:Subject:Content-Description:Content-ID:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Cc:Cc:Date:Date:In-Reply-To:In-Reply-To:MIME-Version:MIME-Version:Message-ID:Message-ID:Reply-To:References:References:Sender;
        bh=RpT/H9rcQ7ixw4i3+3UZ5QOlHh7IMrLh2gHnDzou/nc=;
        b=Me6rE/1/p2s7jLidZTF6on33LGbsf5vu4T2XXXT99O5cwCIwwntmCnGU1TmQ/AiH
        6WEj3yNrqDDHsY6Rf2txhmIqfU3Dhooqk0h1gsrQxWmOGxObaZhJ02Q/SHAdGGnsFuE
        LLFEdLT0ioKebrdQU5AQWPPBpZmzkWdQXSOZW3LurayLVuXom5nOK/TCT+TJO6yKcCx
        SViJxWKQSRgxBi3bGdTYiV8OdmY3rm0K8jmzmduZiAVLsx/1gUlT1FOX2S+acn4dNVb
        XduYg/Yni8lbuWskKEB41P6WcW905O0cACgReZjSpgDXhAqaMZ12Xdhs4fVL5ga7VAE
        zk96/bnnWw==
Date:   Wed, 31 May 2023 17:47:10 +0200 (CEST)
From:   Ben Schneider <ben@bens.haus>
To:     Gregory CLEMENT <gregory.clement@bootlin.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Linux Arm Kernel <linux-arm-kernel@lists.infradead.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Devicetree <devicetree@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Message-ID: <NWmRXzg--3-9@bens.haus>
In-Reply-To: <877csouaaw.fsf@BL-laptop>
References: <NWNpfIn--3-9@bens.haus> <f8393f75-ff32-4450-b8d6-b08d43240200@lunn.ch> <NWhH-xL--7-9@bens.haus> <877csouaaw.fsf@BL-laptop>
Subject: Re: [PATCH] arm64: dts: marvell: Fix espressobin-ultra boot
 failure
 and wifi
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

May 31, 2023, 09:20 by gregory.clement@bootlin.com:

>
> I don't see the patch so I can't apply it...
>
>
Hi Gregory, sorry I wasn't sure if I should resend the patch.

Boot hangs on EspressoBIN Ultra (Armada 3720) after a message that device
vcc_sd1 had been disabled. The device manufacturer patched this issue in
their kernel fork noting that vcc_sd1 is used by the EspressoBIN model
but not the EspressoBIN Ultra. Removing the device from the tree fixes
the boot hang and wifi.

Link: https://github.com/globalscaletechnologies/linux/commit/b879d560eebf2=
766781614a0169a9564f1e0fc06

Signed-off-by: Ben Schneider <ben@bens.haus>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts | 3 +++
1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts =
b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts
index d29d2da95..f9abef8dc 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts
@@ -24,6 +24,8 @@
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 ethernet5 =3D &switch0port4;
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
=C2=A0
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /delete-node/ regulator;
+
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reg_usb3_vbus: usb3-vbus {
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 compatible =3D "regulator-fixed";
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 regulator-name =3D "usb3-vbus";
@@ -66,6 +68,7 @@
};
=C2=A0
&sdhci1 {
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /delete-property/ vqmmc-supply;
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 status =3D "disabled";
};

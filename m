Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B595731052
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 09:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244767AbjFOHQG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 03:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245066AbjFOHPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 03:15:25 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E372B4692;
        Thu, 15 Jun 2023 00:12:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1686812462; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=A7+OEOe2tKbtr0Wfk5CpOaVff+0K09lqCd/PqvcPh2jVucV7eUE45BmWIoVb3zWCYf
    BryJ/xt7P43eKgFAfp+8X1sCAKzL8lVbBOpye1UQUNpTtcBJyoS34xhmfMAhWum6s+bz
    ER+yhYcRmU7kcnjszSOw58oEUN0xWcJuCIInBvXOhglfm3uv0xr2Yfc738aFSztPersC
    18aCfGnJZUy1fHvhJN7x+RafayHRUeo+u0OlcMWrs8+hYLXpbshwg6HECp4mxadE/4QA
    h2ovQ+DSx0WMKJ3efOj5Ah9EVvHcIdHu1mKPOpYU2+JqPMMof+BsKIPekeyM4I062TTR
    j5Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1686812462;
    s=strato-dkim-0002; d=strato.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=TDJy/nCvrrGgkIeB/WaaG50bfZku9SJeUReU+whMQHM=;
    b=Qze99mfNNKROeAMDb9pHHvLhlTe3ooeVHYTRiNt0jqoX1tbEKaowG7HSnZSjxLVr9j
    zBvcS9EkgnXHM6kTJjzw8PmrBuxj11upbwFHwMpV7f2pEAjhSF9cRId7vnr+4tMKJDXI
    Evk4Vkh3wN8lsVk58MywyDriG1GVjLGxZ8f/+r/BrNkD94JNypyxlbIyzh7ZbeNdAEA4
    iBLrZ7tqxK1heSXQieDXk+kmswAoHizjUhDgW0O5jTZeqyfqj7bbadGJBJRi6GhZa/Hl
    NW7apQ7nga4eO7buYqpGPzgQNSvALcqtPhyKJfz3P3YdJa+823JVIcJieuozZCevsvUg
    evUA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1686812462;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=TDJy/nCvrrGgkIeB/WaaG50bfZku9SJeUReU+whMQHM=;
    b=TOOJyLeYcYS5BsZh7jMAykirrC2ykQROoRBe5dSkhNP7mlgxS9coH3uuFfNlXy74j9
    TH/aJzAOlOTFg6xKr4VP+efWy1ZXRkfX1nUBLZuJO/BWmYyJqgy8OZB/wmUAcYE/EmhC
    pIoIieaJnPTCKdSqpHM1fDOVPiXtS6S515WIeMAnrYdwkm3nlH/Hkb7vzKTEo/HWn1my
    gKgUiVFm2gSwKm9W2bdkBtfEaZ2WGo7tzokb9al3/LWtw1DHginIkaF/My7TeVcME1P3
    yj2gg2kZRzcM7N3GI5v/RQ9YVQ4ceCsBzvdkBFVtSJwUENmS3l2FAHoWjOZ/lO+mJlCT
    AqgQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1686812462;
    s=strato-dkim-0003; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=TDJy/nCvrrGgkIeB/WaaG50bfZku9SJeUReU+whMQHM=;
    b=1LVB8RGilMdBNbH1Ibn85Q47fByovt/rlfHl9hpXUn87z2NWBSdfLqdVh76W61v2PO
    sdpmIhj2T+NQXKYiT3Dw==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj5Apz9PSN6LgsXcGeonQ="
Received: from imac.fritz.box
    by smtp.strato.de (RZmta 49.6.0 DYNA|AUTH)
    with ESMTPSA id jaf17fz5F71223U
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
    Thu, 15 Jun 2023 09:01:02 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.21\))
Subject: Re: [PATCH 5/9] MIPS: DTS: CI20: Misc. cleanups
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20230604145642.200577-6-paul@crapouillou.net>
Date:   Thu, 15 Jun 2023 09:01:02 +0200
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-mips@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        list@opendingux.net
Content-Transfer-Encoding: quoted-printable
Message-Id: <7895ACE7-2D31-4858-891A-44C2BC7B9D9D@goldelico.com>
References: <20230604145642.200577-1-paul@crapouillou.net>
 <20230604145642.200577-6-paul@crapouillou.net>
To:     Paul Cercueil <paul@crapouillou.net>
X-Mailer: Apple Mail (2.3445.104.21)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please find a more useful subject.

> Am 04.06.2023 um 16:56 schrieb Paul Cercueil <paul@crapouillou.net>:
>=20
> - Use the standard "ecc-engine" property instead of the custom
> "ingenic,bch-controller" to get a handle to the BCH controller.
>=20
> - Respect cell sizes in the Ethernet controller node.
>=20
> - Use proper macro for interrupt type instead of hardcoding magic
>  values.
>=20
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
> arch/mips/boot/dts/ingenic/ci20.dts | 8 ++++----
> 1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/mips/boot/dts/ingenic/ci20.dts =
b/arch/mips/boot/dts/ingenic/ci20.dts
> index 7f6e7a4e3915..b7dbafa1f85d 100644
> --- a/arch/mips/boot/dts/ingenic/ci20.dts
> +++ b/arch/mips/boot/dts/ingenic/ci20.dts
> @@ -356,7 +356,7 @@ nandc: nand-controller@1 {
> 		#address-cells =3D <1>;
> 		#size-cells =3D <0>;
>=20
> -		ingenic,bch-controller =3D <&bch>;
> +		ecc-engine =3D <&bch>;
>=20
> 		ingenic,nemc-tAS =3D <10>;
> 		ingenic,nemc-tAH =3D <5>;
> @@ -422,8 +422,8 @@ dm9000@6 {
> 		pinctrl-names =3D "default";
> 		pinctrl-0 =3D <&pins_nemc_cs6>;
>=20
> -		reg =3D <6 0 1   /* addr */
> -		       6 2 1>; /* data */
> +		reg =3D <6 0 1>, /* addr */
> +		      <6 2 1>; /* data */
>=20
> 		ingenic,nemc-tAS =3D <15>;
> 		ingenic,nemc-tAH =3D <10>;
> @@ -435,7 +435,7 @@ dm9000@6 {
> 		vcc-supply =3D <&eth0_power>;
>=20
> 		interrupt-parent =3D <&gpe>;
> -		interrupts =3D <19 4>;
> +		interrupts =3D <19 IRQ_TYPE_EDGE_RISING>;
>=20
> 		nvmem-cells =3D <&eth0_addr>;
> 		nvmem-cell-names =3D "mac-address";


For better bisecting it would be helpful to split this into 3 patches.

And they are not really related to WiFi/Bluetooth.


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3E8C71FA91
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 09:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234125AbjFBHDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 03:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233964AbjFBHC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 03:02:56 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7E4AE6D;
        Fri,  2 Jun 2023 00:02:31 -0700 (PDT)
X-GND-Sasl: gregory.clement@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1685689350;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=apbl6ibXzDtLo3IwU3XOOCAze/S/2TUiq/3Tkscqyw8=;
        b=QNlXX9AQez4mxsXP3+AU5dLvKKLp+zi+dvOXdTl0doYocJjdzu8l8aLepubUE0Ii4L4n9Z
        hW8uUpbLpFlGAyy2orxWr2yGhfzWv4LyBijW+MytDlh4aQ1D1fZVuhcfFG+isaV36uabxq
        zAv51Fl3Y4LMqVyxX5l+/rsv5y80ygPW3yckW1XQjlyIjiZH/8BxETXwgo8/LZ1xwmT4Fz
        792E/MmXkPLyGJv1Jc/pIHJyDdgXD78Ekx1i2HsRchNzkWswg0rFTwkkEozYtfYiorFPsp
        Ob1Ep95urmzqZse6cbsGgzEdNlc4QhOIUOeWtlHi3YOBhDW0XujOfYo6JIByYA==
X-GND-Sasl: gregory.clement@bootlin.com
X-GND-Sasl: gregory.clement@bootlin.com
X-GND-Sasl: gregory.clement@bootlin.com
X-GND-Sasl: gregory.clement@bootlin.com
X-GND-Sasl: gregory.clement@bootlin.com
X-GND-Sasl: gregory.clement@bootlin.com
X-GND-Sasl: gregory.clement@bootlin.com
X-GND-Sasl: gregory.clement@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4087724000A;
        Fri,  2 Jun 2023 07:02:29 +0000 (UTC)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Ben Schneider <ben@bens.haus>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Linux Arm Kernel <linux-arm-kernel@lists.infradead.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Devicetree <devicetree@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: marvell: Fix espressobin-ultra boot failure
 and wifi
In-Reply-To: <NWmRXzg--3-9@bens.haus>
References: <NWNpfIn--3-9@bens.haus>
 <f8393f75-ff32-4450-b8d6-b08d43240200@lunn.ch> <NWhH-xL--7-9@bens.haus>
 <877csouaaw.fsf@BL-laptop> <NWmRXzg--3-9@bens.haus>
Date:   Fri, 02 Jun 2023 09:02:28 +0200
Message-ID: <87o7lys5x7.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Schneider <ben@bens.haus> writes:

> May 31, 2023, 09:20 by gregory.clement@bootlin.com:
>
>>
>> I don't see the patch so I can't apply it...
>>
>>
> Hi Gregory, sorry I wasn't sure if I should resend the patch.


Thanks however it is still not applicable, could you send with git-send
email ?

>
> Boot hangs on EspressoBIN Ultra (Armada 3720) after a message that device
> vcc_sd1 had been disabled. The device manufacturer patched this issue in
> their kernel fork noting that vcc_sd1 is used by the EspressoBIN model
> but not the EspressoBIN Ultra. Removing the device from the tree fixes
> the boot hang and wifi.
>
> Link: https://github.com/globalscaletechnologies/linux/commit/b879d560eeb=
f2766781614a0169a9564f1e0fc06
>
> Signed-off-by: Ben Schneider <ben@bens.haus>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> ---
> arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts | 3 +++
> 1 file changed, 3 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dt=
s b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts
> index d29d2da95..f9abef8dc 100644
> --- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts
> @@ -24,6 +24,8 @@
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 ethernet5 =3D &switch0port4;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
> =C2=A0
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /delete-node/ regulator;
> +
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reg_usb3_vbus: usb3-vbus {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 compatible =3D "regulator-fixed";
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 regulator-name =3D "usb3-vbus";
> @@ -66,6 +68,7 @@
> };
> =C2=A0
> &sdhci1 {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /delete-property/ vqmmc-supply;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 status =3D "disabled";
> };

--=20
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com

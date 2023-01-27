Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AEC167E16F
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 11:20:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232975AbjA0KU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 05:20:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231656AbjA0KU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 05:20:27 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 246F01EBE1;
        Fri, 27 Jan 2023 02:20:05 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id t18so4538629wro.1;
        Fri, 27 Jan 2023 02:20:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=986kNoTX7HQuFjtuPYsQX3nJMp/mDefMIZLTNU//MaA=;
        b=Sad+FyBArEkw4v91Xh8DZW6D8RxM9cDW+CD10015GaCQjTLX8LJveXhaJjkIf5U01L
         aC1KMtktWlQxDDbaEyvokaDTLFQQEDNyt1BZeeZfOQKg36R8OcvOTTZVFEOWUyCSHWO3
         mLwxUXNmTAamQd3pwnVBs+a39y37+tHUcriRO0DipO30+GY1c1AXrY/SF9GH5b+uydSb
         1WIg0EZMuLmC6JZSIP/TGUM5LTpxVlN8pXXZ5/o6vGZkfk075Xph2A/6yDmVscmkkTyv
         ARvsTt1fcGoxmWaIH+AE+4ilcEVps43hTH8lOoVTC9aX231PoZC2HwTn2OuR0KvenHhE
         nF5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=986kNoTX7HQuFjtuPYsQX3nJMp/mDefMIZLTNU//MaA=;
        b=iNY6a1p5LDiEr0iTD0L4k6lLHTwTUXWgo9XcQpDtAleff0o6CqCC3+y5P0jHpjHk8f
         JyUmLTElgXUeQpfC571Wx1lfpRW3GArLcWJx8+4fK1lcgZb4J01cWXg53tG/j/R6j9/h
         jwJlxRgjOewd40uxiQeVN/FbyeNP/I82mHhr3GfZfE0B5Dfjek4v+LFD4t39owiWyWZZ
         jnX2vlMnWp0p7DKbvYvabJZJJiM+4sEiVkZhd59NEMK+UJBD92j0gDprHtEl2okAozQ8
         yykknAqpuHgpU94TYLoCfMADdjZO7oJj0St+qHyPwyCZoVb78+74iOA9eJ2M6cBrjF5/
         k+oA==
X-Gm-Message-State: AO0yUKW10uXyEIQvaOcY0+fbIAyrlYPMPdWUmgoLhmuxdeu1ymO4/CG+
        W4R1PAk2sxf9p2NM7afEfjA=
X-Google-Smtp-Source: AK7set+Pd50pUM5H0ZNoleGCfOH/eDbbphd/8EJ4gOMzwxstG7KxGUcSUThAxOZMYAYXw1n6FifzEQ==
X-Received: by 2002:adf:a491:0:b0:2bf:b394:4f23 with SMTP id g17-20020adfa491000000b002bfb3944f23mr10327198wrb.51.1674814803600;
        Fri, 27 Jan 2023 02:20:03 -0800 (PST)
Received: from smtpclient.apple ([167.99.200.149])
        by smtp.gmail.com with ESMTPSA id p6-20020a5d48c6000000b002bfc0558ecdsm3478532wrs.113.2023.01.27.02.20.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jan 2023 02:20:03 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH 4/4] arm64: dts: meson: add support for BananaPi M2-Pro
From:   Christian Hewitt <christianshewitt@gmail.com>
In-Reply-To: <a35f7f09-eb19-6cfc-2053-c6b340f10cbd@linaro.org>
Date:   Fri, 27 Jan 2023 14:19:59 +0400
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic <linux-amlogic@lists.infradead.org>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <356B9EBF-B9C4-4CB0-9F83-9E7A62F93F65@gmail.com>
References: <20230127100236.3385154-1-christianshewitt@gmail.com>
 <20230127100236.3385154-5-christianshewitt@gmail.com>
 <a35f7f09-eb19-6cfc-2053-c6b340f10cbd@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On 27 Jan 2023, at 2:06 pm, Krzysztof Kozlowski =
<krzysztof.kozlowski@linaro.org> wrote:
>=20
> On 27/01/2023 11:02, Christian Hewitt wrote:
>> BPI-M2-PRO is based upon the BPI-M5 design except for a different
>> physical board layout and the following changes:
>>=20
>> - USB 3.0 ports reduced from 4x to 2x
>> - 3.5mm Combined CVBS/Audio Jack removed
>> - RTL8821BU WiFi/BT module (internal USB connected)
>>=20
>> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
>> ---
>> arch/arm64/boot/dts/amlogic/Makefile          |  1 +
>> .../dts/amlogic/meson-sm1-bananapi-m2-pro.dts | 98 =
+++++++++++++++++++
>> 2 files changed, 99 insertions(+)
>> create mode 100644 =
arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m2-pro.dts
>>=20
>> diff --git a/arch/arm64/boot/dts/amlogic/Makefile =
b/arch/arm64/boot/dts/amlogic/Makefile
>> index 97b42e2100e0..644451794aca 100644
>> --- a/arch/arm64/boot/dts/amlogic/Makefile
>> +++ b/arch/arm64/boot/dts/amlogic/Makefile
>> @@ -60,6 +60,7 @@ dtb-$(CONFIG_ARCH_MESON) +=3D =
meson-gxm-wetek-core2.dtb
>> dtb-$(CONFIG_ARCH_MESON) +=3D meson-s4-s805x2-aq222.dtb
>> dtb-$(CONFIG_ARCH_MESON) +=3D meson-sm1-a95xf3-air-gbit.dtb
>> dtb-$(CONFIG_ARCH_MESON) +=3D meson-sm1-a95xf3-air.dtb
>> +dtb-$(CONFIG_ARCH_MESON) +=3D meson-sm1-bananapi-m2-pro.dtb
>> dtb-$(CONFIG_ARCH_MESON) +=3D meson-sm1-bananapi-m5.dtb
>> dtb-$(CONFIG_ARCH_MESON) +=3D meson-sm1-h96-max.dtb
>> dtb-$(CONFIG_ARCH_MESON) +=3D meson-sm1-khadas-vim3l.dtb
>> diff --git =
a/arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m2-pro.dts =
b/arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m2-pro.dts
>> new file mode 100644
>> index 000000000000..4890d5d9a4f7
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m2-pro.dts
>> @@ -0,0 +1,98 @@
>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>> +/*
>> + * Copyright (c) 2021 BayLibre SAS
>> + * Author: Neil Armstrong <narmstrong@baylibre.com>
>> + */
>> +
>> +/dts-v1/;
>> +
>> +#include "meson-sm1-bananapi.dtsi"
>> +#include <dt-bindings/sound/meson-g12a-tohdmitx.h>
>> +
>> +/ {
>> +	compatible =3D "bananapi,bpi-m2-pro", "amlogic,sm1";
>> +	model =3D "Banana Pi BPI-M2-PRO";
>> +
>> +	sound {
>> +		compatible =3D "amlogic,axg-sound-card";
>> +		model =3D "BPI-M2-PRO";
>> +		audio-aux-devs =3D <&tdmout_b>;
>> +		audio-routing =3D "TDMOUT_B IN 0", "FRDDR_A OUT 1",
>> +				"TDMOUT_B IN 1", "FRDDR_B OUT 1",
>> +				"TDMOUT_B IN 2", "FRDDR_C OUT 1",
>> +				"TDM_B Playback", "TDMOUT_B OUT";
>> +
>> +		assigned-clocks =3D <&clkc CLKID_MPLL2>,
>> +				  <&clkc CLKID_MPLL0>,
>> +				  <&clkc CLKID_MPLL1>;
>> +		assigned-clock-parents =3D <0>, <0>, <0>;
>> +		assigned-clock-rates =3D <294912000>,
>> +				       <270950400>,
>> +				       <393216000>;
>> +		status =3D "okay";
>=20
> It's by default. Did any DTSI disable the sound node?

No. I=E2=80=99m simply transcribing from the original M5 dts (with edits =
to omit
the audio jack bits) and the sound nodes of other Amlogic dts which have
long included the same.=20

Q. Do I need to remove it here? (sounds like a yes)
Q. Do we need to exorcise/cleanup the same from all other meson dts?

Christian


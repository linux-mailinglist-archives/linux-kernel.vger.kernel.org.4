Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D19686313C8
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Nov 2022 12:57:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbiKTL5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 06:57:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiKTL5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 06:57:30 -0500
Received: from sender4-op-o18.zoho.com (sender4-op-o18.zoho.com [136.143.188.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B04B0C36;
        Sun, 20 Nov 2022 03:57:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1668945436; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=ng3Yjnce5LoSWYNSaPWg8YBKbAm8VShZgrA7Stnl55Jy4XHxc5F6yHyAzx7heFlNk+4nGq4oecz00/IrFQAKKTDQ1+qJ1eIMOnFfZx90ht1oLCrmFdkv8aUqwqJ0kCoQsT+WWDvHTA2+wFHcGZwbRzY4EweGvlAAeDIxWrl091s=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1668945436; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=TWmgry8NgngIUiXTgpSXxtbDHcnIyfa0JiiI/7Nvz+0=; 
        b=FFrifJu29X09dDqjHasO3Vvv8Vl6sQ/2nAY6cxlXZPfC0LnNeJn5z3OZ1wAn9L7tZ6He6o96YLVOeiudF5xbqaQg1BewHtCDKEliP9CiD7NXMNpddwtQ8zXDM5pxBV5jWmGZkPEp35X01Wr1s6lo6NWI0EWVuTpG39BGt1TzxfE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=icenowy.me;
        spf=pass  smtp.mailfrom=uwu@icenowy.me;
        dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1668945436;
        s=zmail; d=icenowy.me; i=uwu@icenowy.me;
        h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
        bh=TWmgry8NgngIUiXTgpSXxtbDHcnIyfa0JiiI/7Nvz+0=;
        b=TEHdXYjcq2IQ8SOZRsIQ+VcXg+Cgi8+rzb9YilugQd39ZKud1ac/HG0nBANeMvVw
        gwxjcJSNMWXGtchc8j7AwZ0cBxEawyAiMQw3RofSPqk5Kp6v0bQhB6Rf5Kd3SAz9fVm
        ikkOdE3JkRLqWVyD2KTFIDM1KrExGxQ/0TwBEwlo=
Received: from edelgard.fodlan.icenowy.me (112.94.100.29 [112.94.100.29]) by mx.zohomail.com
        with SMTPS id 1668945432410994.7351069945597; Sun, 20 Nov 2022 03:57:12 -0800 (PST)
Message-ID: <924b302f8714677b4f018b0d64a7e92db6d9e6ea.camel@icenowy.me>
Subject: Re: [PATCH 6/7] riscv: dts: bouffalolab: add Sipeed M1S dock
 devicetree
From:   Icenowy Zheng <uwu@icenowy.me>
To:     Jisheng Zhang <jszhang@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Date:   Sun, 20 Nov 2022 19:57:06 +0800
In-Reply-To: <20221120082114.3030-7-jszhang@kernel.org>
References: <20221120082114.3030-1-jszhang@kernel.org>
         <20221120082114.3030-7-jszhang@kernel.org>
Organization: Anthon Open-Source Community
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 
MIME-Version: 1.0
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=E5=9C=A8 2022-11-20=E6=98=9F=E6=9C=9F=E6=97=A5=E7=9A=84 16:21 +0800=EF=BC=
=8CJisheng Zhang=E5=86=99=E9=81=93=EF=BC=9A
> Sipeed manufactures a M1S system-on-module and dock board, add basic
> support for them.
>=20
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
> =C2=A0arch/riscv/boot/dts/bouffalolab/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 2 ++
> =C2=A0.../boot/dts/bouffalolab/bl808-sipeed-m1s.dts | 30

I suggest a M1s DTSI and a M1s Dock DTS.

> +++++++++++++++++++
> =C2=A02 files changed, 32 insertions(+)
> =C2=A0create mode 100644 arch/riscv/boot/dts/bouffalolab/Makefile
> =C2=A0create mode 100644 arch/riscv/boot/dts/bouffalolab/bl808-sipeed-
> m1s.dts
>=20
> diff --git a/arch/riscv/boot/dts/bouffalolab/Makefile
> b/arch/riscv/boot/dts/bouffalolab/Makefile
> new file mode 100644
> index 000000000000..42e17e1a97bd
> --- /dev/null
> +++ b/arch/riscv/boot/dts/bouffalolab/Makefile
> @@ -0,0 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0
> +dtb-$(CONFIG_SOC_BOUFFALOLAB) +=3D bl808-sipeed-m1s.dtb
> diff --git a/arch/riscv/boot/dts/bouffalolab/bl808-sipeed-m1s.dts
> b/arch/riscv/boot/dts/bouffalolab/bl808-sipeed-m1s.dts
> new file mode 100644
> index 000000000000..64421fb2ad67
> --- /dev/null
> +++ b/arch/riscv/boot/dts/bouffalolab/bl808-sipeed-m1s.dts
> @@ -0,0 +1,30 @@
> +// SPDX-License-Identifier: (GPL-2.0+ or MIT)
> +/*
> + * Copyright (C) 2022 Jisheng Zhang <jszhang@kernel.org>
> + */
> +
> +/dts-v1/;
> +
> +#include "bl808.dtsi"
> +
> +/ {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0model =3D "Sipeed M1S";
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0compatible =3D "sipeed,m1s", "=
bouffalolab,bl808";
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0aliases {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0serial0 =3D &uart0;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0};
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0chosen {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0stdout-path =3D "serial0:2000000n8";
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0};
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0memory@50000000 {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0device_type =3D "memory";
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0reg =3D <0x50000000 0x04000000>;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0};
> +};
> +
> +&uart0 {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0status =3D "okay";
> +};


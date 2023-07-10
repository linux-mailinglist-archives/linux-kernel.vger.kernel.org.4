Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1057874E251
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 01:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbjGJXvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 19:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjGJXvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 19:51:07 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E38F91AC;
        Mon, 10 Jul 2023 16:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1689033063;
        bh=0rZ8py8WFbjd+KaEuTNOvnpKq7U/hktOERHZwfzmUpg=;
        h=Date:From:To:Cc:Subject:From;
        b=cnq9/c/h6BYOykcOL2njRHa0bEH0yqKzEZoYO0A0rHffCs8kx67jM1ZGm+aIHsw//
         VnVUeUfAXGnSEfD44L3I4GNQsGkBMpRBUFBVc5ZHg5/8yQhK8WVGPeScK05ca3XG9L
         U+NcTpd2JCjggwwfF01F3RsGVmMqEW31R/HOaSCsUt6gQG38vFqQq9sRrX20Ed8hHh
         RiqHFIGmIvOhhTPUpV+glcmAaafUBBZ9F6aT4vT2Wt2ozPr0ga1fSHHKnXxLWo2CC6
         ZXqxPB7Z/J82yr/U1ldB2npinnul/jqrrc7Z+C3XIealYLFR6ToBjVoWhdg84xqFMN
         X0rQEGIzOpUTA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4R0LP26Nszz4wb5;
        Tue, 11 Jul 2023 09:51:02 +1000 (AEST)
Date:   Tue, 11 Jul 2023 09:51:01 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Joel Stanley <joel@jms.id.au>
Cc:     Eddie James <eajames@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the aspeed tree
Message-ID: <20230711095101.6277674b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/xjvL+9c_VqmQQBErHBcvQqV";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/xjvL+9c_VqmQQBErHBcvQqV
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the aspeed tree, today's linux-next build (arm
multi_v7_defconfig) produced this warning:

arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dts:238.6-19: Warning (reg_=
format): /ahb/apb/fsi@1e79b000/cfam@0,0/i2c@1800/i2c-bus@a/eeprom@50:reg: p=
roperty has invalid length (4 bytes) (#address-cells =3D=3D 2, #size-cells =
=3D=3D 1)
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dts:247.6-19: Warning (reg_=
format): /ahb/apb/fsi@1e79b000/cfam@0,0/i2c@1800/i2c-bus@b/eeprom@50:reg: p=
roperty has invalid length (4 bytes) (#address-cells =3D=3D 2, #size-cells =
=3D=3D 1)
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dts:256.6-19: Warning (reg_=
format): /ahb/apb/fsi@1e79b000/cfam@0,0/i2c@1800/i2c-bus@c/eeprom@50:reg: p=
roperty has invalid length (4 bytes) (#address-cells =3D=3D 2, #size-cells =
=3D=3D 1)
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dts:265.6-19: Warning (reg_=
format): /ahb/apb/fsi@1e79b000/cfam@0,0/i2c@1800/i2c-bus@d/eeprom@50:reg: p=
roperty has invalid length (4 bytes) (#address-cells =3D=3D 2, #size-cells =
=3D=3D 1)
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dtb: Warning (pci_device_re=
g): Failed prerequisite 'reg_format'
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dtb: Warning (pci_device_bu=
s_num): Failed prerequisite 'reg_format'
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dts:233.27-240.6: Warning (=
i2c_bus_bridge): /ahb/apb/fsi@1e79b000/cfam@0,0/i2c@1800/i2c-bus@a: incorre=
ct #address-cells for I2C bus
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dts:233.27-240.6: Warning (=
i2c_bus_bridge): /ahb/apb/fsi@1e79b000/cfam@0,0/i2c@1800/i2c-bus@a: incorre=
ct #size-cells for I2C bus
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dts:242.27-249.6: Warning (=
i2c_bus_bridge): /ahb/apb/fsi@1e79b000/cfam@0,0/i2c@1800/i2c-bus@b: incorre=
ct #address-cells for I2C bus
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dts:242.27-249.6: Warning (=
i2c_bus_bridge): /ahb/apb/fsi@1e79b000/cfam@0,0/i2c@1800/i2c-bus@b: incorre=
ct #size-cells for I2C bus
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dts:251.27-258.6: Warning (=
i2c_bus_bridge): /ahb/apb/fsi@1e79b000/cfam@0,0/i2c@1800/i2c-bus@c: incorre=
ct #address-cells for I2C bus
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dts:251.27-258.6: Warning (=
i2c_bus_bridge): /ahb/apb/fsi@1e79b000/cfam@0,0/i2c@1800/i2c-bus@c: incorre=
ct #size-cells for I2C bus
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dts:260.27-267.6: Warning (=
i2c_bus_bridge): /ahb/apb/fsi@1e79b000/cfam@0,0/i2c@1800/i2c-bus@d: incorre=
ct #address-cells for I2C bus
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dts:260.27-267.6: Warning (=
i2c_bus_bridge): /ahb/apb/fsi@1e79b000/cfam@0,0/i2c@1800/i2c-bus@d: incorre=
ct #size-cells for I2C bus
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dtb: Warning (i2c_bus_reg):=
 Failed prerequisite 'reg_format'
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dtb: Warning (i2c_bus_reg):=
 Failed prerequisite 'i2c_bus_bridge'
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dtb: Warning (spi_bus_reg):=
 Failed prerequisite 'reg_format'
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dts:236.15-239.7: Warning (=
avoid_default_addr_size): /ahb/apb/fsi@1e79b000/cfam@0,0/i2c@1800/i2c-bus@a=
/eeprom@50: Relying on default #address-cells value
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dts:236.15-239.7: Warning (=
avoid_default_addr_size): /ahb/apb/fsi@1e79b000/cfam@0,0/i2c@1800/i2c-bus@a=
/eeprom@50: Relying on default #size-cells value
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dts:245.15-248.7: Warning (=
avoid_default_addr_size): /ahb/apb/fsi@1e79b000/cfam@0,0/i2c@1800/i2c-bus@b=
/eeprom@50: Relying on default #address-cells value
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dts:245.15-248.7: Warning (=
avoid_default_addr_size): /ahb/apb/fsi@1e79b000/cfam@0,0/i2c@1800/i2c-bus@b=
/eeprom@50: Relying on default #size-cells value
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dts:254.15-257.7: Warning (=
avoid_default_addr_size): /ahb/apb/fsi@1e79b000/cfam@0,0/i2c@1800/i2c-bus@c=
/eeprom@50: Relying on default #address-cells value
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dts:254.15-257.7: Warning (=
avoid_default_addr_size): /ahb/apb/fsi@1e79b000/cfam@0,0/i2c@1800/i2c-bus@c=
/eeprom@50: Relying on default #size-cells value
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dts:263.15-266.7: Warning (=
avoid_default_addr_size): /ahb/apb/fsi@1e79b000/cfam@0,0/i2c@1800/i2c-bus@d=
/eeprom@50: Relying on default #address-cells value
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dts:263.15-266.7: Warning (=
avoid_default_addr_size): /ahb/apb/fsi@1e79b000/cfam@0,0/i2c@1800/i2c-bus@d=
/eeprom@50: Relying on default #size-cells value

Presumably introduced by commit

  267c95dc9f80 ("ARM: dts: aspeed: bonnell: Add DIMM SPD")

--=20
Cheers,
Stephen Rothwell

--Sig_/xjvL+9c_VqmQQBErHBcvQqV
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSsmWUACgkQAVBC80lX
0GzRGQf/dAe/VENSmdR4P9TLNb19qI7LKRcCpq+WVf1hrwPZaX58QHjGtmCZPBb9
kvF7E2hQ+ojLPTevrTqC64pvAu6tSbWCYI4FSGLKTp9S3SvgIYtGge8lWg6WOe1/
WuCoi93Fa/bjKRU1JhDrM7v20wgYVk40GASpoa02nFdROSmcupkyVT7CFXAEkRU4
MCKdsdopS6khOzdYBqZmbzVSbflPadrWZXiD3SBO84bO0kQcHfwroYDbXwzRSe8n
CJT7A/i32wwVzHKvADtc7VCivh0F23l26LNXTmxklQIWBuC5gMkBA88r4hvtc1FQ
CJP6rNNccJnGjlONPV1UFp/nI9HWbA==
=X+r/
-----END PGP SIGNATURE-----

--Sig_/xjvL+9c_VqmQQBErHBcvQqV--

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D62206BEE0A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 17:25:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbjCQQY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 12:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbjCQQY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 12:24:56 -0400
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32F33C5AF0;
        Fri, 17 Mar 2023 09:24:46 -0700 (PDT)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 92AC6100005;
        Fri, 17 Mar 2023 16:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1679070285;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OJYMrde9Tsch86i3JGsu8G+CJ4MPghfFAWP4131uPlI=;
        b=Oj0gtqhytwyH3QX+CItruqfC6F9ZAFryHzOo1uX59FXNO7HPAi0Wd8KFc3EQ9pTlIxYDXZ
        96oKbRwvOcZwNfRHigMz5q2kltQfIyH0IaAnSj3o/My+oeQlrQCZ400JvtmwfPWTO5bEko
        E9Ss400GhGwhBm1JNnlzGvT5DcCYN6zg7ot77f8xX/iRIDwfs9eevucc79zHrW9pSb7GC/
        sTCbT9KFhZSWsETsme2U9yFUv3vOutzc7ztHItViaHa60FgU0hnCyD+z0bweNlZACRy39x
        zjsatBH1a0NPLO3UE2z+xZSOMzZkm/IIIW5P43ZiFwV/rbl0mQ5jRwn6xVyZGA==
Date:   Fri, 17 Mar 2023 17:24:41 +0100
From:   Herve Codina <herve.codina@bootlin.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 2/7] drivers: misc: Add support for the Lantiq
 PEF2256 framer
Message-ID: <20230317172441.0b0985b4@bootlin.com>
In-Reply-To: <43b7e386-5b85-3d51-5431-4a46b2779729@csgroup.eu>
References: <20230316122741.577663-1-herve.codina@bootlin.com>
 <20230316122741.577663-3-herve.codina@bootlin.com>
 <43b7e386-5b85-3d51-5431-4a46b2779729@csgroup.eu>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

On Thu, 16 Mar 2023 14:00:42 +0000
Christophe Leroy <christophe.leroy@csgroup.eu> wrote:

[...]
> > +#define PEF2256_PC6	        0x86 /* Port Configuration 6 */
> > +#define PEF2256_GCM(_n)         (0x92 + _n - 1) /* Global Counter Mode=
 n=3D1..8 */ =20
>=20
> Should be (0x92 + (_n) - 1) to avoid any risk.

Yes definitively.
Will be updated in v3.

>=20
> > +#define PEF2256_GCM1	        0x92 /* Global Counter Mode 1 */
[...]
> > +#define   PEF2256_GIS_ISR(_n)	(1<<(n)) =20
>=20
> _n or n ?

Should be (1 << (_n))
Will be updated in v3.

>=20
> > +#define PEF2256_WID	0xEC /* Wafer Identification Register */
[...]
> > +static inline void pef2256_clrbits8(struct pef2256 *pef2256, int offse=
t, u8 clr)
> > +{
> > +	u8 v;
> > +
> > +	v =3D pef2256_read8(pef2256, offset);
> > +	v &=3D ~clr;
> > +	pef2256_write8(pef2256, offset, v);
> > +} =20
>=20
> Not sure it is worth the number of lines.
>=20
> Would liekly be as good with just:
>=20
> 	pef2256_write8(pef2256, offset, pef2256_read8(pef2256, offset) & ~clr);
>=20
> Same for all.

Will be updated in v3.

>=20
>=20
> Also, it shouldn't need to be flagged 'inline' as it is defined in the C=
=20
> file it is used. GCC will decide by itself if it is worth inlining.

In the kernel register accessor helpers are traditionally inline.
  # git grep 'static .* u32 .*read.*(' drivers/*.c | grep inline | wc -l
  432
  # git grep 'static .* u32 .*read.*(' drivers/*.c | grep -v inline | wc -l
  1
Sure, my git grep is not accurate but it gives ideas of the quantities.

I prefer to keep the inline for the register accessor helpers.


>=20
> > +
> > +static inline void pef2256_setbits8(struct pef2256 *pef2256, int offse=
t, u8 set)
> > +{
> > +	u8 v;
> > +
> > +	v =3D pef2256_read8(pef2256, offset);
> > +	v |=3D set;
> > +	pef2256_write8(pef2256, offset, v);
> > +}
> > +
> > +
> > +static inline void pef2256_clrsetbits8(struct pef2256 *pef2256, int of=
fset, u8 clr, u8 set)
> > +{
> > +	u8 v;
> > +
> > +	v =3D pef2256_read8(pef2256, offset);
> > +	v &=3D ~clr;
> > +	v |=3D set;
> > +	pef2256_write8(pef2256, offset, v);
> > +}
> > +
> > +static enum pef2256_version pef2256_get_version(struct pef2256 *pef225=
6)
> > +{
> > +	enum pef2256_version version;
> > +	const char *version_txt;
> > +	u8 vstr, wid;
> > +
> > +	vstr =3D pef2256_read8(pef2256, PEF2256_VSTR);
> > +	wid =3D pef2256_read8(pef2256, PEF2256_WID);
> > +
> > +	switch (vstr) {
> > +	case PEF2256_VSTR_VERSION_12:
> > +		if ((wid & PEF2256_12_WID_MASK) =3D=3D PEF2256_12_WID_VERSION_12) {
> > +			version_txt =3D "1.2";
> > +			version =3D PEF2256_VERSION_1_2;
> > +			goto end;
> > +		}
> > +		break;
> > +	case PEF2256_VSTR_VERSION_2x:
> > +		switch (wid & PEF2256_2X_WID_MASK) {
> > +		case PEF2256_2X_WID_VERSION_21:
> > +			version_txt =3D "2.1 (2.x)";
> > +			version =3D PEF2256_VERSION_2_1;
> > +			goto end;
> > +		case PEF2256_2X_WID_VERSION_22:
> > +			version_txt =3D "2.2 (2.x)";
> > +			version =3D PEF2256_VERSION_2_2;
> > +			goto end;
> > +		default:
> > +			break;
> > +		}
> > +		break;
> > +	case PEF2256_VSTR_VERSION_21:
> > +		version_txt =3D "2.1";
> > +		version =3D PEF2256_VERSION_2_1;
> > +		goto end;
> > +	default:
> > +		break; =20
>=20
> A default doing nothing is not needed unless the switch handles a enum=20
> and you have not covered all possible values.
>=20
> My preference would be that you use the default to set:
> version =3D PEF2256_VERSION_UNKNOWN;
>=20
> then use an if (version =3D=3D PEF2256_VERSION_UNKNOWN) / else below for =
the=20
> dev_err/dev_info.

The function will be reworked in v3

>=20
> > +	}
> > +
> > +	dev_err(pef2256->dev, "Unknown version (0x%02x, 0x%02x)\n", vstr, wid=
);
> > +	return PEF2256_VERSION_UNKNOWN;
> > +
> > +end:
> > +	dev_info(pef2256->dev, "Version %s detected\n", version_txt);
> > +	return version;
> > +}
> > +
> > +static int pef2256_12_setup_gcm(struct pef2256 *pef2256)
> > +{
> > +	static const u8 gcm_1544000[6] =3D {0xF0, 0x51, 0x00, 0x80, 0x00, 0x1=
5};
> > +	static const u8 gcm_2048000[6] =3D {0x00, 0x58, 0xD2, 0xC2, 0x00, 0x1=
0};
> > +	static const u8 gcm_8192000[6] =3D {0x00, 0x58, 0xD2, 0xC2, 0x03, 0x1=
0};
> > +	static const u8 gcm_10000000[6] =3D {0x90, 0x51, 0x81, 0x8F, 0x04, 0x=
10};
> > +	static const u8 gcm_12352000[6] =3D {0xF0, 0x51, 0x00, 0x80, 0x07, 0x=
15};
> > +	static const u8 gcm_16384000[6] =3D {0x00, 0x58, 0xD2, 0xC2, 0x07, 0x=
10};
> > +	unsigned long mclk_rate;
> > +	const u8 *gcm;
> > +	int i;
> > +
> > +	mclk_rate =3D clk_get_rate(pef2256->mclk);
> > +	switch (mclk_rate) {
> > +	case 1544000:
> > +		gcm =3D gcm_1544000;
> > +		break;
> > +	case 2048000:
> > +		gcm =3D gcm_2048000;
> > +		break;
> > +	case 8192000:
> > +		gcm =3D gcm_8192000;
> > +		break;
> > +	case 10000000:
> > +		gcm =3D gcm_10000000;
> > +		break;
> > +	case 12352000:
> > +		gcm =3D gcm_12352000;
> > +		break;
> > +	case 16384000:
> > +		gcm =3D gcm_16384000;
> > +		break;
> > +	default:
> > +		dev_err(pef2256->dev, "Unsupported v1.2 MCLK rate %lu\n", mclk_rate);
> > +		return -EINVAL;
> > +	}
> > +	for (i =3D 0; i < 6; i++)
> > +		pef2256_write8(pef2256, PEF2256_GCM(i+1), gcm[i]);
> > +
> > +	return 0;
> > +}
> > +
> > +static int pef2256_2x_setup_gcm(struct pef2256 *pef2256)
> > +{
> > +	static const u8 gcm_1544000[8] =3D {0x00, 0x15, 0x00, 0x08, 0x00, 0x3=
F, 0x9C, 0xDF};
> > +	static const u8 gcm_2048000[8] =3D {0x00, 0x18, 0xFB, 0x0B, 0x00, 0x2=
F, 0xDB, 0xDF};
> > +	static const u8 gcm_8192000[8] =3D {0x00, 0x18, 0xFB, 0x0B, 0x00, 0x0=
B, 0xDB, 0xDF};
> > +	static const u8 gcm_10000000[8] =3D {0x40, 0x1B, 0x3D, 0x0A, 0x00, 0x=
07, 0xC9, 0xDC};
> > +	static const u8 gcm_12352000[8] =3D {0x00, 0x19, 0x00, 0x08, 0x01, 0x=
0A, 0x98, 0xDA};
> > +	static const u8 gcm_16384000[8] =3D {0x00, 0x18, 0xFB, 0x0B, 0x01, 0x=
0B, 0xDB, 0xDF};
> > +	unsigned long mclk_rate;
> > +	const u8 *gcm;
> > +	int i;
> > +
> > +	mclk_rate =3D clk_get_rate(pef2256->mclk);
> > +	switch (mclk_rate) {
> > +	case 1544000:
> > +		gcm =3D gcm_1544000;
> > +		break;
> > +	case 2048000:
> > +		gcm =3D gcm_2048000;
> > +		break;
> > +	case 8192000:
> > +		gcm =3D gcm_8192000;
> > +		break;
> > +	case 10000000:
> > +		gcm =3D gcm_10000000;
> > +		break;
> > +	case 12352000:
> > +		gcm =3D gcm_12352000;
> > +		break;
> > +	case 16384000:
> > +		gcm =3D gcm_16384000;
> > +		break;
> > +	default:
> > +		dev_err(pef2256->dev, "Unsupported v2.x MCLK rate %lu\n", mclk_rate);
> > +		return -EINVAL;
> > +	}
> > +	for (i =3D 0; i < 8; i++)
> > +		pef2256_write8(pef2256, PEF2256_GCM(i+1), gcm[i]);
> > +
> > +	return 0;
> > +} =20
>=20
> This function and the previous one look very similar, can we merge them ?

Yes, will be merged in v3.

>=20
> > +
> > +static int pef2256_setup_gcm(struct pef2256 *pef2256)
> > +{
> > +	return (pef2256->version =3D=3D PEF2256_VERSION_1_2) ?
> > +		pef2256_12_setup_gcm(pef2256) : pef2256_2x_setup_gcm(pef2256);
> > +}
> > +
> > +static int pef2256_setup_e1(struct pef2256 *pef2256)
> > +{
> > +	u8 fmr1, fmr2, sic1;
> > +	int ret;
> > +
> > +	/* Basic setup, Master clocking mode (GCM8..1) */
> > +	ret =3D pef2256_setup_gcm(pef2256);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/* RCLK output : DPLL clock, DCO-X enabled, DCO-X internal ref clock =
*/
> > +	pef2256_write8(pef2256, PEF2256_CMR1, 0x00);
> > +
> > +	/*
> > +	 * SCLKR selected, SCLKX selected,
> > +	 * receive synchro pulse sourced by SYPR,
> > +	 * transmit synchro pulse sourced by SYPX
> > +	 */
> > +	pef2256_write8(pef2256, PEF2256_CMR2, 0x00);
> > +
> > +	/* NRZ coding, no alarm simulation */
> > +	pef2256_write8(pef2256, PEF2256_FMR0, 0x00);
> > +
> > +	/*
> > +	 * E1, frame format, 2 Mbit/s system data rate, no AIS
> > +	 * transmission to remote end or system interface, payload loop
> > +	 * off, transmit remote alarm on
> > +	 */
> > +	fmr1 =3D 0x00;
> > +	fmr2 =3D PEF2256_FMR2_AXRA;
> > +	switch (pef2256->frame_type) {
> > +	case PEF2256_FRAME_E1_DOUBLEFRAME:
> > +		fmr2 |=3D PEF2256_FMR2_RFS_DOUBLEFRAME;
> > +		break;
> > +	case PEF2256_FRAME_E1_CRC4_MULTIFRAME:
> > +		fmr1 |=3D PEF2256_FMR1_XFS;
> > +		fmr2 |=3D PEF2256_FMR2_RFS_CRC4_MULTIFRAME;
> > +		break;
> > +	case PEF2256_FRAME_E1_AUTO_MULTIFRAME:
> > +		fmr1 |=3D PEF2256_FMR1_XFS;
> > +		fmr2 |=3D PEF2256_FMR2_RFS_AUTO_MULTIFRAME;
> > +		break;
> > +	default:
> > +		dev_err(pef2256->dev, "Unsupported frame type %d\n", pef2256->frame_=
type);
> > +		return -EINVAL;
> > +	}
> > +	pef2256_write8(pef2256, PEF2256_FMR1, fmr1);
> > +	pef2256_write8(pef2256, PEF2256_FMR2, fmr2);
> > +
> > +	/* E1 default for the receive slicer threshold */
> > +	pef2256_write8(pef2256, PEF2256_LIM2, PEF2256_LIM2_SLT_THR50);
> > +	if (!pef2256->is_subordinate) {
> > +		/* SEC input, active high */
> > +		pef2256_write8(pef2256, PEF2256_GPC1, PEF2256_GPC1_CSFP_SEC_IN_HIGH);
> > +	} else {
> > +		/* Loop-timed */
> > +		pef2256_setbits8(pef2256, PEF2256_LIM2, PEF2256_LIM2_ELT);
> > +		/* FSC output, active high */
> > +		pef2256_write8(pef2256, PEF2256_GPC1, PEF2256_GPC1_CSFP_FSC_OUT_HIGH=
);
> > +	}
> > +
> > +	/* internal second timer, power on */
> > +	pef2256_write8(pef2256, PEF2256_GCR, 0x00);
> > +
> > +	/*
> > +	 * slave mode, local loop off, mode short-haul
> > +	 * In v2.x, bit3 is a forced 1 bit in the datasheet -> Need to be set.
> > +	 */
> > +	if (pef2256->version =3D=3D PEF2256_VERSION_1_2)
> > +		pef2256_write8(pef2256, PEF2256_LIM0, 0x00);
> > +	else
> > +		pef2256_write8(pef2256, PEF2256_LIM0, PEF2256_2X_LIM0_BIT3);
> > +
> > +	/* analog interface selected, remote loop off */
> > +	pef2256_write8(pef2256, PEF2256_LIM1, 0x00);
> > +
> > +	/*
> > +	 * SCLKR, SCLKX, RCLK configured to inputs,
> > +	 * XFMS active low, CLK1 and CLK2 pin configuration
> > +	 */
> > +	pef2256_write8(pef2256, PEF2256_PC5, 0x00);
> > +	pef2256_write8(pef2256, PEF2256_PC6, 0x00);
> > +
> > +	/*
> > +	 * 2.048 MHz system clocking rate, receive buffer 2 frames, transmit
> > +	 * buffer bypass, data sampled and transmitted on the falling edge of
> > +	 * SCLKR/X, automatic freeze signaling, data is active in the first
> > +	 * channel phase
> > +	 */
> > +	pef2256_write8(pef2256, PEF2256_SIC1, 0x00);
> > +	pef2256_write8(pef2256, PEF2256_SIC2, 0x00);
> > +	pef2256_write8(pef2256, PEF2256_SIC3, 0x00);
> > +
> > +	/* channel loop-back and single frame mode are disabled */
> > +	pef2256_write8(pef2256, PEF2256_LOOP, 0x00);
> > +
> > +	/* all bits of the transmitted service word are cleared */
> > +	pef2256_write8(pef2256, PEF2256_XSW, PEF2256_XSW_XY(0x1F));
> > +	/* CAS disabled and clear spare bit values */
> > +	pef2256_write8(pef2256, PEF2256_XSP, 0x00);
> > +
> > +	/* no transparent mode active */
> > +	pef2256_write8(pef2256, PEF2256_TSWM, 0x00);
> > +
> > +	/*
> > +	 * the transmit clock offset is cleared
> > +	 * the transmit time slot offset is cleared
> > +	 */
> > +	pef2256_write8(pef2256, PEF2256_XC0, 0x00);
> > +
> > +	/* Keep default value for the transmit offset */
> > +	pef2256_write8(pef2256, PEF2256_XC1, 0x9C);
> > +
> > +	/*
> > +	 * transmit pulse mask, default value from datasheet
> > +	 * transmitter in tristate mode
> > +	 */
> > +	if (pef2256->version =3D=3D PEF2256_VERSION_1_2) {
> > +		pef2256_write8(pef2256, PEF2256_XPM0, 0x7B);
> > +		pef2256_write8(pef2256, PEF2256_XPM1, 0x03);
> > +		pef2256_write8(pef2256, PEF2256_XPM2, PEF2256_XPM2_XLT | 0x00);
> > +	} else {
> > +		pef2256_write8(pef2256, PEF2256_XPM0, 0x9C);
> > +		pef2256_write8(pef2256, PEF2256_XPM1, 0x03);
> > +		pef2256_write8(pef2256, PEF2256_XPM2, PEF2256_XPM2_XLT | 0x00);
> > +	} =20
>=20
> Only first line seem different, could XPM1 and XPM2 be outside the if/els=
e ?

Sure.
Will be updated in v3.

>=20
> > +
> > +	/* "master" mode */
> > +	if (!pef2256->is_subordinate)
> > +		pef2256_setbits8(pef2256, PEF2256_LIM0, PEF2256_LIM0_MAS);
> > +
> > +	/* transmit line in normal operation */
> > +	pef2256_clrbits8(pef2256, PEF2256_XPM2, PEF2256_XPM2_XLT);
> > +
> > +	if (pef2256->version =3D=3D PEF2256_VERSION_1_2) {
> > +		/* receive input threshold =3D 0,21V */
> > +		pef2256_clrsetbits8(pef2256, PEF2256_LIM1, PEF2256_12_LIM1_RIL_MASK,
> > +				    PEF2256_12_LIM1_RIL_210);
> > +	} else {
> > +		/* receive input threshold =3D 0,21V */ =20
>=20
> Same comment twice, could be before the 'if' and remove the { } then ?

Will be updated in v3.

>=20
> > +		pef2256_clrsetbits8(pef2256, PEF2256_LIM1, PEF2256_2X_LIM1_RIL_MASK,
> > +				    PEF2256_2X_LIM1_RIL_210);
> > +	}
> > +	/* transmit line coding =3D HDB3 */
> > +	pef2256_clrsetbits8(pef2256, PEF2256_FMR0, PEF2256_FMR0_XC_MASK,
> > +			    PEF2256_FMR0_XC_HDB3); =20
>=20
> Wouldn't that fit in a single line with the new recommended 100 char max=
=20
> line length ? I thing it would be more readable as a single line.

Will be updated in v3 if it fits in 100 chars.
Same for the line right below related to the receive part.

>=20
> > +
> > +	/* receive line coding =3D HDB3 */
> > +	pef2256_clrsetbits8(pef2256, PEF2256_FMR0, PEF2256_FMR0_RC_MASK,
> > +			    PEF2256_FMR0_RC_HDB3);
> > +
> > +	/* detection of LOS alarm =3D 176 pulses (ie (10 + 1) * 16) */
> > +	pef2256_write8(pef2256, PEF2256_PCD, 10);
> > +
> > +	/* recovery of LOS alarm =3D 22 pulses (ie 21 + 1) */
> > +	pef2256_write8(pef2256, PEF2256_PCR, 21);
> > +
> > +	/* DCO-X center frequency enabled */
> > +	pef2256_setbits8(pef2256, PEF2256_CMR2, PEF2256_CMR2_DCOXC);
> > +
> > +	if (pef2256->is_subordinate) {
> > +		/* select RCLK source =3D 2M */
> > +		pef2256_clrsetbits8(pef2256, PEF2256_CMR1, PEF2256_CMR1_RS_MASK,
> > +				    PEF2256_CMR1_RS_DCOR_2048);
> > +		/* disable switching from RCLK to SYNC */
> > +		pef2256_setbits8(pef2256, PEF2256_CMR1, PEF2256_CMR1_DCS);
> > +	} =20
>=20
> I'd move the comments into a single one before the 'if', the two=20
> comments are related.

I will change to a single line comment but not before the 'if'.
The comment is related to the subordinate case and not global for 'all'
cases.

>=20
> > +
> > +	if (pef2256->version !=3D PEF2256_VERSION_1_2) {
> > +		/* during inactive channel phase switch RDO/RSIG into tri-state */
> > +		pef2256_setbits8(pef2256, PEF2256_SIC3, PEF2256_SIC3_RTRI);
> > +	} =20
>=20
> I'd put the comment before the 'if' and remove the { }

Same reason to keep as it.
The comment is specific to the if content.

>=20
> > +
> > +	if (!pef2256->is_tx_falling_edge) {
> > +		/* rising edge sync pulse transmit */ =20
>=20
> This comment doesn't seem to match the condition (rising versus falling).

if not falling, it is rising.

I will update in v3 to invert the condition and improve the comment by
mentioning transmit and receive in each cases.

>=20
> > +		pef2256_clrsetbits8(pef2256, PEF2256_SIC3,
> > +				    PEF2256_SIC3_RESR, PEF2256_SIC3_RESX);
> > +	} else {
> > +		/* rising edge sync pulse receive */ =20
>=20
> This comment doesn't seem to match the condition (receive versus tx).
>=20
> > +		pef2256_clrsetbits8(pef2256, PEF2256_SIC3,
> > +				    PEF2256_SIC3_RESX, PEF2256_SIC3_RESR);
> > +	}
> > +
> > +	/* transmit offset counter (XCO10..0) =3D 4 */
> > +	pef2256_write8(pef2256, PEF2256_XC0, 0);
> > +	pef2256_write8(pef2256, PEF2256_XC1, 4);
> > +	/* receive offset counter (RCO10..0) =3D 4 */
> > +	pef2256_write8(pef2256, PEF2256_RC0, 0);
> > +	pef2256_write8(pef2256, PEF2256_RC1, 4);
> > +
> > +	/* system clock rate */
> > +	switch (pef2256->sysclk_rate) {
> > +	case 2048000:
> > +		sic1 =3D PEF2256_SIC1_SSC_2048;
> > +		break;
> > +	case 4096000:
> > +		sic1 =3D PEF2256_SIC1_SSC_4096;
> > +		break;
> > +	case 8192000:
> > +		sic1 =3D PEF2256_SIC1_SSC_8192;
> > +		break;
> > +	case 16384000:
> > +		sic1 =3D PEF2256_SIC1_SSC_16384;
> > +		break;
> > +	default:
> > +		dev_err(pef2256->dev, "Unsupported sysclk rate %u\n", pef2256->syscl=
k_rate);
> > +		return -EINVAL;
> > +	}
> > +	pef2256_clrsetbits8(pef2256, PEF2256_SIC1, PEF2256_SIC1_SSC_MASK, sic=
1);
> > +
> > +	/* data clock rate */
> > +	switch (pef2256->data_rate) {
> > +	case 2048000:
> > +		fmr1 =3D PEF2256_FMR1_SSD_2048;
> > +		sic1 =3D PEF2256_SIC1_SSD_2048;
> > +		break;
> > +	case 4096000:
> > +		fmr1 =3D PEF2256_FMR1_SSD_4096;
> > +		sic1 =3D PEF2256_SIC1_SSD_4096;
> > +		break;
> > +	case 8192000:
> > +		fmr1 =3D PEF2256_FMR1_SSD_8192;
> > +		sic1 =3D PEF2256_SIC1_SSD_8192;
> > +		break;
> > +	case 16384000:
> > +		fmr1 =3D PEF2256_FMR1_SSD_16384;
> > +		sic1 =3D PEF2256_SIC1_SSD_16384;
> > +		break;
> > +	default:
> > +		dev_err(pef2256->dev, "Unsupported data rate %u\n", pef2256->data_ra=
te);
> > +		return -EINVAL;
> > +	}
> > +	pef2256_clrsetbits8(pef2256, PEF2256_FMR1, PEF2256_FMR1_SSD_MASK, fmr=
1);
> > +	pef2256_clrsetbits8(pef2256, PEF2256_SIC1, PEF2256_SIC1_SSD_MASK, sic=
1);
> > +
> > +	/* channel phase */
> > +	pef2256_clrsetbits8(pef2256, PEF2256_SIC2, PEF2256_SIC2_SICS_MASK,
> > +			    PEF2256_SIC2_SICS(pef2256->channel_phase));
> > +
> > +	if (pef2256->is_subordinate) {
> > +		/* transmit buffer size =3D 2 frames */
> > +		pef2256_clrsetbits8(pef2256, PEF2256_SIC1, PEF2256_SIC1_XBS_MASK,
> > +				    PEF2256_SIC1_XBS_2FRAMES);
> > +		/* transmit transparent mode */
> > +		pef2256_setbits8(pef2256, PEF2256_XSW, PEF2256_XSW_XTM);
> > +	} =20
>=20
> Could this block get regrouped with the RX block depending on=20
> is_subordinate ?

Yes,
Will be done in v3.

>=20
> > +
> > +	/* error counter latched every 1s */
> > +	pef2256_setbits8(pef2256, PEF2256_FMR1, PEF2256_FMR1_ECM);
> > +	/* error counter mode COFA */
> > +	pef2256_setbits8(pef2256, PEF2256_GCR, PEF2256_GCR_ECMC);
> > +	/* errors in service words have no influence */
> > +	pef2256_setbits8(pef2256, PEF2256_RC0, PEF2256_RC0_SWD);
> > +	/* 4 consecutive incorrect FAS causes loss of sync */
> > +	pef2256_setbits8(pef2256, PEF2256_RC0, PEF2256_RC0_ASY4);
> > +	/* Si-Bit, Spare bit For International, FAS word */
> > +	pef2256_setbits8(pef2256, PEF2256_XSW, PEF2256_XSW_XSIS);
> > +	pef2256_setbits8(pef2256, PEF2256_XSP, PEF2256_XSP_XSIF);
> > +
> > +	/* port RCLK is output */
> > +	pef2256_setbits8(pef2256, PEF2256_PC5, PEF2256_PC5_CRP);
> > +	/* status changed interrupt at both up and down */
> > +	pef2256_setbits8(pef2256, PEF2256_GCR, PEF2256_GCR_SCI);
> > +
> > +	/* Clear any ISR2 pending interrupts and unmask needed interrupts */
> > +	pef2256_read8(pef2256, PEF2256_ISR2);
> > +	pef2256_clrbits8(pef2256, PEF2256_IMR2, PEF2256_INT2_LOS | PEF2256_IN=
T2_AIS);
> > +
> > +	/* reset lines */
> > +	pef2256_write8(pef2256, PEF2256_CMDR, PEF2256_CMDR_RRES | PEF2256_CMD=
R_XRES);
> > +	return 0;
> > +}
> > +
> > +static int pef2256_setup(struct pef2256 *pef2256)
> > +{
> > +	if (!pef2256->is_e1) {
> > +		dev_err(pef2256->dev, "Only E1 line is currently supported\n");
> > +		return -EOPNOTSUPP;
> > +	}
> > +
> > +	return pef2256_setup_e1(pef2256); =20
>=20
> In order to use future addition of other modes, I'd do:
>=20
> 	if (!pef2256->is_e1)
> 		return pef2256_setup_e1(pef2256);
>=20
> 	dev_err(pef2256->dev, "Only E1 line is currently supported\n");
> 	return -EOPNOTSUPP;
>=20

Will be changed in v3 using your proposition (with 'if' condition fixed).

> > +}
> > +
> > +
> > +
> > +static void pef2256_isr_default_handler(struct pef2256 *pef2256, u8 nb=
r, u8 isr)
> > +{
> > +	dev_warn(pef2256->dev, "ISR%u: 0x%02x not handled\n", nbr, isr);
> > +}
> > +
> > +static bool pef2256_is_carrier_on(struct pef2256 *pef2256)
> > +{
> > +	u8 frs0;
> > +
> > +	frs0 =3D pef2256_read8(pef2256, PEF2256_FRS0);
> > +	return !(frs0 & (PEF2256_FRS0_LOS | PEF2256_FRS0_AIS));
> > +}
> > +
> > +static void pef2256_isr2_handler(struct pef2256 *pef2256, u8 nbr, u8 i=
sr)
> > +{
> > +	bool is_changed =3D false;
> > +	unsigned long flags;
> > +	bool is_carrier_on;
> > +
> > +	if (isr & (PEF2256_INT2_LOS | PEF2256_INT2_AIS)) {
> > +
> > +		spin_lock_irqsave(&pef2256->lock, flags);
> > +		is_carrier_on =3D pef2256_is_carrier_on(pef2256);
> > +		if (is_carrier_on !=3D pef2256->is_carrier_on) {
> > +			pef2256->is_carrier_on =3D is_carrier_on;
> > +			is_changed =3D true;
> > +		}
> > +		spin_unlock_irqrestore(&pef2256->lock, flags); =20
>=20
> Do we really need spin_locks for that ?
> If atomicity is really an issue, may we use atomic operations instead ?

Indeed, I can use atomic ops here.
Will be changed in v3.

>=20
> > +
> > +		if (is_changed)
> > +			atomic_notifier_call_chain(&pef2256->event_notifier_list,
> > +						   PEF2256_EVENT_CARRIER, NULL);
> > +	}
> > +}
> > +

Thanks for the review.

Regards,
Herv=C3=A9

--=20
Herv=C3=A9 Codina, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

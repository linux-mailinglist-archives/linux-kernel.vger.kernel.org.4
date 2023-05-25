Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D23A7710C78
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 14:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241122AbjEYMyf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 08:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240404AbjEYMyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 08:54:22 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E866135;
        Thu, 25 May 2023 05:54:19 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 34PCrdrO005723;
        Thu, 25 May 2023 07:53:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1685019219;
        bh=6ks66yZV5gcEqGgIUg5LbU7F3LbUrto/eH+llPvKqdE=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=odMtc5DxIo5ppR5sgJNi9JAWEZ+rLNZAW34GpZlVlUYWm6vKgKu6d5yls9aahr3c9
         7B052k0opU+ux7gLR7y6FMOfnoymvm2lxsciC+qhwgoQeqJQrLX9EFD1OWvGzEQNCr
         qblLB1Ax/1ulfnVB23Iou4TYWBL2WE0/UhXDRGlM=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 34PCrd5O123006
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 25 May 2023 07:53:39 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 25
 May 2023 07:53:39 -0500
Received: from DLEE101.ent.ti.com ([fe80::91ee:60bc:bfb7:851c]) by
 DLEE101.ent.ti.com ([fe80::91ee:60bc:bfb7:851c%18]) with mapi id
 15.01.2507.023; Thu, 25 May 2023 07:53:39 -0500
From:   "Ding, Shenghao" <shenghao-ding@ti.com>
To:     Takashi Iwai <tiwai@suse.de>
CC:     Shenghao Ding <13916275206@139.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "pierre-louis.bossart@linux.intel.com" 
        <pierre-louis.bossart@linux.intel.com>,
        "Lu, Kevin" <kevin-lu@ti.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Xu, Baojun" <x1077012@ti.com>, "Gupta, Peeyush" <peeyush@ti.com>,
        "Navada Kanyana, Mukund" <navada@ti.com>,
        "gentuser@gmail.com" <gentuser@gmail.com>,
        "Ryan_Chu@wistron.com" <Ryan_Chu@wistron.com>,
        "Sam_Wu@wistron.com" <Sam_Wu@wistron.com>
Subject: RE: [EXTERNAL] Re: [PATCH v3 4/5] ALSA: hda/tas2781: Add tas2781 HDA
 driver
Thread-Topic: [EXTERNAL] Re: [PATCH v3 4/5] ALSA: hda/tas2781: Add tas2781 HDA
 driver
Thread-Index: AQHZi7qiFX/KEOnLRkSXJDizgQHnya9nuCRggABbjACAAuPwoA==
Date:   Thu, 25 May 2023 12:53:38 +0000
Message-ID: <0102db2e22dc472091a586bb73b467d9@ti.com>
References: <20230519080227.20224-1-13916275206@139.com>
        <871qjayuvv.wl-tiwai@suse.de>   <9daf95da47b540329aa9fbbd2df5e504@ti.com>
 <87353ngtp1.wl-tiwai@suse.de>
In-Reply-To: <87353ngtp1.wl-tiwai@suse.de>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.250.162.66]
x-exclaimer-md-config: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Takashi Iwai <tiwai@suse.de>
> Sent: Tuesday, May 23, 2023 7:43 PM
> To: Ding, Shenghao <shenghao-ding@ti.com>
> Cc: Shenghao Ding <13916275206@139.com>; broonie@kernel.org;
> devicetree@vger.kernel.org; krzysztof.kozlowski+dt@linaro.org;
> robh+dt@kernel.org; lgirdwood@gmail.com; perex@perex.cz; pierre-
> louis.bossart@linux.intel.com; Lu, Kevin <kevin-lu@ti.com>; alsa-
> devel@alsa-project.org; linux-kernel@vger.kernel.org; Xu, Baojun
> <x1077012@ti.com>; Gupta, Peeyush <peeyush@ti.com>; Navada Kanyana,
> Mukund <navada@ti.com>; gentuser@gmail.com; Ryan_Chu@wistron.com;
> Sam_Wu@wistron.com
> Subject: Re: [EXTERNAL] Re: [PATCH v3 4/5] ALSA: hda/tas2781: Add tas2781
> HDA driver
>=20
> On Tue, 23 May 2023 13:22:03 +0200,
> Ding, Shenghao wrote:
> >
> > > +	[ALC287_FIXUP_TAS2781_I2C_2] =3D {
> > > +		.type =3D HDA_FIXUP_FUNC,
> > > +		.v.func =3D tas2781_fixup_i2c,
> > > +		.chained =3D true,
> > > +		.chain_id =3D ALC269_FIXUP_THINKPAD_ACPI,
> > > +	},
> > > +	[ALC287_FIXUP_TAS2781_I2C_4] =3D {
> > > +		.type =3D HDA_FIXUP_FUNC,
> > > +		.v.func =3D tas2781_fixup_i2c,
> > > +		.chained =3D true,
> > > +		.chain_id =3D ALC269_FIXUP_THINKPAD_ACPI,
> > > +	},
> >
> > What's a difference between *_2 and *_4?
> > Combine them into ALC287_FIXUP_TAS2781_I2C
>=20
> Hm, so there is no difference in stereo and quad speakers?
Yes, our firmware defines the stereo or quad speaker
>=20
> > > +static int tas2781_save_calibration(struct tasdevice_priv
> > > +*tas_priv) {
> > > +	efi_guid_t efi_guid =3D EFI_GUID(0x02f9af02, 0x7734, 0x4233, 0xb4,
> 0x3d,
> > > +		0x93, 0xfe, 0x5a, 0xa3, 0x5d, 0xb3);
> > > +	static efi_char16_t efi_name[] =3D L"CALI_DATA";
> > > +	struct hda_codec *codec =3D tas_priv->codec;
> > > +	unsigned int subid =3D codec->core.subsystem_id & 0xFFFF;
> > > +	struct tm *tm =3D &tas_priv->tm;
> > > +	unsigned int attr, crc;
> > > +	unsigned int *tmp_val;
> > > +	efi_status_t status;
> > > +	int ret =3D 0;
> > > +
> > > +	//Lenovo devices
> > > +	if ((subid =3D=3D 0x387d) || (subid =3D=3D 0x387e) || (subid =3D=3D=
 0x3881)
> > > +		|| (subid =3D=3D 0x3884) || (subid =3D=3D 0x3886) || (subid =3D=3D=
 0x38a7)
> > > +		|| (subid =3D=3D 0x38a8) || (subid =3D=3D 0x38ba) || (subid =3D=3D
> 0x38bb)
> > > +		|| (subid =3D=3D 0x38be) || (subid =3D=3D 0x38bf) || (subid =3D=3D=
 0x38c3)
> > > +		|| (subid =3D=3D 0x38cb) || (subid =3D=3D 0x38cd))
> > > +		efi_guid =3D EFI_GUID(0x1f52d2a1, 0xbb3a, 0x457d, 0xbc, 0x09,
> > > +			0x43, 0xa3, 0xf4, 0x31, 0x0a, 0x92);
> >
> > Here can be a problem: the device ID is embedded here, and it's hard to
> find out.  You'd better to make it some quirk flag that is set in a commo=
n
> place and check the flag here instead of checking ID at each place.
> >
> > Do you have example of the solution? I found some quirk flag is static =
in
> the patch_realtek.c, can't be accessed outside that file.
>=20
> You may store some values in struct hda_component, I suppose?
I will try it.
>=20
> BTW, please try to fix your mailer to do citation more correctly...
accept
>=20
>=20
> thanks,
>=20
> Takashi

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EEAE70DB68
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 13:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236166AbjEWLW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 07:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbjEWLWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 07:22:55 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C40BCF;
        Tue, 23 May 2023 04:22:54 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 34NBM4tX078568;
        Tue, 23 May 2023 06:22:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1684840924;
        bh=xuKQvXHJklOgkcPjezOZZ60CSNAUUih10lDCrfMjZ6k=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=gldnpfReGii3TR627fFtPNi0e3FxdVbeb52FWHMhMw6smcL41pvaxoe8KmzL23kLm
         Njjx3yFaMruV4oShTzSKWqUFC3LAPynmzvv9b9+ekc42YxvbW3T2dscEmlDlsFfyza
         C5fVMtuQyXyrtBuFC+KcEcid0YqTLwcOeuIbMgcI=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 34NBM4eG064268
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 23 May 2023 06:22:04 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 23
 May 2023 06:22:04 -0500
Received: from DLEE101.ent.ti.com ([fe80::91ee:60bc:bfb7:851c]) by
 DLEE101.ent.ti.com ([fe80::91ee:60bc:bfb7:851c%18]) with mapi id
 15.01.2507.023; Tue, 23 May 2023 06:22:03 -0500
From:   "Ding, Shenghao" <shenghao-ding@ti.com>
To:     Takashi Iwai <tiwai@suse.de>, Shenghao Ding <13916275206@139.com>
CC:     "broonie@kernel.org" <broonie@kernel.org>,
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
Thread-Index: AQHZi7qiFX/KEOnLRkSXJDizgQHnya9nuCRg
Date:   Tue, 23 May 2023 11:22:03 +0000
Message-ID: <9daf95da47b540329aa9fbbd2df5e504@ti.com>
References: <20230519080227.20224-1-13916275206@139.com>
 <871qjayuvv.wl-tiwai@suse.de>
In-Reply-To: <871qjayuvv.wl-tiwai@suse.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.85.15.102]
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


-----Original Message-----
From: Takashi Iwai <tiwai@suse.de>=20
Sent: Sunday, May 21, 2023 4:03 PM
To: Shenghao Ding <13916275206@139.com>
Cc: broonie@kernel.org; devicetree@vger.kernel.org; krzysztof.kozlowski+dt@=
linaro.org; robh+dt@kernel.org; lgirdwood@gmail.com; perex@perex.cz; pierre=
-louis.bossart@linux.intel.com; Lu, Kevin <kevin-lu@ti.com>; Ding, Shenghao=
 <shenghao-ding@ti.com>; alsa-devel@alsa-project.org; linux-kernel@vger.ker=
nel.org; Xu, Baojun <x1077012@ti.com>; Gupta, Peeyush <peeyush@ti.com>; Nav=
ada Kanyana, Mukund <navada@ti.com>; gentuser@gmail.com; Ryan_Chu@wistron.c=
om; Sam_Wu@wistron.com
Subject: [EXTERNAL] Re: [PATCH v3 4/5] ALSA: hda/tas2781: Add tas2781 HDA d=
river

On Fri, 19 May 2023 10:02:27 +0200,
Shenghao Ding wrote:
>=20
> Create tas2781 HDA driver.
>=20
> Signed-off-by: Shenghao Ding <13916275206@139.com>

First of all, please give more description.  It's far more changes than wri=
tten in four words.

Also, don't forget to put me on Cc.  I almost overlooked this one.

> diff --git a/sound/pci/hda/patch_realtek.c=20
> b/sound/pci/hda/patch_realtek.c index 172ffc2c332b..f5b912f90018=20
> 100644
> --- a/sound/pci/hda/patch_realtek.c
> +++ b/sound/pci/hda/patch_realtek.c
> +static int comp_match_tas2781_dev_name(struct device *dev, void=20
> +*data) {
> +	struct scodec_dev_name *p =3D data;
> +	const char *d =3D dev_name(dev);
> +	int n =3D strlen(p->bus);
> +	char tmp[32];
> +
> +	/* check the bus name */
> +	if (strncmp(d, p->bus, n))
> +		return 0;
> +	/* skip the bus number */
> +	if (isdigit(d[n]))
> +		n++;
> +	/* the rest must be exact matching */
> +	snprintf(tmp, sizeof(tmp), "-%s:00", p->hid);
> +
> +	return !strcmp(d + n, tmp);
> +}

You don't use the index here...
Accepted
> +static void tas2781_generic_fixup(struct hda_codec *cdc, int action,
> +	const char *bus, const char *hid, int count) {
> +	struct device *dev =3D hda_codec_dev(cdc);
> +	struct alc_spec *spec =3D cdc->spec;
> +	struct scodec_dev_name *rec;
> +	int ret, i;
> +
> +	switch (action) {
> +	case HDA_FIXUP_ACT_PRE_PROBE:
> +		for (i =3D 0; i < count; i++) {
> +			rec =3D devm_kmalloc(dev, sizeof(*rec), GFP_KERNEL);
> +			if (!rec)
> +				return;
> +			rec->bus =3D bus;
> +			rec->hid =3D hid;
> +			rec->index =3D i;

... and assigning here.  It means that the multiple instances would silentl=
y break.  It's better to catch here instead.
Accepted
> +static void tas2781_fixup_i2c(struct hda_codec *cdc,
> +	const struct hda_fixup *fix, int action) {
> +	 tas2781_generic_fixup(cdc, action, "i2c", "TIAS2781", 1); }
> +
>  /* for alc295_fixup_hp_top_speakers */  #include "hp_x360_helper.c"
> =20
> @@ -7201,6 +7260,8 @@ enum {
>  	ALC287_FIXUP_YOGA9_14IAP7_BASS_SPK_PIN,
>  	ALC295_FIXUP_DELL_INSPIRON_TOP_SPEAKERS,
>  	ALC236_FIXUP_DELL_DUAL_CODECS,
> +	ALC287_FIXUP_TAS2781_I2C_2,
> +	ALC287_FIXUP_TAS2781_I2C_4
>  };
> =20
>  /* A special fixup for Lenovo C940 and Yoga Duet 7; @@ -9189,6=20
> +9250,18 @@ static const struct hda_fixup alc269_fixups[] =3D {
>  		.chained =3D true,
>  		.chain_id =3D ALC255_FIXUP_DELL1_MIC_NO_PRESENCE,
>  	},
> +	[ALC287_FIXUP_TAS2781_I2C_2] =3D {
> +		.type =3D HDA_FIXUP_FUNC,
> +		.v.func =3D tas2781_fixup_i2c,
> +		.chained =3D true,
> +		.chain_id =3D ALC269_FIXUP_THINKPAD_ACPI,
> +	},
> +	[ALC287_FIXUP_TAS2781_I2C_4] =3D {
> +		.type =3D HDA_FIXUP_FUNC,
> +		.v.func =3D tas2781_fixup_i2c,
> +		.chained =3D true,
> +		.chain_id =3D ALC269_FIXUP_THINKPAD_ACPI,
> +	},

What's a difference between *_2 and *_4?
Combine them into ALC287_FIXUP_TAS2781_I2C
> --- /dev/null
> +++ b/sound/pci/hda/tas2781_hda_i2c.c
> +static int tas2781_acpi_get_i2c_resource(struct acpi_resource
> +	*ares, void *data)
> +{
> +	struct tasdevice_priv *tas_priv =3D (struct tasdevice_priv *)data;
> +	struct acpi_resource_i2c_serialbus *sb;
> +
> +	if (i2c_acpi_get_i2c_resource(ares, &sb)) {
> +		if (sb->slave_address !=3D TAS2781_GLOBAL_ADDR) {
> +			tas_priv->tasdevice[tas_priv->ndev].dev_addr =3D
> +				(unsigned int) sb->slave_address;
> +			tas_priv->ndev++;
> +		} else
> +			tas_priv->glb_addr.dev_addr =3D TAS2781_GLOBAL_ADDR;
> +

Did you run checkpatch.pl?  I thought it would complain.
Accept.
> +static void tas2781_hda_playback_hook(struct device *dev, int action)=20
> +{
> +	struct tasdevice_priv *tas_priv =3D dev_get_drvdata(dev);
> +	int ret =3D 0;
> +
> +	dev_info(tas_priv->dev, "%s: action =3D %d\n", __func__, action);

Don't use dev_info().  It'd be dev_dbg() at most.
Accept.
> +	switch (action) {
> +	case HDA_GEN_PCM_ACT_OPEN:
> +		pm_runtime_get_sync(dev);
> +		mutex_lock(&tas_priv->codec_lock);
> +		tas_priv->cur_conf =3D 0;
> +		tas_priv->rcabin.profile_cfg_id =3D 1;
> +		tasdevice_tuning_switch(tas_priv, 0);
> +		mutex_unlock(&tas_priv->codec_lock);
> +		break;
> +	case HDA_GEN_PCM_ACT_CLOSE:
> +		mutex_lock(&tas_priv->codec_lock);
> +		tasdevice_tuning_switch(tas_priv, 1);
> +		mutex_unlock(&tas_priv->codec_lock);
> +
> +		pm_runtime_mark_last_busy(dev);
> +		pm_runtime_put_autosuspend(dev);
> +		break;
> +	default:
> +		dev_warn(tas_priv->dev, "Playback action not supported: %d\n",
> +			action);
> +		break;
> +	}
> +
> +	if (ret)
> +		dev_err(tas_priv->dev, "Regmap access fail: %d\n", ret);

The ret is never used.
Accept.
> +static int tasdevice_set_profile_id(struct snd_kcontrol *kcontrol,
> +		struct snd_ctl_elem_value *ucontrol) {
> +	struct tasdevice_priv *tas_priv =3D snd_kcontrol_chip(kcontrol);
> +
> +	tas_priv->rcabin.profile_cfg_id =3D ucontrol->value.integer.value[0];
> +
> +	return 1;

It should return 0 if the value is unchanged.
(Ditto for other *_put functions)
Accept.
> +static int tasdevice_create_control(struct tasdevice_priv *tas_priv)=20
> +{
> +	char prof_ctrl_name[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
> +	struct hda_codec *codec =3D tas_priv->codec;
> +	struct snd_kcontrol_new prof_ctrl =3D {
> +		.name =3D prof_ctrl_name,
> +		.iface =3D SNDRV_CTL_ELEM_IFACE_CARD,
> +		.info =3D tasdevice_info_profile,
> +		.get =3D tasdevice_get_profile_id,
> +		.put =3D tasdevice_set_profile_id,
> +	};
> +	int ret;
> +
> +	/* Create a mixer item for selecting the active profile */
> +	scnprintf(prof_ctrl_name, SNDRV_CTL_ELEM_ID_NAME_MAXLEN,
> +		"tasdev-profile-id");

A too bad name as a control element.  Use a more readable one.
Accept.
> +static int tasdevice_info_programs(struct snd_kcontrol *kcontrol,
> +			struct snd_ctl_elem_info *uinfo)
> +{
> +	struct tasdevice_priv *tas_priv =3D snd_kcontrol_chip(kcontrol);
> +	struct tasdevice_fw *tas_fw =3D tas_priv->fmw;
> +
> +	uinfo->type =3D SNDRV_CTL_ELEM_TYPE_INTEGER;
> +	uinfo->count =3D 1;
> +	uinfo->value.integer.min =3D 0;
> +	uinfo->value.integer.max =3D (int)tas_fw->nr_programs;

The cast is superfluous.
Accept.
> +static int tasdevice_info_configurations(
> +	struct snd_kcontrol *kcontrol, struct snd_ctl_elem_info *uinfo) {
> +	struct tasdevice_priv *tas_priv =3D snd_kcontrol_chip(kcontrol);
> +	struct tasdevice_fw *tas_fw =3D tas_priv->fmw;
> +
> +	uinfo->type =3D SNDRV_CTL_ELEM_TYPE_INTEGER;
> +	uinfo->count =3D 1;
> +	uinfo->value.integer.min =3D 0;
> +	uinfo->value.integer.max =3D (int)tas_fw->nr_configurations - 1;

Ditto.
Accept.
> +/**
> + * tas2781_digital_getvol - get the volum control
> + * @kcontrol: control pointer
> + * @ucontrol: User data
> + * Customer Kcontrol for tas2781 is primarily for regmap booking,=20
> +paging
> + * depends on internal regmap mechanism.
> + * tas2781 contains book and page two-level register map, especially
> + * book switching will set the register BXXP00R7F, after switching to=20
> +the
> + * correct book, then leverage the mechanism for paging to access the
> + * register.
> + */

You shouldn't use the kerneldoc marker "/**" for local static functions.  I=
t's not a part of API.
Accept.
> +static int tasdevice_dsp_create_ctrls(struct tasdevice_priv
> +	*tas_priv)
> +{
> +	char prog_name[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
> +	char conf_name[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
> +	struct hda_codec *codec =3D tas_priv->codec;
> +	struct snd_kcontrol_new prog_ctl =3D {
> +		.name =3D prog_name,
> +		.iface =3D SNDRV_CTL_ELEM_IFACE_CARD,
> +		.info =3D tasdevice_info_programs,
> +		.get =3D tasdevice_program_get,
> +		.put =3D tasdevice_program_put,
> +	};
> +	struct snd_kcontrol_new conf_ctl =3D {
> +		.name =3D conf_name,
> +		.iface =3D SNDRV_CTL_ELEM_IFACE_CARD,
> +		.info =3D tasdevice_info_configurations,
> +		.get =3D tasdevice_config_get,
> +		.put =3D tasdevice_config_put,
> +	};
> +	int ret;
> +
> +	scnprintf(prog_name, SNDRV_CTL_ELEM_ID_NAME_MAXLEN, "tasdev-prog-id");
> +	scnprintf(conf_name, SNDRV_CTL_ELEM_ID_NAME_MAXLEN,=20
> +"tasdev-conf-id");

Please use better names.
Accept.
> +static void tas2781_apply_calib(struct tasdevice_priv *tas_priv) {
> +	unsigned char page_array[CALIB_MAX] =3D {0x17, 0x18, 0x18, 0x0d, 0x18};
> +	unsigned char rgno_array[CALIB_MAX] =3D {0x74, 0x0c, 0x14, 0x3c,=20
> +0x7c};

Should be static const arrays.
Accept.
> +static int tas2781_save_calibration(struct tasdevice_priv *tas_priv)=20
> +{
> +	efi_guid_t efi_guid =3D EFI_GUID(0x02f9af02, 0x7734, 0x4233, 0xb4, 0x3d=
,
> +		0x93, 0xfe, 0x5a, 0xa3, 0x5d, 0xb3);
> +	static efi_char16_t efi_name[] =3D L"CALI_DATA";
> +	struct hda_codec *codec =3D tas_priv->codec;
> +	unsigned int subid =3D codec->core.subsystem_id & 0xFFFF;
> +	struct tm *tm =3D &tas_priv->tm;
> +	unsigned int attr, crc;
> +	unsigned int *tmp_val;
> +	efi_status_t status;
> +	int ret =3D 0;
> +
> +	//Lenovo devices
> +	if ((subid =3D=3D 0x387d) || (subid =3D=3D 0x387e) || (subid =3D=3D 0x3=
881)
> +		|| (subid =3D=3D 0x3884) || (subid =3D=3D 0x3886) || (subid =3D=3D 0x3=
8a7)
> +		|| (subid =3D=3D 0x38a8) || (subid =3D=3D 0x38ba) || (subid =3D=3D 0x3=
8bb)
> +		|| (subid =3D=3D 0x38be) || (subid =3D=3D 0x38bf) || (subid =3D=3D 0x3=
8c3)
> +		|| (subid =3D=3D 0x38cb) || (subid =3D=3D 0x38cd))
> +		efi_guid =3D EFI_GUID(0x1f52d2a1, 0xbb3a, 0x457d, 0xbc, 0x09,
> +			0x43, 0xa3, 0xf4, 0x31, 0x0a, 0x92);

Here can be a problem: the device ID is embedded here, and it's hard to fin=
d out.  You'd better to make it some quirk flag that is set in a common pla=
ce and check the flag here instead of checking ID at each place.

Do you have example of the solution? I found some quirk flag is static in t=
he patch_realtek.c, can't be accessed outside that file.

> +	crc =3D crc32(~0, tas_priv->cali_data.data, 84) ^ ~0;
> +	dev_info(tas_priv->dev, "cali crc 0x%08x PK tmp_val 0x%08x\n",
> +		crc, tmp_val[21]);

If it's a dev_info() output, make it more understandable.
I'll fix it
> +	if (crc =3D=3D tmp_val[21]) {
> +		time64_to_tm(tmp_val[20], 0, tm);
> +		dev_info(tas_priv->dev, "%4ld-%2d-%2d, %2d:%2d:%2d\n",
> +			tm->tm_year, tm->tm_mon, tm->tm_mday,
> +			tm->tm_hour, tm->tm_min, tm->tm_sec);

Ditto.  Or, make them a debug print instead.
Accepted
> +static int tas2781_runtime_suspend(struct device *dev) {
> +	struct tasdevice_priv *tas_priv =3D dev_get_drvdata(dev);
> +	int i, ret =3D 0;
> +
> +	dev_info(tas_priv->dev, "Runtime Suspend\n");

It must be a debug print.  Otherwise it'll be too annoying.
Accepted
Also, as a minor nitpicking, there are many functions that set ret =3D 0 at=
 the beginning but never used.  The unconditional 0 initialization is often=
 a bad sign indicating that the author doesn't think fully of the code flow=
.  Please revisit those.


thanks,

Takashi

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2027F713891
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 09:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjE1Hyu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 03:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjE1Hys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 03:54:48 -0400
Received: from smtp.smtpout.orange.fr (smtp-24.smtpout.orange.fr [80.12.242.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61EE3F7
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 00:54:38 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id 3BETqtnSL8aX93BETqQLQb; Sun, 28 May 2023 09:54:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1685260476;
        bh=rlF+tPpF0RKAj6/8Ph4lFw7GmY9q1bfRc9wg4tDEi/8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=FuIyuO0fvGmU0+CFIolbOSXt80ZVi3UELAOj2gVeP4qoHOeJgkb0EY1DKR/eUxou5
         +orvC68vwWdSD11FzJO9EmFM4IQREvrSzxYKC21Im3Kr+zaKY7J6Dv666WqHSlCjTx
         1rFwExDuGEpxEvjYuv96bPRECDxUUJ5pbh21QBKaCbpfBOejiT3zrN9Ec9iLkEbfD7
         hOMnDrC+TvCgzJCkZyXh9GpcmNKmoRvmiXaIsFglYVLSnUeZcgEp+21kmvetlyQ4Q1
         0I+NFTP/S6XSw5+yIanEgsdWjST9ULWBnnmzY5NqQYMJZ0VDEcU5gskcJMvQXCPFQ1
         aaCOzmh2wKk5A==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 28 May 2023 09:54:36 +0200
X-ME-IP: 86.243.2.178
Message-ID: <4f4da428-5fff-5fc9-2edf-aa74d556519c@wanadoo.fr>
Date:   Sun, 28 May 2023 09:54:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 5/6] ALSA: hda/tas2781: Add tas2781 HDA driver
Content-Language: fr
To:     Shenghao Ding <13916275206@139.com>
Cc:     Ryan_Chu@wistron.com, Sam_Wu@wistron.com,
        alsa-devel@alsa-project.org, broonie@kernel.org,
        devicetree@vger.kernel.org, gentuser@gmail.com, kevin-lu@ti.com,
        krzysztof.kozlowski+dt@linaro.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, navada@ti.com, peeyush@ti.com,
        perex@perex.cz, pierre-louis.bossart@linux.intel.com,
        robh+dt@kernel.org, shenghao-ding@ti.com, tiwai@suse.de,
        x1077012@ti.com
References: <20230527223613.11106-1-13916275206@139.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20230527223613.11106-1-13916275206@139.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 28/05/2023 à 00:36, Shenghao Ding a écrit :
> Create tas2781 HDA driver.
> 
> Signed-off-by: Shenghao Ding <13916275206-7R9yAhoRP9E@public.gmane.org>
> 
> ---
> Changes in v4:
>   - Add tiwai-l3A5Bk7waGM@public.gmane.org into Cc list
>   - remove unused ret in tas2781_hda_playback
>   - in all *__put function, return 0, if the value is unchanged
>   - remove superfluous
>   - rewrite the subid judgement
>   - dev_info to dev_dbg
>   Changes to be committed:
> 	modified:   sound/pci/hda/Kconfig
> 	modified:   sound/pci/hda/Makefile
> 	new file:   sound/pci/hda/tas2781_hda_i2c.c
> ---
>   sound/pci/hda/Kconfig           |  15 +
>   sound/pci/hda/Makefile          |   2 +
>   sound/pci/hda/tas2781_hda_i2c.c | 834 ++++++++++++++++++++++++++++++++
>   3 files changed, 851 insertions(+)
>   create mode 100644 sound/pci/hda/tas2781_hda_i2c.c

[...]

> +static int tas2781_acpi_get_i2c_resource(struct acpi_resource
> +	*ares, void *data)
> +{
> +	struct tasdevice_priv *tas_priv = (struct tasdevice_priv *)data;

Nit: Is the cast really needed?
(should you feel like removing it to ease reading, their are a few other 
onces elsewhere)

> +	struct acpi_resource_i2c_serialbus *sb;
> +
> +	if (i2c_acpi_get_i2c_resource(ares, &sb)) {
> +		if (sb->slave_address != TAS2781_GLOBAL_ADDR) {
> +			tas_priv->tasdevice[tas_priv->ndev].dev_addr =
> +				(unsigned int)sb->slave_address;
> +			tas_priv->ndev++;
> +		} else
> +			tas_priv->glb_addr.dev_addr = TAS2781_GLOBAL_ADDR;
> +

Nit: Unneeded NL (or missing {} around the 'else' branch if it is the 
style you prefer)

> +	}
> +
> +	return 1;
> +}

[...]

> +static int tasdevice_set_profile_id(struct snd_kcontrol *kcontrol,
> +		struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct tasdevice_priv *tas_priv = snd_kcontrol_chip(kcontrol);
> +	int ret = 0;
> +
> +	if (tas_priv->rcabin.profile_cfg_id !=
> +		ucontrol->value.integer.value[0]) {
> +		tas_priv->rcabin.profile_cfg_id =
> +			ucontrol->value.integer.value[0];
> +		ret = 0;

So ret is always 0?

Either it is not needed and a "return 0;" below  would be enough, either 
the function should be void (if changinf the prototype is possible, not 
sure), either there is a typo.

> +	}
> +
> +	return ret;
> +}
> +
> +static int tasdevice_create_control(struct tasdevice_priv *tas_priv)
> +{
> +	char prof_ctrl_name[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
> +	struct hda_codec *codec = tas_priv->codec;
> +	struct snd_kcontrol_new prof_ctrl = {
> +		.name = prof_ctrl_name,
> +		.iface = SNDRV_CTL_ELEM_IFACE_CARD,
> +		.info = tasdevice_info_profile,
> +		.get = tasdevice_get_profile_id,
> +		.put = tasdevice_set_profile_id,
> +	};
> +	int ret;
> +
> +	/* Create a mixer item for selecting the active profile */
> +	scnprintf(prof_ctrl_name, SNDRV_CTL_ELEM_ID_NAME_MAXLEN,
> +		"spk-profile-id");
> +	ret = snd_ctl_add(codec->card, snd_ctl_new1(&prof_ctrl, tas_priv));
> +	if (ret) {
> +		dev_err(tas_priv->dev, "Failed to add KControl %s = %d\n",

Nit: KControl here, Control a few lines below. I guess they should be 
the same.

> +			prof_ctrl.name, ret);
> +		goto out;
> +	}
> +
> +	dev_dbg(tas_priv->dev, "Added Control %s\n", prof_ctrl.name);
> +
> +out:
> +	return ret;
> +}

[...]

> +static int tasdevice_program_put(struct snd_kcontrol *kcontrol,
> +	struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct tasdevice_priv *tas_priv = snd_kcontrol_chip(kcontrol);
> +	unsigned int nr_program = ucontrol->value.integer.value[0];
> +	int ret = 0;
> +
> +	if (tas_priv->cur_prog != nr_program) {
> +		tas_priv->cur_prog = nr_program;
> +		ret = 1;

(Base on this, I guess, that the answer above for 
tasdevice_set_profile_id() is : typo s/0/1/)

> +	}
> +
> +	return ret;
> +}
> +
> +static int tasdevice_config_get(struct snd_kcontrol *kcontrol,
> +	struct snd_ctl_elem_value *ucontrol)
> +{
> +

Nit: Unneeded NL

> +	struct tasdevice_priv *tas_priv = snd_kcontrol_chip(kcontrol);
> +
> +	ucontrol->value.integer.value[0] = tas_priv->cur_conf;
> +
> +	return 0;
> +}

[...]

> +static int tas2781_save_calibration(struct tasdevice_priv *tas_priv)
> +{
> +	efi_guid_t efi_guid = EFI_GUID(0x02f9af02, 0x7734, 0x4233, 0xb4, 0x3d,
> +		0x93, 0xfe, 0x5a, 0xa3, 0x5d, 0xb3);
> +	static efi_char16_t efi_name[] = L"CALI_DATA";
> +	struct tm *tm = &tas_priv->tm;
> +	unsigned int attr, crc;
> +	unsigned int *tmp_val;
> +	efi_status_t status;
> +	int ret = 0;
> +
> +	//Lenovo devices

Nit: why a different style for comment?

> +	if (tas_priv->catlog_id == LENOVO)
> +		efi_guid = EFI_GUID(0x1f52d2a1, 0xbb3a, 0x457d, 0xbc, 0x09,
> +			0x43, 0xa3, 0xf4, 0x31, 0x0a, 0x92);
> +
> +	tas_priv->cali_data.total_sz = 0;
> +	/* Get real size of UEFI variable */
> +	status = efi.get_variable(efi_name, &efi_guid, &attr,
> +		&tas_priv->cali_data.total_sz, tas_priv->cali_data.data);
> +	if (status == EFI_BUFFER_TOO_SMALL) {
> +		ret = -ENODEV;
> +		/* Allocate data buffer of data_size bytes */
> +		tas_priv->cali_data.data = devm_kzalloc(tas_priv->dev,
> +			tas_priv->cali_data.total_sz, GFP_KERNEL);
> +		if (!tas_priv->cali_data.data)
> +			return -ENOMEM;
> +		/* Get variable contents into buffer */
> +		status = efi.get_variable(efi_name, &efi_guid, &attr,
> +			&tas_priv->cali_data.total_sz,
> +			tas_priv->cali_data.data);
> +		if (status != EFI_SUCCESS) {
> +			ret = -EINVAL;
> +			goto out;

Nit: return -EINVAL; as just a few lines above?

> +		}

If so, return -ENODEV; here would be more explicit.
So, 'ret' becomes useless and return 0; at the end of the function looks 
enough.

> +	}
> +
> +	tmp_val = (unsigned int *)tas_priv->cali_data.data;
> +
> +	crc = crc32(~0, tas_priv->cali_data.data, 84) ^ ~0;
> +	dev_dbg(tas_priv->dev, "cali crc 0x%08x PK tmp_val 0x%08x\n",
> +		crc, tmp_val[21]);
> +
> +	if (crc == tmp_val[21]) {
> +		time64_to_tm(tmp_val[20], 0, tm);
> +		dev_dbg(tas_priv->dev, "%4ld-%2d-%2d, %2d:%2d:%2d\n",
> +			tm->tm_year, tm->tm_mon, tm->tm_mday,
> +			tm->tm_hour, tm->tm_min, tm->tm_sec);
> +		tas2781_apply_calib(tas_priv);
> +	}
> +out:
> +	return ret;
> +}
> +
> +static void tasdevice_fw_ready(const struct firmware *fmw,
> +	void *context)
> +{
> +	struct tasdevice_priv *tas_priv = (struct tasdevice_priv *)context;
> +	struct hda_codec *codec = tas_priv->codec;
> +	int i, ret = 0;

Nit: = 0 is not needed

> +
> +	pm_runtime_get_sync(tas_priv->dev);
> +	mutex_lock(&tas_priv->codec_lock);
> +
> +	ret = tasdevice_rca_parser(tas_priv, fmw);
> +	if (ret)
> +		goto out;
> +	tasdevice_create_control(tas_priv);

CJ


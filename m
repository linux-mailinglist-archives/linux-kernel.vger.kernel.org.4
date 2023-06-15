Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D475731662
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 13:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343782AbjFOLVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 07:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244277AbjFOLVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 07:21:36 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E7582705
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 04:21:33 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9788faaca2dso274668566b.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 04:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686828092; x=1689420092;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pV+y4rT5kQxU13ZWSN4RWCUCARBYQF07f0m1RJyvFAA=;
        b=IYrdVZiFOin/Wd7Rq+fWzaFW8RkZmF77MVOWUyexrf5yAWVi/4t3qWhafp4WvJ7bBW
         SNevCE1Y3tT2+0BhvmNfKlzPDUjiL5rN1hxXFId7zs+QYeEpEiWDM/jK/U4G7nV1AOHd
         yd5ENhr7xtnUQ4IXHcEFL9/yKj1CEyJGmHHm99eRQiUXBbj//q0iubqSg2yyduYiHJPH
         V6bN0ywpis86GsfdZBD9NPEQmI6yNj6cgnJar0cGlFh3PLbngNcIxld7j3lSL9zgrTEy
         SaZSDRGZ28HdP5U//Il3ob3mhcmNqfiJR363hb3LyF468QnC778+uqWB0G+JjbPTW+Zw
         Kpzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686828092; x=1689420092;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pV+y4rT5kQxU13ZWSN4RWCUCARBYQF07f0m1RJyvFAA=;
        b=dJM5K+b6BDbPjxMHh1Obb8CoM0+sU3TeXk14iKX2rJ9e+kCNvLon2BNZsGsp6j4Vh9
         PKGGfGvCMk/+pFOJWZ4JTNijNZ4OJgNgzaCQIQS1bAvyTTffvX3SGhd9+2rdj4nuL/eF
         vYSW/wRF3lAIPtxIDl80SeIKzeBOnNks9S/Igdvls84Ohr1r8vB+VCqtnvcyCENt7cCw
         1nCidedwwp16ORECjKriX7kQ7BGTaW2Ht1bt4tIfldJy86uUkHXjwEzlxIN+Criz6whe
         H8+O63uPRQtqFzkZDX5ACBlIJu+fBKOCfKVtK5mlvBeez1hsHRpxn6peTvqBvbHU6P+M
         xB0g==
X-Gm-Message-State: AC+VfDz/CwJhyT0CpZEAJJwBK01uRdGoZOe4flvFrMg6DZz1Xi06qiSi
        KulLzmJEV/B9FJAAveyDTRzBgA==
X-Google-Smtp-Source: ACHHUZ59wFGqjNj2za4uofAV4ZCkscTF4ivQVEtbL+YESxcp9a2mKdimrRkPO/jFfPGpw/lip2Ym5A==
X-Received: by 2002:a17:906:7943:b0:982:4df6:6017 with SMTP id l3-20020a170906794300b009824df66017mr5926980ejo.77.1686828092062;
        Thu, 15 Jun 2023 04:21:32 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id a13-20020a170906684d00b009828dac8425sm1286289ejs.105.2023.06.15.04.21.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jun 2023 04:21:31 -0700 (PDT)
Message-ID: <8e9b62f3-d8c6-fea4-738b-c502f7167131@linaro.org>
Date:   Thu, 15 Jun 2023 13:21:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 2/2] ASoC: codecs: wsa884x: Add WSA884x family of
 speakers
Content-Language: en-US
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Patrick Lai <quic_plai@quicinc.com>
References: <20230612095716.118631-1-krzysztof.kozlowski@linaro.org>
 <20230612095716.118631-2-krzysztof.kozlowski@linaro.org>
 <493895cc-378a-d908-372b-0a873cc0800e@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <493895cc-378a-d908-372b-0a873cc0800e@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/06/2023 12:18, Srinivas Kandagatla wrote:
> Thanks Krzyztof,
> 
> few minor nits below.

Please trim unrelated context - it's easy to miss a comment between huge
quoted text.

>> +
>> +static const char * const wsa884x_dev_mode_text[] = {
>> +	"Speaker", "Receiver"
>> +};
>> +
>> +enum wsa884x_variant {
>> +	WSA8840 = 0x0,
>> +	WSA8845 = 0x5,
>> +	WSA8845H = 0xc,
> A proper defines for this makes more sense than a enum.

OK. I will also put the define next to respective register define.

> 


O_REG(2000), },
>> +	{ WSA884X_ANA_WO_CTL_1, 0x00 },
>> +	{ WSA884X_OTP_REG_38, 0x00 },
>> +	{ WSA884X_OTP_REG_40, 0x8 << WSA884X_OTP_REG_40_ISENSE_RESCAL_SHIFT },
> 
> FIELD macros?

Ack.

>> +};
>> +
>> +static void wsa884x_set_gain_parameters(struct wsa884x_priv *wsa884x)
>> +{
>> +	struct regmap *regmap = wsa884x->regmap;
>> +	unsigned int min_gain, igain, vgain, comp_offset;
>> +
>> +	/*
>> +	 * Downstream sets gain parameters customized per boards per use-case.
>> +	 * Choose here some sane values matching knowon users, like QRD8550
>> +	 * board:.
>> +	 *
>> +	 * Values match here downstream:
>> +	 * For WSA884X_RECEIVER - G_7P5_DB system gain
>> +	 * For WSA884X_SPEAKER - G_21_DB system gain
>> +	 */
>> +	if (wsa884x->dev_mode == WSA884X_RECEIVER) {
>> +		comp_offset = COMP_OFFSET4;
>> +		min_gain = G_M6_DB;
>> +		igain = ISENSE_18_DB;
>> +		vgain = VSENSE_M12_DB;
>> +	} else {
>> +		/* WSA884X_SPEAKER */
>> +		comp_offset = COMP_OFFSET0;
>> +		min_gain = G_0_DB;
>> +		igain = ISENSE_12_DB;
>> +		vgain = VSENSE_M24_DB;
>> +	}
>> +
>> +	regmap_update_bits(regmap, WSA884X_ISENSE2,
>> +			   WSA884X_ISENSE2_ISENSE_GAIN_CTL_MASK,
>> +			   igain << WSA884X_ISENSE2_ISENSE_GAIN_CTL_SHIFT);
>> +	regmap_update_bits(regmap, WSA884X_VSENSE1,
>> +			   WSA884X_VSENSE1_GAIN_VSENSE_FE_MASK,
>> +			   vgain << WSA884X_VSENSE1_GAIN_VSENSE_FE_SHIFT);
>> +	regmap_update_bits(regmap, WSA884X_GAIN_RAMPING_MIN,
>> +			   WSA884X_GAIN_RAMPING_MIN_MIN_GAIN_MASK,
>> +			   min_gain << WSA884X_GAIN_RAMPING_MIN_MIN_GAIN_SHIFT);
>> +
>> +	if (wsa884x->port_enable[WSA884X_PORT_COMP]) {
>> +		regmap_update_bits(regmap, WSA884X_DRE_CTL_0,
>> +				   WSA884X_DRE_CTL_0_OFFSET_MASK,
>> +				   comp_offset);
>> +
>> +		regmap_update_bits(regmap, WSA884X_DRE_CTL_1,
>> +				   WSA884X_DRE_CTL_1_CSR_GAIN_EN_MASK,
>> +				   0x0);
>> +	} else {
>> +		regmap_update_bits(regmap, WSA884X_DRE_CTL_1,
>> +				   WSA884X_DRE_CTL_1_CSR_GAIN_EN_MASK,
>> +				   0x1);
>> +	}
>> +}
>> +
>> +static void wsa884x_init(struct wsa884x_priv *wsa884x)
>> +{
>> +	unsigned int wo_ctl_0;
>> +	unsigned int variant = 0;
>> +
>> +	if (!regmap_read(wsa884x->regmap, WSA884X_OTP_REG_0, &variant))
>> +		wsa884x->variant = variant & WSA884X_OTP_REG_0_ID_MASK;
>> +
>> +	regmap_multi_reg_write(wsa884x->regmap, wsa884x_reg_init,
>> +			       ARRAY_SIZE(wsa884x_reg_init));
>> +
>> +	wo_ctl_0 = 0xc;
>> +	wo_ctl_0 |= WSA884X_ANA_WO_CTL_0_MODE_SPEAKER << WSA884X_ANA_WO_CTL_0_MODE_SHIFT;
> FIELD helpers?
> 

ack

>> +	/* Assume that compander is enabled by default unless it is haptics sku */
>> +	if (wsa884x->variant == WSA8845H)
>> +		wo_ctl_0 |= WSA884X_ANA_WO_CTL_0_PA_AUX_18_DB << WSA884X_ANA_WO_CTL_0_PA_AUX_SHIFT;
>> +	else
>> +		wo_ctl_0 |= WSA884X_ANA_WO_CTL_0_PA_AUX_0_DB << WSA884X_ANA_WO_CTL_0_PA_AUX_SHIFT;
> new line

It's write of previous created/computed value, so it's unusual to split
these with new line.

> 
>> +	regmap_write(wsa884x->regmap, WSA884X_ANA_WO_CTL_0, wo_ctl_0);
>> +
>> +	wsa884x_set_gain_parameters(wsa884x);
>> +
>> +	wsa884x->hw_init = false;
>> +}
>> +
>> +static int wsa884x_update_status(struct sdw_slave *slave,
>> +				 enum sdw_slave_status status)
>> +{
>> +	struct wsa884x_priv *wsa884x = dev_get_drvdata(&slave->dev);
>> +	int ret;
>> +
>> +	if (status == SDW_SLAVE_UNATTACHED)
> 
> should we not put the regmap in to cache state when device is un-attached?

Makes sense. I checked few other drivers and I did not see such pattern,
but it seems reasonable.

> 
>> +		wsa884x->hw_init = false;
>> +
>> +	if (wsa884x->hw_init || status != SDW_SLAVE_ATTACHED)
>> +		return 0;
>> +
>> +	regcache_cache_only(wsa884x->regmap, false);
>> +	ret = regcache_sync(wsa884x->regmap);
>> +	if (ret < 0) {
>> +		dev_err(&slave->dev, "Cannot sync regmap cache\n");
>> +		return ret;
>> +	}
>> +
>> +	wsa884x_init(wsa884x);
>> +
>> +	return 0;
>> +}
>> +
>> +static int wsa884x_port_prep(struct sdw_slave *slave,
>> +			     struct sdw_prepare_ch *prepare_ch,
>> +			     enum sdw_port_prep_ops state)
>> +{
>> +	struct wsa884x_priv *wsa884x = dev_get_drvdata(&slave->dev);
>> +
>> +	if (state == SDW_OPS_PORT_POST_PREP)
>> +		wsa884x->port_prepared[prepare_ch->num - 1] = true;
>> +	else
>> +		wsa884x->port_prepared[prepare_ch->num - 1] = false;
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct sdw_slave_ops wsa884x_slave_ops = {
>> +	.update_status = wsa884x_update_status,
>> +	.port_prep = wsa884x_port_prep,
>> +};
>> +
>> +static int wsa884x_dev_mode_get(struct snd_kcontrol *kcontrol,
>> +				struct snd_ctl_elem_value *ucontrol)
>> +{
>> +	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
>> +	struct wsa884x_priv *wsa884x = snd_soc_component_get_drvdata(component);
>> +
>> +	ucontrol->value.enumerated.item[0] = wsa884x->dev_mode;
>> +
>> +	return 0;
>> +}
>> +
>> +static int wsa884x_dev_mode_put(struct snd_kcontrol *kcontrol,
>> +				struct snd_ctl_elem_value *ucontrol)
>> +{
>> +	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
>> +	struct wsa884x_priv *wsa884x = snd_soc_component_get_drvdata(component);
>> +
>> +	if (wsa884x->dev_mode == ucontrol->value.enumerated.item[0])
>> +		return 0;
>> +
>> +	wsa884x->dev_mode = ucontrol->value.enumerated.item[0];
>> +
>> +	return 1;
>> +}
>> +
>> +static int wsa884x_get_swr_port(struct snd_kcontrol *kcontrol,
>> +				struct snd_ctl_elem_value *ucontrol)
>> +{
>> +	struct snd_soc_component *comp = snd_soc_kcontrol_component(kcontrol);
>> +	struct wsa884x_priv *wsa884x = snd_soc_component_get_drvdata(comp);
>> +	struct soc_mixer_control *mixer = (struct soc_mixer_control *)kcontrol->private_value;
>> +	int portidx = mixer->reg;
>> +
>> +	ucontrol->value.integer.value[0] = wsa884x->port_enable[portidx];
>> +
>> +	return 0;
>> +}
>> +
>> +static int wsa884x_set_swr_port(struct snd_kcontrol *kcontrol,
>> +				struct snd_ctl_elem_value *ucontrol)
>> +{
>> +	struct snd_soc_component *comp = snd_soc_kcontrol_component(kcontrol);
>> +	struct wsa884x_priv *wsa884x = snd_soc_component_get_drvdata(comp);
>> +	struct soc_mixer_control *mixer = (struct soc_mixer_control *)kcontrol->private_value;
>> +	int portidx = mixer->reg;
>> +
>> +	if (ucontrol->value.integer.value[0]) {
>> +		if (wsa884x->port_enable[portidx])
>> +			return 0;
>> +
>> +		wsa884x->port_enable[portidx] = true;
>> +	} else {
>> +		if (!wsa884x->port_enable[portidx])
>> +			return 0;
>> +
>> +		wsa884x->port_enable[portidx] = false;
>> +	}
>> +
>> +	return 1;
>> +}
>> +
>> +static int wsa884x_codec_probe(struct snd_soc_component *comp)
>> +{
>> +	struct wsa884x_priv *wsa884x = snd_soc_component_get_drvdata(comp);
>> +
>> +	snd_soc_component_init_regmap(comp, wsa884x->regmap);
>> +
>> +	return 0;
>> +}
>> +
>> +static void wsa884x_spkr_post_pmu(struct snd_soc_component *component,
>> +				  struct wsa884x_priv *wsa884x)
>> +{
>> +	unsigned int curr_limit, curr_ovrd_en;
>> +
>> +	wsa884x_set_gain_parameters(wsa884x);
>> +	if (wsa884x->dev_mode == WSA884X_RECEIVER) {
>> +		snd_soc_component_write_field(component, WSA884X_DRE_CTL_0,
>> +					      WSA884X_DRE_CTL_0_PROG_DELAY_MASK, 0x3);
>> +		snd_soc_component_write_field(component, WSA884X_CDC_PATH_MODE,
>> +					      WSA884X_CDC_PATH_MODE_RXD_MODE_MASK,
>> +					      0x1);
>> +		snd_soc_component_write_field(component, WSA884X_PWM_CLK_CTL,
>> +					      WSA884X_PWM_CLK_CTL_PWM_CLK_FREQ_SEL_MASK,
>> +					      0x1);
>> +	} else {
>> +		/* WSA884X_SPEAKER */
>> +		snd_soc_component_write_field(component, WSA884X_DRE_CTL_0,
>> +					      WSA884X_DRE_CTL_0_PROG_DELAY_MASK, 0xf);
>> +	}
>> +
>> +	if (wsa884x->port_enable[WSA884X_PORT_PBR]) {
>> +		curr_ovrd_en = 0x0;
>> +		curr_limit = 0x15;
> 
> Can we define these hardcoded values?

I don't know their meaning.

> 
>> +	} else {
>> +		curr_ovrd_en = 0x1;
>> +		if (wsa884x->dev_mode == WSA884X_RECEIVER)
>> +			curr_limit = 0x9;
>> +		else
>> +			curr_limit = 0x15;
>> +	}
>> +	snd_soc_component_update_bits(component, WSA884X_CURRENT_LIMIT,
>> +				      WSA884X_CURRENT_LIMIT_CURRENT_LIMIT_OVRD_EN_MASK,
>> +				      curr_ovrd_en);
>> +	snd_soc_component_update_bits(component, WSA884X_CURRENT_LIMIT,
>> +				      WSA884X_CURRENT_LIMIT_CURRENT_LIMIT_MASK,
>> +				      curr_limit << WSA884X_CURRENT_LIMIT_CURRENT_LIMIT_SHIFT);
> 
> field apis should make this bit cleaner.

ack


Best regards,
Krzysztof


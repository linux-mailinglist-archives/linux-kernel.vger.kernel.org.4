Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1A2D5B3B0E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 16:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232231AbiIIOr7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 10:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232195AbiIIOrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 10:47:55 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E497F1282D5
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 07:47:53 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id z23so2139313ljk.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 07:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=JB9qgUrwYsWle3Jv9JHDQg8bS7SdjgM/S8qMg12D/Vw=;
        b=un9G4vfKcf5oiK+XurhljjSXBl0WVTJjEoefol8zx7MG/0ZU4YWSpEByGeExqOspWG
         wxSh1krcqHEalllyfqyyOa8eBmZzCkBdjHdA45L15gpqcHXR5IlAYJ3h497h8fxP0AkU
         bWqR2hs7R0gqg5Z0uVuShPTq7i28wjN4SMjQY6Y4v1lybTC/+/pbh1VJocmX2ZX7aQvt
         /Ul200xCDGSOEuOqE7aIUlgU06FKvc1cBCxBSivjBj4In8Mw1Y8sde3mY3IS535jHSvm
         Hvg9N/RYsubhLLlg2hqsXAksE3Wb/gS7TCer8q8Os+OPnFxJJrNYz2kkPxtaLm78/48V
         9EdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=JB9qgUrwYsWle3Jv9JHDQg8bS7SdjgM/S8qMg12D/Vw=;
        b=S7bDwaPc4BfzGiL2eQlChm/oae3wDLwN40SDlwzGdc6+XYburEZPQStQBffZCreuBp
         l5V9H605QOvwBhYcWooxjFFUBXqMd4iEQ8q6jPt3zfLUhJCbFNIAQIr31FGGoqKIuTuE
         bcdxC3cHtsmWIN8pGB4XyRc663HSdMx1gTzgKj9TKxhr06x8pKs3u7RF3jkersD1oirk
         MVSfoV/o1Yyn455JokuFmlYRaZHB3iLoopML7oYuXwVq0HWzFONI7CgWTqnP4f3+JKT6
         gjE0HaqbswB845gP4e3zziMiutFcyHGyxso36IUwV1S4+iLqXjpMl4czXdFECxqmnJWh
         8Rrg==
X-Gm-Message-State: ACgBeo34yBQMzk3Nx1hl7TjwbaiJ+0yeAnJlUb0Ln4tay5MiJe1eIBkp
        Oor+W0Byai/baRDJtwh/XEkGWQ==
X-Google-Smtp-Source: AA6agR4xVAukvcaWllAijmuqOnA2x/hHl+myh1R2qfTpY7GoO7sLz9cKdE73/dUbiPyLwAA7J5SLsQ==
X-Received: by 2002:a2e:bd0e:0:b0:261:e718:e902 with SMTP id n14-20020a2ebd0e000000b00261e718e902mr4250918ljq.435.1662734872291;
        Fri, 09 Sep 2022 07:47:52 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id m18-20020ac24252000000b0048a85bd4429sm108378lfl.126.2022.09.09.07.47.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Sep 2022 07:47:51 -0700 (PDT)
Message-ID: <541b11a1-6b5a-cae0-73d9-f1fe8c961a15@linaro.org>
Date:   Fri, 9 Sep 2022 16:47:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 09/10] ASoC: cs42l83: Extend CS42L42 support to new part
Content-Language: en-US
To:     =?UTF-8?Q?Martin_Povi=c5=a1er?= <povik+lin@cutebit.org>,
        James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Matt Flax <flatmax@flatmax.com>,
        - <patches@opensource.cirrus.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        asahi@lists.linux.dev
References: <20220909135334.98220-1-povik+lin@cutebit.org>
 <20220909135334.98220-10-povik+lin@cutebit.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220909135334.98220-10-povik+lin@cutebit.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/09/2022 15:53, Martin Povišer wrote:
> The CS42L83 part is a headphone jack codec found in recent Apple
> machines. It is a publicly undocumented part but as far as can be told
> it is identical to CS42L42 except for two points:
> 

(...)


> +	regmap = devm_regmap_init_i2c(i2c_client, &cs42l83_regmap);
> +	if (IS_ERR(regmap)) {
> +		ret = PTR_ERR(regmap);
> +		dev_err(&i2c_client->dev, "regmap_init() failed: %d\n", ret);
> +		return ret;

Use dev_err_probe()

> +	}
> +
> +	cs42l83->devid = CS42L83_CHIP_ID;
> +	cs42l83->dev = dev;
> +	cs42l83->regmap = regmap;
> +	cs42l83->irq = i2c_client->irq;
> +
> +	ret = cs42l42_common_probe(cs42l83, &cs42l42_soc_component, &cs42l42_dai);
> +	if (ret)
> +		return ret;
> +
> +	ret = cs42l42_init(cs42l83);
> +	if (ret)
> +		cs42l42_common_remove(cs42l83);
> +
> +	return ret;
> +}
> +
> +static int cs42l83_i2c_remove(struct i2c_client *i2c_client)
> +{
> +	struct cs42l42_private *cs42l83 = dev_get_drvdata(&i2c_client->dev);
> +
> +	cs42l42_common_remove(cs42l83);
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused cs42l83_i2c_resume(struct device *dev)
> +{
> +	int ret;
> +
> +	ret = cs42l42_resume(dev);
> +	if (ret)
> +		return ret;
> +
> +	cs42l42_resume_restore(dev);
> +
> +	return 0;
> +}
> +
> +static const struct dev_pm_ops cs42l83_i2c_pm_ops = {
> +	SET_SYSTEM_SLEEP_PM_OPS(cs42l42_suspend, cs42l83_i2c_resume)
> +};
> +
> +static const struct of_device_id __maybe_unused cs42l83_of_match[] = {
> +	{ .compatible = "cirrus,cs42l83", },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, cs42l83_of_match);
> +
> +static struct i2c_driver cs42l83_i2c_driver = {
> +	.driver = {
> +		.name = "cs42l83",
> +		.pm = &cs42l83_i2c_pm_ops,
> +		.of_match_table = of_match_ptr(cs42l83_of_match),

This should complain with compile testing. Usually it comes with
__maybe_unused/


Best regards,
Krzysztof

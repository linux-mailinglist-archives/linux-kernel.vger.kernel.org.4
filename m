Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96C665B3239
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 10:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbiIIIsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 04:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231759AbiIIIsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 04:48:03 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F8212D19C
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 01:48:01 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id z23so1030590ljk.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 01:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=rx+Xj6kNsjTGjbwHEWq+tn+y0SwxN5dk8VZnA0vE+cI=;
        b=mUxhLvLZRdGyYmtuFWlZcNusjoJOhVWVZ1+Bciu2ZmksTLSSjbBOFKEd+oDoZIwibI
         /2D+zYHfnBky85VAH3kOBX4YRlf0iD36nRB68rtWIWZJbICvwlJLa8kvr+9y/FQf+nQF
         VfdTlzciU964hWB7seOxgrpvOtUHQTBITo32KaPkRNqCWnT4VYfz/IMZpSC0/VisI6Jt
         j4orSO0blDZ0nOfNJ6uB3ouqhW+r9+KaK22MSaBt5hEkEV3VxOfXeLHqMJhvpzbouRrG
         rV6RV/oVpZ4FP/zwUWqQrHMahs8EkI4wYbZycLHWJkg91XTX4rq/6zoLGASGRA7lJqMk
         YXZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=rx+Xj6kNsjTGjbwHEWq+tn+y0SwxN5dk8VZnA0vE+cI=;
        b=f+aDRhDVw1kie2eDUrpe3uUBOs1+yGJhCLX2NHVWIQU3i1smWy+hscdjmuigXJx+pw
         rtVa/AeFl7WgDTma2AOBnQtJZvTAQU34Y2qH9KRBLghMxisPflANGsC3AUTXKWXlGgyl
         YR1QPUd+pOsrJx+QhUT0JdwefuDbdyYvXfbO5h3peIcX/2AvaO1hiNSPMyGb/rjI3co0
         emhXzvli8UShJTaYhTnzJygi1l02rR5bqc/G/0w6L3qHZU0rnxyAMP7gvmnpl5f3Bq11
         cF0uhVJaspnqubXv5LeGd20Ayp3NuR/VitVMGexZds0HUuJ5rXAoFjtuJo86lVzKMjbj
         RQlA==
X-Gm-Message-State: ACgBeo13O9Z8fJfY+cnrgB1KdWb/Y1x4lGrMGPufsRnVEfR7eYrR5Htm
        fa3rC2LEtiyfUrtByBLIG/+TaA==
X-Google-Smtp-Source: AA6agR4mhgGay9aeTtnG76J2zyjgEOBTNQKaE1Dy8goFKCEU5a4adsTngqcNgiKWYNeNPABlPyJgfg==
X-Received: by 2002:a2e:bf01:0:b0:25f:df1a:f39d with SMTP id c1-20020a2ebf01000000b0025fdf1af39dmr3901873ljr.365.1662713278501;
        Fri, 09 Sep 2022 01:47:58 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id v8-20020a056512348800b0049707888a61sm177188lfr.293.2022.09.09.01.47.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Sep 2022 01:47:58 -0700 (PDT)
Message-ID: <8999ed83-4c91-a3d5-3821-d89e3ef11add@linaro.org>
Date:   Fri, 9 Sep 2022 10:47:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v7 1/4] drivers: hwmon: Add max31760 fan speed controller
 driver
Content-Language: en-US
To:     Ibrahim Tilki <Ibrahim.Tilki@analog.com>, jdelvare@suse.com,
        linux@roeck-us.net
Cc:     linux-hwmon@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nurettin Bolucu <Nurettin.Bolucu@analog.com>
References: <20220909071618.231246-1-Ibrahim.Tilki@analog.com>
 <20220909071618.231246-2-Ibrahim.Tilki@analog.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220909071618.231246-2-Ibrahim.Tilki@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/09/2022 09:16, Ibrahim Tilki wrote:
> MAX31760 is a precision fan speed controller with nonvolatile lookup table.
> Device has one internal and one external temperature sensor support.
> Controls two fans and measures their speeds. Generates hardware alerts when
> programmable max and critical temperatures are exceeded.
> 
> Signed-off-by: Ibrahim Tilki <Ibrahim.Tilki@analog.com>
> Reviewed-by: Nurettin Bolucu <Nurettin.Bolucu@analog.com>


> +
> +static int max31760_probe(struct i2c_client *client)
> +{
> +	struct device *dev = &client->dev;
> +	struct max31760_state *state;
> +	struct device *hwmon_dev;
> +	int ret;
> +
> +	state = devm_kzalloc(dev, sizeof(struct max31760_state), GFP_KERNEL);

sizeof(*)

run checkpatch on your code

> +	if (!state)
> +		return -ENOMEM;
> +
> +	state->regmap = devm_regmap_init_i2c(client, &regmap_config);
> +	if (IS_ERR(state->regmap))
> +		return dev_err_probe(dev,
> +				     PTR_ERR(state->regmap),
> +				     "regmap initialization failed\n");
> +
> +	dev_set_drvdata(dev, state);
> +
> +	/* Set alert output to comparator mode */
> +	ret = regmap_set_bits(state->regmap, REG_CR2, CR2_ALERTS);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "cannot write register\n");
> +
> +	max31760_create_lut_nodes(state);
> +
> +	hwmon_dev = devm_hwmon_device_register_with_info(dev, client->name,
> +							 state,
> +							 &max31760_chip_info,
> +							 state->groups);
> +
> +	return PTR_ERR_OR_ZERO(hwmon_dev);
> +}
> +
> +static const struct of_device_id max31760_of_match[] = {
> +	{.compatible = "adi,max31760"},
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, max31760_of_match);
> +
> +static const struct i2c_device_id max31760_id[] = {
> +	{"max31760"},
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, max31760_id);
> +
> +static int __maybe_unused max31760_suspend(struct device *dev)
> +{
> +	struct max31760_state *state = dev_get_drvdata(dev);
> +
> +	return regmap_set_bits(state->regmap, REG_CR2, CR2_STBY);
> +}
> +
> +static int __maybe_unused max31760_resume(struct device *dev)
> +{
> +	struct max31760_state *state = dev_get_drvdata(dev);
> +
> +	return regmap_clear_bits(state->regmap, REG_CR2, CR2_STBY);
> +}
> +
> +static SIMPLE_DEV_PM_OPS(max31760_pm_ops, max31760_suspend, max31760_resume);

DEFINE_SIMPLE_DEV_PM_OPS and drop maybe_unused.


> +
> +static struct i2c_driver max31760_driver = {
> +	.class		= I2C_CLASS_HWMON,
> +	.driver = {
> +		.name	= "max31760",
> +		.of_match_table = of_match_ptr(max31760_of_match),

of_match_ptr goes with maybe_unuses. You should see compile test warnings...


Best regards,
Krzysztof

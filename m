Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C918374E80C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 09:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbjGKHda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 03:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbjGKHd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 03:33:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5D911A2;
        Tue, 11 Jul 2023 00:33:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6926561355;
        Tue, 11 Jul 2023 07:33:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CA0CC433C7;
        Tue, 11 Jul 2023 07:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689060805;
        bh=ZzJs7jl+4dwk0J8YV8WPR3nY4dQUO+X9kJHL9hcrypY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=nW+lKo1D0JAwMvWcioG5zh2rfp0gQA63RIw5wWEccsphe5Ch9cX5SW6FwhPj0OKWK
         FrRp16HwdbkgEEty8Lc07pSpovC8WnY0N4RyNrWp+VNBCG4+GNrS2mNRX5sJKxb6wc
         LlGIMoppWrGsUwPAabNjjQkmO03gR/6QnE36knA84uc/0DxB6JDtt6xBW7xZjFX4Z9
         jTa7kMxoCsVJeL5+DGugVc5QmmwGquhVWgSn0jPYCwrpXUTelzp7U0cz54K/xCn3Qs
         AaMMLfKLhvib/ntplxdsCC4CnL4ykk7v8nctQCbgx+ypufUyf25OtTaSg7VXy5NB9A
         TbDsaGZItBFxA==
Message-ID: <1504c4eb-9def-dd75-ceb0-bb6c32fb78f2@kernel.org>
Date:   Tue, 11 Jul 2023 09:33:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: add mcp4728 I2C DAC driver
Content-Language: en-US
To:     Andrea Collamati <andrea.collamati@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <87174c80-aa05-8db7-18e8-e22479d9c635@gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <87174c80-aa05-8db7-18e8-e22479d9c635@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for your patch. There is something to discuss/improve.

On 10/07/2023 22:43, Andrea Collamati wrote:
> From 01b156ca1b27be83f4c74c288dbc0bcad178fe0b Mon Sep 17 00:00:00 2001
> From: Andrea Collamati <andrea.collamati@gmail.com>
> Date: Mon, 10 Jul 2023 16:20:40 +0200
> Subject: [PATCH] iio: add mcp4728 I2C DAC driver

1. That is not a proper patch header. I don't know how you got it, but
it's wrong. Use just b4 or git format-patch and git send-email.

2. Please use scripts/get_maintainers.pl to get a list of necessary
people and lists to CC (and consider --no-git-fallback argument). It
might happen, that command when run on an older kernel, gives you
outdated entries. Therefore please be sure you base your patches on
recent Linux kernel.


> 
> Microchip MCP4728 is a 12-bit quad channel
> digital-to-analog converter (DAC) with I2C interface.
> 
> This patch adds support for per-channel gain, power state and power down mode control.

3. Please do not use "This commit/patch", but imperative mood. See
longer explanation here:
https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95

> Current state could be saved to on-chip EEPROM.
> Internal voltage reference and external vdd ref are supported.
> 
> ---
>  .../bindings/iio/dac/microchip,mcp4728.yaml   |  42 ++

4. Bindings are always separate patches.

5. Please run scripts/checkpatch.pl and fix reported warnings. Some
warnings can be ignored, but the code here looks like it needs a fix.
Feel free to get in touch if the warning is not clear.


>  drivers/iio/dac/Kconfig                       |  12 +
>  drivers/iio/dac/Makefile                      |   1 +
>  drivers/iio/dac/mcp4728.c                     | 641 ++++++++++++++++++
>  4 files changed, 696 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/dac/microchip,mcp4728.yaml
>  create mode 100644 drivers/iio/dac/mcp4728.c
> 
> diff --git a/Documentation/devicetree/bindings/iio/dac/microchip,mcp4728.yaml b/Documentation/devicetree/bindings/iio/dac/microchip,mcp4728.yaml
> new file mode 100644
> index 000000000000..68f4e359a921
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/dac/microchip,mcp4728.yaml
> @@ -0,0 +1,42 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/dac/microchip,mcp4728.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Microchip mcp4728

6. mcp or MCP? What is this? Proper title is missing...  also no
description.

> +
> +maintainers:
> +  - Andrea Collamati <andrea.collamati@gmail.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - microchip,mcp4728      

7. Blank line
8. Whitespace errors

> +  reg:
> +    maxItems: 1
> +
> +  vdd-supply:
> +    description: |
> +      Provides both power and acts as the reference supply on the mcp4728
> +      when Internal Vref is not selected.      
> +
> +required:
> +  - compatible
> +  - reg
> +  - vdd-supply
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        mcp4728_dac@64 {

9. Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

Also, underscores are not allowed in node names.

Shouldn't this binding be just merged with existing mcp4725? Are you
sure it's not similar device, IOW, are you sure you do not have vref supply?


> +            compatible = "microchip,mcp4728";
> +            reg = <0x60>;
> +            vdd-supply = <&vdac_vdd>;
> +        };
> +    };

...

> +
> +static int mcp4728_probe(struct i2c_client *client,
> +             const struct i2c_device_id *id)
> +{
> +    struct mcp4728_data *data;
> +    struct iio_dev *indio_dev;
> +    int err;
> +
> +    indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> +    if (indio_dev == NULL)
> +        return -ENOMEM;

Missing blank line

> +    data = iio_priv(indio_dev);
> +    i2c_set_clientdata(client, indio_dev);
> +    data->client = client;
> +    if (dev_fwnode(&client->dev))
> +        data->id = (uintptr_t)device_get_match_data(&client->dev);
> +    else
> +        data->id = id->driver_data;

Dead code, drop.

> +
> +    data->vdd_reg = devm_regulator_get(&client->dev, "vdd");
> +    if (IS_ERR(data->vdd_reg))
> +        return PTR_ERR(data->vdd_reg);
> +
> +    err = regulator_enable(data->vdd_reg);
> +    if (err)
> +        goto err_disable_vdd_reg;
> +
> +    err = mcp4728_init_channels_data(data);
> +    if (err) {
> +        dev_err(&client->dev,
> +            "failed to read mcp4728 current configuration\n");

None of your statements look properly aligned. What's more everything
has incorrect indentation.

Run checkpatch --strict and fix ALL warnings and errors.

> +        goto err_disable_vdd_reg;
> +    }
> +
> +    indio_dev->name = id->name;
> +    indio_dev->info = &mcp4728_info;
> +    indio_dev->channels = mcp4728_channels;
> +    indio_dev->num_channels = MCP4728_N_CHANNELS;
> +    indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +    err = iio_device_register(indio_dev);
> +    if (err)
> +        goto err_disable_vdd_reg;
> +
> +    return 0;
> +
> +err_disable_vdd_reg:
> +    regulator_disable(data->vdd_reg);
> +
> +    return err;
> +}
> +
> +static int mcp4728_remove(struct i2c_client *client)
> +{
> +    struct iio_dev *indio_dev = i2c_get_clientdata(client);
> +    struct mcp4728_data *data = iio_priv(indio_dev);
> +
> +    iio_device_unregister(indio_dev);
> +    regulator_disable(data->vdd_reg);
> +    return 0;
> +}
> +
> +static const struct i2c_device_id mcp4728_id[] = { { "mcp4728", MCP4728 }, {} };

That's some odd formatting. Look at existing files:
git grep i2c_device_id

> +MODULE_DEVICE_TABLE(i2c, mcp4728_id);
> +
> +static const struct of_device_id mcp4728_of_match[] = {
> +    { .compatible = "microchip,mcp4728", .data = (void *)MCP4728 },

Drop unused MCP4728.

> +    {}
> +};
> +MODULE_DEVICE_TABLE(of, mcp4728_of_match);
> +
> +static struct i2c_driver mcp4728_driver = {
> +        .driver = {
> +                .name = MCP4728_DRV_NAME,
> +                .of_match_table = mcp4728_of_match,
> +                .pm = pm_sleep_ptr(&mcp4728_pm_ops),
> +        },
> +        .probe = mcp4728_probe,
> +        .remove = mcp4728_remove,
> +        .id_table = mcp4728_id,
> +};
> +module_i2c_driver(mcp4728_driver);
> +
> +MODULE_AUTHOR("Andrea Collamati <andrea.collamati@gmail.com>");
> +MODULE_DESCRIPTION("MCP4728 12-bit DAC");
> +MODULE_LICENSE("GPL");

Best regards,
Krzysztof


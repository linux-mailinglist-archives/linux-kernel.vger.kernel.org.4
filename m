Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4EC96E5422
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 23:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbjDQVvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 17:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbjDQVvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 17:51:17 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E4CB1BD7;
        Mon, 17 Apr 2023 14:51:15 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1a661032878so8017905ad.2;
        Mon, 17 Apr 2023 14:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681768275; x=1684360275;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=LLjvo47Yg8oNrAf8xHCqSGvaFVURy3sWbyz+3EtNcco=;
        b=A7A6LDpmjnVZ8kfGJ9peKaYQbXqQZlTeY+dpXv263odHGH2v7WEgK4emajpzQ8Xxgk
         lmXmP1viKxmP3MLbTkPEcgDmxMTMPvWEx5q06lr3yxDXQ/hiRhmETsP6sVrjme3XhZv+
         LLi10pMPs65P5qni/OjAWfYY1h6gcHhNxPeE3RmroBdyLO1SNljqRDKX6JE0g6MCv9Zv
         00p0mSoK+/bITDe2as5a1P/O0BIkt66fdRjb20B8nLrRMhNFz89dFv2rB8VQuWM0jbba
         PB5ffNMfo2IIkkx9rx4guZvDLIUnYxb57FXOs9H/xN0AFx797FKcgGEy+bpsYEtlynlq
         ICeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681768275; x=1684360275;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LLjvo47Yg8oNrAf8xHCqSGvaFVURy3sWbyz+3EtNcco=;
        b=B9zYAjAjsj9fLvrHn81GMPmpqUTYY4j/in3Jjjs0y9//ZHBD2ak/c/R3a5w8zYMcCJ
         u1v/nXsW6I6+Qaer5Me6j40Gn51cKQV6a3ZajGiSNwIvNC1inOuQEKcOa4NhD9vctrlj
         HrX9mTJwqtuVlC0r5pn3z/HFhWBF5IPFYwnQajXUDwICjIqTLqLSv56eYFnkKu1+b2dY
         76zQi0VN7PhUaXwhgPk4QIjVAhuj9WKpHa1gAgVjW2ZUdwSA1+RMHUxY8Fa/Sl2LDymS
         wVVEGaLeiey2ebUDa+bgv60kzsWaD/AS5TFTxzIuFWoSpPosfjkOKyR47qHZor9ZdWyQ
         pzjA==
X-Gm-Message-State: AAQBX9cCFP4ZwPVDMDE/H0wEoAOQHpIdE9l97dfZdwYp+XRWd9vULpsL
        2lRgnfTsXYCXrWDx18JeyjI=
X-Google-Smtp-Source: AKy350b/e/4ZzrMm6Zkq4c5zFVU189UzjTiaBNWHL+BN4p8dv5Ek1zr8rtTdoGRm+yZ3ZgbukvsT4A==
X-Received: by 2002:a17:903:22c4:b0:1a1:d70f:7114 with SMTP id y4-20020a17090322c400b001a1d70f7114mr17833plg.14.1681768274622;
        Mon, 17 Apr 2023 14:51:14 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d17-20020a17090ad3d100b0023faa95f75csm9333526pjw.36.2023.04.17.14.51.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Apr 2023 14:51:14 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <8d158880-1e6a-5fdd-dae7-a7647794eb60@roeck-us.net>
Date:   Mon, 17 Apr 2023 14:51:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 3/5] hwmon: (socfpga) Add hardware monitoring support on
 SoCFPGA platforms
Content-Language: en-US
To:     Dinh Nguyen <dinh.nguyen@linux.intel.com>,
        linux-hwmon@vger.kernel.org
Cc:     dinguyen@kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-kernel@vger.kernel.org, jdelvare@suse.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20230410153314.27127-1-dinh.nguyen@linux.intel.com>
 <20230410153314.27127-3-dinh.nguyen@linux.intel.com>
 <09730359-8731-e21e-3335-bf60ba7f1280@roeck-us.net>
 <a3e966f8-8e9d-7081-1665-9d2e87acb310@linux.intel.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <a3e966f8-8e9d-7081-1665-9d2e87acb310@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/17/23 13:55, Dinh Nguyen wrote:
> 
> On 4/10/2023 9:44 PM, Guenter Roeck wrote:
>> On 4/10/23 08:33, dinh.nguyen@linux.intel.com wrote:
>>> From: Dinh Nguyen <dinh.nguyen@linux.intel.com>
>>>
>>> The driver supports 64-bit SoCFPGA platforms for temperature and voltage
>>> reading using the platform's SDM(Secure Device Manager). The driver
>>> also uses the Stratix10 Service layer driver.
>>>
>>> This driver only supports OF SoCFPGA 64-bit platforms.
>>>
>>> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>> Signed-off-by: Dinh Nguyen <dinh.nguyen@linux.intel.com>
>>> ---
>>>   Documentation/hwmon/index.rst                 |   1 +
>>>   Documentation/hwmon/socfpga-hwmon.rst         |  30 ++
>>>   drivers/firmware/stratix10-svc.c              |  18 +-
>>
>> Changes outside the hwmon subsystem need to be in a separate patch.
> 
> will separate...
> 
>>
>>> drivers/hwmon/Kconfig                         |  11 +
>>>   drivers/hwmon/Makefile                        |   1 +
>>>   drivers/hwmon/socfpga-hwmon.c                 | 406 ++++++++++++++++++
>>>   include/linux/firmware/intel/stratix10-smc.h  |  34 ++
>>>   .../firmware/intel/stratix10-svc-client.h     |   6 +
>>>   8 files changed, 506 insertions(+), 1 deletion(-)
>>>   create mode 100644 Documentation/hwmon/socfpga-hwmon.rst
>>>   create mode 100644 drivers/hwmon/socfpga-hwmon.c
>>>
>>>
> ...
>>> +
>>> +enum hwmon_type_op {
>>> +    SOCFPGA_HWMON_TYPE_TEMP,
>>> +    SOCFPGA_HWMON_TYPE_VOLT,
>>> +    SOCFPGA_HWMON_TYPE_MAX
>>
>> Unused define
> 
> Removed.
> 
>>
>>> +};
>>> +
>>> +static const char *const hwmon_types_str[] = { "temperature", "voltage" };
>>> +
>>> +static umode_t socfpga_is_visible(const void *dev,
>>> +                  enum hwmon_sensor_types type,
>>> +                  u32 attr, int chan)
>>> +{
>>> +    switch (type) {
>>> +    case hwmon_temp:
>>> +    case hwmon_in:
>>> +        return 0444;
>>> +    default:
>>> +        return 0;
>>> +    }
>>> +}
>>> +
>>> +static void socfpga_smc_callback(struct stratix10_svc_client *client,
>>> +                      struct stratix10_svc_cb_data *data)
>>> +{
>>> +    struct socfpga_hwmon_priv *priv = client->priv;
>>> +    struct arm_smccc_res *res = data->kaddr1;
>>> +
>>> +    if (data->status == BIT(SVC_STATUS_OK))    {
>>> +        if (priv->msg.command == COMMAND_HWMON_READTEMP)
>>> +            priv->temperature.value = res->a0;
>>> +        else
>>> +            priv->voltage.value = res->a0;
>>> +    } else
>>> +        dev_err(client->dev, "%s returned 0x%lX\n", __func__, res->a0);
>>> +
>>
>> Missing { } in else branch. Please run checkpatch --strict and fix
>> continuation line alignment issues as well as unbalanced if/else
>> reports.
> Will do.
>>
>>> +    complete(&priv->completion);
>>> +}
>>> +
>>> +static int socfpga_hwmon_send(struct socfpga_hwmon_priv *priv)
>>> +{
>>> +    int ret;
>>> +
>>> +    priv->client.receive_cb = socfpga_smc_callback;
>>> +
>>> +    ret = stratix10_svc_send(priv->chan, &priv->msg);
>>> +    if (ret < 0)
>>> +        return ret;
>>> +
>>> +    if (!wait_for_completion_timeout(&priv->completion, HWMON_TIMEOUT)) {
>>> +        dev_err(priv->client.dev, "SMC call timeout!\n");
>>> +        return -ETIMEDOUT;
>>> +    }
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static int socfpga_hwmon_err_to_errno(struct socfpga_hwmon_priv *priv)
>>> +{
>>> +    int value = priv->temperature.value;
>>> +
>>> +    if (!(value & ETEMP_ERROR))
>>> +        return 0;
>>> +
>>
>> This is odd. int is normally 32 bit, this function is called from
>> socfpga_read() for temperatures, which presumably are defined
>> as "signed 32-bit fixed point binary". That means that negative
>> temperatures would be treated as errors. Please verify.
> 
> That's correct, if bit 31 is set, then it indicates an error.
> 

This ...

>>
>>> +    dev_err(priv->client.dev, "temperature sensor code 0x%08x\n", value);
>>> +
>>
>> Please don't clog the log with such messages.
> 
> Removed.
> 
>>
>>> +    value &= ~ETEMP_ERROR;
>>> +    switch (value) {
>>> +    case ETEMP_NOT_PRESENT:
>>> +        return -ENOENT;
>>> +    case ETEMP_CORRUPT:
>>> +    case ETEMP_NOT_INITIALIZED:
>>> +        return -ENODATA;
>>> +    case ETEMP_BUSY:
>>> +        return -EBUSY;
>>> +    case ETEMP_INACTIVE:
>>> +    case ETEMP_TIMEOUT:
>>> +    case ETEMP_TOO_OLD:
>>> +        return -EAGAIN;
>>> +    default:
>>> +        /* Unknown error */
>>> +        return -EINVAL;
>>
>> Should be -EIO.
>>
> Replaced.
>>> +    }
>>> +}
>>> +
>>> +static int socfpga_read(struct device *dev, enum hwmon_sensor_types type,
>>> +            u32 attr, int chan, long *val)
>>> +{
>>> +    struct socfpga_hwmon_priv *priv = dev_get_drvdata(dev);
>>> +    int ret;
>>> +
>>> +    mutex_lock(&priv->lock);
>>> +    reinit_completion(&priv->completion);
>>> +
>>> +    switch (type) {
>>> +    case hwmon_temp:
>>> +        priv->msg.arg[0] = BIT_ULL(priv->temperature.chan[chan]);
>>> +        priv->msg.command = COMMAND_HWMON_READTEMP;
>>> +        if (socfpga_hwmon_send(priv))
>>> +            goto status_done;
>>> +
>>> +        ret = socfpga_hwmon_err_to_errno(priv);
>>> +        if (ret)
>>> +            break;
>>> +        /*
>>> +         * The Temperature Sensor IP core returns the Celsius
>>> +         * temperature value in signed 32-bit fixed point binary

... and this contradict each other. If bit 31 indicates an error,
this can not be a signed 32-bit value.

Guenter

>>> +         * format, with eight bits below binary point.
>>> +         */
>>> +        *val = (priv->temperature.value * MILLIDEGREE_PER_DEGREE) / 256;
>>> +        break;
>>> +    case hwmon_in: /* Read voltage */
>>
>> Pointless comment
> 
> Removed.
> 
>>
>>> +        priv->msg.arg[0] = BIT_ULL(priv->voltage.chan[chan]);
>>> +        priv->msg.command = COMMAND_HWMON_READVOLT;
>>> +        if (socfpga_hwmon_send(priv))
>>> +            goto status_done;
>>> +
>>
>> No error check for voltage sensors ?
>> Also, unless I am missing something, the error bailout leaves ret
>> undefined.
>>
> There are no error readings for the voltage sensors specified in the spec. Will update
> 
> the ret value.
> 
>>> +        /*
>>> +         * The Voltage Sensor IP core returns the sampled voltage
>>> +         * in unsigned 32-bit fixed point binary format, with 16 bits
>>> +         * below binary point.
>>> +         */
>>> +        *val = (priv->voltage.value * MILLIVOLT_PER_VOLT) / 65536;
>>> +        break;
>>> +    default:
>>> +        ret = -EOPNOTSUPP;
>>> +        break;
>>> +    }
>>> +
>>> +status_done:
>>> +    stratix10_svc_done(priv->chan);
>>> +    mutex_unlock(&priv->lock);
>>> +    return ret;
>>> +}
>>> +
>>> +static int socfpga_read_string(struct device *dev,
>>> +                   enum hwmon_sensor_types type, u32 attr,
>>> +                   int chan, const char **str)
>>> +{
>>> +    struct socfpga_hwmon_priv *priv = dev_get_drvdata(dev);
>>> +
>>> +    switch (type) {
>>> +    case hwmon_in:
>>> +        *str = priv->voltage.names[chan];
>>> +        return 0;
>>> +    case hwmon_temp:
>>> +        *str = priv->temperature.names[chan];
>>> +        return 0;
>>> +    default:
>>> +        return -EOPNOTSUPP;
>>> +    }
>>> +}
>>> +
>>> +static const struct hwmon_ops socfpga_ops = {
>>> +    .is_visible = socfpga_is_visible,
>>> +    .read = socfpga_read,
>>> +    .read_string = socfpga_read_string,
>>> +};
>>> +
>>> +static const struct hwmon_channel_info *socfpga_info[] = {
>>> +    HWMON_CHANNEL_INFO(temp,
>>> +        HWMON_T_INPUT | HWMON_T_LABEL, HWMON_T_INPUT | HWMON_T_LABEL,
>>> +        HWMON_T_INPUT | HWMON_T_LABEL, HWMON_T_INPUT | HWMON_T_LABEL,
>>> +        HWMON_T_INPUT | HWMON_T_LABEL, HWMON_T_INPUT | HWMON_T_LABEL,
>>> +        HWMON_T_INPUT | HWMON_T_LABEL, HWMON_T_INPUT | HWMON_T_LABEL,
>>> +        HWMON_T_INPUT | HWMON_T_LABEL, HWMON_T_INPUT | HWMON_T_LABEL,
>>> +        HWMON_T_INPUT | HWMON_T_LABEL, HWMON_T_INPUT | HWMON_T_LABEL,
>>> +        HWMON_T_INPUT | HWMON_T_LABEL, HWMON_T_INPUT | HWMON_T_LABEL,
>>> +        HWMON_T_INPUT | HWMON_T_LABEL, HWMON_T_INPUT | HWMON_T_LABEL),
>>> +    HWMON_CHANNEL_INFO(in,
>>> +        HWMON_I_INPUT | HWMON_I_LABEL, HWMON_I_INPUT | HWMON_I_LABEL,
>>> +        HWMON_I_INPUT | HWMON_I_LABEL, HWMON_I_INPUT | HWMON_I_LABEL,
>>> +        HWMON_I_INPUT | HWMON_I_LABEL, HWMON_I_INPUT | HWMON_I_LABEL,
>>> +        HWMON_I_INPUT | HWMON_I_LABEL, HWMON_I_INPUT | HWMON_I_LABEL,
>>> +        HWMON_I_INPUT | HWMON_I_LABEL, HWMON_I_INPUT | HWMON_I_LABEL,
>>> +        HWMON_I_INPUT | HWMON_I_LABEL, HWMON_I_INPUT | HWMON_I_LABEL,
>>> +        HWMON_I_INPUT | HWMON_I_LABEL, HWMON_I_INPUT | HWMON_I_LABEL,
>>> +        HWMON_I_INPUT | HWMON_I_LABEL, HWMON_I_INPUT | HWMON_I_LABEL),
>>> +    NULL
>>> +};
>>> +
>>> +static const struct hwmon_chip_info socfpga_chip_info = {
>>> +    .ops = &socfpga_ops,
>>> +    .info = socfpga_info,
>>> +};
>>> +
>>> +static int socfpga_add_channel(struct device *dev,  const char *type,
>>> +                u32 val, const char *label,
>>> +                struct socfpga_hwmon_priv *priv)
>>> +{
>>> +    int type_index;
>>> +    struct socfpga_hwmon_chan *p;
>>> +
>>> +    type_index = match_string(hwmon_types_str, ARRAY_SIZE(hwmon_types_str), type);
>>> +    switch (type_index) {
>>> +    case SOCFPGA_HWMON_TYPE_TEMP:
>>> +        p = &priv->temperature;
>>> +        break;
>>> +    case SOCFPGA_HWMON_TYPE_VOLT:
>>> +        p = &priv->voltage;
>>> +        break;
>>> +    default:
>>> +        return -ENODATA;
>>> +    }
>>> +    if (p->n >= SOCFPGA_HWMON_MAXSENSORS)
>>> +        return -ENOSPC;
>>> +
>>> +    p->names[p->n] = label;
>>> +    p->chan[p->n] = val;
>>> +    p->n++;
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static int socfpga_probe_child_from_dt(struct device *dev,
>>> +                       struct device_node *child,
>>> +                       struct socfpga_hwmon_priv *priv)
>>> +{
>>> +    struct device_node *grandchild;
>>> +    const char *label;
>>> +    const char *type;
>>> +    u32 val;
>>> +    int ret;
>>> +
>>> +    if (of_property_read_string(child, "name", &type))
>>> +        return dev_err_probe(dev, -EINVAL, "No type for %pOF\n", child);
>>> +
>>> +    for_each_child_of_node(child, grandchild) {
>>> +        ret = of_property_read_u32(grandchild, "reg", &val);
>>> +        if (ret)
>>> +            return dev_err_probe(dev, ret, "missing reg property of %pOF\n",
>>> +                         grandchild);
>>> +
>>> +        ret = of_property_read_string(grandchild, "label", &label);
>>> +        if (ret)
>>> +            return dev_err_probe(dev, ret, "missing label propoerty of %pOF\n",
>>> +                         grandchild);
>>> +        ret = socfpga_add_channel(dev, type, val, label, priv);
>>> +        if (ret == -ENOSPC)
>>> +            return dev_err_probe(dev, ret, "too many channels, only %d supported\n",
>>> +                         SOCFPGA_HWMON_MAXSENSORS);
>>> +    }
>>> +    return 0;
>>> +}
>>> +
>>> +static int socfpga_probe_from_dt(struct device *dev,
>>> +                 struct socfpga_hwmon_priv *priv)
>>> +{
>>> +    const struct device_node *np = dev->of_node;
>>> +    struct device_node *child;
>>> +    int ret = 0;
>>> +
>>> +    for_each_child_of_node(np, child) {
>>> +        ret = socfpga_probe_child_from_dt(dev, child, priv);
>>> +        if (ret)
>>> +            break;
>>> +    }
>>> +    of_node_put(child);
>>> +
>>> +    return ret;
>>> +}
>>> +
>>> +static int socfpga_hwmon_probe(struct platform_device *pdev)
>>> +{
>>> +    struct device *dev = &pdev->dev;
>>> +    struct device *hwmon_dev;
>>> +    struct socfpga_hwmon_priv *priv;
>>> +    int ret;
>>> +
>>> +    priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>>> +    if (!priv)
>>> +        return -ENOMEM;
>>> +
>>> +    priv->client.dev = dev;
>>> +    priv->client.priv = priv;
>>> +
>>> +    ret = socfpga_probe_from_dt(dev, priv);
>>> +    if (ret)
>>> +        return dev_err_probe(dev, ret, "Unable to probe from device tree\n");
>>> +
>>> +    mutex_init(&priv->lock);
>>> +    init_completion(&priv->completion);
>>> +    hwmon_dev = devm_hwmon_device_register_with_info(dev, "socfpgahwmon",
>>> +                             priv,
>>> +                             &socfpga_chip_info,
>>> +                             NULL);
>>> +    if (IS_ERR(hwmon_dev))
>>> +        return PTR_ERR(hwmon_dev);
>>> +
>>> +    priv->chan = stratix10_svc_request_channel_byname(&priv->client,
>>> +                    SVC_CLIENT_HWMON);
>>
>> This is racy: hwmon attributes exist here, and priv->chan may be accessed before
>> it is set.
> 
> Fixed in v2.
> 
>>
>>> +    if (IS_ERR(priv->chan))
>>> +        return dev_err_probe(dev, PTR_ERR(priv->chan),
>>> +                     "couldn't get service channel %s\n",
>>> +                     SVC_CLIENT_RSU);
>>> +
>>> +    platform_set_drvdata(pdev, priv);
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static int socfpga_hwmon_remove(struct platform_device *pdev)
>>> +{
>>> +    struct socfpga_hwmon_priv *priv = platform_get_drvdata(pdev);
>>> +
>>> +    stratix10_svc_free_channel(priv->chan);
>>
>> This releases the channel before the hwmon device is released.
>> Another race condition.
> 
> fixed in V2.
> 
> Thanks for the review!
> 
> Dinh
> 


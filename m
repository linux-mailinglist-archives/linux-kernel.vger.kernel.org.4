Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD5566760A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 15:28:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236860AbjALO2M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 09:28:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236108AbjALO1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 09:27:36 -0500
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ED515CFB5;
        Thu, 12 Jan 2023 06:18:19 -0800 (PST)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-15ed38a9b04so338458fac.8;
        Thu, 12 Jan 2023 06:18:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=WYX0uH9UZkQqulRdVqNio3eapqaLpKyXAlfLyLC1eu0=;
        b=Q7cqOm8n6bVihF31N5+25rviTrdAFhUQ2rVagd9wydCulin2kjpOmfVBqNv9qmjWLq
         b9xoYMFMwytZnzisni1sDje8LinUqHJu+pC+UQWwe8TZLPgdhfE28awsOi8cp6JvvhAQ
         NW2hDPv2K8q/MjPh3ZKJXxiFvlPUmmwMlsoh2gypWEKbdNxmEyik0Bz75Ac26bioQ/j1
         JH9JyoSHgEASeiPYrJsq1U72GLX65SuP5ONJ00fA6Z1UIeO8i+UezOD9zVszUJ3G+Ani
         wNy/OVhq6rtLEn0SuEQE7w3EpbZLEz9L8GwsM0ZwkvR//mkCqGPErwzJnLdnNNNV4E4J
         5NLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WYX0uH9UZkQqulRdVqNio3eapqaLpKyXAlfLyLC1eu0=;
        b=cTfQEAHD1R4a2t24MSHYVNkqDDdU/tAOc1m2aNRbdfm8XLWCxCwRuumw/gQemduqLm
         x5kPPBs5QHuKt0jVGme3EazeCvXUn9LRZn+Fiy77q1yXBP7sswaM8nqbYxXE9GWKxvg0
         5NJyZHGmgid47cLNy/gxuJVIqZ5wt2WLxgJ0Ph0AGuUVC97t1KY7/Y6QWerJOyahB9B2
         ofBN0WdEF5I0PCmw/xmZsNCANn/WsvY243qQUSjM3xtrs3ae7EFiF11q7O5QDjjXMqTl
         jrL/GTMe4FCAa79BvVnTMj07SqZCQC3RgIbqg45w30PMuFld5bZZdVm1zkMz2mE6M2aV
         u7sw==
X-Gm-Message-State: AFqh2krf3Kzlfik+KVAAdlz78hr8KcGFdF+73QZLmQx9vJoNtemHg0YC
        2m5BIUK4vNGu0jVqAhZ/pac=
X-Google-Smtp-Source: AMrXdXsvlivtk5qEHw2J5t/dlqnItD4pqwLVO/sTzkv3KA0+oIeuKrmIr5Ro8qow1hpkKW1hfd4C0w==
X-Received: by 2002:a05:6870:a2c6:b0:15e:ce8d:f65c with SMTP id w6-20020a056870a2c600b0015ece8df65cmr593505oak.23.1673533098535;
        Thu, 12 Jan 2023 06:18:18 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9-20020a056870d28900b0014b8347e1e3sm8944119oae.12.2023.01.12.06.18.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jan 2023 06:18:17 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <0a203680-9ef0-771c-8bf5-df1b4bc2022d@roeck-us.net>
Date:   Thu, 12 Jan 2023 06:18:15 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: FW: [PATCH 2/2] usb: typec: tcpci_rt1718s: Add Richtek RT1718S
 tcpci driver
Content-Language: en-US
To:     Gene Chen <gene.chen.richtek@gmail.com>,
        Gene Chen <gene_chen@richtek.com>,
        Rob Herring <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        ChiYuan Huang <cy_huang@richtek.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1673256674-25165-1-git-send-email-gene_chen@richtek.com>
 <1673256674-25165-2-git-send-email-gene_chen@richtek.com>
 <46838aa3-9747-e2e9-a982-6a3b349f853d@roeck-us.net>
 <2af0661f930d4393bda9f7e771654bac@richtek.com>
 <CAE+NS34UupGuG++zXnpWCv5yZ+xw_pra5TEy1LXDty0tuDzYBQ@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <CAE+NS34UupGuG++zXnpWCv5yZ+xw_pra5TEy1LXDty0tuDzYBQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/12/23 00:05, Gene Chen wrote:
>> -----Original Message-----
>> From: Guenter Roeck [mailto:groeck7@gmail.com] On Behalf Of Guenter Roeck
>> Sent: Tuesday, January 10, 2023 2:52 AM
>> To: gene_chen(陳俊宇) <gene_chen@richtek.com>; robh+dt@kernel.org; krzysztof.kozlowski+dt@linaro.org; heikki.krogerus@linux.intel.com
>> Cc: gregkh@linuxfoundation.org; linux-usb@vger.kernel.org; devicetree@vger.kernel.org; linux-kernel@vger.kernel.org
>> Subject: Re: [PATCH 2/2] usb: typec: tcpci_rt1718s: Add Richtek RT1718S tcpci driver
>>
>> On 1/9/23 01:31, gene_chen@richtek.com wrote:
>>> From: Gene Chen <gene_chen@richtek.com>
>>>
>>> Richtek RT1718S is highly integrated TCPC and Power Delivery (PD)
>>> controller with IEC-ESD Protection on SBU/CC/DP/DM, USB2.0 Switch,
>>> Charging Port Controller and Power-Path Control.
>>>
>>> Signed-off-by: Gene Chen <gene_chen@richtek.com>
>>> ---
>>>    drivers/usb/typec/tcpm/Kconfig         |   9 +
>>>    drivers/usb/typec/tcpm/Makefile        |   1 +
>>>    drivers/usb/typec/tcpm/tcpci_rt1718s.c | 349 +++++++++++++++++++++++++++++++++
>>>    3 files changed, 359 insertions(+)
>>>    create mode 100644 drivers/usb/typec/tcpm/tcpci_rt1718s.c
>>>
>>> diff --git a/drivers/usb/typec/tcpm/Kconfig
>>> b/drivers/usb/typec/tcpm/Kconfig index e6b88ca..f0efb34 100644
>>> --- a/drivers/usb/typec/tcpm/Kconfig
>>> +++ b/drivers/usb/typec/tcpm/Kconfig
>>> @@ -27,6 +27,15 @@ config TYPEC_RT1711H
>>>      Type-C Port Controller Manager to provide USB PD and USB
>>>      Type-C functionalities.
>>>
>>> +config TYPEC_RT1718S
>>> +tristate "Richtek RT1718S Type-C chip driver"
>>> +depends on I2C
>>> +help
>>> +  Richtek RT1718S Type-C chip driver that works with
>>> +  Type-C Port Controller Manager to provide USB PD and USB
>>> +  Type-C functionalities.
>>> +  Additionally, it supports BC1.2 and power-path control.
>>> +
>>>    config TYPEC_MT6360
>>>    tristate "Mediatek MT6360 Type-C driver"
>>>    depends on MFD_MT6360
>>> diff --git a/drivers/usb/typec/tcpm/Makefile
>>> b/drivers/usb/typec/tcpm/Makefile index 906d9dc..db33ffc 100644
>>> --- a/drivers/usb/typec/tcpm/Makefile
>>> +++ b/drivers/usb/typec/tcpm/Makefile
>>> @@ -5,6 +5,7 @@ obj-$(CONFIG_TYPEC_WCOVE)+= typec_wcove.o
>>>    typec_wcove-y:= wcove.o
>>>    obj-$(CONFIG_TYPEC_TCPCI)+= tcpci.o
>>>    obj-$(CONFIG_TYPEC_RT1711H)+= tcpci_rt1711h.o
>>> +obj-$(CONFIG_TYPEC_RT1718S)+= tcpci_rt1718s.o
>>>    obj-$(CONFIG_TYPEC_MT6360)+= tcpci_mt6360.o
>>>    obj-$(CONFIG_TYPEC_TCPCI_MT6370)+= tcpci_mt6370.o
>>>    obj-$(CONFIG_TYPEC_TCPCI_MAXIM)+= tcpci_maxim.o
>>> diff --git a/drivers/usb/typec/tcpm/tcpci_rt1718s.c
>>> b/drivers/usb/typec/tcpm/tcpci_rt1718s.c
>>> new file mode 100644
>>> index 00000000..305b39c
>>> --- /dev/null
>>> +++ b/drivers/usb/typec/tcpm/tcpci_rt1718s.c
>>> +
>>> +if (*(u8 *)reg == RT1718S_P1PREFIX) {
>>> +xfer[0].len = 1,
>>> +xfer[0].buf = (u8 *)(reg + 1);
>>
>> Pointer arithmetic on void * (see below).
>>
> 
> yes, should be xfer[0].buf = (u8 *)reg + 1;
> 
>>> +}
>>
>> There is a lot of context here which needs explanation. The code extracts the upper 8 bit of the register address and drops it if the value is 0.
>> So the address is either 8 bit or 16 bit depending on the register address.
>> Also, this only works because reg_format_endian is set to big endian.
>>
>> This really needs to be documented.
>>
>> Assigning the values to len and buf twice is really bad style.
>> Please use if/else.
>>
> 
> Because of rt1718s address which is more than 1 page(0x00-0xFF), hw
> design i2c pattern with register has 2 byte to access another
> page(0xF200-0xF2FF).
> The upper byte is set to 0xF2 indicated page 2.
> 

Sure. I meant something like

	if (*(u8 *)reg == RT1718S_P1PREFIX) {
		xfer[0].len = 1;	<<== that should be a semicolon, not ','
		xfer[0].buf = (u8 *)reg + 1;
	} else {
		...
	}

to avoid the double assignment.

>>> +
>>> +if (*(u8 *)val == RT1718S_P1PREFIX) {
>>> +xfer.len = val_size - 1;
>>> +xfer.buf = (u8 *)(val + 1);
>>> +}
>>> +
>>
>> Same comments as above. Also, typecast seems wrong. Shouldn't it be
>> ((u8 *)val) + 1) ? My memory may defeat me, but I think that pointer arithmetic on void * is undefined or even illegal.
>>
>>
> 
> You are right, I will fix it, thanks.
> 
>>> +if (ret < 0)
>>> +return ret;
>>> +if (ret != 1)
>>> +return -EIO;
>>> +
>>> +return 0;
>>> +}
>>> +
>>> +static const struct regmap_bus rt1718s_regmap_bus = {
>>> +.read= rt1718s_regmap_read,
>>> +.write= rt1718s_regmap_write,
>>> +};
>>> +
>>
>> This needs documentation: Why not use standard regmap functions ?
>> Yes, I know, it is because of the ubusual addressing format used by the chip, but it still needs to be explained. Not everyone should have to read the datasheet to understand the code.
>>
> 
>      Should I add comment before declare rt1718s_regmap_bus?
> 
> /*
>   * Because of rt1718s address which is more than 1 page(0x00-0xFF),
>   * hw design i2c pattern with register has 2 byte to access another
> page(0xF200-0xF2FF).
>   * The upper byte is set to 0xF2 indicated page 2.
>   */
> 

Yes, something like that.

>>> +static int rt1718s_sw_reset(struct rt1718s_chip *chip) {
>>> +int ret;
>>> +
>>> +ret = regmap_update_bits(chip->tdata.regmap, RT1718S_SYS_CTRL3,
>>> + RT1718S_SWRESET_MASK, RT1718S_SWRESET_MASK);
>>> +if (ret < 0)
>>> +return ret;
>>> +
>>> +/* Wait for IC to reset done*/
>>> +usleep_range(1000, 2000);
>>> +
>>
>> "RT1718S will not response to the I2C commands for 2ms after writing SOFT_RESET"
>>
>> Timeout needs to be at least 2 ms.
>>
> 
> ACK
> 
>>> +return 0;
>>> +}
>>> +
>>> +static int rt1718s_check_chip_exist(struct i2c_client *i2c) {
>>> +int ret;
>>> +
>>> +ret = i2c_smbus_read_word_data(i2c, TCPC_VENDOR_ID);
>>> +if (ret < 0)
>>> +return ret;
>>> +if (ret != RT1718S_VID) {
>>> +dev_err(&i2c->dev, "vid is not correct, 0x%04x\n", ret);
>>> +return -ENODEV;
>>> +}
>>> +ret = i2c_smbus_read_word_data(i2c, TCPC_PRODUCT_ID);
>>> +if (ret < 0)
>>> +return ret;
>>> +if (ret != RT1718S_PID) {
>>> +dev_err(&i2c->dev, "pid is not correct, 0x%04x\n", ret);
>>> +return -ENODEV;
>>> +}
>>> +return 0;
>>> +}
>>> +
>>> +static int rt1718s_probe(struct i2c_client *i2c) {
>>> +struct rt1718s_chip *chip;
>>> +struct gpio_desc *gpiod;
>>> +int ret;
>>> +u16 clr_events = 0;
>>> +
>>> +ret = rt1718s_check_chip_exist(i2c);
>>> +if (ret < 0) {
>>> +dev_err(&i2c->dev, "check vid/pid fail(%d)\n", ret);
>>
>> Double error message.
>>
> 
> ACK, I will remove it.
> 
>>> +return ret;
>>> +}
>>> +
>>> +chip = devm_kzalloc(&i2c->dev, sizeof(*chip), GFP_KERNEL);
>>> +if (!chip)
>>> +return -ENOMEM;
>>> +
>>> +chip->dev = &i2c->dev;
>>> +
>>> +chip->tdata.regmap = devm_regmap_init(&i2c->dev,
>>> +      &rt1718s_regmap_bus, &i2c->dev,
>>> +      &rt1718s_regmap_config);
>>> +if (IS_ERR(chip->tdata.regmap))
>>> +return dev_err_probe(&i2c->dev, PTR_ERR(chip->tdata.regmap),
>>> +     "Failed to init regmap\n");
>>> +
>>> +chip->vbus = devm_regulator_get(&i2c->dev, "vbus");
>>> +if (IS_ERR(chip->vbus))
>>> +return dev_err_probe(&i2c->dev, PTR_ERR(chip->vbus),
>>> +     "Failed to get vbus regulator\n");
>>> +
>>> +ret = rt1718s_sw_reset(chip);
>>> +if (ret < 0)
>>> +return ret;
>>> +
>>> +ret = regmap_raw_write(chip->tdata.regmap, TCPC_ALERT_MASK, &clr_events,
>>> +       sizeof(clr_events));
>>> +
>>> +chip->tdata.init = rt1718s_init;
>>> +chip->tdata.set_vbus = rt1718s_set_vbus;
>>> +chip->tcpci = tcpci_register_port(&i2c->dev, &chip->tdata);
>>> +if (IS_ERR(chip->tcpci))
>>> +return dev_err_probe(&i2c->dev, PTR_ERR(chip->tcpci),
>>> +     "Failed to register tcpci port\n");
>>> +
>>> +/* for platform set gpio default inpull_high */
>>> +gpiod = devm_gpiod_get(&i2c->dev, NULL, GPIOD_IN);
>>> +if (IS_ERR(gpiod))
>>> +return dev_err_probe(&i2c->dev, PTR_ERR(gpiod),
>>> +     "Failed to get gpio\n");
>>> +
>>> +ret = devm_request_threaded_irq(&i2c->dev, i2c->irq, NULL,
>>> +rt1718s_irq, IRQF_ONESHOT,
>>> +dev_name(&i2c->dev), chip);
>>> +if (ret) {
>>> +dev_err(chip->dev, "Failed to register irq\n");
>>> +tcpci_unregister_port(chip->tcpci);
>>> +return ret;
>>> +}
>>> +
>>> +device_init_wakeup(&i2c->dev, true);
>>> +i2c_set_clientdata(i2c, chip);
>>> +
>>> +dev_info(&i2c->dev, "%s:successfully\n", __func__);
>>
>> Nore logging noise.
>>
> 
> ACK
> 
>>> +return 0;
>>> +}
>>> +
>>> +static void rt1718s_remove(struct i2c_client *i2c) {
>>> +struct rt1718s_chip *chip = i2c_get_clientdata(i2c);
>>> +
>>> +tcpci_unregister_port(chip->tcpci);
>>> +}
>>> +
>>> +static int __maybe_unused rt1718s_suspend(struct device *dev) {
>>> +struct i2c_client *i2c = to_i2c_client(dev);
>>> +
>>> +if (device_may_wakeup(dev))
>>> +enable_irq_wake(i2c->irq);
>>> +disable_irq(i2c->irq);
>>> +
>>> +return 0;
>>> +}
>>> +
>>> +static int __maybe_unused rt1718s_resume(struct device *dev) {
>>> +struct i2c_client *i2c = to_i2c_client(dev);
>>> +
>>> +if (device_may_wakeup(dev))
>>> +disable_irq_wake(i2c->irq);
>>> +enable_irq(i2c->irq);
>>> +
>>> +return 0;
>>> +}
>>> +
>>> +static SIMPLE_DEV_PM_OPS(rt1718s_pm_ops, rt1718s_suspend,
>>> +rt1718s_resume);
>>> +
>>> +static const struct of_device_id __maybe_unused rt1718s_of_id[] = {
>>> +{ .compatible = "richtek,rt1718s", },
>>> +{},
>>> +};
>>> +MODULE_DEVICE_TABLE(of, rt1718s_of_id);
>>> +
>>> +static struct i2c_driver rt1718s_i2c_driver = {
>>> +.driver = {
>>> +.name = "rt1718s",
>>> +.pm = &rt1718s_pm_ops,
>>> +.of_match_table = rt1718s_of_id,
>>> +},
>>> +.probe_new = rt1718s_probe,
>>> +.remove = rt1718s_remove,
>>> +};
>>> +module_i2c_driver(rt1718s_i2c_driver);
>>> +
>>> +MODULE_AUTHOR("Gene Chen <gene_chen@richtek.com>");
>>> +MODULE_DESCRIPTION("RT1718S USB Type-C Port Controller Interface
>>> +Driver"); MODULE_LICENSE("GPL");


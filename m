Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A75C5631E2C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 11:23:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231374AbiKUKX0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 05:23:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbiKUKXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 05:23:20 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9A91220DA;
        Mon, 21 Nov 2022 02:23:19 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id cl5so19125496wrb.9;
        Mon, 21 Nov 2022 02:23:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ziRpH8HDRqPXLWgHfi7bJXNDSoyTnVAEssNdB7BkBfQ=;
        b=dUqY4+++/kMuFqFd6pZIm8YbjyUB0SFWYfNuZwwndV2U4G/VPVq176t0B1Kho5a+zZ
         rT5yapd/DBCvYDRYiHWQT9lcybWlY5GTRuAFxKby2zjQ/VZhcjbRdVIBfu9oAn7WBJJA
         hNr9H+hCyowrzhuEeL+TU+JRZJ0J6fJFa32LMEcW0A3I/dHOizJerlR/Kw45SiKwy8PX
         TtxSqN9XJAxlvLaMQjbU+0wjxZUBVNK5WzJwJXYTF1k6IqZM+HeFQtHaDCa7nTlgeoU8
         iojFqTwnBFKSAkqAVABIdZBAiLEA3m5laW2hlY4XfyqThN2xlnArO4Tk4qSExK6bx/Qx
         ZfBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ziRpH8HDRqPXLWgHfi7bJXNDSoyTnVAEssNdB7BkBfQ=;
        b=EMDgLquIElnpittMNdso/mLsK/Mbgx2Y3AT03drwBy9+n86xHTErttmrm2nZctYlB9
         THsbYMrrVCqq/NmITfziYxGasl37E6UnEp0b2HbottVft6AhZv2M7p3LidcDtnNFhmLa
         vlklX/W7o3a54sPY66Gm+4cZerjkdee943UReDOcczKyT3CI47gc1c0fVE/ReiRqCkPH
         kGT4NWQ5F+Kqd7H+UU3CA8ff2cXwiUCDp/3mdybRSZjTRk/Uyu/h+yiAYdtPeC+UUMWB
         mUGUVm8XrhtJ2Icsv4R/soFA6i/mEbC4NDerfSFs9wNCzW7K4zJ/G3pDQIweWWso/00Y
         jQXg==
X-Gm-Message-State: ANoB5pnoMBO/wQ5CXtNWJR/B6/IbU29LT8mqfwLI2ABxZgt0Qt/7gKJ6
        q12Dr7C7mxKnzb+pcs6aGDE=
X-Google-Smtp-Source: AA0mqf7WUGJ2KIm6dc0WpMQzcnHL9mQd9YaGuMWqJBGXThc3BISrwkqq98qhPE7HLstDSd1A4rtKjw==
X-Received: by 2002:adf:ef89:0:b0:22a:f477:7bb6 with SMTP id d9-20020adfef89000000b0022af4777bb6mr10477464wro.390.1669026198265;
        Mon, 21 Nov 2022 02:23:18 -0800 (PST)
Received: from [192.168.0.14] (cpc141996-chfd3-2-0-cust928.12-3.cable.virginm.net. [86.13.91.161])
        by smtp.gmail.com with ESMTPSA id e9-20020a5d5949000000b0022e344a63c7sm10775097wri.92.2022.11.21.02.23.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 02:23:17 -0800 (PST)
Message-ID: <9deaf54c-695c-2f6a-e5f3-1660130651c9@gmail.com>
Date:   Mon, 21 Nov 2022 10:23:16 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v1 2/4] media: ipu3-cio2: Convert to use
 software_node_register_node_group()
To:     Hans de Goede <hdegoede@redhat.com>,
        Dan Scally <dan.scally@ideasonboard.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Yong Zhi <yong.zhi@intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Tianshu Qiu <tian.shu.qiu@intel.com>
References: <20221118185617.33908-1-andriy.shevchenko@linux.intel.com>
 <20221118185617.33908-2-andriy.shevchenko@linux.intel.com>
 <2c69ae41-7920-1438-8bfc-8581aad0ee00@ideasonboard.com>
 <93eb74bf-58c4-1a77-af2f-3a0df4404acf@redhat.com>
Content-Language: en-US
From:   Daniel Scally <djrscally@gmail.com>
In-Reply-To: <93eb74bf-58c4-1a77-af2f-3a0df4404acf@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Morning

On 21/11/2022 10:22, Hans de Goede wrote:
> Hi Dan,
>
> On 11/21/22 11:19, Dan Scally wrote:
>> Hi Andy
>>
>> On 18/11/2022 18:56, Andy Shevchenko wrote:
>>> The currently used software_node_register_nodes() is going to
>>> be removed. Prepare driver by switchich to new API.
>>>
>>> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>> ---
>>
>> Also looks good to me:
>>
>> Reviewed-by: Daniel Scally <dan.scally@ideasonboard.com>
> Any chance you can also give this series a test run on an IPU3 device to
> ensure that it does not cause regressions ?


Sure, wait please...

>
> Regards,
>
> Hans
>
>
>
>>>   drivers/media/pci/intel/ipu3/cio2-bridge.c | 21 ++++++++++++++++++---
>>>   drivers/media/pci/intel/ipu3/cio2-bridge.h |  5 +++--
>>>   2 files changed, 21 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/media/pci/intel/ipu3/cio2-bridge.c b/drivers/media/pci/intel/ipu3/cio2-bridge.c
>>> index 18974a72e94a..dfefe0d8aa95 100644
>>> --- a/drivers/media/pci/intel/ipu3/cio2-bridge.c
>>> +++ b/drivers/media/pci/intel/ipu3/cio2-bridge.c
>>> @@ -195,6 +195,19 @@ static void cio2_bridge_init_swnode_names(struct cio2_sensor *sensor)
>>>            SWNODE_GRAPH_ENDPOINT_NAME_FMT, 0); /* And endpoint 0 */
>>>   }
>>>   +static void cio2_bridge_init_swnode_group(struct cio2_sensor *sensor)
>>> +{
>>> +    struct software_node *nodes = sensor->swnodes;
>>> +
>>> +    sensor->group[SWNODE_SENSOR_HID] = &nodes[SWNODE_SENSOR_HID];
>>> +    sensor->group[SWNODE_SENSOR_PORT] = &nodes[SWNODE_SENSOR_PORT];
>>> +    sensor->group[SWNODE_SENSOR_ENDPOINT] = &nodes[SWNODE_SENSOR_ENDPOINT];
>>> +    sensor->group[SWNODE_CIO2_PORT] = &nodes[SWNODE_CIO2_PORT];
>>> +    sensor->group[SWNODE_CIO2_ENDPOINT] = &nodes[SWNODE_CIO2_ENDPOINT];
>>> +    if (sensor->ssdb.vcmtype)
>>> +        sensor->group[SWNODE_VCM] =  &nodes[SWNODE_VCM];
>>> +}
>>> +
>>>   static void cio2_bridge_create_connection_swnodes(struct cio2_bridge *bridge,
>>>                             struct cio2_sensor *sensor)
>>>   {
>>> @@ -219,6 +232,8 @@ static void cio2_bridge_create_connection_swnodes(struct cio2_bridge *bridge,
>>>       if (sensor->ssdb.vcmtype)
>>>           nodes[SWNODE_VCM] =
>>>               NODE_VCM(cio2_vcm_types[sensor->ssdb.vcmtype - 1]);
>>> +
>>> +    cio2_bridge_init_swnode_group(sensor);
>>>   }
>>>     static void cio2_bridge_instantiate_vcm_i2c_client(struct cio2_sensor *sensor)
>>> @@ -252,7 +267,7 @@ static void cio2_bridge_unregister_sensors(struct cio2_bridge *bridge)
>>>         for (i = 0; i < bridge->n_sensors; i++) {
>>>           sensor = &bridge->sensors[i];
>>> -        software_node_unregister_nodes(sensor->swnodes);
>>> +        software_node_unregister_node_group(sensor->group);
>>>           ACPI_FREE(sensor->pld);
>>>           acpi_dev_put(sensor->adev);
>>>           i2c_unregister_device(sensor->vcm_i2c_client);
>>> @@ -310,7 +325,7 @@ static int cio2_bridge_connect_sensor(const struct cio2_sensor_config *cfg,
>>>           cio2_bridge_create_fwnode_properties(sensor, bridge, cfg);
>>>           cio2_bridge_create_connection_swnodes(bridge, sensor);
>>>   -        ret = software_node_register_nodes(sensor->swnodes);
>>> +        ret = software_node_register_node_group(sensor->group);
>>>           if (ret)
>>>               goto err_free_pld;
>>>   @@ -337,7 +352,7 @@ static int cio2_bridge_connect_sensor(const struct cio2_sensor_config *cfg,
>>>       return 0;
>>>     err_free_swnodes:
>>> -    software_node_unregister_nodes(sensor->swnodes);
>>> +    software_node_unregister_node_group(sensor->group);
>>>   err_free_pld:
>>>       ACPI_FREE(sensor->pld);
>>>   err_put_adev:
>>> diff --git a/drivers/media/pci/intel/ipu3/cio2-bridge.h b/drivers/media/pci/intel/ipu3/cio2-bridge.h
>>> index 4418cbd08208..b93b749c65bd 100644
>>> --- a/drivers/media/pci/intel/ipu3/cio2-bridge.h
>>> +++ b/drivers/media/pci/intel/ipu3/cio2-bridge.h
>>> @@ -117,8 +117,9 @@ struct cio2_sensor {
>>>       struct acpi_device *adev;
>>>       struct i2c_client *vcm_i2c_client;
>>>   -    /* SWNODE_COUNT + 1 for terminating empty node */
>>> -    struct software_node swnodes[SWNODE_COUNT + 1];
>>> +    /* SWNODE_COUNT + 1 for terminating NULL */
>>> +    const struct software_node *group[SWNODE_COUNT + 1];
>>> +    struct software_node swnodes[SWNODE_COUNT];
>>>       struct cio2_node_names node_names;
>>>         struct cio2_sensor_ssdb ssdb;

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECE1469FC9E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 21:00:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232201AbjBVUA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 15:00:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232199AbjBVUAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 15:00:22 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3282193F8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 12:00:10 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id t15so9009789wrz.7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 12:00:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UwUDGKoPgiuo5lALlHpfmsp5MEL6Xw8SNKbG9NQwr4c=;
        b=zOmfsgm2oMNxKfdD6mf2QSJdaBYIpimqxO7NODPiEeUMgGgv085WJYS348gnwWhHVO
         yYI52yy56Eq4bZm7M9Dq6It/xcvCrr95hSlJWHgc4C7/4ZtBgT/XDwLJ6HXOVIZrWcB7
         ISd9tRZsD5wNPj0n5+30x2gOEO7R9QANEoKYXKhb2AAV96d3fJxhz/5nXWTx48TtvUxW
         MD+mBPJXf1CtL823mD5BEqqyHe5IOQlTdjkQf7KUjC22OEr3GeUGrpHv9kpJEZjJQchf
         WH6BW4wdOQzomqelOeqIqkFJhKSFekix9WkDi8JaSMBOwd4FoxXg02RfgCjKK9dp+UCG
         lpHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UwUDGKoPgiuo5lALlHpfmsp5MEL6Xw8SNKbG9NQwr4c=;
        b=XIXyNX3Uc4eRa+bkXx2P7Qkh6pp71cWALiaIANQ+7jDXhPhsec2PCH/25gqAfbFH0E
         abxFyiNpkielB3JIPwbrB7ONIzn3EtqopSzvEHqueOSQCVtQ9XS5oyT/yy0nwHwZNtRz
         7qhD1JJhExq+e9ThgQgB34mprHM94P0mHaS0X67o7GBRvychOExNl+XUULzOlC8CQ1nf
         Jvq7lbOVmDTkL5iXZUufjhkfeu5yrJj+XoIn75j45yBxEOTg9Db73vxtYMBMf/jJJna/
         5nyxev0SkQzinDYnQJn0f+XYssaJ+KIwwk39USkXcptxlX3/m6D4krvohdtRpAJzS3D9
         kNBw==
X-Gm-Message-State: AO0yUKXPVrEa0lM/dVXusgi0Qb/7Gb5lgDL6igFtF1+CWx0DKDpfgaYn
        nFeq57uWh/FFggr9POlhPMzY1Q==
X-Google-Smtp-Source: AK7set8QV+TEp7mcc79CNUS9FSeQrKu89ZriCplsTFQ+8TXFTLjX8xXl7kACrCDQdWkkGS8vanVjIQ==
X-Received: by 2002:adf:f208:0:b0:2c5:4b22:bce9 with SMTP id p8-20020adff208000000b002c54b22bce9mr9293747wro.47.1677096008681;
        Wed, 22 Feb 2023 12:00:08 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:be67:8d59:7eae:a15d? ([2a05:6e02:1041:c10:be67:8d59:7eae:a15d])
        by smtp.googlemail.com with ESMTPSA id j7-20020a05600c42c700b003db012d49b7sm3227982wme.2.2023.02.22.12.00.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Feb 2023 12:00:07 -0800 (PST)
Message-ID: <0889767f-d187-0cb4-895e-c149517b6636@linaro.org>
Date:   Wed, 22 Feb 2023 21:00:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 06/16] thermal: Don't use 'device' internal thermal
 zone structure field
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Balsam CHIHI <bchihi@baylibre.com>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Keerthy <j-keerthy@ti.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Ido Schimmel <idosch@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:TI BANDGAP AND THERMAL DRIVER" 
        <linux-omap@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
References: <20230221180710.2781027-1-daniel.lezcano@linaro.org>
 <20230221180710.2781027-7-daniel.lezcano@linaro.org>
 <CAJZ5v0gTmi7ZeDDdHWGWju4m3bv2366oVqSP1dGOT+3jLV-jaw@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0gTmi7ZeDDdHWGWju4m3bv2366oVqSP1dGOT+3jLV-jaw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/02/2023 20:43, Rafael J. Wysocki wrote:
> On Tue, Feb 21, 2023 at 7:07 PM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>> Some drivers are directly using the thermal zone's 'device' structure
>> field.
>>
>> Use the driver device pointer instead of the thermal zone device when
>> it is available.
>>
>> Remove the traces when they are duplicate with the traces in the core
>> code.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> Reviewed-by: Balsam CHIHI <bchihi@baylibre.com> #Mediatek LVTS
>> ---

[ ... ]

>>          thermal_zone_device_update(data->ti_thermal, THERMAL_EVENT_UNSPECIFIED);
>>
>> -       dev_dbg(&data->ti_thermal->device, "updated thermal zone %s\n",
>> +       dev_dbg(data->bgp->dev, "updated thermal zone %s\n",
>>                  data->ti_thermal->type);
> 
> The code before the change is more consistent, because it refers to
> the same object in both instances.
> 
> It looks like a type field accessor is needed, eg. thermal_zone_device_type()?
> 
> Or move the debug message to thermal_zone_device_update()?

Actually it is done on purpose because the patch 9 replaces the accesses 
to 'type' by 'id', the thermal_zone_device_type() accessor won't be needed.

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


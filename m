Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8B0700004
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 07:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239932AbjELFt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 01:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239603AbjELFt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 01:49:57 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D844423A
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 22:49:56 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4f2510b2b98so6520357e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 22:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683870594; x=1686462594;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dR0nPo0wLXJGUhsmXk+iF/iV8x3IujL7+cKIQfngnOU=;
        b=i0sxN/sx8ja2FZljN9NZ10+XdTRyx7TVXS3XfBfK+T5XnYeoQATiWpyzGVwwQoV7Rh
         ou2JuvRLHczboNQzh7ytXb/iJhLsDOqiXOAg5Eg3KTiD6TsfZe7Qsb6auRw9iEt9aHPb
         qXrKwLRV5Q6GiY6YnueJ9qDNFSkEiWmntCsj3ztOHJhDlF880ld+kbZHJ3H6CSJ7WjUb
         qKcnsRjk7I9k18xWhdJQL6+LY+jJ/u7woDjRPnb3ibZY9Ksdmlox5qB1k7X3crDmo12r
         ZLY+kB4j+Sva8WpyGOt4xYL9sWdgYZJUjj09kRcfvU0F52vgYlhs8aBfO//0HWw8j3Ic
         Mdhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683870594; x=1686462594;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dR0nPo0wLXJGUhsmXk+iF/iV8x3IujL7+cKIQfngnOU=;
        b=C6d2vT/MJ2j6TcHJoOUnCs8TC8TtaJN+RW0t4Ore+NQKUnhI11o+HAXhKvGz9JhFHU
         Xr/ExuAGKaVOcS4e/1pvFueivPq4mMfRDPXloPl9IIrSPSI2fYxof9qRA4oG7yY+4QCc
         NHLvFTiEhrrl0ftoKDAvquzhLqOVJDS5ZmcRR5Ry9rjlewiG43D9F2kQPlJ2uOb5iVFq
         dO/P92BBxwlaYZJgL2M8fh/kvVMgm5dgZKm8F0zITb5jEnUjIp2cGHNsBnGDI8nZf19X
         MpDFMIgmqkhfL1ur9nE2BNFPXfZ8avSwypXYW8Nj+1xAvsXUYZiV4uYJhnfbjncGQ2nt
         dVQg==
X-Gm-Message-State: AC+VfDyM9ACahajOIi0BJvrvjpN8XBP+nEYZmMWc9lTuHnB1B0t97V1C
        I95tRy/0oj1S8zI0oeqcIik=
X-Google-Smtp-Source: ACHHUZ43V0as7o8VwI49xZcuvNvWFSSEekkE+KpkYu8hWeWT0AjKq8aHqvDUeYmVV0l16OsvGj3u1A==
X-Received: by 2002:ac2:5d6e:0:b0:4d6:d0a0:8313 with SMTP id h14-20020ac25d6e000000b004d6d0a08313mr3178160lft.10.1683870594149;
        Thu, 11 May 2023 22:49:54 -0700 (PDT)
Received: from [192.168.1.126] (62-78-225-252.bb.dnainternet.fi. [62.78.225.252])
        by smtp.gmail.com with ESMTPSA id z10-20020a19f70a000000b004f00189e1dcsm1344831lfe.117.2023.05.11.22.49.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 May 2023 22:49:53 -0700 (PDT)
Message-ID: <f4ed65a9-4d7f-0b76-1b04-b0c85fabd8cd@gmail.com>
Date:   Fri, 12 May 2023 08:49:52 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US, en-GB
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     oe-kbuild@lists.linux.dev,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <46296e39-dbc1-4f27-b89c-af6f08d9f318@kili.mountain>
 <a1ad0e10-23d2-a860-e9a1-2680313d643f@gmail.com>
 <f5f669fc-ebb4-46df-8957-84c714481ace@kili.mountain>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: drivers/iio/accel/kionix-kx022a.c:1053 kx022a_probe_internal()
 warn: passing zero to 'dev_err_probe'
In-Reply-To: <f5f669fc-ebb4-46df-8957-84c714481ace@kili.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/12/23 08:41, Dan Carpenter wrote:
> On Fri, May 12, 2023 at 08:16:02AM +0300, Matti Vaittinen wrote:
>>> 7c1d1677b3227c Matti Vaittinen 2022-10-24  1046  	irq = fwnode_irq_get_byname(fwnode, "INT1");
>>> 7c1d1677b3227c Matti Vaittinen 2022-10-24  1047  	if (irq > 0) {
>>> 7c1d1677b3227c Matti Vaittinen 2022-10-24  1048  		data->inc_reg = KX022A_REG_INC1;
>>> 7c1d1677b3227c Matti Vaittinen 2022-10-24  1049  		data->ien_reg = KX022A_REG_INC4;
>>> 7c1d1677b3227c Matti Vaittinen 2022-10-24  1050  	} else {
>>> 7c1d1677b3227c Matti Vaittinen 2022-10-24  1051  		irq = fwnode_irq_get_byname(fwnode, "INT2");
>>> 7c1d1677b3227c Matti Vaittinen 2022-10-24  1052  		if (irq <= 0)
>>>                                                                       ^^^^^^^^
>>> This code assumes fwnode_irq_get_byname() can return zero.
>>>
>>> 7c1d1677b3227c Matti Vaittinen 2022-10-24 @1053  			return dev_err_probe(dev, irq, "No suitable IRQ\n");
>>>
>>> But fortunately, it can't otherwise this would return success.
>>>
>>
>> Ouch. Actually, the fwnode_irq_get_byname() can return zero on device-tree
>> mapping error. I did actually send a patch to address this some time ago:
>> https://lore.kernel.org/lkml/cover.1666710197.git.mazziesaccount@gmail.com/
>>
> 
> Ah.  I just went by the documentation instead of looking at the code.
> 
> Originally a bunch of irq functions return NO_IRQ on error which was a
> design mistake...  irq_of_parse_and_map() still returns zero on error
> instead of negative error codes.  I wrote a check for that yesterday.
> 
> drivers/gpu/drm/msm/dsi/dsi_host.c:1949 msm_dsi_host_init() warn: irq_of_parse_and_map() returns zero on failure
> drivers/dma/ti/edma.c:2405 edma_probe() warn: irq_of_parse_and_map() returns zero on failure
> drivers/dma/ti/edma.c:2421 edma_probe() warn: irq_of_parse_and_map() returns zero on failure
> drivers/net/ethernet/xilinx/ll_temac_main.c:1570 temac_probe() warn: irq_of_parse_and_map() returns zero on failure
> drivers/net/ethernet/xilinx/ll_temac_main.c:1573 temac_probe() warn: irq_of_parse_and_map() returns zero on failure
> drivers/ata/sata_mv.c:4094 mv_platform_probe() warn: irq_of_parse_and_map() returns zero on failure
> 
> It would be good if we could apply your patch, otherwise I could create
> an explicit check for fwnode_irq_get_byname() returns.

I guess I can re-spin the series. Let's see if there is some good 
suggestion(s) on how to fix the i2c-smbus.

> Ideally, everything would just return negative error codes on error.

I definitely agree.


Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~


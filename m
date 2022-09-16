Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87D755BA99C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 11:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbiIPJml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 05:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbiIPJmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 05:42:17 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B625AA3F0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 02:42:07 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id ay36so6143485wmb.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 02:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=CekMEk048jVDpV2M7TvNGk4zmn7Sz4+tJE6IULI0IEw=;
        b=FpYpkK+HtqqTUOxa6wiG/EMtdCNxIvUQlKpCdQsy6UbpLc8mHfrwOcXMMgVgjJBUcF
         ievwgElcXZacirzeYw2YSgCtNqWdzu8hw26bZliq0Yx8ONPc4bMFKWETPZ7PRjuegIKl
         JlfHvb2niTzD4gd7Mg+GTYJHBDDy8AH2zLPvwZE/wTbfBPqzk1x2hpAXpuTmc1ZKgisc
         pFb+pS5sIoYTSLlO5R7ntzXjBH0ENdmPuG2XneNo2ks3ygwFw060pQxPr9GcUsWY96lq
         ZGNZYSYzF1ydiqCDoss/EaiKmCMGTG5skOAh37RUgUF3Pdj2m2x3iTyrSTF26AH47CuG
         EUyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=CekMEk048jVDpV2M7TvNGk4zmn7Sz4+tJE6IULI0IEw=;
        b=LYXoz+envSCj/GKQS6pcYzx/EWK076tRK8CYgJk+J01WkyLmIaTh0YaVUJEoZRyDQJ
         VKZzboAwzIQD9fh8ZmuSVFJdDc9etOL+djX+1Ru6qoCJFriwBB/Q+Q++iDQCjoKizMws
         WkD3Q0EsPoVzhI6LaROs0Ml+jMNWSj4DhmTSYS5MM33TNyfIuYc0rsn+PkEA1tyvEbgE
         cnZYruy4gpMV17OmMZ98PiBBYv11iG5kG/yQHhuLa+XzObr5JV8drKOA3FSdaRUlLy53
         BdIumOZsl1xkDcMNRdwh5NcQpsHa5YV8PdyvxXjP3rcxZGHgj1BqMSRF3BejwyJ/mVE6
         QC3A==
X-Gm-Message-State: ACgBeo3y4MQJvLDe2OWYQEDn3+qJiQtcQ/Fhf6F+l/FtqFqnlSewefCt
        j1xcQSSNtX4aDj+DQf0S/heIxw==
X-Google-Smtp-Source: AA6agR7vw12ymYnFdtt8myqkdPJgA58PgmcvD40LODng33eNF01LbrXG6rMy5wzG3Izn7C9RAUs5oQ==
X-Received: by 2002:a05:600c:1da2:b0:3b4:856a:162c with SMTP id p34-20020a05600c1da200b003b4856a162cmr9386047wms.28.1663321325748;
        Fri, 16 Sep 2022 02:42:05 -0700 (PDT)
Received: from [10.119.22.201] ([89.101.193.73])
        by smtp.gmail.com with ESMTPSA id h7-20020a056000000700b0022a2dbc80fdsm4693383wrx.10.2022.09.16.02.42.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Sep 2022 02:42:05 -0700 (PDT)
Message-ID: <fced86d4-7a54-b270-ed4f-9c3095ea97fe@linaro.org>
Date:   Fri, 16 Sep 2022 10:42:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2 1/2] media: dt-bindings: media: i2c: document OV4689 DT
 bindings
Content-Language: en-US
To:     Mikhail Rudenko <mike.rudenko@gmail.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Shawn Tu <shawnx.tu@intel.com>,
        Christian Hemp <c.hemp@phytec.de>,
        Arec Kao <arec.kao@intel.com>, Arnd Bergmann <arnd@arndb.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Daniel Scally <djrscally@gmail.com>,
        Jimmy Su <jimmy.su@intel.com>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220911200147.375198-1-mike.rudenko@gmail.com>
 <20220911200147.375198-2-mike.rudenko@gmail.com>
 <cd363d98-74be-b42f-b1e1-c0f7e79f6011@linaro.org> <87zgf0pa7i.fsf@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <87zgf0pa7i.fsf@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/09/2022 13:16, Mikhail Rudenko wrote:

> 
> I see, will drop the first "media:" in v3.
> 
>> Also you duplicated dt
>> bindings as prefix and commit msg (skip the latter).
> 
> Just to be clear, do you mean dropping "device-tree binding" phrase from
> the commit message?

Ah, sorry, I meant in the subject. You already have dt-bindings as
prefix, so no "DT bindings" at the end. Just:
media: dt-bindings: i2c: document OV4689

> 
>>> ---
>>>  .../bindings/media/i2c/ovti,ov4689.yaml       | 141 ++++++++++++++++++
>>>  MAINTAINERS                                   |   7 +
>>>  2 files changed, 148 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/media/i2c/ovti,ov4689.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/media/i2c/ovti,ov4689.yaml b/Documentation/devicetree/bindings/media/i2c/ovti,ov4689.yaml
>>> new file mode 100644
>>> index 000000000000..376330b5572a
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/media/i2c/ovti,ov4689.yaml
>>> @@ -0,0 +1,141 @@
>>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/media/i2c/ovti,ov4689.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Omnivision OV4689 CMOS
>>> +
>>> +maintainers:
>>> +  - Mikhail Rudenko <mike.rudenko@gmail.com>
>>> +
>>> +description: |
>>> +  The Omnivision OV4689 is a high performance, 1/3-inch, 4 megapixel
>>> +  image sensor. Ihis chip supports high frame rate speeds up to 90 fps
>>> +  at 2688x1520 resolution. It is programmable through an I2C
>>> +  interface, and sensor output is sent via 1/2/4 lane MIPI CSI-2
>>> +  connection.
>>> +
>>> +allOf:
>>> +  - $ref: /schemas/media/video-interface-devices.yaml#
>>> +
>>> +properties:
>>> +  compatible:
>>> +    const: ovti,ov4689
>>> +
>>> +  reg:
>>> +    maxItems: 1
>>> +
>>> +  clocks:
>>> +    description:
>>> +      External clock (XVCLK) for the sensor, 6-64 MHz
>>> +    maxItems: 1
>>> +
>>> +  clock-names: true
>>
>> This has to be strictly defined - which name you expect.
> 
> Will fix in v3. Or maybe we should drop clock-names altogether and use
> devm_clk_get(&client->dev, NULL) in the driver instead (I've seen this
> approach in some existing drivers)?

Yes, usually clock-names for one entry does not make sense.

> 
>>> +
>>> +  dovdd-supply:
>>> +    description:
>>> +      Digital I/O voltage supply, 1.7-3.0 V
>>> +
>>> +  avdd-supply:
>>> +    description:
>>> +      Analog voltage supply, 2.6-3.0 V
>>> +
>>> +  dvdd-supply:
>>> +    description:
>>> +      Digital core voltage supply, 1.1-1.3 V
>>> +
>>> +  powerdown-gpios:
>>> +    maxItems: 1
>>
>> You can skip here maxItems - it is defined by gpio-consumer-common.
> 
> Ack, will fix in v3. Does this also apply to reset-gpios?

No.

https://elixir.bootlin.com/linux/v6.0-rc1/source/Documentation/devicetree/bindings/gpio/gpio-consumer-common.yaml


Best regards,
Krzysztof

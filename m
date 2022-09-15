Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 368F35BA28B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 00:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbiIOWDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 18:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiIOWDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 18:03:46 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A2DC459A6;
        Thu, 15 Sep 2022 15:03:45 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id l12so23856088ljg.9;
        Thu, 15 Sep 2022 15:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date;
        bh=TFtx1KDgtTM0guPlXqDPIbAnzqs4tdXSSSFU0BK0QIk=;
        b=eQaqn3UIwD/aaMwup1N1iDKN9tv4h4gzHYmvGWpPS+xJ7Dqpr5ECPmzuBXNUyZDQd2
         v+WVEQRsGPV+LYpLrb4psQDKPgxsUFE9zTle5miaKDF8qs0orJFst6wcjsC3ewgmg9s2
         0zsA0npFZcsGTh+1dwiJKi0OUR/JCmYyYUo6lE89u559BCfvX63Wf0NDQ0tqVFkcdyzY
         mlvegw2InqU31U0yPKXWyfuTSjPAdIG/6ugFjM4TX2bVQY5sub8WXW22GxTExQyJxBvy
         ujhtkifuc2JCOyeJIRyZ4dz3Dcksa3vBxork8+FtPUEl9yHZ4Atx4h64xAMyvyDzIHKs
         h0rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date;
        bh=TFtx1KDgtTM0guPlXqDPIbAnzqs4tdXSSSFU0BK0QIk=;
        b=TRqBrohc7CUtK9EYiI+wdS9vKQLgH8xUEvh5EDOj/spxPkAeamc5rhSJPhhYIOnpEs
         B+9sOXRA3kCy5P47GUQozgtDghnMMk5DfWlkVM5OLMAUqKlqLQTbX2mGhqZvnW0hbX97
         zkwy0+GkNj2FgYr0R8uhYZCkYMnslUqorTftDEzAoaSPLdKeRmJnHJ8dAIO5sfAlJ05f
         9dax8Sn9u/xfF18LQsDa7dcN1YHtcOp2dfshwNwnhE+o8fMMNUI1SiLQXKMs0Lss4Ro7
         9oqeVM3wGw9Jzg8KtXEbIIlq0ODRw3oZ+2VAlkVo5W481BRf30rlKWhCA6i2LT460+P2
         4Prg==
X-Gm-Message-State: ACrzQf3qy8Vh9mXAVVlbwItE+VASNgx/ASpSHq4V7O/RBRc0+KGMoMmP
        uGDyVThCokRZ+8+2GSgR6z/PLZPrKM5Mnw==
X-Google-Smtp-Source: AMsMyM5RDu0Pj3rd8qFwmSRkhUvB4T7QYx+2GZe1R24VPtpEQcLqtINoA1CSln1aA/U1I+mDZ8cJiw==
X-Received: by 2002:a2e:86c9:0:b0:26c:2f32:e4fa with SMTP id n9-20020a2e86c9000000b0026c2f32e4famr533418ljj.389.1663279423110;
        Thu, 15 Sep 2022 15:03:43 -0700 (PDT)
Received: from razdolb (95-31-185-216.broadband.corbina.ru. [95.31.185.216])
        by smtp.gmail.com with ESMTPSA id 11-20020a05651c128b00b0026c34bed71csm371203ljc.87.2022.09.15.15.03.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 15:03:42 -0700 (PDT)
References: <20220911200147.375198-1-mike.rudenko@gmail.com>
 <20220911200147.375198-2-mike.rudenko@gmail.com>
 <20220913140553.GA2735@tom-ThinkPad-T14s-Gen-2i>
User-agent: mu4e 1.9.0; emacs 28.1
From:   Mikhail Rudenko <mike.rudenko@gmail.com>
To:     Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
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
Subject: Re: [PATCH v2 1/2] media: dt-bindings: media: i2c: document OV4689
 DT bindings
Date:   Thu, 15 Sep 2022 23:11:57 +0300
In-reply-to: <20220913140553.GA2735@tom-ThinkPad-T14s-Gen-2i>
Message-ID: <87sfkspa6b.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Tommaso,

On 2022-09-13 at 16:05 +02, Tommaso Merciai <tommaso.merciai@amarulasolutions.com> wrote:
> Hi Mikhail,
>
> On Sun, Sep 11, 2022 at 11:01:34PM +0300, Mikhail Rudenko wrote:
>> Add device-tree binding documentation for OV4689 image sensor driver,
>> and the relevant MAINTAINERS entries.
>>
>> Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>
>> ---
>>  .../bindings/media/i2c/ovti,ov4689.yaml       | 141 ++++++++++++++++++
>>  MAINTAINERS                                   |   7 +
>>  2 files changed, 148 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/media/i2c/ovti,ov4689.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/media/i2c/ovti,ov4689.yaml b/Documentation/devicetree/bindings/media/i2c/ovti,ov4689.yaml
>> new file mode 100644
>> index 000000000000..376330b5572a
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/media/i2c/ovti,ov4689.yaml
>> @@ -0,0 +1,141 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/media/i2c/ovti,ov4689.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Omnivision OV4689 CMOS
>> +
>> +maintainers:
>> +  - Mikhail Rudenko <mike.rudenko@gmail.com>
>> +
>> +description: |
>> +  The Omnivision OV4689 is a high performance, 1/3-inch, 4 megapixel
>> +  image sensor. Ihis chip supports high frame rate speeds up to 90 fps
>> +  at 2688x1520 resolution. It is programmable through an I2C
>> +  interface, and sensor output is sent via 1/2/4 lane MIPI CSI-2
>> +  connection.
>> +
>> +allOf:
>> +  - $ref: /schemas/media/video-interface-devices.yaml#
>> +
>> +properties:
>> +  compatible:
>> +    const: ovti,ov4689
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    description:
>> +      External clock (XVCLK) for the sensor, 6-64 MHz
>> +    maxItems: 1
>> +
>> +  clock-names: true
>> +
>> +  dovdd-supply:
>> +    description:
>> +      Digital I/O voltage supply, 1.7-3.0 V
>> +
>> +  avdd-supply:
>> +    description:
>> +      Analog voltage supply, 2.6-3.0 V
>> +
>> +  dvdd-supply:
>> +    description:
>> +      Digital core voltage supply, 1.1-1.3 V
>> +
>> +  powerdown-gpios:
>> +    maxItems: 1
>> +    description:
>> +      GPIO connected to the powerdown pin (active low)
>> +
>> +  reset-gpios:
>> +    maxItems: 1
>> +    description:
>> +      GPIO connected to the reset pin (active low)
>> +
>> +  orientation: true
>> +
>> +  rotation: true
>> +
>> +  port:
>> +    $ref: /schemas/graph.yaml#/$defs/port-base
>> +    additionalProperties: false
>> +    description:
>> +      Output port node, single endpoint describing the CSI-2 transmitter
>> +
>> +    properties:
>> +      endpoint:
>> +        $ref: /schemas/media/video-interfaces.yaml#
>> +        unevaluatedProperties: false
>> +
>> +        properties:
>> +          data-lanes:
>> +            oneOf:
>> +              - items:
>> +                  - const: 1
>> +                  - const: 2
>> +                  - const: 3
>> +                  - const: 4
>> +              - items:
>> +                  - const: 1
>> +                  - const: 2
>> +              - items:
>> +                  - const: 1
>> +          link-frequencies: true
>> +
>> +        required:
>> +          - data-lanes
>> +          - link-frequencies
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - clocks
>> +  - clock-names
>> +  - dovdd-supply
>> +  - avdd-supply
>> +  - dvdd-supply
>> +  - powerdown-gpios
>> +  - reset-gpios
>> +  - port
>
> I think we don't need all of these entries as required.
> The only let me say "really" required are:
>
> - compatible
> - reg
> - clocks
> - port

Thanks for the review! I agree that the driver may be modified to work
without powerdown and reset gpios and they are not required for sensor
operation. On contrary, supplies are obviously required. Of course, linux
provides dummy regulators if supplies are missing from device tree, but
I though the intention was to document hardware, not implementation
details. What do think of this?

> Regards,
> Tommaso

--
Best regards,
Mikhail Rudenko

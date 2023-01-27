Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5655367DF25
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 09:30:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232557AbjA0Iai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 03:30:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232541AbjA0Iag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 03:30:36 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2286EC14F
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 00:30:35 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id m7so4236127wru.8
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 00:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PzyY2wWF97kB5fX+uFjQpPzD5PWYjl7+jY/2KBj4KNA=;
        b=DAWwPyeoXoNs6zGt2dX8uWsU8bmo4t2KFPGN+I5gbkowFsMIJjrhKcTfe1zFgbpIOk
         j9v0hKnjIaEHvszWjYbd9Nwj3opWixjLE5G6cS4AIiGtjR6Th8ckg1r1d4mKtDqvl3AI
         JTFpMSbC7pUOH1N47z7Opsi9tiEMKVYAvQyOXvkzlXpooD2tMBoY8re8s0s+AdhyRz7h
         wINbLzeb7FJvPXu5mOwKX6MrGcTWEo9zqfVU9SE/ulD2B1aVGz8D9tkDTJdfIJi43MNi
         4dyKIyN6HBAfOaRa7MTn4/FhdJ/JpBZ9nEZdqPgB2u+2oaoVW9HuaIBS8nOCV+fMOR9h
         X7XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PzyY2wWF97kB5fX+uFjQpPzD5PWYjl7+jY/2KBj4KNA=;
        b=t/2kRgIGWhDtIq96AR+CGRfgRoJ1jKt0oQE7n/93jHXllalehEUIwBpoq5OqFu6s2V
         sxr7HpG7p1awqE86fJIj45SWXm0/Oj5R+0o2icbjibC0xX9BQwDN3tAHHMWiS1cXA3BT
         SkfxbNhv7ZvCh6Cs1EZYgKPM3Q3NfdD6dpZDPFlpey0QYm4eLhIbLpby3+2v7eZAthTN
         OIaPCo+/nXcdloDvUENkY5vXmWQpUedmPwWnn7RFxjQCcTPTocbRonfegFHECw0PC5AI
         Jh8B4uQQdsf8vdfnMe4ocmXjR54jVJ0dXRV+GVzAMDUMydxkf8kdHnkwsER8S8RQIixu
         6dug==
X-Gm-Message-State: AFqh2kqsMt3sOn7Q4KXyxiPSrbKoce5NMg/cAkYN4/ckcPG0M4Ud98+s
        hv/qMx8HuIF38HfxnkMEt4N4GA==
X-Google-Smtp-Source: AMrXdXv5pQRXWL1U0hR5Htkz83S8q7xOPVG51oWOAn3sMt+jlNLKgrMtv7/JNUCjzi+Ka3do1eNpCQ==
X-Received: by 2002:adf:f791:0:b0:29d:f817:42c1 with SMTP id q17-20020adff791000000b0029df81742c1mr34873932wrp.54.1674808233556;
        Fri, 27 Jan 2023 00:30:33 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id p17-20020a056000019100b002bddaea7a0bsm3330890wrx.57.2023.01.27.00.30.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jan 2023 00:30:33 -0800 (PST)
Message-ID: <2e183f7b-df8a-38c6-a041-d507fc32e894@linaro.org>
Date:   Fri, 27 Jan 2023 09:30:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/4] dt-bindings: display: bridge: tfp410: Add tfp410 i2c
 example
Content-Language: en-US
To:     Jon Cormier <jcormier@criticallink.com>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Jyri Sarha <jsarha@ti.com>, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Williamson <michael.williamson@criticallink.com>,
        Bob Duke <bduke@criticallink.com>
References: <20230125-tfp410_i2c-v1-0-66a4d4e390b7@criticallink.com>
 <20230125-tfp410_i2c-v1-1-66a4d4e390b7@criticallink.com>
 <906b693d-1e85-8c17-cdda-f09ea8f12e7f@linaro.org>
 <CADL8D3YUNnsZt8tc8x9CxH5Ug6kWJHb=a3N5VJFPSePWH3yWxg@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CADL8D3YUNnsZt8tc8x9CxH5Ug6kWJHb=a3N5VJFPSePWH3yWxg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/01/2023 19:36, Jon Cormier wrote:
> On Thu, Jan 26, 2023 at 10:40 AM Krzysztof Kozlowski <
> krzysztof.kozlowski@linaro.org> wrote:
> 
>> On 25/01/2023 22:09, Jonathan Cormier wrote:
>>> Add a i2c example with HDMI connector
>>
>> Why? It's the same - but more on this below.
>>
> The existing example is for the previous setup where it was configured as
> its own device.  It seemed necessary now that the driver is going to
> support being connected to an i2c bus to show it being used as such.
> 
>>
>>>
>>> Signed-off-by: Jonathan Cormier <jcormier@criticallink.com>
>>
>> You need to test the bindings before sending and fix the errors.
>>
> Will do
> 
>>
>>> ---
>>>  .../bindings/display/bridge/ti,tfp410.yaml         | 42
>> ++++++++++++++++++++++
>>>  1 file changed, 42 insertions(+)
>>>
>>> diff --git
>> a/Documentation/devicetree/bindings/display/bridge/ti,tfp410.yaml
>> b/Documentation/devicetree/bindings/display/bridge/ti,tfp410.yaml
>>> index 4c5dd8ec2951..456214f14b47 100644
>>> --- a/Documentation/devicetree/bindings/display/bridge/ti,tfp410.yaml
>>> +++ b/Documentation/devicetree/bindings/display/bridge/ti,tfp410.yaml
>>> @@ -116,4 +116,46 @@ examples:
>>>          };
>>>      };
>>>
>>> +  - |
>>> +    i2c {
>>> +      #address-cells = <1>;
>>> +      #size-cells = <0>;
>>> +
>>> +      hdmi_encoder: tfp410@38 {
>>
>> Node names should be generic.
>>
>> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
>>
>> Can do
> 
>>> +        compatible = "ti,tfp410";
>>> +        reg = <0x38>;
>>> +
>>> +        ports {
>>> +          address-cells = <1>;
>>> +          size-cells = <0>;
>>> +
>>> +          port@0 {
>>> +            reg = <0>;
>>> +            tfp410_in: endpoint {
>>> +              remote-endpoint = <&dpi1_out>;
>>> +            };
>>> +          };
>>> +
>>> +          port@1 {
>>> +            reg = <1>;
>>> +            tfp410_out: endpoint {
>>> +              remote-endpoint = <&hdmi_connector_in>;
>>> +            };
>>
>> That's the same example as existing one, so it looks useless. I don't
>> see benefits of this example.
>>
> It's mostly the same, except defined inside an i2c bus, with the reg value
> set. Without the powerdown-gpios or ti,deskew.
> And without the pclk-sample and bus-width (these are now read from i2c)
> And I included the hdmi_connector so it would be a more complete and useful
> example of how it could be used. 

hdmi_connector is being dropped because it is not related.


> The TFP410 doesn't handle the ddc i2c bus
> on its own so a separate connector node is needed.  I'll drop it if that's
> preferred.
> 

If you had here different ports, it would be different case. But as of
now the only important part is having reg and not having gpios, so
basically almost the same example. No need for it.

Best regards,
Krzysztof


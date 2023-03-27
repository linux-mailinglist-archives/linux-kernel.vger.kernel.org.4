Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 899F96CB094
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 23:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbjC0VVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 17:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjC0VVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 17:21:17 -0400
Received: from mx4.wp.pl (mx4.wp.pl [212.77.101.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E4A219A9
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 14:21:14 -0700 (PDT)
Received: (wp-smtpd smtp.wp.pl 586 invoked from network); 27 Mar 2023 23:21:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1679952070; bh=1kfIEQ4881S0D8k647T98eFvanH7ICttoIMB4TpzThw=;
          h=Subject:To:From;
          b=nknBxSHg3zY72B7bJ9W1PnIGMbH4mELYrO+8OAu8hyaPqoEQjStI0SP31GCljHHzQ
           J2wIH5zT+tasipn+ProSbYFf3+f61aYzW597as9MOVklGQTKY22IIsMme2wCqraz7W
           6MIQcUBXuGAAeS9QC9VfS4AZ2TcsmHxeofq+hPww=
Received: from 79.184.247.17.ipv4.supernova.orange.pl (HELO [192.168.1.25]) (olek2@wp.pl@[79.184.247.17])
          (envelope-sender <olek2@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <krzysztof.kozlowski@linaro.org>; 27 Mar 2023 23:21:10 +0200
Message-ID: <b3e0502b-61d0-430e-8832-dbbec69035a5@wp.pl>
Date:   Mon, 27 Mar 2023 23:21:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] dt-bindings: mips: lantiq: Document Lantiq SoC dt
 bindings
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        tsbogend@alpha.franken.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-mips@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230326122942.870990-1-olek2@wp.pl>
 <3871e958-79aa-2b4c-3300-270a2eb8f8e8@linaro.org>
From:   Aleksander Bajkowski <olek2@wp.pl>
In-Reply-To: <3871e958-79aa-2b4c-3300-270a2eb8f8e8@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-WP-MailID: 2094fb3d9004dd78c0e4d5fcd3f22d42
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [AVMi]                               
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,


On 26.03.2023 16:54, Krzysztof Kozlowski wrote:
> On 26/03/2023 14:29, Aleksander Jan Bajkowski wrote:
>> Document the legacy Lantiq device tree bindings.
> This suggests you are documenting existing compatibles, but I do not see
> them at all. Confusing.

The added compatible strings can be found in:
- arch/mips/lantiq/xway/sysctrl.c,
- arch/mips/lantiq/falcon/prom.c,
- arch/mips/lantiq/xway/prom.c.

Upstream only has one dts for danube development board. More dts
can be found in OpenWRT [1]. I have a bunch of these devices and
intend to send dts files upstream.

>
>> Compatible strings for xRX100 (ar9) and newer SoCs
> Please wrap commit message according to Linux coding style / submission
> process (neither too early nor over the limit):
> https://elixir.bootlin.com/linux/v5.18-rc4/source/Documentation/process/submitting-patches.rst#L586


Will be fixed in v2.


>> should be renamed and will be added later.
> Subject: drop second/last, redundant "dt bindings". The "dt-bindings"
> prefix is already stating that these are bindings.


Will be fixed in v2.


>
>> Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
>> ---
>>  .../devicetree/bindings/mips/lantiq/soc.yaml  | 38 +++++++++++++++++++
>>  1 file changed, 38 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/mips/lantiq/soc.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/mips/lantiq/soc.yaml b/Documentation/devicetree/bindings/mips/lantiq/soc.yaml
>> new file mode 100644
>> index 000000000000..90e8148b111b
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mips/lantiq/soc.yaml
>> @@ -0,0 +1,38 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/mips/lantiq/soc.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Lantiq SoC based Platform
>> +
>> +maintainers:
>> +  - Aleksander Jan Bajkowski <olek2@wp.pl>
>> +
>> +description:
>> +  Devices with a Lantiq CPU shall have the following properties.
>> +
>> +properties:
>> +  $nodename:
>> +    const: "/"
>> +  compatible:
>> +    oneOf:
>> +      - description: Boards with Lantiq Amazon-SE SoC
>> +        items:
>> +          - const: lantiq,ase
> This does not look like proper board compatible. Boards have almost
> always minimum two compatibles - one for SoC and one for board. With
> commit msg this just adds to confusion...
>

The added dt-binding contains only the SoC part. The compatible strings
for individual boards will be added later together with the dts files. Before
sending the dts files I want to document current bindings and clear
checkpach warnings about undocumented strings.


> Best regards,
> Krzysztof
>

1. https://github.com/openwrt/openwrt/tree/master/target/linux/lantiq/files/arch/mips/boot/dts/lantiq


Best Regards,
Aleksander



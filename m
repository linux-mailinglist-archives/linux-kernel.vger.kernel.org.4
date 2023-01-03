Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F7DD65BEE0
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 12:27:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236995AbjACL1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 06:27:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233146AbjACL1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 06:27:19 -0500
Received: from out29-178.mail.aliyun.com (out29-178.mail.aliyun.com [115.124.29.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0539731F;
        Tue,  3 Jan 2023 03:27:15 -0800 (PST)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1034973|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.265725-0.00146619-0.732809;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047199;MF=wangweidong.a@awinic.com;NM=1;PH=DS;RN=28;RT=28;SR=0;TI=SMTPD_---.QjR9KV8_1672745223;
Received: from ubuntu-VirtualBox..(mailfrom:wangweidong.a@awinic.com fp:SMTPD_---.QjR9KV8_1672745223)
          by smtp.aliyun-inc.com;
          Tue, 03 Jan 2023 19:27:10 +0800
From:   wangweidong.a@awinic.com
To:     krzysztof.kozlowski@linaro.org
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        cezary.rojewski@intel.com, ckeepax@opensource.cirrus.com,
        devicetree@vger.kernel.org, duanyibo@awinic.com,
        flatmax@flatmax.com, james.schulman@cirrus.com,
        krzysztof.kozlowski+dt@linaro.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, liweilei@awinic.com, perex@perex.cz,
        pierre-louis.bossart@linux.intel.com, povik+lin@cutebit.org,
        rf@opensource.cirrus.com, robh+dt@kernel.org, shumingf@realtek.com,
        srinivas.kandagatla@linaro.org, stephan@gerhold.net, steve@sk2.org,
        tanureal@opensource.cirrus.com, tiwai@suse.com,
        wangweidong.a@awinic.com, yijiangtao@awinic.com,
        zhaolei@awinic.com, zhuning0077@gmail.com
Subject: Re: [PATCH V8 5/5] ASoC: dt-bindings: Add schema for "awinic,aw883xx"
Date:   Tue,  3 Jan 2023 19:27:03 +0800
Message-Id: <20230103112703.382153-1-wangweidong.a@awinic.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <aa0de3c8-d783-f8cc-42a9-7988acd6ab87@linaro.org>
References: <aa0de3c8-d783-f8cc-42a9-7988acd6ab87@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof

On 30/12/2022 10:34, wangweidong.a@awinic.com wrote:
>> From: Weidong Wang <wangweidong.a@awinic.com>
>> 
>> Add a DT schema for describing Awinic AW883xx audio amplifiers. They are
>> controlled using I2C.
>> 
>> Signed-off-by: Weidong Wang <wangweidong.a@awinic.com>
>> ---
>>  .../bindings/sound/awinic,aw883xx.yaml        | 49 +++++++++++++++++++
>>  1 file changed, 49 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/sound/awinic,aw883xx.yaml
>> 
>> diff --git a/Documentation/devicetree/bindings/sound/awinic,aw883xx.yaml b/Documentation/devicetree/bindings/sound/awinic,aw883xx.yaml
>> new file mode 100644
>> index 000000000000..b677427ebcd1
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/sound/awinic,aw883xx.yaml
>> @@ -0,0 +1,49 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/sound/awinic,aw883xx.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Awinic AW883xx Smart Audio Amplifier
>> +
>> +maintainers:
>> +  - Stephan Weidong Wang <wangweidong.a@awinic.com>
>> +
>> +description:
>> +  The Awinic AW883XX is an I2S/TDM input, high efficiency
>> +  digital Smart K audio amplifier with an integrated 10.25V
>> +  smart boost convert.
>> +
>> +allOf:
>> +  - $ref: dai-common.yaml#
>> +
>> +properties:
>> +  compatible:
>> +    const: awinic,aw883xx

> Now the question what does "xx" stand for? I cannot find such product on
> awinic website:
> https://www.awinic.com/En/Index/queryAll/wd/aw883xx.html

xx represents our company's aw88394 and aw88395 chips,Aw88395 chips can be found on 
https://www.awinic.com/cn/detail/index/catid/229/id/48/title/AW88395CSR.html
The aw88394 chip will be available on the website in the near future.

>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  reset-gpios:
>> +    maxItems: 1
>> +

> Why there is no sound-dai-cells?

I'll add sound-dai-cells in patch v8

>> +  sound-name-prefix: true

> Drop it.

I will modify it on patch v8

>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - reset-gpios
>> +
>> +additionalProperties: false

> Instead:
> unevaluatedProperties: false

> unless this is not a codec and sound-dai-cells cannot be used?

I will modify it on patch v8

>> +
>> +examples:
>> +  - |
>> +    i2c {
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +        audio-codec@34 {
>> +            compatible = "awinic,aw883xx";
>> +            reg = <0x34>;
>> +            reset-gpios = <&gpio 10 GPIO_ACTIVE_LOW>;

> Does not look like you tested the bindings. Please run `make
> dt_binding_check` (see
> Documentation/devicetree/bindings/writing-schema.rst for instructions).

I will modify it on patch v8

Best regards,
Weidong Wang

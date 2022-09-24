Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8F245E8F01
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 19:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233892AbiIXRnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 13:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233627AbiIXRnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 13:43:01 -0400
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 575933DBFD;
        Sat, 24 Sep 2022 10:43:00 -0700 (PDT)
Received: by mail-oi1-f177.google.com with SMTP id m130so3562923oif.6;
        Sat, 24 Sep 2022 10:43:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=HXYwv0eUsV9BZNGwJ8kp6pulJ+l7ZOn/6fd+60rpoK8=;
        b=6UD8O5Lguv6oMdFwzLzOCr20ePTFuL+o1Lzv3LdpACGLXig5uxbicN2UuaMwk8G5Iw
         X/O8hSnRUsXkrwY+D/8UQgJiuYFyZHDgfwzxBsXManOZCF/TrsucfiPdkqvZyf0F4KMz
         SVw1jwbGtMXmgA4UnBFLOXTxLcormhSzpMrEGDN1t2ALo8WqcqasNRA2ESE9zwFIfj3n
         wkfJy6ojbjmNuZHhmp+G90gL167O2zcmHwYUB792Ur9q7/4ZcXlxcy/k0NelFHZGwWDu
         HVMcddewn+BSgHf08loGZca+EpyXrhVhvv/7EiF8Ih2efmdAiYkT/U9PLv1POI/pVToM
         rWoQ==
X-Gm-Message-State: ACrzQf3eynveDGDpRLLOowDRol2TOSsFxlHrn90TkAPDqC0hQi+Kc5Mg
        lvbciI7qTKOIfoUyo9MXNA==
X-Google-Smtp-Source: AMsMyM4A0Q0w0n/GBT7sN6ZLirXs+UFQfi2UsZ5FkncmJEKuikkF4ckNrXa9ed+kubL1xeoJWhcJnQ==
X-Received: by 2002:a05:6808:30a8:b0:350:2323:ef2e with SMTP id bl40-20020a05680830a800b003502323ef2emr6764258oib.38.1664041379504;
        Sat, 24 Sep 2022 10:42:59 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id s136-20020acaa98e000000b003504e119b10sm5046187oie.44.2022.09.24.10.42.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Sep 2022 10:42:58 -0700 (PDT)
Received: (nullmailer pid 1028011 invoked by uid 1000);
        Sat, 24 Sep 2022 17:42:58 -0000
Date:   Sat, 24 Sep 2022 12:42:58 -0500
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?B?5pyx6ZO25rOi?= <zhuyinbo@loongson.cn>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhanghongchen <zhanghongchen@loongson.cn>
Subject: Re: Re: [PATCH v2 2/3] dt-bindings: thermal: Convert loongson2 to
 json-schema
Message-ID: <20220924174258.GA1011284-robh@kernel.org>
References: <20220921015605.17078-1-zhuyinbo@loongson.cn>
 <20220921015605.17078-2-zhuyinbo@loongson.cn>
 <fb901889-d769-ba56-d4cb-2d9d8b50f74f@linaro.org>
 <28a78a10.a7dd.1835f5aaf90.Coremail.zhuyinbo@loongson.cn>
 <a44244f2-fb96-0483-b529-d0f2b0b7e5d8@linaro.org>
 <4febe7e4.a96c.18362d997e3.Coremail.zhuyinbo@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4febe7e4.a96c.18362d997e3.Coremail.zhuyinbo@loongson.cn>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2022 at 09:39:30AM +0800, 朱银波 wrote:
> 
> 
> 
> > -----原始邮件-----
> > 发件人: "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>
> > 发送时间:2022-09-21 17:31:11 (星期三)
> > 收件人: "朱银波" <zhuyinbo@loongson.cn>
> > 抄送: "Rafael J . Wysocki" <rafael@kernel.org>, "Daniel Lezcano" <daniel.lezcano@linaro.org>, "Amit Kucheria" <amitk@kernel.org>, "Zhang Rui" <rui.zhang@intel.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, zhanghongchen <zhanghongchen@loongson.cn>
> > 主题: Re: [PATCH v2 2/3] dt-bindings: thermal: Convert loongson2 to json-schema
> > 
> > On 21/09/2022 11:22, 朱银波 wrote:
> > >> -----原始邮件-----
> > >> 发件人: "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>
> > >> 发送时间:2022-09-21 15:05:00 (星期三)
> > >> 收件人: "Yinbo Zhu" <zhuyinbo@loongson.cn>, "Rafael J . Wysocki" <rafael@kernel.org>, "Daniel Lezcano" <daniel.lezcano@linaro.org>, "Amit Kucheria" <amitk@kernel.org>, "Zhang Rui" <rui.zhang@intel.com>, "Rob Herring" <robh+dt@kernel.org>, "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
> > >> 抄送: zhanghongchen <zhanghongchen@loongson.cn>
> > >> 主题: Re: [PATCH v2 2/3] dt-bindings: thermal: Convert loongson2 to json-schema
> > >>
> > >> On 21/09/2022 03:56, Yinbo Zhu wrote:
> > >>> Convert the loongson2 thermal binding to DT schema format using
> > >>> json-schema.
> > >>
> > >> Incorrect subject and incorrect commit msg. There is no conversion here.
> > > Our soc architecture is the loongson2 series, so we will modify it accordingly.
> > 
> > How the soc architecture is related to my comment that you do not
> > perform conversion?
> I got it, and I will aad a conversion.
> > 
> > > 
> > >>
> > >>>
> > >>> Signed-off-by: Yinbo Zhu <c>
> > >>> ---
> > >>> Change in v2:
> > >>> 		1. Add description and type about the "id".	
> > >>> 		2. Make the filename was based on compatible.
> > >>>
> > >>>  .../bindings/thermal/loongson2-thermal.yaml   | 52 +++++++++++++++++++
> > >>>  1 file changed, 52 insertions(+)
> > >>>  create mode 100644 Documentation/devicetree/bindings/thermal/loongson2-thermal.yaml
> > >>>
> > >>> diff --git a/Documentation/devicetree/bindings/thermal/loongson2-thermal.yaml b/Documentation/devicetree/bindings/thermal/loongson2-thermal.yaml
> > >>> new file mode 100644
> > >>> index 000000000000..2994ae3a56aa
> > >>> --- /dev/null
> > >>> +++ b/Documentation/devicetree/bindings/thermal/loongson2-thermal.yaml
> > >>
> > >>
> > >> No improvements here. You ignore my comments, so I am going to NAK it.
> > > I don't get your point, that dts compatible is "loongson,loongson2-thermal", so this driver file name is named
> > > loongson2-thermal that according what you said about "Filename based on compatible."
> > > If what I understand is not what you expect, please tell me how to modify it.
> > 
> > 
> > Filename must match the compatible, so: loongson,loongson2-thermal.yaml
> I got it, and I will add a conversion.
> > 
> > >>
> > >>
> > >>> @@ -0,0 +1,52 @@
> > >>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > >>> +%YAML 1.2
> > >>> +---
> > >>> +$id: http://devicetree.org/schemas/thermal/loongson2-thermal.yaml#
> > >>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > >>> +
> > >>> +title: Thermal sensors on loongson2 SoCs
> > >>> +
> > >>> +maintainers:
> > >>> +  - zhanghongchen <zhanghongchen@loongson.cn>
> > >>> +  - Yinbo Zhu <zhuyinbo@loongson.cn>
> > >>> +
> > >>> +properties:
> > >>> +  compatible:
> > >>> +    const: loongson,loongson2-thermal
> > >>> +
> > >>> +  reg:
> > >>> +    maxItems: 1
> > >>> +
> > >>> +  id:
> > >>> +    $ref: '//schemas/types.yaml#/definitions/uint32'
> > >>
> > >> No improvements here, so let me be specific - you need to really justify
> > >> such property or it cannot go to schema.
> > > The loongson2_thermal.c driver need parse this "id" property.
> > 
> > This is not reason to add properties to DT. DT describes the hardware,
> > not driver behavior.
> > 
> > Why hardware needs arbitrary, additional addressing number instead of
> > standard unit address?
> The loongson2 series soc supports up to four sensors, but the 2K1000 has only one sensor, so the ID must be 0. 
> For the 2K1000, in order to distinguish the differences between different hardware in the Loongson2 SoC series,
> the ID is added to the dts

Differences in SoCs is what 'compatible' is for. If 'loongson2' is not a 
specific SoC, then your compatible string is not specific enough.

> > 
> > >>
> > >>> +    description: |
> > >>> +      Specify the thermal sensor id.
> > >>> +    minimum: 0
> > >>> +    maximum: 3
> > >>> +
> > >>> +  interrupts:
> > >>> +    maxItems: 1
> > >>> +
> > >>> +  "#thermal-sensor-cells":
> > >>> +    const: 1

If one SoC only has 1 sensor, then this could be 0. However, you don't 
have to do that, but it's another way to distinguish differences.

> > >>> +
> > >>> +required:
> > >>> +  - compatible
> > >>> +  - reg
> > >>> +  - id
> > >>> +  - interrupt-parent
> > >>
> > >> Why?
> > > The interrupts of our dts do not specify an interrupt parent,
> > > eg. interrupts = <7 IRQ_TYPE_LEVEL_LOW>
> > > so we need to add an interrupt parent property.
> > 
> > You can add but I am asking why is it required?
> Since there is more than one interrupt controller in the Loongson2 series soc, that need to specify the interrupt 
> controller in the dts, that is, the interrupt parent.   If different interrupt parents are used in dts, the interrupt 
> numbers are different.

It is perfectly valid for the 'interrupt-parent' to be in *any* parent 
node. So it is never required by any binding.

Rob


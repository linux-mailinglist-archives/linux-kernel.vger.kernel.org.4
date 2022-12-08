Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CEA1647288
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 16:11:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbiLHPLS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 10:11:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiLHPLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 10:11:16 -0500
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8721549B47;
        Thu,  8 Dec 2022 07:11:15 -0800 (PST)
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 09 Dec 2022 00:11:14 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id DADAA2058B4F;
        Fri,  9 Dec 2022 00:11:14 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Fri, 9 Dec 2022 00:11:14 +0900
Received: from [10.212.157.17] (unknown [10.212.157.17])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 49C481DA8;
        Fri,  9 Dec 2022 00:11:14 +0900 (JST)
Message-ID: <43a32346-2cad-8f67-4f26-2ed3a781d68b@socionext.com>
Date:   Fri, 9 Dec 2022 00:11:14 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 09/16] dt-bindings: soc: socionext: Add UniPhier
 SoC-glue logic
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221207055405.30940-1-hayashi.kunihiko@socionext.com>
 <20221207055405.30940-10-hayashi.kunihiko@socionext.com>
 <26c92774-e709-ef13-598b-d271368249bc@linaro.org>
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
In-Reply-To: <26c92774-e709-ef13-598b-d271368249bc@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/12/08 17:16, Krzysztof Kozlowski wrote:> On 07/12/2022 06:53, Kunihiko Hayashi wrote:
 >> Add devicetree binding schema for the SoC-glue logic implemented on
 >> Socionext Uniphier SoCs.
 >>
 >> This SoC-glue logic is a set of miscellaneous function registers
 >> handling signals for specific devices outside system components,
 >> and also has multiple functions such as I/O pinmux, usb-phy, debug,
 >> clock-mux for a specific SoC, and so on.
 >>
 >> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
 >> ---
 >>   .../socionext,uniphier-soc-glue.yaml          | 113 ++++++++++++++++++
 >>   1 file changed, 113 insertions(+)
 >>   create mode 100644
 >> Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-soc-glue.yaml
 >>
 >> diff --git
 >> a/Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-soc-glue.yaml
 >> b/Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-soc-glue.yaml
 >> new file mode 100644
 >> index 000000000000..6fc790963660
 >> --- /dev/null
 >> +++
 >> b/Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-soc-glue.yaml
 >> @@ -0,0 +1,113 @@
 >> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 >> +%YAML 1.2
 >> +---
 >> +$id:
 >> http://devicetree.org/schemas/soc/socionext/socionext,uniphier-soc-glue.yaml#
 >> +$schema: http://devicetree.org/meta-schemas/core.yaml#
 >> +
 >> +title: Socionext UniPhier SoC-glue logic
 >> +
 >> +maintainers:
 >> +  - Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
 >> +
 >> +description: |+
 >> +  SoC-glue logic implemented on Socionext UniPhier SoCs is a collection
 >> of
 >> +  miscellaneous function registers handling signals outside system
 >> components.
 >> +
 >> +properties:
 >> +  compatible:
 >> +    items:
 >> +      - enum:
 >> +          - socionext,uniphier-ld4-soc-glue
 >> +          - socionext,uniphier-pro4-soc-glue
 >> +          - socionext,uniphier-pro5-soc-glue
 >> +          - socionext,uniphier-pxs2-soc-glue
 >> +          - socionext,uniphier-sld8-soc-glue
 >> +          - socionext,uniphier-ld11-soc-glue
 >> +          - socionext,uniphier-ld20-soc-glue
 >> +          - socionext,uniphier-pxs3-soc-glue
 >> +          - socionext,uniphier-nx1-soc-glue
 >> +      - const: simple-mfd
 >> +      - const: syscon
 >> +
 >> +  reg:
 >> +    maxItems: 1
 >> +
 >> +patternProperties:
 >> +  "^pinctrl(@[0-9a-f]+)?$":
 >
 > Your children cannot have unit address in this binding (not mentioning
 > that children schema has in example statement that unit address is
 > invalid: "must be a child of syscon node").

Same as uniphier-sysctrl, I'll drop the address patterns.

Thank you,

---
Best Regards
Kunihiko Hayashi

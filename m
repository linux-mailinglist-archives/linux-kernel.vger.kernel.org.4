Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07199642419
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 09:08:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231757AbiLEIIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 03:08:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231406AbiLEIIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 03:08:04 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9126120AE;
        Mon,  5 Dec 2022 00:08:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id BC8A2CE0ED0;
        Mon,  5 Dec 2022 08:08:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED95BC433C1;
        Mon,  5 Dec 2022 08:07:53 +0000 (UTC)
Message-ID: <ed6a2a1c-e14c-ef9f-b20b-8e662e2c78c8@xs4all.nl>
Date:   Mon, 5 Dec 2022 09:07:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 3/9] media: dt-bindings: cec: convert common CEC
 properties to DT schema
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Alain Volmat <alain.volmat@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Joe Tessler <jrt@google.com>,
        Yannick Fertre <yannick.fertre@foss.st.com>,
        Jeff Chase <jnchase@google.com>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
References: <20221204182908.138910-1-krzysztof.kozlowski@linaro.org>
 <20221204182908.138910-3-krzysztof.kozlowski@linaro.org>
Content-Language: en-US
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <20221204182908.138910-3-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/12/2022 19:29, Krzysztof Kozlowski wrote:
> Convert common HDMI CEC adapter bindings to DT schema.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>

Thanks!

	Hans

> ---
>  .../devicetree/bindings/media/cec.txt         |  8 ------
>  .../bindings/media/cec/cec-common.yaml        | 28 +++++++++++++++++++
>  MAINTAINERS                                   |  2 +-
>  3 files changed, 29 insertions(+), 9 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/media/cec.txt
>  create mode 100644 Documentation/devicetree/bindings/media/cec/cec-common.yaml
> 
> diff --git a/Documentation/devicetree/bindings/media/cec.txt b/Documentation/devicetree/bindings/media/cec.txt
> deleted file mode 100644
> index 22d7aae3d3d7..000000000000
> --- a/Documentation/devicetree/bindings/media/cec.txt
> +++ /dev/null
> @@ -1,8 +0,0 @@
> -Common bindings for HDMI CEC adapters
> -
> -- hdmi-phandle: phandle to the HDMI controller.
> -
> -- needs-hpd: if present the CEC support is only available when the HPD
> -  is high. Some boards only let the CEC pin through if the HPD is high,
> -  for example if there is a level converter that uses the HPD to power
> -  up or down.
> diff --git a/Documentation/devicetree/bindings/media/cec/cec-common.yaml b/Documentation/devicetree/bindings/media/cec/cec-common.yaml
> new file mode 100644
> index 000000000000..af6ee5f1c73f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/cec/cec-common.yaml
> @@ -0,0 +1,28 @@
> +# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/cec/cec-common.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: HDMI CEC Adapters Common Properties
> +
> +maintainers:
> +  - Hans Verkuil <hverkuil@xs4all.nl>
> +
> +properties:
> +  $nodename:
> +    pattern: "^cec(@[0-9a-f]+|-[0-9]+)?$"
> +
> +  hdmi-phandle:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      Phandle to the HDMI controller.
> +
> +  needs-hpd:
> +    type: boolean
> +    description:
> +      The CEC support is only available when the HPD is high. Some boards only
> +      let the CEC pin through if the HPD is high, for example if there is a
> +      level converter that uses the HPD to power up or down.
> +
> +additionalProperties: true
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 07cb85cac4c3..45402e03cda5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4832,7 +4832,7 @@ S:	Supported
>  W:	http://linuxtv.org
>  T:	git git://linuxtv.org/media_tree.git
>  F:	Documentation/ABI/testing/debugfs-cec-error-inj
> -F:	Documentation/devicetree/bindings/media/cec.txt
> +F:	Documentation/devicetree/bindings/media/cec/cec-common.yaml
>  F:	Documentation/driver-api/media/cec-core.rst
>  F:	Documentation/userspace-api/media/cec
>  F:	drivers/media/cec/


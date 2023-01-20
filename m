Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10655674C12
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 06:23:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbjATFXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 00:23:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231347AbjATFXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 00:23:14 -0500
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BE6B7518FD;
        Thu, 19 Jan 2023 21:13:19 -0800 (PST)
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 20 Jan 2023 13:54:07 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id E2C412059054;
        Fri, 20 Jan 2023 13:54:07 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Fri, 20 Jan 2023 13:54:08 +0900
Received: from [10.212.158.61] (unknown [10.212.158.61])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 4FE257BCC;
        Fri, 20 Jan 2023 13:54:07 +0900 (JST)
Message-ID: <13697e8c-977d-aad3-18d6-e520fc1013f8@socionext.com>
Date:   Fri, 20 Jan 2023 13:54:07 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] dt-bindings: soc: socionext,uniphier-soc-glue: Make child
 node names fixed names
To:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230120020339.3223112-1-robh@kernel.org>
Content-Language: en-US
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
In-Reply-To: <20230120020339.3223112-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 2023/01/20 11:03, Rob Herring wrote:
> The child nodes 'pinctrl', 'usb-hub', and 'clock-controller' in the
> socionext,uniphier-soc-glue binding are not patterns, but the full node
> name, so move them to 'properties'. As patterns, they were missing start
> and end anchors so any prefix or suffix was allowed.
> 
> Fixes: 0611adff8b3a ("dt-bindings: soc: socionext: Add UniPhier SoC-glue
> logic")
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>   .../bindings/soc/socionext/socionext,uniphier-soc-glue.yaml      | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git
> a/Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-soc-g
> lue.yaml
> b/Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-soc-g
> lue.yaml
> index 4b6852db4747..7845dcfca986 100644
> ---
> a/Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-soc-g
> lue.yaml
> +++
> b/Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-soc-g
> lue.yaml
> @@ -32,7 +32,6 @@ properties:
>     reg:
>       maxItems: 1
>   
> -patternProperties:
>     pinctrl:
>       $ref: /schemas/pinctrl/socionext,uniphier-pinctrl.yaml#
>   

Thanks for pointing out.
This is because I forgot to remove it when I changed the child node,
and it should be removed.

Reviewed-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>

Thank you,

---
Best Regards
Kunihiko Hayashi

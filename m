Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66A61733486
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 17:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbjFPPRn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 11:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232085AbjFPPRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 11:17:41 -0400
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DE7B2D4E;
        Fri, 16 Jun 2023 08:17:40 -0700 (PDT)
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-77af8476cd4so29525439f.1;
        Fri, 16 Jun 2023 08:17:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686928659; x=1689520659;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8hr09IJTZlwSUbPk2/1Wb+ALEzpCoAzJqAu6w5jI53E=;
        b=b+zF8Q34ZWFpfYUM+E9qTvFtxDT4PJBeVhAnGOmFH5rBw/tEX6iLPPBceRl0ZyDRr0
         h9dRF2q16KdesvE4camH9zuZQXbohjQJT+W//cg/mOZanhiPX26/O0YAt1wivzqk3/BG
         WA4lVq9Yz9vpf6jOCOuve7GqImMJnxA8JX0QUtvSgLeFfXlKM09a+4YSQVkBx94tfOfO
         MvXLGWpofd1z6LF7pa438WtkdfVYCXkpxzbE+2KuxlSEGxvsSIdloV6P539oFBhvQXkA
         TomPTINTD0jAHPOTfd14cjUEJH9yVjImi1dlZG3+NsGb0hCBqK8XGuXpztl+dlTJkQci
         tg3g==
X-Gm-Message-State: AC+VfDxu8hzrTputLcF70G9iFwsdRqCq//teROMYi6ybNj1F3JysrdO8
        wp1UAcUdNACKHgl/WN/QDA==
X-Google-Smtp-Source: ACHHUZ4yyc48/MBGsIaSwJMSrIIBOVmk5aGfk0RJg9fKb9qWkHVh8375Ybh7RxU7l93EBjwdqgAong==
X-Received: by 2002:a6b:dd16:0:b0:77a:d862:242f with SMTP id f22-20020a6bdd16000000b0077ad862242fmr2380653ioc.21.1686928659358;
        Fri, 16 Jun 2023 08:17:39 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id ed4-20020a056638290400b00424e5091bf8sm211022jab.94.2023.06.16.08.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jun 2023 08:17:38 -0700 (PDT)
Received: (nullmailer pid 431745 invoked by uid 1000);
        Fri, 16 Jun 2023 15:17:36 -0000
Date:   Fri, 16 Jun 2023 09:17:36 -0600
From:   Rob Herring <robh@kernel.org>
To:     Yinbo Zhu <zhuyinbo@loongson.cn>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Marc Zyngier <maz@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        loongarch@lists.linux.dev, Jianmin Lv <lvjianmin@loongson.cn>,
        wanghongliang@loongson.cn, Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn
Subject: Re: [PATCH v3 2/3] soc: dt-bindings: add loongson-2 pm
Message-ID: <20230616151736.GA296030-robh@kernel.org>
References: <20230615091757.24686-1-zhuyinbo@loongson.cn>
 <20230615091757.24686-3-zhuyinbo@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230615091757.24686-3-zhuyinbo@loongson.cn>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2023 at 05:17:56PM +0800, Yinbo Zhu wrote:
> Add the Loongson-2 SoC Power Management Controller binding with DT
> schema format using json-schema.
> 
> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
> ---
>  .../soc/loongson/loongson,ls2k-pmc.yaml       | 53 +++++++++++++++++++
>  MAINTAINERS                                   |  6 +++
>  2 files changed, 59 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/loongson/loongson,ls2k-pmc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/soc/loongson/loongson,ls2k-pmc.yaml b/Documentation/devicetree/bindings/soc/loongson/loongson,ls2k-pmc.yaml
> new file mode 100644
> index 000000000000..32499bd10f8c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/loongson/loongson,ls2k-pmc.yaml
> @@ -0,0 +1,53 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/soc/loongson/loongson,ls2k-pmc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Loongson-2 Power Manager controller
> +
> +maintainers:
> +  - Yinbo Zhu <zhuyinbo@loongson.cn>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - loongson,ls2k1000-pmc
> +              - loongson,ls2k0500-pmc
> +          - const: syscon
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  suspend-address:

loongson,suspend-address

> +    $ref: /schemas/types.yaml#/definitions/uint32

Isn't this a 64-bit platform? Probably better if this is a 64-bit value 
in case that's needed in the future.

> +    description:
> +      The "suspend-address" is a deep sleep state (Suspend To RAM)
> +      firmware entry address which was jumped from kernel and it's
> +      value was dependent on specific platform firmware code. In
> +      addition, the PM need according to it to indicate that current
> +      SoC whether support Suspend To RAM.
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    pmc: pm@1fe27000 {
> +        compatible = "loongson,ls2k1000-pmc", "syscon";
> +        reg = <0x1fe27000 0x58>;
> +        interrupt-parent = <&liointc1>;
> +        interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
> +        suspend-address = <0x1c000500>;
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7a91f14cad2e..bcd05f1fa5c1 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12190,6 +12190,12 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/hwinfo/loongson,ls2k-chipid.yaml
>  F:	drivers/soc/loongson/loongson2_guts.c
>  
> +LOONGSON-2 SOC SERIES PM DRIVER
> +M:	Yinbo Zhu <zhuyinbo@loongson.cn>
> +L:	linux-pm@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/soc/loongson/loongson,ls2k-pmc.yaml
> +
>  LOONGSON-2 SOC SERIES PINCTRL DRIVER
>  M:	zhanghongchen <zhanghongchen@loongson.cn>
>  M:	Yinbo Zhu <zhuyinbo@loongson.cn>
> -- 
> 2.20.1
> 

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE8666ED26B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 18:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232016AbjDXQ1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 12:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231268AbjDXQ1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 12:27:00 -0400
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 605CD19AE;
        Mon, 24 Apr 2023 09:26:59 -0700 (PDT)
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-541b60e7288so3704124eaf.1;
        Mon, 24 Apr 2023 09:26:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682353618; x=1684945618;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TNw2i3Q9unD3TSIdaH9haVdJnYN/tbo0P8vrj33ORQk=;
        b=Bz4/QA9Hor/OSmhw/vUjr7NCI91RK+J3wnnpDqG3ImJQ6JQr7bvqHEtCDpr0MVelYp
         fbjbeK1DkyxYDQw8OMz3rXtHFZRS1NHi7Ss7hBfnuwZh+NRgc28TL8GqgymUmMedEGnQ
         qpbkDH+j3P9MZuFZ0rP46pOiJNIhuZTTSOUJVfe7jKX87vUyzoh1PKnV1oaXe6CraMYk
         XHcQrakhf17dSRvNCKWO4vNzB7mKa+0/1IpGGX7TFas2WfogLKuVSGbMfVSTIDJsTfou
         yDsLgr7UXMSbQRsQP72wbGyiVbd0CnkhONrgMSjeX69iJoWJlSdCEmix4hT46UmaYBj7
         94Dg==
X-Gm-Message-State: AAQBX9ddxNvQT+PORsYyqBuAtdrE8clN4cHCCDRJtscfHjtiSMUOjRXa
        cYXRpCC953fPsnOXRQfY0DjcGUWYAw==
X-Google-Smtp-Source: AKy350YhrY2rO66tkMy1Aa7AZTVTqGNmTd1lT1ryxJCDF/XFxa6cVAbTtrHWeRYfcW/ZrYNfWS8/3g==
X-Received: by 2002:a05:6808:9a6:b0:38d:ef18:53b5 with SMTP id e6-20020a05680809a600b0038def1853b5mr6945471oig.51.1682353618592;
        Mon, 24 Apr 2023 09:26:58 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id d13-20020a05680805cd00b0038e34b0a0ecsm4705160oij.8.2023.04.24.09.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 09:26:58 -0700 (PDT)
Received: (nullmailer pid 2778590 invoked by uid 1000);
        Mon, 24 Apr 2023 16:26:57 -0000
Date:   Mon, 24 Apr 2023 11:26:57 -0500
From:   Rob Herring <robh@kernel.org>
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Arnd Bergmann <arnd@kernel.org>, Linus Walleij <linusw@kernel.org>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 30/43] dt-bindings: wdt: Add DT binding ts72xx wdt
Message-ID: <20230424162657.GJ2701399-robh@kernel.org>
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
 <20230424123522.18302-31-nikita.shubin@maquefel.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230424123522.18302-31-nikita.shubin@maquefel.me>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 24, 2023 at 03:34:46PM +0300, Nikita Shubin wrote:
> Add DT binding for Technologic Systems TS-72xx watchdog.
> 
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> ---
>  .../watchdog/technologic,ts72xx-wdt.yaml      | 39 +++++++++++++++++++
>  1 file changed, 39 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/technologic,ts72xx-wdt.yaml
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/technologic,ts72xx-wdt.yaml b/Documentation/devicetree/bindings/watchdog/technologic,ts72xx-wdt.yaml
> new file mode 100644
> index 000000000000..0e06dbaec85f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/technologic,ts72xx-wdt.yaml
> @@ -0,0 +1,39 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/watchdog/technologic,ts72xx-wdt.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Technologic Systems TS-72xx based SBCs watchdog bindings
> +
> +maintainers:
> +  - Wim Van Sebroeck <wim@linux-watchdog.org>
> +  - Guenter Roeck <linux@roeck-us.net>
> +
> +allOf:
> +  - $ref: "watchdog.yaml#"

Drop quotes

> +
> +properties:
> +  compatible:
> +    enum:
> +      - technologic,ts7200-wdt
> +
> +  reg:
> +    maxItems: 2

Need to define each entry.

> +
> +required:
> +  - compatible
> +  - reg
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    watchdog0: watchdog@5a002000 {
> +      compatible = "technologic,ts7200-wdt";
> +      reg = <0x23800000 0x01>, <0x23c00000 0x01>;
> +      timeout-sec = <30>;
> +    };
> +
> +...
> +
> -- 
> 2.39.2
> 

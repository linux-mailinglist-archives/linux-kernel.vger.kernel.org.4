Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C23B86D9EAD
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 19:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239674AbjDFRYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 13:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239680AbjDFRYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 13:24:08 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 981899EDE
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 10:23:44 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id j22so3126415ejv.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 10:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680801777;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pnlv8etWHDfNorUk65qXAdIzN+L3opsvh3H3jUNcHsw=;
        b=BYLJN6tDh8UrgX7aTmSyaWVF3wuYEp0M3OWUZfCyw9+V3TpAkL/abDLE/ARsIEO3hw
         DDukrYXodPpOdZNJ+PuKgFSjeGjpf8EFVHG2nNkFHukxwRpL+w8OYje/8orxjZvxM9Fq
         VFYb4oLE1JygyR+OyVYE3tsEjpy7+jOmGc5eNYuDGA68F9VVl43Q944o8By51VO/u5b9
         OFdEtpa1YJKfbWPiegKM0BwowN9CNwZSJWDNbxlqZ6W+ZC0GPYDs8hoSA9+/Mv9f8OVp
         eigL1VcMPRltjP4kuCJ9G4cDNpLy1nrLywzbq/p5PIHq034JOIG39LwwvZ7v+arwUJBH
         /h1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680801777;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pnlv8etWHDfNorUk65qXAdIzN+L3opsvh3H3jUNcHsw=;
        b=Kwe8b0DIIQ5Gn2bSctBWJXhPNacWewjrUWu8dlywx5EZ+0dDmwtJpJbNbX5gF4u3Eu
         8HIGsXsqMtVTDScQNYuPfKpJd/fl/PKP3behCT8KHyKz2Uz4rasagTMwjVC9tz202QqM
         bXAFBVsfdSfbyAuE7jkKp/sYIWVGpxR6yBEe4Tn3xHxwyk0qvDZT30myOFbKXJIPa+AH
         sTT8h4Z43/4HwQv2I766zGFJ1PoBHLVa+31bWfxYJivOJ9/qG6+6hBEKGurASbAI+A/9
         A3qdYb8EfLR7d6A20WSFDO1IsQM23AFSEaa/k+f6VSpOsR80MwWAKHnxBoYIoxm2KIOf
         97Hw==
X-Gm-Message-State: AAQBX9ddxlzv0TCoF3tKKBvxUXP37r/CKnx1V/mvc6bGqImEiUnPZaBL
        rm52nqIUcJ6pGWVnezeu7N4vbw==
X-Google-Smtp-Source: AKy350aOaRNgk/gPQhNnYCku8DyxXboB4R5P/9bz5ow36dWmnyoDqCPEiFAC7OzNoUSeNFKbXPepDg==
X-Received: by 2002:a17:907:78d2:b0:946:c1d2:8b5d with SMTP id kv18-20020a17090778d200b00946c1d28b5dmr6810809ejc.17.1680801776779;
        Thu, 06 Apr 2023 10:22:56 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:49e6:bb8c:a05b:c4ed? ([2a02:810d:15c0:828:49e6:bb8c:a05b:c4ed])
        by smtp.gmail.com with ESMTPSA id z5-20020a170906074500b00930569e6910sm1082856ejb.16.2023.04.06.10.22.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 10:22:56 -0700 (PDT)
Message-ID: <3381fecd-9b83-627f-c408-76fe387a9b5e@linaro.org>
Date:   Thu, 6 Apr 2023 19:22:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 2/5] dt-bindings: arm: blaize: Add Blaize BLZP1600 SoC
Content-Language: en-US
To:     Niko Pasaloukos <nikolaos.pasaloukos@blaize.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "soc@kernel.org" <soc@kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "olof@lixom.net" <olof@lixom.net>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        James Cowgill <james.cowgill@blaize.com>,
        Matt Redfearn <matthew.redfearn@blaize.com>,
        Neil Jones <neil.jones@blaize.com>
References: <20230406102149.729726-1-nikolaos.pasaloukos@blaize.com>
 <20230406102149.729726-3-nikolaos.pasaloukos@blaize.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230406102149.729726-3-nikolaos.pasaloukos@blaize.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/04/2023 12:22, Niko Pasaloukos wrote:
> Add device tree bindings for the Blaize BLZP1600 CB2
> development board.
> 
> Co-developed-by: James Cowgill <james.cowgill@blaize.com>
> Signed-off-by: James Cowgill <james.cowgill@blaize.com>
> Co-developed-by: Matt Redfearn <matt.redfearn@blaize.com>
> Signed-off-by: Matt Redfearn <matt.redfearn@blaize.com>
> Co-developed-by: Neil Jones <neil.jones@blaize.com>
> Signed-off-by: Neil Jones <neil.jones@blaize.com>
> Signed-off-by: Nikolaos Pasaloukos <nikolaos.pasaloukos@blaize.com>
> ---
>  .../devicetree/bindings/arm/blaize.yaml       | 28 +++++++++++++++++++
>  1 file changed, 28 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/blaize.yaml
> 
> diff --git a/Documentation/devicetree/bindings/arm/blaize.yaml b/Documentation/devicetree/bindings/arm/blaize.yaml
> new file mode 100644
> index 000000000000..739115ba1fec
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/blaize.yaml
> @@ -0,0 +1,28 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/blaize.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Blaize Platforms Device Tree Bindings

If four of people were working on this, I would expect that at least one
person would point that it's not correct name. Start from recent
bindings. Drop Device Tree Bindings.

> +
> +maintainers:
> +  - James Cowgill <james.cowgill@blaize.com>
> +  - Matt Redfearn <matt.redfearn@blaize.com>
> +  - Neil Jones <neil.jones@blaize.com>
> +  - Nikolaos Pasaloukos <nikolaos.pasaloukos@blaize.com>
> +
> +properties:
> +  $nodename:
> +    const: '/'
> +  compatible:
> +    oneOf:
> +      - description: Blaize BLZP1600 based Boards
> +        items:
> +          - enum:
> +              - blaize,blzp1600-som-cb2

som is not a board. You miss board compatible or this is a bit misleading.

Best regards,
Krzysztof


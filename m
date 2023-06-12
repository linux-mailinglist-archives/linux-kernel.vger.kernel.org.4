Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C57172BB3F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 10:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233746AbjFLIwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 04:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233773AbjFLIwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 04:52:16 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E92F1B3;
        Mon, 12 Jun 2023 01:52:05 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2b1b06af50eso46999481fa.1;
        Mon, 12 Jun 2023 01:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686559923; x=1689151923;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vC6uwJ0JqcA9AI2hZ192LN4Lm6HljDsWRRLUQCbqRcI=;
        b=ha+NLGOPK268A8Rm69MB2VrlRZ+bdLMoCKBLy0i1SKtuixABoEGpHl4oGE70nPdWrI
         fWHYhWb5EBh38UF+ViInymqzwkg/Zad+alqWfDprpVo9fgantG3Tz2sziWPw8upec7ts
         /Fv3t/yWt6xY9KXU53ybP9Y85wyqEazYhy6JiPo96nIX5SF4uRKG5GITBsqxWuCk1vQX
         EkWAFhD8ZV+9RpimOe60IiIxpLQXcl/lff1tzJzFERRz1X4gJJh8cCQuDLq3wpAnM8wY
         WWTst4ebBmy5XYqnnge0LQw1u/wcQ76+CfadGwNDS32TMQdIsStrT+N5jEUX9QHUrcCk
         D7qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686559923; x=1689151923;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vC6uwJ0JqcA9AI2hZ192LN4Lm6HljDsWRRLUQCbqRcI=;
        b=i0l5Dbz4oZrBwXUAkXHVFeZ7TxK0rZA95I9mLV51H4+VshpWkkQ4M3cFRW1Wn77gCf
         kwxhr0FBsSWBAUMrKCV94zMNtYjYH28KTNQ0kr3cmmJlG92z3AA0nSjfQJR2e7BKaOmF
         yM+olLohriLVAsGE+RJICsSgOnGBkew11lYXORLPNUqWf86+QzJWqRlKFqv5YJ2A04Rn
         qNSOZIGI2VN4454iqsXY8g+7hyevJMFguQ8a3LLDceGSAn5DnT6lEpQXMhZzAqWoXXxK
         vgSsknsJMkBVJ3obSW5lFkVffTuIfub3MpJ4NgyMubAaXV7WMM3ky+a5PRqHbM6zyBk+
         MNQg==
X-Gm-Message-State: AC+VfDzHqtwgSNirCeCPQ8pNHmuHPaJ3rXs5268hQHdLRvuKsrkaOTjw
        6fYCxRp0MfLCd4stLJFn/b8=
X-Google-Smtp-Source: ACHHUZ7EKA8vldamQ7vDC+e0lKSYEpHmgr+nXY6Twa32SsY75+3B3FPeePjMNjp0U0aabyKDkLIrCw==
X-Received: by 2002:a05:651c:1039:b0:2af:d2ef:49d4 with SMTP id w25-20020a05651c103900b002afd2ef49d4mr2231817ljm.1.1686559923246;
        Mon, 12 Jun 2023 01:52:03 -0700 (PDT)
Received: from mobilestation ([95.79.140.35])
        by smtp.gmail.com with ESMTPSA id s9-20020a2e9c09000000b002b31e0be2d7sm1003800lji.90.2023.06.12.01.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 01:52:02 -0700 (PDT)
Date:   Mon, 12 Jun 2023 11:52:00 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-ide@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH v3 2/5] dt-bindings: ata: dwc-ahci: add Rockchip RK3588
Message-ID: <20230612085200.5okxcipiw5sofo62@mobilestation>
References: <20230608162238.50078-1-sebastian.reichel@collabora.com>
 <20230608162238.50078-3-sebastian.reichel@collabora.com>
 <4c914503-c2e5-a5d8-97af-daaee0b4ec7c@linaro.org>
 <20230612083536.q3sq7w6cyiuxaqtv@mobilestation>
 <838ed0e6-985d-9a45-7ece-c607bda15871@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <838ed0e6-985d-9a45-7ece-c607bda15871@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2023 at 10:39:57AM +0200, Krzysztof Kozlowski wrote:
> On 12/06/2023 10:35, Serge Semin wrote:
> > On Mon, Jun 12, 2023 at 10:24:06AM +0200, Krzysztof Kozlowski wrote:
> >> On 08/06/2023 18:22, Sebastian Reichel wrote:
> >>> This adds Rockchip RK3588 AHCI binding. In order to narrow down the
> >>> allowed clocks without bloating the generic binding, the description
> >>> of Rockchip's AHCI controllers has been moved to its own file.
> >>>
> >>> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> >>> ---
> >>
> >> ...
> >>
> >>> +
> >>> +properties:
> >>> +  compatible:
> >>> +    items:
> >>> +      - enum:
> >>> +          - rockchip,rk3568-dwc-ahci
> >>> +          - rockchip,rk3588-dwc-ahci
> >>> +      - const: snps,dwc-ahci
> >>> +
> >>> +  ports-implemented:
> >>> +    const: 1
> >>> +
> >>> +patternProperties:
> >>> +  "^sata-port@[0-9a-e]$":
> >>> +    $ref: /schemas/ata/snps,dwc-ahci-common.yaml#/$defs/dwc-ahci-port
> >>> +
> >>> +    unevaluatedProperties: false
> >>
> > 
> >> You should be able to skip this patternProperties entirely, because it
> >> comes from dwc-ahci-common -> ahci-common schema. Did you try the patch
> >> without it?
> > 

> > Please see my message about this. The "sata-port@[0-9a-e]$" sub-node
> > bindings could be updated with the "reg" property constraint which,
> > based on the "ports-implemented" property value, most likely is
> > supposed to be always set to const: 1.
> 
> Then anyway the pattern is wrong as it should be @1 always.

* I miscalculated a bit, it should have been zero but in general
the pattern-property is indeed redundant.

As a conclusion the change should look like this:

+properties:
+  compatible:
+    items:
+      - enum:
+          - rockchip,rk3568-dwc-ahci
+          - rockchip,rk3588-dwc-ahci
+      - const: snps,dwc-ahci
+
+  ports-implemented:
+    const: 1
+
+  "sata-port@0":
+    $ref: /schemas/ata/snps,dwc-ahci-common.yaml#/$defs/dwc-ahci-port
+
+    properties:
+      reg:
+        const: 0
+
+    unevaluatedProperties: false
+
+ ...

Right?

-Serge(y)

> 
> Best regards,
> Krzysztof
> 

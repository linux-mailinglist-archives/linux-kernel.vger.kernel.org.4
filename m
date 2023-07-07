Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A2B174B45E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 17:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232710AbjGGPbb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 11:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjGGPb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 11:31:28 -0400
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F1B2128;
        Fri,  7 Jul 2023 08:31:27 -0700 (PDT)
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3463dd0bd4eso6893385ab.1;
        Fri, 07 Jul 2023 08:31:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688743887; x=1691335887;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4krSfV5RdVLkdj4vMo1p32Ocs53a/+FB/VamolfXKgk=;
        b=WBp05flFXWoWVZq0YXHDZnGoKOBKtl6VfMCvZFQrzTolU7oL3M69DelJQjissuu0RN
         /apxE0MdKp2e5LlY/8czBJGrK7LS1I6/Phbuiht54ovgY8yXK/lI6Sik6wAY/q+ysqJv
         nuMdxNRWkwsI5vO3lWlH7/dt7ZxBF1+Jg+UNVc6HMRmUDOFhfslbb/ByiSB/ZcY3QGOP
         2aufgXnF6fFl/hxX1jUNHkQxNnW213E5ntkhjmVaCmqtLujfCnzcDXQJo11XXW5Dto/j
         qlEXV+dPhv+sHIWSC1SSNsIV5DpnRP/6Hue0HZjXD/UUCFXI77XwrcO+oPSvgCS2L/HO
         j2Hw==
X-Gm-Message-State: ABy/qLZCXaubBe21tSvoq8ZW7BjTvpGrUsl4OQdIzNpe/N3yk/VRbYIk
        GqwdrowOQDvcgEFGz/HExw==
X-Google-Smtp-Source: APBJJlGsBsKFeZBb8fU2bcyVgRL9aJv0pp9rDtUdPfMV8gTZk6+GrVqq4VjMLpT6v23Sh93K9+x0rA==
X-Received: by 2002:a92:c083:0:b0:345:ba42:ca4d with SMTP id h3-20020a92c083000000b00345ba42ca4dmr5490944ile.15.1688743886724;
        Fri, 07 Jul 2023 08:31:26 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id w5-20020a92db45000000b00342093347d8sm1346438ilq.76.2023.07.07.08.31.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 08:31:25 -0700 (PDT)
Received: (nullmailer pid 339098 invoked by uid 1000);
        Fri, 07 Jul 2023 15:31:24 -0000
Date:   Fri, 7 Jul 2023 09:31:24 -0600
From:   Rob Herring <robh@kernel.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     linux-amlogic@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-arm-kernel@lists.infradead.org,
        Heiner Kallweit <hkallweit1@gmail.com>,
        devicetree@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>,
        Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: pinctrl: amlogic,meson-pinctrl:
 allow gpio-line-names
Message-ID: <168874388364.339042.7246831191006264441.robh@kernel.org>
References: <20230707-topic-amlogic-upstream-pinctrl-fix-bindings-v2-0-2160060446d7@linaro.org>
 <20230707-topic-amlogic-upstream-pinctrl-fix-bindings-v2-1-2160060446d7@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230707-topic-amlogic-upstream-pinctrl-fix-bindings-v2-1-2160060446d7@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 07 Jul 2023 10:20:44 +0200, Neil Armstrong wrote:
> Allow gpio-line-names property for the gpio subnodes.
> 
> Fixes: 94df03a45276 ("dt-bindings: pinctrl: Convert Amlogic Meson pinctrl binding")
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  .../devicetree/bindings/pinctrl/amlogic,meson-pinctrl-a1.yaml         | 4 ++++
>  .../devicetree/bindings/pinctrl/amlogic,meson-pinctrl-g12a-aobus.yaml | 3 +++
>  .../bindings/pinctrl/amlogic,meson-pinctrl-g12a-periphs.yaml          | 3 +++
>  .../devicetree/bindings/pinctrl/amlogic,meson8-pinctrl-aobus.yaml     | 4 ++++
>  .../devicetree/bindings/pinctrl/amlogic,meson8-pinctrl-cbus.yaml      | 4 ++++
>  5 files changed, 18 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>


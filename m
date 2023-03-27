Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2D76CA8F4
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 17:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbjC0P3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 11:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232630AbjC0P2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 11:28:49 -0400
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A322540EE;
        Mon, 27 Mar 2023 08:28:45 -0700 (PDT)
Received: by mail-ot1-f52.google.com with SMTP id f4-20020a9d0384000000b0069fab3f4cafso4733247otf.9;
        Mon, 27 Mar 2023 08:28:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679930924;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LEE//CVec7N01zWXhmb3QcGzLCREQLQp/FRs8Lve+i8=;
        b=0K/p1PL7PZUZoufEM8AhsUo15BgZ9CZ9Rl8yQK+H3tvouIL3HbaC3TBH1Sdp7MzY2D
         TQ9bduZvE5G4rJsSovvCgFczg3+/6rVBwZijFGBUY1VK6RxgWh1pYOjl17uZb5Dj93pI
         itN19KP/U2TCa2HrxAsRzYymyg8lT1XFKZ9qmFv9jUFP39QHdHCdxQ+AjlnXbX9et8gC
         zU1vux54LlycbUbv2kh+frptV8wxd1N4edB1YGcRGZyipaVUbMK6LNXZZNEkAdcOn9vh
         v7DzAkkuKCMn0L2h805N3aGG6ZpRzq0tlbab0ABf/RrtMprpeCBX/u9yr7r9NRwzgVgo
         +lsA==
X-Gm-Message-State: AAQBX9csWQKNC8Pc7Ct0aorKjAZtvBuRsB4ib/NkqG1OaTQC8VhfW5FH
        5QZjBMUTMNk6vDsp5UAbOQ==
X-Google-Smtp-Source: AKy350bmPVQig+xpjcFDj6G5EpbUIjt419xav/Kwr6elxAu9ry41ovS9zixIUChIOJIaJ1v3e4y4UQ==
X-Received: by 2002:a05:6830:3892:b0:6a1:2a17:16f2 with SMTP id bq18-20020a056830389200b006a12a1716f2mr4375958otb.1.1679930924535;
        Mon, 27 Mar 2023 08:28:44 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id n37-20020a056870972500b00177b33ce85bsm9935770oaq.30.2023.03.27.08.28.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 08:28:44 -0700 (PDT)
Received: (nullmailer pid 3907135 invoked by uid 1000);
        Mon, 27 Mar 2023 15:28:43 -0000
Date:   Mon, 27 Mar 2023 10:28:43 -0500
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Rokosov <ddrokosov@sberdevices.ru>
Cc:     robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        jbrunet@baylibre.com, neil.armstrong@linaro.org,
        rockosov@gmail.com, sboyd@kernel.org, mturquette@baylibre.com,
        khilman@baylibre.com, jian.hu@amlogic.com, kernel@sberdevices.ru,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        martin.blumenstingl@googlemail.com
Subject: Re: [PATCH v11 3/5] dt-bindings: clock: meson: add A1 PLL and
 Peripherals clkcs bindings
Message-ID: <167993090466.3906795.9343915150600336952.robh@kernel.org>
References: <20230321193014.26349-1-ddrokosov@sberdevices.ru>
 <20230321193014.26349-4-ddrokosov@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230321193014.26349-4-ddrokosov@sberdevices.ru>
X-Spam-Status: No, score=0.7 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 21 Mar 2023 22:30:12 +0300, Dmitry Rokosov wrote:
> Add the documentation for Amlogic A1 PLL and Amlogic A1 Peripherals
> clock drivers.
> Introduce Amlogic A1 PLL and Amlogic A1 Peripherals device tree
> bindings and include them to MAINTAINERS.
> 
> Signed-off-by: Jian Hu <jian.hu@amlogic.com>
> Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
> ---
>  .../bindings/clock/amlogic,a1-clkc.yaml       |  73 +++++++++++
>  .../bindings/clock/amlogic,a1-pll-clkc.yaml   |  59 +++++++++
>  MAINTAINERS                                   |   1 +
>  include/dt-bindings/clock/amlogic,a1-clkc.h   | 113 ++++++++++++++++++
>  .../dt-bindings/clock/amlogic,a1-pll-clkc.h   |  21 ++++
>  5 files changed, 267 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/amlogic,a1-clkc.yaml
>  create mode 100644 Documentation/devicetree/bindings/clock/amlogic,a1-pll-clkc.yaml
>  create mode 100644 include/dt-bindings/clock/amlogic,a1-clkc.h
>  create mode 100644 include/dt-bindings/clock/amlogic,a1-pll-clkc.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>


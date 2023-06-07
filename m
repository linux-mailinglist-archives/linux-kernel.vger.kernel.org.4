Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA545726D07
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 22:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234251AbjFGUic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 16:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234250AbjFGUi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 16:38:26 -0400
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D1951706;
        Wed,  7 Jun 2023 13:38:06 -0700 (PDT)
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-77ac30e95caso72989339f.2;
        Wed, 07 Jun 2023 13:38:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686170247; x=1688762247;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+zgUfZbj8UgwFs6zorpXckRZL+p/Z8v5AChyDByc05I=;
        b=dOKG64yR48vpx9BAa3+Ssnlqgi8R96GRo5f46JFafWEQsAKX25eLZFwX2NvYZQSYHu
         LAZkoeR+2wyqSPdaODJl8Chk027ob3z4/xT6X9iRdJeSd7z4rNw2heuPwlF8c0mSKFrx
         5D7O6kKKzzuuvqNYPAI3H9QYru4d4Oku2XAVHlCC1TjRIDlVb2DpH2bDIGc8lhLvmHu6
         YcmKfCqvpyR380F6xcetaVVZtJq1+h2Z5N1u13parVKmXpeP8PDBXu69K0y0x0Ws5QOP
         U2e0mA2i4S/Y54MWxq26OfImcx73ZzSiHy+XuZTatHLe+VNjkap3zEcqEq5t4/VAI+KH
         5wwA==
X-Gm-Message-State: AC+VfDx+By+NYP6ql/osi86Y2+Q0UFTBtjzKa0uaDicTqMiKZZDNLip4
        vUOVkX07Bkxd7V+PpDZ3mw==
X-Google-Smtp-Source: ACHHUZ4Gh0jUQjI7Mx3OVJyPWIKhQiVbqlhuwxeWKu1Od7VcNnyvF5RraLcM3DWUt/PYxm6w3oVW+g==
X-Received: by 2002:a6b:dd13:0:b0:76c:898c:9b10 with SMTP id f19-20020a6bdd13000000b0076c898c9b10mr8694413ioc.0.1686170246861;
        Wed, 07 Jun 2023 13:37:26 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id w7-20020a02cf87000000b00420c5d10c38sm611082jar.74.2023.06.07.13.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 13:37:25 -0700 (PDT)
Received: (nullmailer pid 3979185 invoked by uid 1000);
        Wed, 07 Jun 2023 20:37:23 -0000
Date:   Wed, 7 Jun 2023 14:37:23 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Rokosov <ddrokosov@sberdevices.ru>
Cc:     khilman@baylibre.com, jian.hu@amlogic.com,
        krzysztof.kozlowski+dt@linaro.org, sboyd@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        martin.blumenstingl@googlemail.com, jbrunet@baylibre.com,
        linux-clk@vger.kernel.org, robh+dt@kernel.org,
        neil.armstrong@linaro.org, kernel@sberdevices.ru,
        devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
        rockosov@gmail.com, mturquette@baylibre.com
Subject: Re: [PATCH v16 5/6] dt-bindings: clock: meson: add A1 Peripherals
 clock controller bindings
Message-ID: <168617024273.3979125.14701905013273806999.robh@kernel.org>
References: <20230523135351.19133-1-ddrokosov@sberdevices.ru>
 <20230523135351.19133-6-ddrokosov@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230523135351.19133-6-ddrokosov@sberdevices.ru>
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


On Tue, 23 May 2023 16:53:50 +0300, Dmitry Rokosov wrote:
> Add documentation and dt bindings for the Amlogic A1 Peripherals clock
> controller.
> A1 PLL clock controller has references to A1 Peripherals clock
> controller objects, so reflect them in the schema.
> 
> Signed-off-by: Jian Hu <jian.hu@amlogic.com>
> Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
> ---
>  .../clock/amlogic,a1-peripherals-clkc.yaml    |  73 +++++++++++
>  .../bindings/clock/amlogic,a1-pll-clkc.yaml   |   5 +-
>  .../clock/amlogic,a1-peripherals-clkc.h       | 115 ++++++++++++++++++
>  3 files changed, 191 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/clock/amlogic,a1-peripherals-clkc.yaml
>  create mode 100644 include/dt-bindings/clock/amlogic,a1-peripherals-clkc.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>


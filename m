Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 215EF6DF79A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 15:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbjDLNqu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 09:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbjDLNqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 09:46:48 -0400
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 050811705;
        Wed, 12 Apr 2023 06:46:47 -0700 (PDT)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-18779252f7fso1534106fac.12;
        Wed, 12 Apr 2023 06:46:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681307206; x=1683899206;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wMIsbHNnroLWpq0bCS+nidwmOEDa42ufuQvEvuau8Vo=;
        b=kUJjUrrPVMfD5Rh25Up00+6VJ1anywfwmdQYffkwVS8aJEdpqRS2EJZ7yG4JyJNjrW
         YCVlX0z/gBSvW1o7MsRM/7iZt6+evxzbmE3h+s1GEz2ztIhBt/b8Bw4pmd0UNWGIz8GQ
         lmh21R2lXqTuiMON/CSWobIfnyctPFc8HvhfmyKK9G2rIubwBt0Y8nre7SIrJ/z4FdXS
         RhGu6HtzSPyMmcRQ6HHXEXh+dpWDFmnBEjtjjUHS7Y5wxuhn2TK7zykkIfCdZwBxJt/C
         SEdJ6m5y68Q7k4Ac+vuak/CVWXMH9pk1FTDgSJpwNGXg/jEkL99owCC/aufKSHW+KVys
         myRA==
X-Gm-Message-State: AAQBX9dMs3f7WsxVp4lzMGnQIahNRgimtNCMo1UAOcqoSCMyXd1+f8jp
        JhXsTzC5mFIjKljZjQGIvA==
X-Google-Smtp-Source: AKy350btiGupIrvvLRbguGEmiks3gnNC3F8BxcxIKf+7+nVWNNkVrB99ACrNuK4eYRd9VWILOpnecw==
X-Received: by 2002:a05:6870:4608:b0:177:a1ab:8c53 with SMTP id z8-20020a056870460800b00177a1ab8c53mr3642678oao.12.1681307206210;
        Wed, 12 Apr 2023 06:46:46 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id e5-20020a056830200500b006a1287ccce6sm181638otp.31.2023.04.12.06.46.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 06:46:45 -0700 (PDT)
Received: (nullmailer pid 2218307 invoked by uid 1000);
        Wed, 12 Apr 2023 13:46:44 -0000
Date:   Wed, 12 Apr 2023 08:46:44 -0500
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Rokosov <ddrokosov@sberdevices.ru>
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org,
        linux-clk@vger.kernel.org, khilman@baylibre.com,
        mturquette@baylibre.com, kernel@sberdevices.ru,
        martin.blumenstingl@googlemail.com,
        linux-arm-kernel@lists.infradead.org,
        krzysztof.kozlowski+dt@linaro.org, sboyd@kernel.org,
        rockosov@gmail.com, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, jbrunet@baylibre.com,
        jian.hu@amlogic.com, neil.armstrong@linaro.org
Subject: Re: [PATCH v13 5/6] dt-bindings: clock: meson: add A1 Peripherals
 clock controller bindings
Message-ID: <168130720431.2218249.7671061964988064525.robh@kernel.org>
References: <20230405195927.13487-1-ddrokosov@sberdevices.ru>
 <20230405195927.13487-6-ddrokosov@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230405195927.13487-6-ddrokosov@sberdevices.ru>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 05 Apr 2023 22:59:26 +0300, Dmitry Rokosov wrote:
> Add the documentation for Amlogic A1 Peripherals clock driver,
> and A1 Peripherals clock controller bindings.
> A1 PLL clock controller has references to A1 Peripherals clock
> controller objects, so reflect them in the schema.
> 
> Signed-off-by: Jian Hu <jian.hu@amlogic.com>
> Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
> ---
>  .../bindings/clock/amlogic,a1-clkc.yaml       |  73 +++++++++++
>  .../bindings/clock/amlogic,a1-pll-clkc.yaml   |   5 +-
>  include/dt-bindings/clock/amlogic,a1-clkc.h   | 114 ++++++++++++++++++
>  3 files changed, 190 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/clock/amlogic,a1-clkc.yaml
>  create mode 100644 include/dt-bindings/clock/amlogic,a1-clkc.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>


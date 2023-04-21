Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB7136EB132
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 19:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231770AbjDURuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 13:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232755AbjDURue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 13:50:34 -0400
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B8F172A8;
        Fri, 21 Apr 2023 10:50:09 -0700 (PDT)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-18b1c643219so752596fac.2;
        Fri, 21 Apr 2023 10:50:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682099402; x=1684691402;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7+Yw0wBucBO2eV03SjOJLl/RpSRFafXyyDquHk7Jr6c=;
        b=YVX9ltaMTBYuDnDnyQ9CyZHhxsrnpoKTHLs5C19HoMSE5qlpT7JGu2tioHi3UsPvRV
         Dmw2XCCZtDFE2sokhR9yC7ESmOA0AFcbOdLsSbd9JPDz6fkkdlB27jaWviie2AOR50ZU
         BUYbfm/+hm4IAj3cJCAstclKEF1S6frvdD25Drt8q96XO2wvmwkybMock8PzatV0yLXd
         FIMEsDDl4plo5Fhu7yW4FOChyb/r2PDzDuL5JrChfHMyA3ZtoQ+gNYePLz3eQG05jw/P
         xZhScM490bl+40C3EGnYtXJf+alLBlFdQPEjZQOckPHCj899Xc/wN+VrN7KlBtO/Rq0x
         LaWw==
X-Gm-Message-State: AAQBX9e66KUhn27uEj+nBAGtz7Srw/c+4gJDH6+oGR/I097GVnYJzJG4
        RfZcaTPUq8B9xEjqduSBPQ==
X-Google-Smtp-Source: AKy350aPQ32Mv080byx+joW6KOyOF9h1ws+ph6JZBWjTq+j0gLXXO/D9blhUaQqzLeuFEAsL2xpe2w==
X-Received: by 2002:a05:6870:d693:b0:17a:a825:6be9 with SMTP id z19-20020a056870d69300b0017aa8256be9mr4436762oap.43.1682099402364;
        Fri, 21 Apr 2023 10:50:02 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id j6-20020acab906000000b00383eaea5e88sm1775777oif.38.2023.04.21.10.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 10:50:02 -0700 (PDT)
Received: (nullmailer pid 1537581 invoked by uid 1000);
        Fri, 21 Apr 2023 17:50:01 -0000
Date:   Fri, 21 Apr 2023 12:50:01 -0500
From:   Rob Herring <robh@kernel.org>
To:     Yu Tu <yu.tu@amlogic.com>
Cc:     linux-arm-kernel@lists.infradead.org, kelvin.zhang@amlogic.com,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org,
        Michael Turquette <mturquette@baylibre.com>,
        qi.duan@amlogic.com, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH V7 2/4] dt-bindings: clock: document Amlogic S4 SoC
 peripherals clock controller
Message-ID: <168209940084.1537528.5735682632466385395.robh@kernel.org>
References: <20230417065005.24967-1-yu.tu@amlogic.com>
 <20230417065005.24967-3-yu.tu@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230417065005.24967-3-yu.tu@amlogic.com>
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


On Mon, 17 Apr 2023 14:50:03 +0800, Yu Tu wrote:
> Add the S4 peripherals clock controller dt-bindings in the s4 SoC
> family.
> 
> Signed-off-by: Yu Tu <yu.tu@amlogic.com>
> ---
>  .../clock/amlogic,s4-peripherals-clkc.yaml    |  97 +++++++++++++
>  .../clock/amlogic,s4-peripherals-clkc.h       | 131 ++++++++++++++++++
>  2 files changed, 228 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/amlogic,s4-peripherals-clkc.yaml
>  create mode 100644 include/dt-bindings/clock/amlogic,s4-peripherals-clkc.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>


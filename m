Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E14D6E6F61
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 00:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232279AbjDRWaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 18:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232420AbjDRW3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 18:29:53 -0400
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2099D35A3;
        Tue, 18 Apr 2023 15:29:52 -0700 (PDT)
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6a5f765d5b8so613457a34.3;
        Tue, 18 Apr 2023 15:29:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681856991; x=1684448991;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IrmDFMV+ByWwft8Vdv6h3adx/3/XUUc95kI+OilyKT8=;
        b=Jr7yKa6qFgf9fTJA1+l7uRd6u95JxDEuolU8g8949kjAN9pPNlMRjVGGZlsDH0PCNN
         8MtKbMg4txDB8zfoBxPFrYM9yAR4+Cs19rJ1haq7OxG0YX3zDGnUFRQzQ1m084xjO/zj
         v6Dr7WYhlCzK1DuzLxDlQBcQqORVHBLTdLoq0TMsq7zXe9iNriVONAxfOpZfhTqckT+y
         KTDXaj2RsZDCqg7X3uGmJewqHVeclt+scR12WA5eK17v5iZsU8+9Exd1oE+vdShz2FvK
         wPyUNe2HhnjqefRRJFHpRoZvxh7tEDena+lO1+l5ICpBYTnnEjs4JKx8vaDwPO822NMH
         NM3g==
X-Gm-Message-State: AAQBX9c9sG3qhG9g2VzpYHkUz9ExgR3TuETMVDYzWTYuVxTVhKH9A7QS
        Jp1Jx1m+bpnAA2gY/UigAVSzTdAsFg==
X-Google-Smtp-Source: AKy350ZNJODwIqGkJ5sG/17OBGRNxMmBa91BltKwVlK1NWnfPu6nrcHAX+Hxtp3Q9SF1r4NaiL27Vw==
X-Received: by 2002:a9d:6350:0:b0:6a4:390f:cd61 with SMTP id y16-20020a9d6350000000b006a4390fcd61mr1858161otk.0.1681856991282;
        Tue, 18 Apr 2023 15:29:51 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id d16-20020a056830005000b0068bd922a244sm6134585otp.20.2023.04.18.15.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 15:29:50 -0700 (PDT)
Received: (nullmailer pid 2443692 invoked by uid 1000);
        Tue, 18 Apr 2023 22:29:50 -0000
Date:   Tue, 18 Apr 2023 17:29:50 -0500
From:   Rob Herring <robh@kernel.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        Matti Vaittinen <mazziesaccount@gmail.com>, pavel@ucw.cz,
        krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org
Subject: Re: [PATCH v5 1/2] dt-bindings: leds: Add ROHM BD2606MVV LED
Message-ID: <168185698973.2443640.10846609870028128019.robh@kernel.org>
References: <20230416211550.903240-1-andreas@kemnade.info>
 <20230416211550.903240-2-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230416211550.903240-2-andreas@kemnade.info>
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


On Sun, 16 Apr 2023 23:15:49 +0200, Andreas Kemnade wrote:
> Document ROHM BD2606MVV LED driver devicetree bindings.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
> ---
>  .../bindings/leds/rohm,bd2606mvv.yaml         | 81 +++++++++++++++++++
>  1 file changed, 81 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/rohm,bd2606mvv.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>


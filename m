Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BFBD6D9DD5
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 18:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239611AbjDFQrx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 12:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239220AbjDFQrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 12:47:51 -0400
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF9507ED8;
        Thu,  6 Apr 2023 09:47:36 -0700 (PDT)
Received: by mail-oi1-f170.google.com with SMTP id f14so15938007oiw.10;
        Thu, 06 Apr 2023 09:47:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680799656; x=1683391656;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=goftEu/oL/56f1SzPdGbJy2Za/7DOnQGB7Rg7sScybg=;
        b=zc/Vyqo/bkKvPLMEjJZUx/V7wr+1GD6UGDAXm368dlk4KDVkFUqkwqyKMC96+ckgba
         pPjmTaST3+oEVsfvSS99zJ+fUpu8OwEFV6e316ZKclZAh9CUStFS0DfF/EKqdxy2x+le
         7getFhTGV5Qtl5QS9IvQqX47jZpyo99fYqiGT8sBgho1TEvdASBaDVwVXYZ1FUe5CEgP
         YeOrLz8mjK33Xedt1M1TQfbvuCHrFzDi0o/GDFu98gwBvanWqUIy76KCP/oxV64Pjv+l
         LT5KralIj4QRcHYpIMj/q/hdBMJ7i5u6fPb33ORSwqRHXhsBbkzy6BoHTknmXU/Hbx5v
         OiEA==
X-Gm-Message-State: AAQBX9cw5CJWxU0Koa1PhPv22KMXPX4OtrSvIDyfBHcvKqzuaFpRyjas
        XzgN0epnK6scZITeATXAxg==
X-Google-Smtp-Source: AKy350Yon2Li5QLhuLgTOLq8dbTiEim2m/ZmXxUprhFvPZtz4VV5R+lfSjreM2TmT/a9JHFtn1qfnQ==
X-Received: by 2002:a05:6808:984:b0:383:e301:1795 with SMTP id a4-20020a056808098400b00383e3011795mr3720625oic.4.1680799656216;
        Thu, 06 Apr 2023 09:47:36 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id p10-20020acad80a000000b003898bec0e01sm860605oig.17.2023.04.06.09.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 09:47:35 -0700 (PDT)
Received: (nullmailer pid 3282908 invoked by uid 1000);
        Thu, 06 Apr 2023 16:47:35 -0000
Date:   Thu, 6 Apr 2023 11:47:35 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-phy@lists.infradead.org, Vinod Koul <vkoul@kernel.org>,
        Abraham I <kishon@ti.com>,
        Swapnil Jakhade <sjakhade@cadence.com>,
        devicetree@vger.kernel.org, Yuti Amonkar <yamonkar@cadence.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH 4/5] dt-bindings: phy: ti,phy-j721e-wiz: drop
 assigned-clocks
Message-ID: <168079965469.3282835.8696594614789018779.robh@kernel.org>
References: <20230404190115.546973-1-krzysztof.kozlowski@linaro.org>
 <20230404190115.546973-4-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230404190115.546973-4-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=0.7 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 04 Apr 2023 21:01:14 +0200, Krzysztof Kozlowski wrote:
> The meta schema from DT schema already defines assigned-clocks, so there
> is no need for device schema to mention it at all.  There are also no
> benefits of having it here and a board could actually need more of clock
> assignments than the schema allows.
> 
> Keep however the assigned-clocks in children nodes, as apparently their
> proper parenting is required.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/phy/ti,phy-j721e-wiz.yaml    | 12 ------------
>  1 file changed, 12 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>


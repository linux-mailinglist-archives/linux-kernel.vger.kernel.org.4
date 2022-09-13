Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F08E45B6CA5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 13:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231913AbiIML5Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 07:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231335AbiIML5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 07:57:14 -0400
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D07185E57C;
        Tue, 13 Sep 2022 04:57:13 -0700 (PDT)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-127ba06d03fso31424825fac.3;
        Tue, 13 Sep 2022 04:57:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=vgIdRtooHkTzSKG3+m+u2h/yJ3hfDpcaNPXz25KQG8o=;
        b=nsY85xfrruHuctRwEIjANG28aPSc2Vl8ln1CiuaSTUQ1e4lD43PwulET3ZVg/HJF66
         IE6IXL0UcWpHUX2UQYc6N3fsxIdUv82tRP2sDpOqCrF+sQ50yb26aQvW20paPPrlYfgU
         Ah4NhQVOXUpvbRUnmw56AgN5EN3+GHm3iOBTUbJ3SnaW9lRKgy7vW2bBt7sVumN4dPxB
         Ge41g0TObpmPA50E+bOa9Pxn4BfJfgLXL0Vy35Vg6BNkzCUjKYtaSEa7hlqzscD8/9Yt
         QYBEMfxiausRuBSHdU1EmTe9uLZoCnx2WAiyFmAGffOK/afqxwRWlEpjBg4DhAS2HvhO
         L3nA==
X-Gm-Message-State: ACgBeo2KvRJkRS2/OVzRMMicXzdhDjXed0iIFh2v7Oo6tG6DItB8kyTE
        fJepLDt6bUyn+9z3knsZIA==
X-Google-Smtp-Source: AA6agR7GFEoJJngcu3f/bC4hMJCCtnMxSTKcP0CunsM+ZjfkA0LfvR2yPpPDa9cNWGgTS5J7/p4tFg==
X-Received: by 2002:a05:6808:1208:b0:349:a2cd:ac42 with SMTP id a8-20020a056808120800b00349a2cdac42mr1297763oil.155.1663070233123;
        Tue, 13 Sep 2022 04:57:13 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id s14-20020a056830124e00b00655fd5b878fsm1741547otp.74.2022.09.13.04.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 04:57:12 -0700 (PDT)
Received: (nullmailer pid 3386454 invoked by uid 1000);
        Tue, 13 Sep 2022 11:57:12 -0000
Date:   Tue, 13 Sep 2022 06:57:12 -0500
From:   Rob Herring <robh@kernel.org>
To:     Eliav Farber <farbere@amazon.com>
Cc:     robh+dt@kernel.org, rtanwar@maxlinear.com, p.zabel@pengutronix.de,
        hhhawa@amazon.com, linux@roeck-us.net, jdelvare@suse.com,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        jonnyc@amazon.com, linux-kernel@vger.kernel.org,
        andriy.shevchenko@intel.com
Subject: Re: [PATCH v5 16/21] dt-bindings: hwmon: (mr75203) add
 "moortec,ts-series" property
Message-ID: <20220913115712.GA3386400-robh@kernel.org>
References: <20220908152449.35457-1-farbere@amazon.com>
 <20220908152449.35457-17-farbere@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220908152449.35457-17-farbere@amazon.com>
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

On Thu, 08 Sep 2022 15:24:44 +0000, Eliav Farber wrote:
> Add optional "moortec,ts-series" property to define the temperature
> equation and coefficients that shall be used to convert the digital
> output to value in milli-Celsius.
> Supported series: 5 (default) and 6.
> 
> Series 5:
>   T = G + H * (n / cal5 - 0.5) + J * F
> Where: G = 60, H = 200, cal5 = 4094, J = -0.1, F = frequency clock in MHz
> 
> Series 6:
>    T = G + H * (n / cal5 - 0.5)
> Where: G = 57.4, H = 249.4, cal5 = 4096
> 
> Signed-off-by: Eliav Farber <farbere@amazon.com>
> ---
> V4 -> V3:
> - Remove constraints in free-form text descriptions.
> 
> V3 -> V2:
> - New patch to introduce "moortec,ts-series" property.
> 
>  .../devicetree/bindings/hwmon/moortec,mr75203.yaml       | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42C3E6E9A26
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 19:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbjDTRA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 13:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjDTRAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 13:00:19 -0400
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89E0A4EE8;
        Thu, 20 Apr 2023 09:59:58 -0700 (PDT)
Received: by mail-oo1-f48.google.com with SMTP id l1-20020a4acf01000000b005472eb23b30so852303oos.1;
        Thu, 20 Apr 2023 09:59:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682009978; x=1684601978;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AQjtV9NB28V3LmK6dJUu6sjUOfdt/1VooQe/0CCGd8U=;
        b=fIfBZ4zt65FWRdgqteWfeGfQiNWwJJtyPwZykVb0a/ZW3fsaEVEJbFUNSjDyMjzCCg
         GH65i48e3HQHsrKrAjutyaUKW/JpA2N6xyOVnKgmkv+2geEHniuyFzZ06rh1wy/cG+Xd
         G0eT4sumn7xd7CVOYsmgIZqJwPSn1kcfWTfmEt+c3TLRcUmalnpOA6WgxwJrvT4r2iNy
         lQQpEmR5tjhq6OB0F873vaoxInLmz1CSpWk12GdAm0kAJtAddCxCPHbvv+Nb7kxOm7ah
         9HnLFqS8Ek8VBtdsm4YyMxBh3qpXhj4ZZ92F1sbk7TY64piG5iIqdCV4wgAF5vUdofeo
         FrFA==
X-Gm-Message-State: AAQBX9fBgLXz+BhUeADumXotpv2i/FA8Rr752P9DQPcqhV75GsucfP+X
        vrgNzVXtkFEmouGgIiS63g==
X-Google-Smtp-Source: AKy350ajRi0Dr2GcMCYAxgauZp8jskHLMpNAKhE4wWw3toeDBnVAUGu2G0hk44QXhGaq3YcGVMyPwA==
X-Received: by 2002:a4a:ad04:0:b0:544:dc2c:9f78 with SMTP id r4-20020a4aad04000000b00544dc2c9f78mr1108037oon.6.1682009978108;
        Thu, 20 Apr 2023 09:59:38 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id e131-20020acab589000000b00383d9700294sm746146oif.40.2023.04.20.09.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 09:59:37 -0700 (PDT)
Received: (nullmailer pid 3015138 invoked by uid 1000);
        Thu, 20 Apr 2023 16:59:36 -0000
Date:   Thu, 20 Apr 2023 11:59:36 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH] dt-bindings: thermal: qcom-tsens: correct unit address
Message-ID: <168200997627.3015083.10232502258112260692.robh@kernel.org>
References: <20230420072429.36255-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230420072429.36255-1-krzysztof.kozlowski@linaro.org>
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


On Thu, 20 Apr 2023 09:24:29 +0200, Krzysztof Kozlowski wrote:
> Match unit-address to first reg entry.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>


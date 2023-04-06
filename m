Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5F506D9DDA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 18:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbjDFQsd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 12:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbjDFQsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 12:48:30 -0400
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22C3A559F;
        Thu,  6 Apr 2023 09:48:12 -0700 (PDT)
Received: by mail-oi1-f177.google.com with SMTP id q27so28762467oiw.0;
        Thu, 06 Apr 2023 09:48:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680799688; x=1683391688;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lr+NBLFTleCn7oiTmn9jRVr9291SRIsnMI4MXV5mmfE=;
        b=WwzGcfB0uDLtv8LpAlccl7ogovmVW5swYMT3GVua+IOGgxYVgIP3RyTrBXuq4wH0vd
         E9rPB3Xda6CDMFoC7ek+tq1Ww/ZbQjIjUwsEcwXD6E3eJyzwbuEjVXtvtIxfbOBRNk6d
         eXlgtv4Kc1HPTE199Zr7FsDrd/jmsUe1WTLdmT/B10Y93go73ebBjXXbEV6byk6XRKFq
         cUqvaWl1nvpAv0H+TuvKsOud723gsRvfLi6nvx28M/iYeYjoMM1i1S7zZTE9cQgAmZl4
         bJDpozj9mPe106I89XKNHxf+S9iyDhCjgziWdZCf+28QLR1xgysZkwe5Ph5ss1FiHn0Q
         nCjQ==
X-Gm-Message-State: AAQBX9eQ1YtipUMyg5FAzQuIOntd4M0YVIRpTJQM/6G2LnC1OTixN4rN
        6IKZ/dP2WEoel/t2MxPwXg==
X-Google-Smtp-Source: AKy350YuXAJQFQWkBQ2z3cq6W/FU5uHXPURwTy5ZCMy0TrwFlFHLi1z2KiCu8FQPVApTJUuY0oQqfg==
X-Received: by 2002:a05:6808:1a1b:b0:38b:5d3:f79a with SMTP id bk27-20020a0568081a1b00b0038b05d3f79amr6533620oib.19.1680799687898;
        Thu, 06 Apr 2023 09:48:07 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id a43-20020a4a98ae000000b00541269a2fcesm751807ooj.25.2023.04.06.09.48.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 09:48:07 -0700 (PDT)
Received: (nullmailer pid 3283436 invoked by uid 1000);
        Thu, 06 Apr 2023 16:48:06 -0000
Date:   Thu, 6 Apr 2023 11:48:06 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Swapnil Jakhade <sjakhade@cadence.com>,
        Yuti Amonkar <yamonkar@cadence.com>, Abraham I <kishon@ti.com>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] dt-bindings: phy: ti,phy-am654-serdes: drop
 assigned-clocks type
Message-ID: <20230406164806.GA3282995-robh@kernel.org>
References: <20230404190115.546973-1-krzysztof.kozlowski@linaro.org>
 <20230404190115.546973-3-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230404190115.546973-3-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=0.7 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 04, 2023 at 09:01:13PM +0200, Krzysztof Kozlowski wrote:
> The meta schema from DT schema already defines assigned-clocks, so there
> is no need for device schema to mention it at all.  The specific
> parenting of the first input and output clock is apparently important,
> thus keep them as required, but without defining type.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/phy/ti,phy-am654-serdes.yaml         | 5 -----
>  1 file changed, 5 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>

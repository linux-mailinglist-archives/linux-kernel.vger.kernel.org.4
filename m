Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1725F688AA6
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 00:18:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233070AbjBBXSi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 18:18:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232583AbjBBXSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 18:18:35 -0500
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 812DE126E5;
        Thu,  2 Feb 2023 15:18:34 -0800 (PST)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-15ff0a1f735so4664094fac.5;
        Thu, 02 Feb 2023 15:18:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=43Zx/TXvhDMaAc5zx1VXMsMBlYbMLZIPlizKehYEi8M=;
        b=JHhcIYilPP504AOdY+/3nloAPehrxx1WqxyftoTYJqneD6/tn869l1yLMhfLOSvieA
         A6wtAQLNewCIRJpRV3cWQaclNoS/F/RiA1oEVqJBaXY+OmwHCNmT61Dhv7LqzcAqaLwo
         MdwE8fnTfk9gUBlNp8gcVKiWdhFS+dZSowmhNqzYnIQmIWcMM6FAjbRBv8Ee261u/LnO
         m8TyVXxpK43uL9unaH06K7OZhXlk5bwEU/QIBMab4CC+/saR5LXgXLZslUjHYXimxeJN
         24yi28jVaSU98mJC7wjrZuPhX74MtE1G7kjbfEjScEJSnoCSPpTTwmWHXNoqadHxTJND
         Wmkg==
X-Gm-Message-State: AO0yUKV6xpyhtaLTXjQ/+n4qWk2I+7Dh2+hwVFXedl80Wj2sIb0cSL14
        Z2zbpNYPG18DcW9tQRXEqQ==
X-Google-Smtp-Source: AK7set8mqduKSve5eUbYJLI6XzJzquyQUbxvo8aniumgEc7aq0q/oJssG6sfbcHEikJBI9mH4paZlA==
X-Received: by 2002:a05:6870:8a2c:b0:15f:c483:214d with SMTP id p44-20020a0568708a2c00b0015fc483214dmr3932667oaq.9.1675379913776;
        Thu, 02 Feb 2023 15:18:33 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id k21-20020a056870d39500b0014ff15936casm300283oag.40.2023.02.02.15.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 15:18:33 -0800 (PST)
Received: (nullmailer pid 2888273 invoked by uid 1000);
        Thu, 02 Feb 2023 23:18:32 -0000
Date:   Thu, 2 Feb 2023 17:18:32 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@gmail.com>,
        Robert Foss <rfoss@kernel.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: Re: [PATCH v2] dt-bindings: display: bridge: sil,sii8620: convert to
 dtschema
Message-ID: <167537990980.2888174.4316773506332943399.robh@kernel.org>
References: <20230129160537.32275-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230129160537.32275-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 29 Jan 2023 17:05:37 +0100, Krzysztof Kozlowski wrote:
> Convert the Silicon Image SiI8620 HDMI/MHL bridge bindings to DT schema.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Changes since v1:
> 1. Require also port@1 (Laurent)
> ---
>  .../bindings/display/bridge/sil,sii8620.yaml  | 108 ++++++++++++++++++
>  .../bindings/display/bridge/sil-sii8620.txt   |  33 ------
>  2 files changed, 108 insertions(+), 33 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/sil,sii8620.yaml
>  delete mode 100644 Documentation/devicetree/bindings/display/bridge/sil-sii8620.txt
> 

Applied, thanks!


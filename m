Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ECB16E9935
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 18:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232023AbjDTQJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 12:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231559AbjDTQJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 12:09:08 -0400
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FAC63A8D;
        Thu, 20 Apr 2023 09:09:07 -0700 (PDT)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-187af4a5437so759346fac.0;
        Thu, 20 Apr 2023 09:09:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682006946; x=1684598946;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IkJ757D7Ayc3x5jwYsxuxnxkjlFuulWAJkfbWRzIMQM=;
        b=L+Q/Z9F5Lr72WUhZmeCPJxNdm7GRBO/cumSnJwXXos3DO+1tPW8yh/cyarmkxblbW4
         YQNBb/wLauxOPzR2zdxt8/X4bJN1/Q9CMtKffc2oxLpo5LjUqicZ0RPLHrfoK8N76MFc
         xTe8URzoX/HzzhRM2MOW2+sFNULa3C8YwSq0SJYPSPQBwWK0SF6NR20Y3yJ5wSsiITnN
         zysMzQDsUjHcxt2Ox1IEI5/uVMy5EBURrGzoK/CT8bBvRnJ8nSuno4JlhjZSpECWJ4rO
         ddLyMd6nChVKV9gHH73jcn94RwYdBA8OPEv+fxhUWis36bkwm8iEF34Drzor3+Kl8n+i
         1MQQ==
X-Gm-Message-State: AAQBX9c+YT2vI8JdYMNywKfYyu9IvYBnvKY+rg4oLJEKwWSAAZO7Rif2
        BYrxJqqCDB9VlxNKChY3mQ==
X-Google-Smtp-Source: AKy350aeJxflQzYgaqEyeXyK2zF5CseRY9f1WBxfwgvnpr5+Az0JWEfKsadnsXHRkEEvplIekIvQ9A==
X-Received: by 2002:a05:6870:ec91:b0:180:5c1f:5446 with SMTP id eo17-20020a056870ec9100b001805c1f5446mr1426888oab.50.1682006946545;
        Thu, 20 Apr 2023 09:09:06 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id m21-20020a056870a41500b0018459cc0f52sm870775oal.24.2023.04.20.09.09.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 09:09:06 -0700 (PDT)
Received: (nullmailer pid 2960072 invoked by uid 1000);
        Thu, 20 Apr 2023 16:09:05 -0000
Date:   Thu, 20 Apr 2023 11:09:05 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: Re: [PATCH] dt-bindings: display: panel: add common definition of
 ports
Message-ID: <20230420160905.GA2952736-robh@kernel.org>
References: <20230416153929.356330-1-krzysztof.kozlowski@linaro.org>
 <20230418222613.GA2408838-robh@kernel.org>
 <77d94fe0-75d2-8f64-19c6-fc19438ba71a@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77d94fe0-75d2-8f64-19c6-fc19438ba71a@linaro.org>
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

On Wed, Apr 19, 2023 at 10:56:55AM +0200, Krzysztof Kozlowski wrote:
> On 19/04/2023 00:26, Rob Herring wrote:
> > On Sun, Apr 16, 2023 at 05:39:29PM +0200, Krzysztof Kozlowski wrote:
> >> Few panel bindings for dual-link connections just type "ports: true",
> >> which does not enforce any type.  Add common definition of ports, so the
> >> type will be fixed.
> >>
> >> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >>
> >> ---
> >>
> >> Cc: Konrad Dybcio <konrad.dybcio@linaro.org>
> >> ---
> >>  .../bindings/display/panel/panel-common.yaml     | 16 ++++++++++++++++
> >>  1 file changed, 16 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/display/panel/panel-common.yaml b/Documentation/devicetree/bindings/display/panel/panel-common.yaml
> >> index 5b38dc89cb21..ad62d34e6fa3 100644
> >> --- a/Documentation/devicetree/bindings/display/panel/panel-common.yaml
> >> +++ b/Documentation/devicetree/bindings/display/panel/panel-common.yaml
> >> @@ -70,6 +70,16 @@ properties:
> >>    port:
> >>      $ref: /schemas/graph.yaml#/properties/port
> >>  
> >> +  # For dual-link connections
> >> +  ports:
> >> +    $ref: /schemas/graph.yaml#/properties/ports
> >> +    patternProperties:
> >> +      "^port@[0-9a-f]+$":
> >> +        $ref: /schemas/graph.yaml#/$defs/port-base
> > 
> > This allows any undocumented property.
> 
> Yes, which I hope the device schema (using this panel-common) will
> narrow with additionalProperties: false.
> 
> I can make it explicit: additionalProperties: true.
> 
> Otherwise, how do I allow custom properties like:
> Documentation/devicetree/bindings/display/panel/advantech,idk-2121wr.yaml
> 
> > 
> >> +
> >> +    required:
> >> +      - port@0
> >> +
> > 
> > I don't think this should be added here because users must define what 
> > each port is. With it here, we're going to validate the nodes twice as 
> > well. Same can be said for 'port' though. It can't be extended though.
> 
> So you propose to drop entire "ports" here and expect every panel schema
> to define it instead?

Only those with more than 1 port or extra port/endpoint properties. If 
neither of those are true, then they can use just 'port'. Otherwise, 
all those panel bindings already have to define the port nodes already.

Rob

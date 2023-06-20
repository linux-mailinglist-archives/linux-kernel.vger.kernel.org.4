Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF547370A4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 17:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233099AbjFTPh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 11:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232030AbjFTPhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 11:37:53 -0400
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38FAFE65;
        Tue, 20 Jun 2023 08:37:48 -0700 (PDT)
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-340be77ff6fso24070315ab.3;
        Tue, 20 Jun 2023 08:37:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687275467; x=1689867467;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0sJbkvA8psBZvCbiZz79+0aLmkyZYgwDhRQ2jJ0L/Xc=;
        b=lnwDZyYysglr2h6cqSfEq5bjL0ZWjTl1Aipe3FGrexZDt6L5C9tVTLNV8rvURtC8ie
         3UCK2Q7pGs8DLUuFX7kG2FUPQWKmbrgSgfM1F9ZHE71eBTXk7qF0S5SHn6sqVgZZr8M1
         opnXF3scTgvTZvklM/Uz7o38jScY/1LjRyh1FRndegh1INiEoVerlyWu39JY/HT7s3hD
         vtHo2sh+g9malZgLg6wNL44lfvO3tnLebFxnN34gP3h3lfhjSJFS0IPIts2gvBk5xPwg
         SEGFf8p5TSbhzfSempC6p+v/Rj7IsETGGxXjFGEQUJT/RKVqwXlUKz5cGeXDQimbA6ul
         O7Rw==
X-Gm-Message-State: AC+VfDxiebX1Is/tHptBm0K9+/j1AqQ5ElkQ6Av6ZULlc/n6JlNWOwDD
        oVZIsUNM2FKv7IGrUNqTJA==
X-Google-Smtp-Source: ACHHUZ5u+D4bbGxsP6bC+gdajHPXjGwM+AGf0+Hh4eLKoobenWPCJtpJM8Pm4EeQsdQZBZHPQ2GHEg==
X-Received: by 2002:a92:a30e:0:b0:33d:1735:fd79 with SMTP id a14-20020a92a30e000000b0033d1735fd79mr8830286ili.20.1687275467410;
        Tue, 20 Jun 2023 08:37:47 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id n13-20020a92d9cd000000b0033b2a123254sm656797ilq.61.2023.06.20.08.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 08:37:46 -0700 (PDT)
Received: (nullmailer pid 3641003 invoked by uid 1000);
        Tue, 20 Jun 2023 15:37:43 -0000
Date:   Tue, 20 Jun 2023 09:37:43 -0600
From:   Rob Herring <robh@kernel.org>
To:     Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     andrzej.hajda@intel.com, neil.armstrong@linaro.org,
        robert.foss@linaro.org, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@gmail.com, airlied@gmail.com,
        daniel@ffwll.ch, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        vkoul@kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        oliver.brown@nxp.com, Sandor.yu@nxp.com, linux-imx@nxp.com,
        kernel@pengutronix.de
Subject: Re: [PATCH v6 2/8] dt-bindings: display: bridge: Add Cadence
 MHDP8501 HDMI and DP
Message-ID: <20230620153743.GA3637514-robh@kernel.org>
References: <cover.1686729444.git.Sandor.yu@nxp.com>
 <8687f2221299b120e12f29fdccf264e120227bd7.1686729444.git.Sandor.yu@nxp.com>
 <3439354.PYKUYFuaPT@steina-w>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3439354.PYKUYFuaPT@steina-w>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2023 at 11:31:43AM +0200, Alexander Stein wrote:
> Hi Sandor,
> 
> Am Donnerstag, 15. Juni 2023, 03:38:12 CEST schrieb Sandor Yu:
> > Add bindings for Cadence MHDP8501 DisplayPort and HDMI driver.
> > 
> > Signed-off-by: Sandor Yu <Sandor.yu@nxp.com>
> > ---
> >  .../display/bridge/cdns,mhdp8501.yaml         | 105 ++++++++++++++++++
> >  1 file changed, 105 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/display/bridge/cdns,mhdp8501.yaml
> > 
> > diff --git
> > a/Documentation/devicetree/bindings/display/bridge/cdns,mhdp8501.yaml
> > b/Documentation/devicetree/bindings/display/bridge/cdns,mhdp8501.yaml new
> > file mode 100644
> > index 000000000000..a54756815e6f
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/display/bridge/cdns,mhdp8501.yaml
> > @@ -0,0 +1,105 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/display/bridge/cdns,mhdp8501.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Cadence MHDP8501 Displayport bridge
> > +
> > +maintainers:
> > +  - Sandor Yu <Sandor.yu@nxp.com>
> > +
> > +description:
> > +  The Cadence MHDP8501 Displayport/HDMI TX interface.
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - cdns,mhdp8501-dp
> > +      - cdns,mhdp8501-hdmi
> > +      - fsl,imx8mq-mhdp8501-dp
> > +      - fsl,imx8mq-mhdp8501-hdmi
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    maxItems: 1
> > +    description: MHDP8501 DP/HDMI APB clock.
> > +
> > +  phys:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    items:
> > +      - description: Hotplug cable plugin.
> > +      - description: Hotplug cable plugout.
> > +
> > +  interrupt-names:
> > +    items:
> > +      - const: plug_in
> > +      - const: plug_out
> > +
> > +  ports:
> > +    $ref: /schemas/graph.yaml#/properties/ports
> > +
> > +    properties:
> > +      port@0:
> > +        $ref: /schemas/graph.yaml#/properties/port
> > +        description:
> > +          Input port from display controller output.
> > +      port@1:
> > +        $ref: /schemas/graph.yaml#/properties/port
> > +        description:
> > +          Output port to DP/HDMI connector.
> > +
> > +    required:
> > +      - port@0
> > +      - port@1
> 
> You mark these ports as required, but apparently the drivers do not use them, 
> AFAICT. E.g. missing port@1 is not resulting in an error, at lease for HDMI 
> one.

A connector node should be required whether a particular OS requires it 
or not. The bindings without predate defining a connector node.

Rob

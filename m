Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE657307B5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 21:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbjFNTAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 15:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231823AbjFNTAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 15:00:35 -0400
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 697D71A2;
        Wed, 14 Jun 2023 12:00:34 -0700 (PDT)
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-77aec3ce39aso195554939f.0;
        Wed, 14 Jun 2023 12:00:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686769233; x=1689361233;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fD8D25wPikGFFd99Ol9Rb+Ax0oXPcCmfRQUqnue5Bko=;
        b=Xq+Cd/zTrE8zAbeHUTFuv5niMIBTzyghjMqGyiUFDZ7w5YZWnIGvbO2+K59GTpQEGY
         u5zo96Wq1WpNXX+lXWh1YY0Pdvp3eE4mzeHj6xwACtQCF3NOSyHKACFAbhgzUnfu7d2a
         y4wAPcvOtiE0mkpfA6LZkuZm7opa2PofPUOY1pfNUkszQckYqCN0/ndUtnvL7V025bKz
         dkY2ua8Rd5dskWtHftx78lLXqTMk0QpztTM6F8TZmzM9OZNWxXIadqFpvHzBdMJvT72x
         3+Ilxj4b8/RIP+ZWMIyI3Q0lyQ0YOA6iTRYK/fBvcI4aNEs5ortJldEx36VcxgObYRS5
         8Ryg==
X-Gm-Message-State: AC+VfDycCqz4yy3JcS6fw6Q73My9mcCdw5AMdo6BfVNZqbI/1vWbwYDv
        J3snjbFXozFDP7y1CkUZvw==
X-Google-Smtp-Source: ACHHUZ7dbwBc/2HjqzWfNYoD7dXSx0RVKX9Vkrhyz2da6vQ90zJUsp0Wzy6CF0asX1oG1VJ65XmHeQ==
X-Received: by 2002:a6b:f915:0:b0:776:fc02:184e with SMTP id j21-20020a6bf915000000b00776fc02184emr13520209iog.14.1686769233561;
        Wed, 14 Jun 2023 12:00:33 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id w12-20020a02968c000000b0041d7ad74b36sm5191797jai.17.2023.06.14.12.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 12:00:32 -0700 (PDT)
Received: (nullmailer pid 2553777 invoked by uid 1000);
        Wed, 14 Jun 2023 19:00:30 -0000
Date:   Wed, 14 Jun 2023 13:00:30 -0600
From:   Rob Herring <robh@kernel.org>
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     Nikita Shubin <nikita.shubin@maquefel.me>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Peters <mpeters@embeddedts.com>,
        Kris Bahnsen <kris@embeddedts.com>, linux-ide@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 25/43] dt-bindings: ata: Add Cirrus EP93xx
Message-ID: <20230614190030.GA2547354-robh@kernel.org>
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
 <20230601054549.10843-7-nikita.shubin@maquefel.me>
 <fe8bfbfc-0ce5-d4ea-a2a8-8608fe4e2f97@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe8bfbfc-0ce5-d4ea-a2a8-8608fe4e2f97@kernel.org>
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

On Fri, Jun 02, 2023 at 08:57:37AM +0900, Damien Le Moal wrote:
> On 6/1/23 14:45, Nikita Shubin wrote:
> > Add YAML bindings for ep93xx SoC PATA.
> > 
> > Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> > ---
> > 
> > Notes:
> >     v0 -> v1:
> >     
> >     - renamed file to ep9312-pata
> 
> Looks OK to me but given that this is both for the cirrus,ep9315-pata and
> cirrus,ep9312-pata, wouldn't it be better to name the file
> cirrus,ep931x-pata.yaml ?

cirrus,ep9312-pata makes sense given that is the common fallback.

Wildcards are okay in filenames (only) when there's not a common 
fallback.

> >     - changed email to dlemoal@kernel.org
> >     - dropped label
> >     - fixed ident
> > 
> >  .../bindings/ata/cirrus,ep9312-pata.yaml      | 44 +++++++++++++++++++
> >  1 file changed, 44 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/ata/cirrus,ep9312-pata.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/ata/cirrus,ep9312-pata.yaml b/Documentation/devicetree/bindings/ata/cirrus,ep9312-pata.yaml
> > new file mode 100644
> > index 000000000000..3489be55a6fe
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/ata/cirrus,ep9312-pata.yaml
> > @@ -0,0 +1,44 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/ata/cirrus,ep9312-pata.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Cirrus Logic EP9312 PATA controller
> > +
> > +maintainers:
> > +  - Damien Le Moal <dlemoal@kernel.org>
> > +
> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - const: cirrus,ep9312-pata
> 
> I am not a DT specialist, but isn't this line superfluous since it is listed in
> the items ?

No, this entry is for ep9312. The next entry is for ep9315 which is 
compatible with ep9312 version. The cirrus,ep9315-pata is there in case 
a distinction (e.g. quirk/errata) needs to be made by the driver 
without having to change the DT.

Rob

> 
> > +      - items:
> > +          - const: cirrus,ep9315-pata
> > +          - const: cirrus,ep9312-pata

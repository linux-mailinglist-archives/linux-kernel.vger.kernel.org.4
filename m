Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13E5A73C364
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 23:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231817AbjFWV5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 17:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231582AbjFWV5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 17:57:37 -0400
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC364270A;
        Fri, 23 Jun 2023 14:57:34 -0700 (PDT)
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3422b25556dso4230035ab.2;
        Fri, 23 Jun 2023 14:57:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687557454; x=1690149454;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QyNhFBahKbwr8TDqlpR3tcWu8WPh2FT/RYNpCkwlnps=;
        b=U+aAxV1jr2BoisUCwJl6elUXRs+Q3hocm/5SZ753kpWooaw/zIOz/vRN7tWFe26Rg/
         551fffL9fkZL1smGzQ4DjiKU/tLtr0DYTA4IcG411liVAx3RXA7kc/Z66gg6aEZw/C4+
         SRLcIZbN5xix55/XEDk1zv4jH+2Kcyv3jOh6vUU/57S6d0xS+RuJQ+aROMhFMP6frZP1
         nQKBh/4ufuVfhovPOEpCrEEkxA0Om6xQkOhiz2DTBnOM/lmPJGr6mkmquiPrzsgRorCV
         iCQlXMviCahBlxyiue8bWBOIicqr1MXfZYe+Zzw8wQdV0NZm7uilYD1wHgHh+zhTiGiH
         bOLg==
X-Gm-Message-State: AC+VfDzOpIrj5EWnsqir0AULl3Pup+TU2mQLwLpnaJ50LWGKkJDgwF08
        2pjBuKZTFC8ktPKlGazJOQ==
X-Google-Smtp-Source: ACHHUZ6YXHwqLhAFvEqMHmc5WV/cfzUSPCoAgRtiNJbkDNg/TRnU+94fzqaFo3znX6GFrUjOIu3odg==
X-Received: by 2002:a05:6e02:68e:b0:341:c917:cbc2 with SMTP id o14-20020a056e02068e00b00341c917cbc2mr17490550ils.20.1687557454067;
        Fri, 23 Jun 2023 14:57:34 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id a11-20020a92ce4b000000b0034347d4dc74sm97963ilr.35.2023.06.23.14.57.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 14:57:33 -0700 (PDT)
Received: (nullmailer pid 1267128 invoked by uid 1000);
        Fri, 23 Jun 2023 21:57:31 -0000
Date:   Fri, 23 Jun 2023 15:57:31 -0600
From:   Rob Herring <robh@kernel.org>
To:     Conor Dooley <conor@kernel.org>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: ad74413r: add binding for digital
 input threshold
Message-ID: <20230623215731.GB1216324-robh@kernel.org>
References: <20230623113327.1062170-1-linux@rasmusvillemoes.dk>
 <20230623113327.1062170-2-linux@rasmusvillemoes.dk>
 <20230623-casket-outer-2c9d2a0c4795@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230623-casket-outer-2c9d2a0c4795@spud>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2023 at 05:44:50PM +0100, Conor Dooley wrote:
> On Fri, Jun 23, 2023 at 01:33:25PM +0200, Rasmus Villemoes wrote:
> > Allow specifying the threshold for which the channels configured as
> > digital input change state.
> > 
> > Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> > ---
> > 
> > Running dt_binding_check on this with a too small or large value in
> > the example does give me an error, but the multipleOf does not seem to
> > be enforced; the value 1234567 is not flagged. I don't know if that's
> > expected (maybe I have too old versions of something).
> 
> That's one for Rob. I checked a few others and behaviour was the same
> there.
> 
> >  .../devicetree/bindings/iio/addac/adi,ad74413r.yaml    | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/addac/adi,ad74413r.yaml b/Documentation/devicetree/bindings/iio/addac/adi,ad74413r.yaml
> > index 590ea7936ad7..1f90ce3c7932 100644
> > --- a/Documentation/devicetree/bindings/iio/addac/adi,ad74413r.yaml
> > +++ b/Documentation/devicetree/bindings/iio/addac/adi,ad74413r.yaml
> > @@ -51,6 +51,14 @@ properties:
> >        Shunt (sense) resistor value in micro-Ohms.
> >      default: 100000000
> >  
> > +  digital-input-threshold-microvolt:
> 
> Should this not have an adi vendor prefix, similar to
> "adi,digital-input-threshold-mode-fixed"?

Yes.

Rob

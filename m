Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A8EB5E64AF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 16:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbiIVOHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 10:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiIVOG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 10:06:56 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A6E6D1EA4;
        Thu, 22 Sep 2022 07:06:54 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id p69so13040166yba.0;
        Thu, 22 Sep 2022 07:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=A7tXTulXK9EsRTBAJN67NXi5wmjR4ci7p7egh5drqNU=;
        b=n/a5lt3qbYnD+zKRFJygY/p7R0wjjtDy9etFOQHZrfKGc2xyAmnXgJPpp6bINdynIK
         SKaqJuCU2UPuh7/I+Z2bipcwfmsi4GJw6dEYzS/N97JNgr8WD+YmOc5pB2fMZEpjbItj
         iW2z4YUHTkSU5PBxBmtgF9R2bJqg6eZb1pKKSPeQFpxDWbAXWvft+q4Tj8y2jY5K/3eu
         dHzr3S17CVHQbR3xx9kqPBEtX6KqlK7C1tj5xbxPp7AU5kCN6KaQEaob6VOyRYNeV03R
         gUOAicJtFB/sTcDB9hLFmR3hxF0lbdsCyKAAfC3942/sVAtde1nAmIOk4MkOWrNxfeTh
         naRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=A7tXTulXK9EsRTBAJN67NXi5wmjR4ci7p7egh5drqNU=;
        b=RQXtopCqOTfArmTOsjuP8MAzOBwcK0aCBlXdxQqk8sZ1lifO6+XMtvl2+rd2rdr4hY
         vn7THGNq988pgclo7YWDvezWkUKNZ4TOGHq8RQnF9FbFXjmHFPxiB0WRrAvcOB+ftoNu
         nJMOYLUEA7Kv8p2lNznC/pJv1JkHhWrlD/G7x5AAcKinnKL/+it2jiJv/X3c5owiJGX9
         tRUQdopexM6UrYT56HaEczTa5FPwI8dqSt5QSdSuIrZ2MetIYvYKYfyah+5IlJa+RqUg
         gQCgQurPraKDm+JIVlXCc7oxGm+lWLJ83/7afw7rkE9SUm+c09jw8rKRjZMneobeILW5
         7M2g==
X-Gm-Message-State: ACrzQf1pV0YeoIg6LhDbhewwxPz0oLHIbI7kPyZGpKBvYgMKvHPLX2m8
        QNPkwc74NC3BY2cI+WzRNx/wUOvqd8WkFX/75HI=
X-Google-Smtp-Source: AMsMyM4qzRuMPnqcpxI4D5DhaF+MBCS/2BFSwaJHP4h5xHzbMoiO92ky0eM6Mu/XzbA7eB6ee7Y81yzpM+uNz5URmRg=
X-Received: by 2002:a25:f504:0:b0:683:2272:6c42 with SMTP id
 a4-20020a25f504000000b0068322726c42mr4082250ybe.558.1663855613132; Thu, 22
 Sep 2022 07:06:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220921021300.4111283-1-robertcnelson@gmail.com> <2629221f-5ec9-4e14-69cb-7ae021d5a02d@ti.com>
In-Reply-To: <2629221f-5ec9-4e14-69cb-7ae021d5a02d@ti.com>
From:   Robert Nelson <robertcnelson@gmail.com>
Date:   Thu, 22 Sep 2022 09:06:26 -0500
Message-ID: <CAOCHtYh8HDoR9bZKPdJ0pUQRUzSNChQ+6wXRVUABRXLT_kNeCw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: arm: ti: Add bindings for BeagleBone AI-64
To:     Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Nishanth Menon <nm@ti.com>,
        Jason Kridner <jkridner@beagleboard.org>,
        Drew Fustini <drew@beagleboard.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > diff --git a/Documentation/devicetree/bindings/arm/ti/k3.yaml b/Documentation/devicetree/bindings/arm/ti/k3.yaml
> > index 28b8232e1c5b..09e6845ff243 100644
> > --- a/Documentation/devicetree/bindings/arm/ti/k3.yaml
> > +++ b/Documentation/devicetree/bindings/arm/ti/k3.yaml
> > @@ -61,6 +61,7 @@ properties:
> >            - const: ti,j721e
> >            - items:
> >                - enum:
> > +                  - beagle,j721e-beagleboneai64
> >                    - ti,j721e-evm
> >                    - ti,j721e-sk
> >                - const: ti,j721e
>
> You seem to have forgotten to include Ack from Rob on v2:
>
> https://lore.kernel.org/linux-arm-kernel/20220830180058.GA1764859-robh@kernel.org/

Ah darn, I completely missed that!

-- 
Robert Nelson
https://rcn-ee.com/

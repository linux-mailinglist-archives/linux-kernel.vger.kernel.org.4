Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA51A6CFFBD
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 11:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbjC3JXM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 05:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbjC3JXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 05:23:04 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBFD36A56
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 02:23:03 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id x20so18892411ljq.9
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 02:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680168182;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mdyzvn5/XTpDm+iH3j9fZyX83N397jAkWDTmZkSoPvo=;
        b=WoWkh+0NcZOYEG2uGRWildnzvfDg/iPfPD5Hv+1KyUMBUDHC1/8R059MW/EN5GYu0v
         WLT+8dtbSb96XJSkhicI1R8B1ZQMjzJeo92xPZAfhtEP3aSknL8PX21DpLCrpyLpg+ar
         1VbZfS20nDOG+71/1KU2ccVw3LRdRRnwJwnG0HP80Cbv2iC1qrgSyoTkZ+We8xESvR92
         vN8UOoBK9lsgBRA4urcZsyQI2RZbF/6vFrzdi9K1OJyYZo9aFhsG7SoLYhdozgI6rnKC
         x+WU+uaCO85zk2UxhqTiw2QEMEpsDHL3mB+ao9/d+fOYfIUTwZQW0z89cmiy0et8dTJY
         mN4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680168182;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mdyzvn5/XTpDm+iH3j9fZyX83N397jAkWDTmZkSoPvo=;
        b=2ogQ3/l7EvMuG1mqWFHmJjbJYAYjgYTyYeYr3Cw7vCqF74VNL2UbdJiM7nmvpJyeOD
         hBX1OksDIySUJuDDhynEgdTlREd2PxWcVtrvvSx/xYBIExjl7CgdW/9yd24ThK1pyBUa
         kqsVC8x1NQLvlJj6tUcALOYJMjheFiDk0v3khAEoo+xnWn8qT5t5KsdkI++FAcq33Csq
         9CtObm7QlbM48Gh/vB49E0LC7/4gVjRy5bJBO9PTdk3JGODUYmLfa/H3dRKkpmQ9qVaz
         RjT6vesV5zwb5RdJRRUtwBdokqMeWNjF181zGUf6yeOlUacZJI+1XIAwnoM9jSl7BYoS
         QSsg==
X-Gm-Message-State: AAQBX9deMVXnuQttpLAtdrci+N4MDsYwt/AbkMKjOGGfNfOmAn0LoezF
        64JyxqGHSxyYIC2JXS9mPjCXU0QVREiWxXbNS/0=
X-Google-Smtp-Source: AKy350aP51CSDtYf/zkFBcrlnc5bba8YhZ0Ii41eIaQA3hvvP/hZ3W2J7i70xVqweWwsE+ntAEKpZQ==
X-Received: by 2002:a2e:3a0f:0:b0:290:6af8:ec25 with SMTP id h15-20020a2e3a0f000000b002906af8ec25mr6333473lja.52.1680168182088;
        Thu, 30 Mar 2023 02:23:02 -0700 (PDT)
Received: from rayden (h-46-59-78-111.A175.priv.bahnhof.se. [46.59.78.111])
        by smtp.gmail.com with ESMTPSA id l18-20020a2e99d2000000b00297dad1a2b0sm5661477ljj.103.2023.03.30.02.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 02:23:01 -0700 (PDT)
Date:   Thu, 30 Mar 2023 11:23:00 +0200
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Etienne Carriere <etienne.carriere@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        op-tee@lists.trustedfirmware.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH v6 1/2] dt-bindings: optee driver interrupt can be a
 per-cpu interrupt
Message-ID: <20230330092300.GB990388@rayden>
References: <20230322132212.3646972-1-etienne.carriere@linaro.org>
 <CAFA6WYP09nmgXafdqZnpBfoe_rHTDCDy+BV8d8jjC-V9mCADSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFA6WYP09nmgXafdqZnpBfoe_rHTDCDy+BV8d8jjC-V9mCADSQ@mail.gmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2023 at 08:26:22PM +0530, Sumit Garg wrote:
> On Wed, 22 Mar 2023 at 18:52, Etienne Carriere
> <etienne.carriere@linaro.org> wrote:
> >
> > Explicit in optee firmware device tree bindings that the interrupt
> > used by optee driver for async notification can be a peripheral
> > interrupt or a per-cpu interrupt.
> >
> > Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
> > ---
> > No change since v5
> >
> 
> Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

I'm picking up this.

Thanks,
Jens

> 
> -Sumit
> 
> > No change since v4
> >
> > Changes since v3:
> > - Patch added in this v4 to address review comments.
> > ---
> >  .../devicetree/bindings/arm/firmware/linaro,optee-tz.yaml      | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml b/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml
> > index d4dc0749f9fd..5d033570b57b 100644
> > --- a/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml
> > +++ b/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml
> > @@ -28,7 +28,8 @@ properties:
> >      maxItems: 1
> >      description: |
> >        This interrupt which is used to signal an event by the secure world
> > -      software is expected to be edge-triggered.
> > +      software is expected to be either a per-cpu interrupt or an
> > +      edge-triggered peripheral interrupt.
> >
> >    method:
> >      enum: [smc, hvc]
> > --
> > 2.25.1
> >

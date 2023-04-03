Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76BFF6D453A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 15:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231736AbjDCNFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 09:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231553AbjDCNFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 09:05:11 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5134DA;
        Mon,  3 Apr 2023 06:05:09 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-17aa62d0a4aso30679478fac.4;
        Mon, 03 Apr 2023 06:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680527109;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EUy367G/hkdb7IHkLrR4RAgWXMK4YWzHQhzTa5DUWOE=;
        b=FXuIC7haw4VuYXVifk+R+3Ll+JAZe0q+XSqYssmGBjcNeig0oGsuyFBLQehyyhBG1Y
         6jKwrIQ3i+qEKM0OCdO3BswtZ3PrrKU2Soxff6bDiEnviU4bIHods/O6WddKvIiJJd80
         4zrWetZkv84iLxMMsUb+x9r0u68pVYFg6iYN5HpyOcb3fRqUh7iNGjbG1SGllmi1a7Km
         mCFBJuick0a1AAAFrdvirAyityYzO9i0gU9XUKBznTF0+M6q2skIn/YWgY76ayDrio8h
         OO6TGDY0NP6J9A0Y7N8Gx+AtiAp3gRHwlDDJVYxwXmarBzIQqXFcG1OcM8R90AT5f/zD
         sdcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680527109;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EUy367G/hkdb7IHkLrR4RAgWXMK4YWzHQhzTa5DUWOE=;
        b=jTBTd7GxYPIKy6o3HRDmgURLNKGFoDXZ0aiTYWwJnQ+Q9IS4B21yZKhjvUEfqlYsfd
         /BZldLGAlwLvGpLTzls8zB7mHWpFQebKa9oSzLoCL+8SQLr9PHtn/U95wjgMXKYZb9QA
         hOd1kJ8+R9UkzEagUASBrAUybRZhBpdh83lvdrzeS0q+KpLXtUcESZ+KpwMHSxRCMd9/
         snpK5fJp2gxde8ir5KmY6Ksnc8FFVPqZvCwj1w7bK9dvR/svNbZk1osXRLcEs5E7CdTq
         0oFLkDQcILRPr5lb1Ijk3WOuRqYvY2YH6x7EmBnTbHRtP3eFRJDLZo2fwvUzWOdpvOT3
         Id8g==
X-Gm-Message-State: AAQBX9dKfN1WNUjyps1TF/oA+JcFVStuQ085F+InAVI5z7rK34XzLRzM
        aEe3HuAmO4zuxSkGor+Pk4GOHR75uWSvFTE/1fa5AhuvTNY=
X-Google-Smtp-Source: AKy350aZi3rzyRrIWyxfhkJHE+qA6fgstApfn8FC9Y0cGcJLK7C5kdd2T45lQPkiU+8B2dxj/a8JGFYC31yVrllBHV4=
X-Received: by 2002:a05:6870:e306:b0:17e:e396:ccd7 with SMTP id
 z6-20020a056870e30600b0017ee396ccd7mr11090106oad.6.1680527109059; Mon, 03 Apr
 2023 06:05:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230120003051.9100-1-bb@ti.com> <20230120003051.9100-3-bb@ti.com>
 <0172f045-4bd0-ec5e-35a0-efc80da5ace0@ti.com> <20230131015728.347i3cttyxtitcwi@bryanbrattlof.com>
In-Reply-To: <20230131015728.347i3cttyxtitcwi@bryanbrattlof.com>
From:   Christian Gmeiner <christian.gmeiner@gmail.com>
Date:   Mon, 3 Apr 2023 15:04:57 +0200
Message-ID: <CAH9NwWeDSFrF61UC=NENTvQpUU_erGtKrhUzBVQWvA3KjbH_Fg@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] arm64: dts: ti: k3-am62-wakeup: add VTM node
To:     Bryan Brattlof <bb@ti.com>
Cc:     "Raghavendra, Vignesh" <vigneshr@ti.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        ARM Linux Mailing List <linux-arm-kernel@lists.infradead.org>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Keerthy <j-keerthy@ti.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi Vignesh!
>
> On January 28, 2023 thus sayeth Raghavendra, Vignesh:
> > Hi Bryan,
> >
> > On 1/20/2023 6:00 AM, Bryan Brattlof wrote:
> > > @@ -94,10 +95,13 @@ cbass_wakeup: bus@2b000000 {
> > >                     compatible = "simple-bus";
> > >                     #address-cells = <2>;
> > >                     #size-cells = <2>;
> > > -                   ranges = <0x00 0x2b000000 0x00 0x2b000000 0x00 0x00300400>, /* Peripheral Window */
> > > +                   ranges = <0x00 0x00b00000 0x00 0x00b00000 0x00 0x00002400>, /* VTM */
> >
> > You would need to update unit address in node name as well:
> >                       cbass_wakeup: bus@b00000 {
>
> Ah! I missed that. I'll get this fixed

Any update on this? Would be great if these changes could make it into
the next merge window.

-- 
greets
--
Christian Gmeiner, MSc

https://christian-gmeiner.info/privacypolicy

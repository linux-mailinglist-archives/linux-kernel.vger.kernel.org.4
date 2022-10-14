Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEA5B5FF588
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 23:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbiJNVkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 17:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbiJNVkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 17:40:31 -0400
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB9B3726AF;
        Fri, 14 Oct 2022 14:40:29 -0700 (PDT)
Received: by mail-ot1-f48.google.com with SMTP id p24-20020a9d6958000000b00661c528849eso2605990oto.9;
        Fri, 14 Oct 2022 14:40:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sb3JrLf3T9Yv0jAPi4EuzhhdXdPJSp+d1r33oSjcyO4=;
        b=lRLZ9AxG4AEfAkEj33pNyGTg/z1mi6W6RkQly602r/vbbbq0vAO2LD3QWEjpjhhKAJ
         /yX50heQPtWm8vOeo7iXNjnv58gJAN9gpuy9zNFq7VYS4iY8Hb+QocR4rRSY3+ODhVJ5
         iUOz2ex7YkfKmt5jhYJ6hkv0spjHHl+tYEkAJlzENI7N72lc+DT+BONxJALVBa7AnHjl
         cU6icjdC0pR73itQ6/r9KVveAsqKuNgq6qkKn/vuiKWYntyO8wH1QsVvEcbERjdnOX/K
         Cjoa/AZtj0vj3CWVknC9NrPjiJAP/VXLe30i5VWEPWysH6TI9YzkE0dvPBAsZIYxQY0I
         Rknw==
X-Gm-Message-State: ACrzQf00+O55LjmM/RtpTX8lJI8p/wXAspL6ckVsXf0qR3VJxTo6H1zo
        hh/oszMUIZKawE+28rRbPQ==
X-Google-Smtp-Source: AMsMyM4lvKNql9jR06JZlPelLERp1xv52bnZviFnwE99OASEPA+LBV3gCV0Cy3wCagYwVKyPcAjZyQ==
X-Received: by 2002:a05:6830:1cc8:b0:65c:8e3:cfd with SMTP id p8-20020a0568301cc800b0065c08e30cfdmr6533otg.28.1665783628871;
        Fri, 14 Oct 2022 14:40:28 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id x7-20020a9d6287000000b00661a1a48079sm1721096otk.7.2022.10.14.14.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 14:40:28 -0700 (PDT)
Received: (nullmailer pid 2945760 invoked by uid 1000);
        Fri, 14 Oct 2022 21:40:29 -0000
Date:   Fri, 14 Oct 2022 16:40:29 -0500
From:   Rob Herring <robh@kernel.org>
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Shawn Tu <shawnx.tu@intel.com>,
        Jacopo Mondi <jacopo@jmondi.org>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v2 1/5] media: dt-bindings: ov5645: Convert OV5645
 binding to a schema
Message-ID: <20221014214029.GA2937999-robh@kernel.org>
References: <20221014183459.181567-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221014183459.181567-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAL_JsqKC_BJDJLLFck_0CbQ-0rZ0oVWMAdiwwGep23nh2pP19g@mail.gmail.com>
 <CA+V-a8vMLuzJ8h5UDNXUiZRXPV1vJ9gguUMywe_+sPcU8tK+tA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+V-a8vMLuzJ8h5UDNXUiZRXPV1vJ9gguUMywe_+sPcU8tK+tA@mail.gmail.com>
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

On Fri, Oct 14, 2022 at 10:27:53PM +0100, Lad, Prabhakar wrote:
> Hi Rob,
> 
> Thank you for the review.
> 
> On Fri, Oct 14, 2022 at 10:05 PM Rob Herring <robh+dt@kernel.org> wrote:
> >
> > On Fri, Oct 14, 2022 at 1:35 PM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> > >
> > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > >
> > > Convert the simple OV5645 Device Tree binding to json-schema.
> > >
> > > The previous binding marked the below properties as required which was a
> > > driver requirement and not the device requirement so just drop them from
> > > the required list during the conversion.
> > > - clock-frequency
> > > - enable-gpios
> > > - reset-gpios
> > >
> > > Also drop the "clock-names" property as we have a single clock source for
> > > the sensor and the driver has been updated to drop the clk referencing by
> > > name.
> >
> > Driver requirements are the ABI!
> >
> > This breaks a kernel without the driver change and a DTB that has
> > dropped the properties.
> >
> I already have a patch for the driver [0] which I missed to include
> along with the series.

You completely miss the point. Read the first sentence again. Changing 
driver requirements changes the ABI.

This breaks the ABI. The driver patch does not help that.


> > Also, with 'clock-names' dropped, you've just introduced a bunch of
> > warnings on other people's platforms. Are you going to 'fix' all of
> > them?
> >
> Yes I will fix them, once the patch driver patch [0] is merged in.

Why? You are just making extra work. We have enough warnings as-is to 
fix.

Rob

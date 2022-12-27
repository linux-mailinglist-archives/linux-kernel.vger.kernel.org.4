Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D11F656E66
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 20:37:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbiL0ThX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 14:37:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbiL0ThV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 14:37:21 -0500
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD7F9D122
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 11:37:20 -0800 (PST)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-47fc4e98550so53411527b3.13
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 11:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TDuSRMT7LeuW6RQ7N+xypX5CPMcCsvqhVlnHymvmVtI=;
        b=rEZX25ycDQZ1thQanMnm+pHbQa936C7pegvTyeEJbbP0xHMpnpylJ/PxzJHrDDGqCm
         uh9TvIADFBvJpo0yFkZgHkBkdDfpmVSAU+FKksylfr1HrbmquN5Wff0v1DclOXJ3uGpM
         LZddDRee3hQpJtoqDzbXQ2IXnexVIDhN9FgN0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TDuSRMT7LeuW6RQ7N+xypX5CPMcCsvqhVlnHymvmVtI=;
        b=1YLv4+PhKs15h0+fzh2cbWPzf/ubelBSjaKV4qA93zPAOQ2FCOVWfLCX/kWrSdkELj
         TR/rbItMCTJXSd7dmsnDjpEDhNqnb8/GoKdpHi/ja0aDLTpCKsORs6Vdjz1Zf4k0SYoo
         Eyt7ISZgH6HnARM30hHXX3K/UwgGIsrooCemf133+6N5mntzkCRPCs6o+gFZGbV5Hz9y
         OTzEvhOr6phVdZQzHEnU3g1EKzogmhKkLwso/VGeVU3ebFXR0GyKQyM4wtnswNOnQ8Un
         0/tYeHwS12VKmSGEaY98OD2KvjoCXdtNrqLtfgbG2QWO4i441LVCUVkA2tPhnmcO+4v3
         sktg==
X-Gm-Message-State: AFqh2kpRuubocLgMorrCXH09oSnlmTfzqEgshsJJCzpU/JT0kqQ+H3Vk
        v5IF5biyL1zVwo/fz7lGBA6tzRcRQ2y/l11i76oCAg==
X-Google-Smtp-Source: AMrXdXtk1VEXi6sU/cPZRwXTFvEyMW0TOBsoND8twqKnIwU8PKZUmc1bpUOjkUgxf0ckeok/mCZ824hGpaMayafFoCw=
X-Received: by 2002:a0d:ff86:0:b0:47a:a05b:7d0d with SMTP id
 p128-20020a0dff86000000b0047aa05b7d0dmr859893ywf.230.1672169839892; Tue, 27
 Dec 2022 11:37:19 -0800 (PST)
MIME-Version: 1.0
References: <20221227110335.2923359-1-javierm@redhat.com> <20221227110335.2923359-2-javierm@redhat.com>
 <CAMty3ZAaHKJ21D8mE=HU3D3KOGAiZ7vfmW_Hgc-E5JO5S+tMNA@mail.gmail.com> <CABxcv=kwtk21UbOwaV4tq=BpPsrYmnTrzuhybjbknipqk5R-fA@mail.gmail.com>
In-Reply-To: <CABxcv=kwtk21UbOwaV4tq=BpPsrYmnTrzuhybjbknipqk5R-fA@mail.gmail.com>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Wed, 28 Dec 2022 01:07:08 +0530
Message-ID: <CAMty3ZDESyJoWMO_BgHzUJN=hLV0dH6y=3B9ogOsSUvaTMqarQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] dt-bindings: display: Add Himax HX8394 panel controller
To:     Javier Martinez Canillas <javier@dowhile0.org>
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        devicetree@vger.kernel.org, Robert Mader <robert.mader@posteo.de>,
        Onuralp Sezer <thunderbirdtr@fedoraproject.org>,
        Neal Gompa <ngompa13@gmail.com>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Tom Fitzhenry <tom@tom-fitzhenry.me.uk>,
        Martijn Braam <martijn@brixit.nl>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Ondrej Jirman <megi@xff.cz>,
        Peter Robinson <pbrobinson@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?UTF-8?Q?Kamil_Trzci=C5=84ski?= <ayufan@ayufan.eu>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maya Matuszczyk <maccraft123mc@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 28, 2022 at 12:58 AM Javier Martinez Canillas
<javier@dowhile0.org> wrote:
>
> Hello Jagan,
>
> On Tue, Dec 27, 2022 at 7:16 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
>
> [...]
>
> > > +allOf:
> > > +  - $ref: panel-common.yaml#
> > > +
> > > +properties:
> > > +  compatible:
> > > +    enum:
> > > +      # HannStar HSD060BHW4 5.99" 720x1440 TFT LCD panel
> > > +      - hannstar,hsd060bhw4
> >
> > Parent controller can have a compatible where the associated panels
> > will be enum list.
> >
>
> I'm not sure to follow what you meant. Could you please elaborate?

compatible:
    items:
      - enum:
          - hannstar,hsd060bhw4
      - const: himax,hx8394

himax,hx8394 is the actual controller and is denoted as fallback compatible.

Jagan.

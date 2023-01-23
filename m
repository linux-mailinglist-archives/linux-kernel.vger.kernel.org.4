Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4A506783AC
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 18:53:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232716AbjAWRxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 12:53:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbjAWRxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 12:53:41 -0500
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F0FA2B63F;
        Mon, 23 Jan 2023 09:53:41 -0800 (PST)
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-15bb8ec196aso14857136fac.3;
        Mon, 23 Jan 2023 09:53:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HezRXXIQxXPtMIWpEGs9XWajQCD0kCzEdwMP0szra1Y=;
        b=3MGI6Q9b8sVl0hYcQnTxHzKE1KgPhH0TWtLA720zr1BCowOm0NGOsg8k8UCdg87XQz
         J73MFFN77vEY6qd04/Ux+DXPT0hTgvenIUoCfoSSAnzp4DlvJpZw+50nAvLYQxfwfhO2
         /8ba8OSJUqJGpTwU13cD0PcRhmtBjZKqg+z76hSuSV07e35PMaKDibG3C8i1PbFVOJUn
         qnt2jEl23Ax1VIoh3Gy4wOa1KRCMXSG8wcYXDRdZJ3rs3Ed4VRXRwoR9u0Qm+rGvG/P0
         35xu7itvDKjSMcItzDRRIKw+757xiFI0y9koHnsSC+k2xWgCZexQk+QrzlWGaXXqJkBz
         gl1A==
X-Gm-Message-State: AFqh2kp1aH2NzrX2RqxSp/CvqXGEJjWw2lurgke1J4QzlrjuYPlaD6g2
        NCsYJkwLzFZsS3D+LuuIzA==
X-Google-Smtp-Source: AMrXdXsdPNG8TH0x+2IAyk2abcc9M+PaIG7GDMdhZabCSwFyK7idZOfBF+6vwpZb+UKigpv5r9mK7g==
X-Received: by 2002:a05:6870:494b:b0:143:e045:7082 with SMTP id fl11-20020a056870494b00b00143e0457082mr12913559oab.58.1674496420250;
        Mon, 23 Jan 2023 09:53:40 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id bd36-20020a056808222400b00364ebf27363sm15742oib.0.2023.01.23.09.53.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 09:53:39 -0800 (PST)
Received: (nullmailer pid 2113958 invoked by uid 1000);
        Mon, 23 Jan 2023 17:53:39 -0000
Date:   Mon, 23 Jan 2023 11:53:39 -0600
From:   Rob Herring <robh@kernel.org>
To:     Rayyan Ansari <rayyan@ansari.sh>
Cc:     dri-devel@lists.freedesktop.org,
        ~postmarketos/upstreaming@lists.sr.ht, asahi@lists.linux.dev,
        janne@jannau.net, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>, devicetree@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v2 2/2] dt-bindings: display: simple-framebuffer:
 Document physical width and height properties
Message-ID: <20230123175339.GA2019900-robh@kernel.org>
References: <20230121153544.467126-1-rayyan@ansari.sh>
 <20230121153544.467126-3-rayyan@ansari.sh>
 <CAL_JsqL+G=Cxkc2j_NowznpqNAnixrU+-6SdccFbpMaP6OYSqQ@mail.gmail.com>
 <cdf32cb0-4529-6bbd-fdda-ae641d141ee5@ansari.sh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cdf32cb0-4529-6bbd-fdda-ae641d141ee5@ansari.sh>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 22, 2023 at 05:25:38PM +0000, Rayyan Ansari wrote:
> On 22/01/2023 15:36, Rob Herring wrote:
> > On Sat, Jan 21, 2023 at 9:36 AM Rayyan Ansari <rayyan@ansari.sh> wrote:
> > > 
> > 
> > Why do you need this change?
> > 
> > The 'simple-framebuffer' contains data on how the bootloader
> > configured the display. The bootloader doesn't configure the display
> > size, so this information doesn't belong here. The information should
> > already be in the panel node, so also no point in duplicating it here.
> > 
> > > Signed-off-by: Rayyan Ansari <rayyan@ansari.sh>
> > > ---
> > >   .../devicetree/bindings/display/simple-framebuffer.yaml   | 8 ++++++++
> > >   1 file changed, 8 insertions(+)
> 
> Hi Rob,
> 
> There is the usecase that Hans has mentioned, but I have also mentioned
> another usecase previously.
> 
> Adding the width-mm and height-mm properties allows user interfaces such as
> Phosh (https://puri.sm/posts/phosh-overview/) to scale correctly to the
> screen. In my case, a panel node is not available and the aforementioned
> interface is in fact running on the SimpleDRM driver (which binds to the
> simple-framebuffer device).

Why is the panel node not available? Why not add it? Presumably it is 
not there because you aren't (yet) using the simple-panel driver (and 
others that would need). But presumably you will eventually as I'd 
imagine turning the screen off and back on might be a desired feature.

So why add a temporary DT property that's tied to your *current* kernel? 
The DT should not be tightly coupled to the kernel.

Rob

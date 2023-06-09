Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10D4B72A61C
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 00:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232726AbjFIWDo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 18:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232498AbjFIWDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 18:03:38 -0400
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 232DB3A85;
        Fri,  9 Jun 2023 15:03:37 -0700 (PDT)
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-33b00ce51caso9566775ab.2;
        Fri, 09 Jun 2023 15:03:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686348216; x=1688940216;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lbWnd1453WWYSB5tZKL9wA4jRIrmIbrZJ2ihOV5eBj0=;
        b=TBHh6znyAU/BT3zhMBrlohsoeyzuaClSrcP/AF6GXv9EAcBNW5EA7CyMvAmfMi9Vsu
         zV1gJ1eCucA6gt43nYxhDbYgZIRzMvQXUashjVt7rK776lq5w59K4JUfJz+0J5G3+f5e
         1xlyznfLszm0GKz3I6AEsjTtJW/eXRc5F9CXf/R64szlHVADbm4mrzP+0rxy4PLagSyK
         I8BhiMBX38lL5eeqeMISF8Yq6XkeuZd05rSGJFK5HijqbMftgNKuDKMVdO3BGas/Xfeu
         bAxU+PZLYd4jjEUAJF8l9yNUKoAuYLviVy4oDJVWzWAi9OE97qKlc+qKRYI3pK8qdSQD
         jHiw==
X-Gm-Message-State: AC+VfDw3jnL0BMFtXgj02zfIskupu63ZzJSDoSE1MDWN4LQvejJnyWRP
        7HKEMXqzVZrOFQnWsvPsyw==
X-Google-Smtp-Source: ACHHUZ5g/3hAO2umBs2VXYQ0I2em+F4t0rg+2lA6/YO5SiWMldXnF+mwfMfvbJytyDA5GLeINIOA/g==
X-Received: by 2002:a92:dc08:0:b0:33d:1c2b:b558 with SMTP id t8-20020a92dc08000000b0033d1c2bb558mr2366041iln.22.1686348216369;
        Fri, 09 Jun 2023 15:03:36 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id g9-20020a926b09000000b0033e4937640esm1310594ilc.80.2023.06.09.15.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 15:03:35 -0700 (PDT)
Received: (nullmailer pid 2542654 invoked by uid 1000);
        Fri, 09 Jun 2023 22:03:33 -0000
Date:   Fri, 9 Jun 2023 16:03:33 -0600
From:   Rob Herring <robh@kernel.org>
To:     cong yang <yangcong5@huaqin.corp-partner.google.com>
Cc:     Conor Dooley <conor@kernel.org>, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, dmitry.torokhov@gmail.com, jikos@kernel.org,
        benjamin.tissoires@redhat.com, dianders@chromium.org,
        hsinyi@google.com, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: input: touchscreen: Add ilitek 9882T
 touchscreen chip
Message-ID: <20230609220333.GA2535896-robh@kernel.org>
References: <20230605060524.1178164-1-yangcong5@huaqin.corp-partner.google.com>
 <20230605060524.1178164-2-yangcong5@huaqin.corp-partner.google.com>
 <20230605-anyway-grab-f7a35aa199fb@spud>
 <CAHwB_NK_j1SJ1BBkVqafFM_+fWSyvwjCpMmHQxjLjnz_KHR=KA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHwB_NK_j1SJ1BBkVqafFM_+fWSyvwjCpMmHQxjLjnz_KHR=KA@mail.gmail.com>
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

On Tue, Jun 06, 2023 at 10:06:05AM +0800, cong yang wrote:
> Hi,Conor,
> 
> On Mon, Jun 5, 2023 at 6:20 PM Conor Dooley <conor@kernel.org> wrote:
> >
> > Hey Cong Yang,
> >
> > On Mon, Jun 05, 2023 at 02:05:23PM +0800, Cong Yang wrote:
> > > Add an ilitek touch screen chip ili9882t.
> >
> > Could you add a comment here mentioning the relationship between these
> > chips?
> 
> Okay, I will add in V3 version.
> 
> > On Mon, Jun 05, 2023 at 02:05:23PM +0800, Cong Yang wrote:
> >
> > > Signed-off-by: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
> > > ---
> > >  .../bindings/input/elan,ekth6915.yaml         | 23 ++++++++++++++++---
> > >  1 file changed, 20 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/Documentation/devicetree/bindings/input/elan,ekth6915.yaml b/Documentation/devicetree/bindings/input/elan,ekth6915.yaml
> > > index 05e6f2df604c..f0e7ffdce605 100644
> > > --- a/Documentation/devicetree/bindings/input/elan,ekth6915.yaml
> > > +++ b/Documentation/devicetree/bindings/input/elan,ekth6915.yaml
> > > @@ -15,11 +15,14 @@ description:
> > >
> > >  properties:
> > >    compatible:
> > > -    items:
> > > -      - const: elan,ekth6915
> > > +    enum:
> > > +      - elan,ekth6915
> > > +      - ilitek,ili9882t
> > >
> > >    reg:
> > > -    const: 0x10
> > > +    enum:
> > > +      - 0x10
> > > +      - 0x41
> >
> > Is 0x10 only valid for the elan,ekth6915 & 0x41 for the ilitek one?
> > If so, please add some enforcement of the values based on the
> > compatible.
> 
> I don't think 0x10 is the only address for ekth6915,(nor is 0x41 the
> only address for ili9882t). It depends on the hardware design.

I'd just drop the values as we don't typically enforce 'reg' values.

Rob

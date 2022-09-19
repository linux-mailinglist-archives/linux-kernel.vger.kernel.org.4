Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91B1C5BC407
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 10:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbiISIIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 04:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbiISIIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 04:08:48 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E60E4AE5C;
        Mon, 19 Sep 2022 01:08:46 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id lc7so62685922ejb.0;
        Mon, 19 Sep 2022 01:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=ChpUK8RSwNQblLECjo619xEoogvtragMFjPnBad9ZaU=;
        b=FMzLWCE7rLj2pgkd68HYS/SItV62aOhHh72mwmlPFqrj4eO9IX65qn3Zh4HDfO9k5e
         PUBwQjlj3VkA+GmSGy6CZGBvcR63+5gTUjfr5jfChj5HkhlBOX8sW6nS1g5YTxypi51J
         F6q1Mh7uL5yIS+6JYhuLQDED634sMj/+l5jke0fhGXXn8PWpt+lCZdf9v9+gX0mKGGz6
         +nH8cRN/fbxRO7DTksMtKsLaPPc9cRX+i9r46/Sw+Z6o3QsqcSmIm3lN0yjVWb35uEV3
         vg0/yGUCpuQl/AYj1Zxa3uiYyz4WOCF7KIZCSY0/1ImtprpiVSkoi9cuUbO5NTiPM/Qt
         re9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=ChpUK8RSwNQblLECjo619xEoogvtragMFjPnBad9ZaU=;
        b=IqAVUfAqbu9t1pGZ79+jboXZ/SLufmE3ulSC6y+d8W1BMSEKA6AfW+xoJjRYFpEKj7
         8JOs92QhJ4sz5KNxJcFT4jXbKKRMf+veKr9zr9tgXD6JUHjw4FvofkWWkpe6n/Anxuvj
         Zh9eS1gp30CM669cbsR8uNGFcHOzxWWArxAJCOiipzmuRBcpxwf+IwLpFEZNsSg367lO
         ppRPD7D8sOqa1NEMu9PD6usU35oxrhD1HVknpQw9bGbfe8BdGHvGVSg87EHhpfIEhm+s
         ZOPvtc3lN7MIEOUdg9AdhibQ4lhPnRDRvoAN+R+ieVspgxTNwVhPP5oDrUsxB3A80rJ1
         79fw==
X-Gm-Message-State: ACrzQf3HV0ilzORLgkeDLunaShm//L8qttteR4VrxkNt5pwy9dQaNmCf
        iJeitg+SAr3ux5f39mlCdpY/fDzxc0574//USYg=
X-Google-Smtp-Source: AMsMyM5242Sp3awy87MF1zpXSy90hM10NPZ7trT1hjEMEGgJXs96bbayN5mV0CoPsW2kwA51bNRbAoVIo3ZNiig6AhU=
X-Received: by 2002:a17:907:847:b0:77f:f489:cc25 with SMTP id
 ww7-20020a170907084700b0077ff489cc25mr11844533ejb.80.1663574925462; Mon, 19
 Sep 2022 01:08:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220916133521.73183-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <YyZS38Wo7rDsNRm2@pendragon.ideasonboard.com>
In-Reply-To: <YyZS38Wo7rDsNRm2@pendragon.ideasonboard.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Mon, 19 Sep 2022 09:08:18 +0100
Message-ID: <CA+V-a8vvNHFt818wryyuhWxPtay4czjWXiH=AWEKiJ1AzB46mA@mail.gmail.com>
Subject: Re: [PATCH] media: dt-bindings: i2c: ovti,ov5640: Drop ref to video-interface-devices.yaml
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil@xs4all.nl>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Hi Laurent,

Thank you for the review.

On Sun, Sep 18, 2022 at 12:06 AM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Prabhakar,
>
> Thank you for the patch.
>
> On Fri, Sep 16, 2022 at 02:35:21PM +0100, Prabhakar wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > video-interface-devices.yaml isn't used so just drop it from the
> > DT binding doc.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> >  Documentation/devicetree/bindings/media/i2c/ovti,ov5640.yaml | 3 ---
> >  1 file changed, 3 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/media/i2c/ovti,ov5640.yaml b/Documentation/devicetree/bindings/media/i2c/ovti,ov5640.yaml
> > index 540fd69ac39f..ce99aada75ad 100644
> > --- a/Documentation/devicetree/bindings/media/i2c/ovti,ov5640.yaml
> > +++ b/Documentation/devicetree/bindings/media/i2c/ovti,ov5640.yaml
> > @@ -9,9 +9,6 @@ title: OmniVision OV5640 Image Sensor Device Tree Bindings
> >  maintainers:
> >    - Steve Longerbeam <slongerbeam@gmail.com>
> >
> > -allOf:
> > -  - $ref: /schemas/media/video-interface-devices.yaml#
> > -
>
> The rotation property listed in this binding uses the definition from
> video-interface-devices.yaml. I don't think just dropping this is the
> right solution. Changing additionaProperties to unevaluatedProperties
> seems a better option.
>
Agreed, I missed rotation was used from video-interface-devices.yaml.
Agreed the changing additionaProperties to unevaluatedProperties seems
a better option.

Cheers,
Prabhakar

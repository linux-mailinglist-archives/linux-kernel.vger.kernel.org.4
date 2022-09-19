Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 745F45BC582
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 11:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbiISJgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 05:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbiISJgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 05:36:13 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA0E26ACD;
        Mon, 19 Sep 2022 02:36:01 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id z2so4369778edi.1;
        Mon, 19 Sep 2022 02:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=LowgVzMAhXEseWsSPSLE6xnKe/5h9hZUiv086pOwDOg=;
        b=KWcb2nQMaXD6QS861AGNWZJ6euiUaAe6srfhrZZl0rAbS2vm83XM9hmcvvWfyYEbPv
         /0n4VNQ6bt3KqYInns/I+jirwnZ7RGbjixRadIld1bqH+SrMo2JMoItnBRYWyb57WiOP
         EncnGo4l7i/l/dHhDRvJo6zV9KKjIgptiDh46aUTsCOwkbpn0zP4NWy+335/SWQ+SnhF
         NNs0StD8ilZTurta9KRBFlc8OJrrwURv0d+jMJ24fkAUNUlD/o3pPf7azGoNQnXuWf9W
         rk0m6k4/rfWxdkUA95Ffg5J3ywNDl+XnsrwNYdlaZqWX/mOvu7PbuPV6lB/2j7Q20j1S
         TLtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=LowgVzMAhXEseWsSPSLE6xnKe/5h9hZUiv086pOwDOg=;
        b=ckP23qRjSomGNuT9aBCWR4KGAfzyhcOirljMa/w40jH5YG+TUKNSIU497yNOcgPj6n
         jLxIk4o1eOd+7L4NkQiTpPefoAHXaNB8kH3Fd23S5LmbjaBcbbG7TPcpCRRNV3exaRYE
         zrKtpewU27ngSKVGmnfLeB07HwQeCbOmqJ4+W+x3x5p3x5qR9p0xH5am8IFEGrRO6HV5
         +dNVylIB2GDTt6QBMWxyG+nBebEfPWn5EBh6jlqqqE/ctEuWN1GLRj7+/NYIgBI3gKkl
         sW0wPSBZ1LaTrUG21Jk8YyPbpBKN+SKxKdiXVxgrEPgUryXYdkoUekWrscoiOpy/EOn/
         oe5g==
X-Gm-Message-State: ACrzQf0WKEG1ST7NICgeh8pofkU+nfJXi6aQqLsujbDC4K/rjGxF++Az
        394zCWuNiPyJ1l+labnh2rd/fcz7v2yWc2wtsc4=
X-Google-Smtp-Source: AMsMyM52kCAO9ZvYqLe9i7KLJErRhymAU+D4dUkjgi56Je3DvLFjzIEeiiPCf6wYXBoYo0V00UR1JKXqle/BDrNDb+g=
X-Received: by 2002:a05:6402:35c1:b0:451:e1aa:e66e with SMTP id
 z1-20020a05640235c100b00451e1aae66emr14056073edc.275.1663580149759; Mon, 19
 Sep 2022 02:35:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220916133521.73183-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <YyZS38Wo7rDsNRm2@pendragon.ideasonboard.com> <CA+V-a8vvNHFt818wryyuhWxPtay4czjWXiH=AWEKiJ1AzB46mA@mail.gmail.com>
 <fc1c075d-e20d-9395-d168-8cfe530f77ad@linaro.org>
In-Reply-To: <fc1c075d-e20d-9395-d168-8cfe530f77ad@linaro.org>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Mon, 19 Sep 2022 10:35:21 +0100
Message-ID: <CA+V-a8uMyU89rufmqWiGFqpVjFPvHBeVeSd1Wt07eWZo1X+Bgw@mail.gmail.com>
Subject: Re: [PATCH] media: dt-bindings: i2c: ovti,ov5640: Drop ref to video-interface-devices.yaml
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
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

Hi Krzysztof,

On Mon, Sep 19, 2022 at 9:19 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 19/09/2022 10:08, Lad, Prabhakar wrote:
> > Hi Laurent,
> >
> > Thank you for the review.
> >
> > On Sun, Sep 18, 2022 at 12:06 AM Laurent Pinchart
> > <laurent.pinchart@ideasonboard.com> wrote:
> >>
> >> Hi Prabhakar,
> >>
> >> Thank you for the patch.
> >>
> >> On Fri, Sep 16, 2022 at 02:35:21PM +0100, Prabhakar wrote:
> >>> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >>>
> >>> video-interface-devices.yaml isn't used so just drop it from the
> >>> DT binding doc.
> >>>
> >>> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >>> ---
> >>>  Documentation/devicetree/bindings/media/i2c/ovti,ov5640.yaml | 3 ---
> >>>  1 file changed, 3 deletions(-)
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/media/i2c/ovti,ov5640.yaml b/Documentation/devicetree/bindings/media/i2c/ovti,ov5640.yaml
> >>> index 540fd69ac39f..ce99aada75ad 100644
> >>> --- a/Documentation/devicetree/bindings/media/i2c/ovti,ov5640.yaml
> >>> +++ b/Documentation/devicetree/bindings/media/i2c/ovti,ov5640.yaml
> >>> @@ -9,9 +9,6 @@ title: OmniVision OV5640 Image Sensor Device Tree Bindings
> >>>  maintainers:
> >>>    - Steve Longerbeam <slongerbeam@gmail.com>
> >>>
> >>> -allOf:
> >>> -  - $ref: /schemas/media/video-interface-devices.yaml#
> >>> -
> >>
> >> The rotation property listed in this binding uses the definition from
> >> video-interface-devices.yaml. I don't think just dropping this is the
> >> right solution. Changing additionaProperties to unevaluatedProperties
> >> seems a better option.
> >>
> > Agreed, I missed rotation was used from video-interface-devices.yaml.
> > Agreed the changing additionaProperties to unevaluatedProperties seems
> > a better option.
>
> The meaning of unevaluatedProperties:false would be here - accept other
> properties (not mentioned here explicitly) from referenced schema. If
> this is your actual intention for this binding, it makes sense. But if
> the intention in this binding was to disallow these other properties,
> then it would be wrong to change to unevaluatedProperties.
>
Thank you for the clarification. The intention is to disallow the property.

> Therefore before sending patches and calling something better or not,
> please instead focus on that aspect of referenced schema.
>
Sure will do, sorry for the noise.

Cheers,
Prabhakar

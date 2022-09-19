Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 398DB5BC59F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 11:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbiISJlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 05:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiISJlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 05:41:31 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE6022125F;
        Mon, 19 Sep 2022 02:41:29 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 29so40411047edv.2;
        Mon, 19 Sep 2022 02:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=/+Lkv6fT4JotvfZ1N3HSgobhDodNjszC7kCC21enwqc=;
        b=Yub/FOwRjn1HJgkZ6XkPpR/5YpU20kprWcdiBgUJpcGtCVoKC1wT7LqNnF2e7dyplg
         jjbpj/1/jGgVGb/aqUq8mdAtc8XIzSLXozfXMT+8NbaCXglT5QyI/JznUFt7AapFHCCk
         wn/3Whb7ZtTelJABfmkNddRhijDq2EcasSDp7FYVpQQy7TSLoawzEjbVSdh2q0aR008a
         kgp1IjK8L1tZlxr7fxCJxaMfVPnDEyU1TOanHnKMiywT9S4oKjNlEitDQd6kKaFYKn7y
         U2rKIJ086FMrZRruUhrf9RXxLjfT2h63HnXwgE4T551UhFSZx3Okkte2BTQJRfpMNPlC
         QsZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=/+Lkv6fT4JotvfZ1N3HSgobhDodNjszC7kCC21enwqc=;
        b=HK1JE5gG95vTPsgAnkS9bSjs3pUrL5eD3spfrJ/UWXsIeLtLVaO9/gkW8Gn+dOBkaX
         oiYa9cPIkkgYKLMc7LstJRj6Hm6EZXGD/RORIcypftUOfytsH2MerSshSc1mFlSPlNB/
         Om9gLwbLtaub7dEdA1NoeqwEjYghYt42AIX5e9bd+q9JydMw/5WET9HtXPu7DaKGrsMo
         hPcy8yqE0/LVJNy3U2n+XN0XWaAKYaPFoqSZKTHeBeFUf2pCPy7g0DB5u7jfI/DmqleI
         Hgqk3+eg9HKis/BOoxE6nMQlHsmpu1vro+uygjnK5lF7IE28+hO9gQ9F2MN82Wma1gle
         AXKg==
X-Gm-Message-State: ACrzQf2h1c1k5zIyXHee3vkqmGKRRax59RlsoQJnTwDfa2xRIxuZxjpT
        0MlLXW2hhc2BsFXkZ4b1uXpS8cw3+gMiyED8CBs=
X-Google-Smtp-Source: AMsMyM5ZfDcye9egkTwgIM+6j2Ph/CYzqgmTc1tjrdcL+ejMFVD0DTx86OW4Djftr846YhjCQmXNsGk1LdzdKdUxKd0=
X-Received: by 2002:a05:6402:f11:b0:44f:e1ff:801a with SMTP id
 i17-20020a0564020f1100b0044fe1ff801amr15020002eda.109.1663580488136; Mon, 19
 Sep 2022 02:41:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220916133521.73183-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <YyZS38Wo7rDsNRm2@pendragon.ideasonboard.com> <CA+V-a8vvNHFt818wryyuhWxPtay4czjWXiH=AWEKiJ1AzB46mA@mail.gmail.com>
 <fc1c075d-e20d-9395-d168-8cfe530f77ad@linaro.org> <CA+V-a8uMyU89rufmqWiGFqpVjFPvHBeVeSd1Wt07eWZo1X+Bgw@mail.gmail.com>
 <Yyg4SU7D5mClOvP/@pendragon.ideasonboard.com>
In-Reply-To: <Yyg4SU7D5mClOvP/@pendragon.ideasonboard.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Mon, 19 Sep 2022 10:41:00 +0100
Message-ID: <CA+V-a8uM=33jw_BE7S1G3DsvbUdvxUhkBty6VCWdAprQ288haw@mail.gmail.com>
Subject: Re: [PATCH] media: dt-bindings: i2c: ovti,ov5640: Drop ref to video-interface-devices.yaml
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
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

On Mon, Sep 19, 2022 at 10:37 AM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> On Mon, Sep 19, 2022 at 10:35:21AM +0100, Lad, Prabhakar wrote:
> > On Mon, Sep 19, 2022 at 9:19 AM Krzysztof Kozlowski wrote:
> > > On 19/09/2022 10:08, Lad, Prabhakar wrote:
> > > > On Sun, Sep 18, 2022 at 12:06 AM Laurent Pinchart wrote:
> > > >> On Fri, Sep 16, 2022 at 02:35:21PM +0100, Prabhakar wrote:
> > > >>> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > >>>
> > > >>> video-interface-devices.yaml isn't used so just drop it from the
> > > >>> DT binding doc.
> > > >>>
> > > >>> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > >>> ---
> > > >>>  Documentation/devicetree/bindings/media/i2c/ovti,ov5640.yaml | 3 ---
> > > >>>  1 file changed, 3 deletions(-)
> > > >>>
> > > >>> diff --git a/Documentation/devicetree/bindings/media/i2c/ovti,ov5640.yaml b/Documentation/devicetree/bindings/media/i2c/ovti,ov5640.yaml
> > > >>> index 540fd69ac39f..ce99aada75ad 100644
> > > >>> --- a/Documentation/devicetree/bindings/media/i2c/ovti,ov5640.yaml
> > > >>> +++ b/Documentation/devicetree/bindings/media/i2c/ovti,ov5640.yaml
> > > >>> @@ -9,9 +9,6 @@ title: OmniVision OV5640 Image Sensor Device Tree Bindings
> > > >>>  maintainers:
> > > >>>    - Steve Longerbeam <slongerbeam@gmail.com>
> > > >>>
> > > >>> -allOf:
> > > >>> -  - $ref: /schemas/media/video-interface-devices.yaml#
> > > >>> -
> > > >>
> > > >> The rotation property listed in this binding uses the definition from
> > > >> video-interface-devices.yaml. I don't think just dropping this is the
> > > >> right solution. Changing additionaProperties to unevaluatedProperties
> > > >> seems a better option.
> > > >
> > > > Agreed, I missed rotation was used from video-interface-devices.yaml.
> > > > Agreed the changing additionaProperties to unevaluatedProperties seems
> > > > a better option.
> > >
> > > The meaning of unevaluatedProperties:false would be here - accept other
> > > properties (not mentioned here explicitly) from referenced schema. If
> > > this is your actual intention for this binding, it makes sense. But if
> > > the intention in this binding was to disallow these other properties,
> > > then it would be wrong to change to unevaluatedProperties.
> > >
> > Thank you for the clarification. The intention is to disallow the property.
>
> Why should they be disallowed ?
>
my bad! "rotation" property is supposed to be allowed so the earlier
comment to change to unevaluatedProperties holds good.

Cheers,
Prabhakar

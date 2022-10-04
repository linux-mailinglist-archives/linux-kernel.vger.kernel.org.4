Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBDFD5F4A86
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 22:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbiJDU4o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 16:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiJDU4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 16:56:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0A0F2A95D;
        Tue,  4 Oct 2022 13:56:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 83AB7B81BD6;
        Tue,  4 Oct 2022 20:56:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C9B8C433D6;
        Tue,  4 Oct 2022 20:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664916998;
        bh=+v1s1uuSDD/XUgsGR2kBZYKdQWHRoUn14JslXrnftKQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IhC/8yTeiQvTxSrEM6+9zdTO7RCNp51Aymw9YdTW+lkRa4/2vlLWEvSwwP/nhw2GX
         5WwpYvNHwrFfllyz4eaxQPrKp2DsUBuZZvIuzJXqRcJBzz1OX0trGxqNwjaREjsH3W
         +doJniO7K756WKKt9Q/gVFtcM632klnyLdzDU+cOWpu0RJTsatzi8YT6JXkWZtwMW2
         A4tImhm9yjsMZv5MDofLYO0nHaYq7p7wUtAfvKjpKarN0RwFLa4eq+5pMUYNXxvpVq
         I+p7Ovc8izGETVSQNhUPCxC0m303MwRkQmmNlxXxHZlZ+/fvNQy4rlLXqCoIZF1KVO
         SKV20hG93A1eA==
Received: by mail-vs1-f52.google.com with SMTP id n186so10150010vsc.9;
        Tue, 04 Oct 2022 13:56:37 -0700 (PDT)
X-Gm-Message-State: ACrzQf1nNU/PMoc13Dt3f8d9/oP8rOyTSJzhTIVvVrdSLOVrL50WwFFs
        8pVRcH7sGpJLaM1HKKLWYThmW8jivIKU0idNMA==
X-Google-Smtp-Source: AMsMyM7f70M/JxQGww4Jppt5Cs/DXOxkWqVwzVrUd2iWuh1bIekfiwVIfxmU57Hzwq30UwIEbi24MRz0dA4I8aGIZX4=
X-Received: by 2002:a67:3c7:0:b0:39b:45c2:6875 with SMTP id
 190-20020a6703c7000000b0039b45c26875mr12151814vsd.6.1664916996943; Tue, 04
 Oct 2022 13:56:36 -0700 (PDT)
MIME-Version: 1.0
References: <20221004120907.72767-1-krzysztof.kozlowski@linaro.org>
 <YzwvDEKAzbqjSYjT@pendragon.ideasonboard.com> <64a355f2-e9a1-dcca-cb86-48805acae8d5@linaro.org>
 <YzwyT28hf7daYqa1@pendragon.ideasonboard.com>
In-Reply-To: <YzwyT28hf7daYqa1@pendragon.ideasonboard.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 4 Oct 2022 15:56:26 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLzPjAH0N01=ZOShXSweSeJg7VJTJVHwQoEAXqT3ZJ6tg@mail.gmail.com>
Message-ID: <CAL_JsqLzPjAH0N01=ZOShXSweSeJg7VJTJVHwQoEAXqT3ZJ6tg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: display: panel: use spi-peripheral-props.yaml
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Markuss Broks <markuss.broks@gmail.com>,
        Daniel Mack <daniel@zonque.org>,
        Dillon Min <dillon.minfei@gmail.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 4, 2022 at 8:17 AM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Krzysztof,
>
> On Tue, Oct 04, 2022 at 03:10:29PM +0200, Krzysztof Kozlowski wrote:
> > On 04/10/2022 15:03, Laurent Pinchart wrote:
> > > On Tue, Oct 04, 2022 at 02:09:07PM +0200, Krzysztof Kozlowski wrote:
> > >> For devices connectable by SPI bus (e.g. already using
> > >> "spi-max-frequency" property), reference the "spi-peripheral-props.yaml"
> > >> schema to allow using all SPI device properties, even these which device
> > >> bindings author did not tried yet.
> > >
> > > Isn't this done implicitly by spi-controller.yaml ? SPI devices that are
> > > children of an SPI controller should match the patternProperties
> > > "^.*@[0-9a-f]+$" in that file, which has a $ref: spi-peripheral-props.yaml.
> > > Is there something I'm missing ?
> >
> > You are correct about one side of this - SPI controller bindings.
> > However these schemas here have clear: additional/unevaluatedProperties:
> > false, thus when they find DTS like:
> > panel@xxx {
> >   compatible = "one of these spi panels";
> >   ...
> >   spi-cs-high;
> >   spi-rx-delay-us = <50>;
> >   ... and some more from specific controllers
> > }
> >
> > you will get errors, because the panel schema does not allow them.
> >
> > The bindings were done (some time ago) in such way, that they require
> > that both SPI controller and SPI device reference spi-props.
>
> You're absolutely right that additionalProperties needs to be replaced
> by unevaluatedProperties. Can the additions of $ref be dropped, or is
> that needed too ?

unevaluatedProperties doesn't work with child node schemas (from one
or both schemas). This is because the schemas are applied
independently and can't 'see' each other. The spi-controller.yaml
schema is applied to the SPI bus node and SPI peripheral schemas are
applied to SPI device nodes. This means that child node schemas have
to either be complete or only list properties which will be listed in
the complete schema for the child nodes. For example, 'reg' has to be
listed anyways to define how many entries. This is also why we need a
ref at each level in the graph binding anytime there are additional
properties defined.

Rob

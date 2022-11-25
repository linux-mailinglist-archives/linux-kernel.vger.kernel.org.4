Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40F526382EB
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 04:58:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbiKYD6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 22:58:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiKYD6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 22:58:22 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3E7821E02
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 19:58:21 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id ha10so7723397ejb.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 19:58:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qQyWEHxXa79BofbvN9Ap5hUF4GqRCe2Xjm2cBntw/bE=;
        b=Lr8vVyUXtkK6UZYfzOdWDABeh/apxGg1mIEnt0ef3Zn+MAvK0NYu5eimOEDUW9uIDl
         RRSLerbb4aYtwun2wAN4H0WrvEwxRx3TOdJXE7pxvWzi0EFHIAp9WkGrEBhSGn1Fusyy
         CJPkalmbHREaFQ1Mso7r3R7Rn1JuwDbx00kcY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qQyWEHxXa79BofbvN9Ap5hUF4GqRCe2Xjm2cBntw/bE=;
        b=uB9ia84p7tD8BqsOYzupCFbSgsfczjqYBryS+wHafhMFei5oAyZj5pdOQMwt4euW8h
         6ph6yJAHBd6ygiaPY9GymXzYcag1HVrZC2BPBY6ls7fecS3bfcI19x8N2mDwqYm3z0BD
         yn2vuUTL5xWQpKER9WB5MbtNvwIbFy2wMKaMKFfNs6Tb/9CQyCQNA62OpX5lVggm0IgD
         keYrs5MLvq78TVX46HLBLX41jN18j3IKKr2YZYMbNv6Oiig/AqoMubj63261brSzEdOE
         smm7HVD5Q0NVqpPCO1vP/bcmdZyVmu0CTc6v032vnMs3HEM6EAf09X4MmOwcv3VXdp6y
         1q9A==
X-Gm-Message-State: ANoB5pn7H0XPHWSHljV/Odyey0tr5U/Vv0IIwJzE6QSO0bmmyHG8emn8
        BQuOayKVN1iUnNeaCKbzbIMOI1bK9Nfn8euUESzPpQ==
X-Google-Smtp-Source: AA0mqf60DoiiSCvpqj+wbIXb7MO5zK4U2JjnitTifneLjLdAV07UDYzW6uQh0/y4Sqr6wogfXNwTwDBzX2w5ZETbiug=
X-Received: by 2002:a17:906:43c7:b0:7bb:c1e6:c4ac with SMTP id
 j7-20020a17090643c700b007bbc1e6c4acmr3635363ejn.757.1669348700297; Thu, 24
 Nov 2022 19:58:20 -0800 (PST)
MIME-Version: 1.0
References: <20221124102056.393220-1-treapking@chromium.org>
 <20221124102056.393220-4-treapking@chromium.org> <166930150025.3946612.5757271936642172776.robh@kernel.org>
In-Reply-To: <166930150025.3946612.5757271936642172776.robh@kernel.org>
From:   Pin-yen Lin <treapking@chromium.org>
Date:   Fri, 25 Nov 2022 11:58:09 +0800
Message-ID: <CAEXTbpcn+AkG0YF2xHce99dX7V=tt3i76tBQ8m=qLjx+u7YKHQ@mail.gmail.com>
Subject: Re: [PATCH v6 3/7] dt-bindings: drm/bridge: anx7625: Add mode-switch support
To:     Rob Herring <robh@kernel.org>
Cc:     Prashant Malani <pmalani@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        devicetree@vger.kernel.org,
        ", Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
        dri-devel@lists.freedesktop.org,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        linux-acpi@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Rob Herring <robh+dt@kernel.org>,
        chrome-platform@lists.linux.dev,
        Robert Foss <robert.foss@linaro.org>,
        Allen Chen <allen.chen@ite.com.tw>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        =?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= 
        <nfraprado@collabora.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Guenter Roeck <groeck@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Marek Vasut <marex@denx.de>,
        Benson Leung <bleung@chromium.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, linux-kernel@vger.kernel.org,
        Jonas Karlman <jonas@kwiboo.se>, Lyude Paul <lyude@redhat.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Xin Ji <xji@analogixsemi.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for accidentally using the tab characters. Will fix this in v7.

On Fri, Nov 25, 2022 at 1:39 AM Rob Herring <robh@kernel.org> wrote:
>
>
> On Thu, 24 Nov 2022 18:20:52 +0800, Pin-yen Lin wrote:
> > Analogix 7625 can be used in systems to switch the DP traffic between
> > two downstreams, which can be USB Type-C DisplayPort alternate mode
> > lane or regular DisplayPort output ports.
> >
> > Update the binding to accommodate this usage by introducing a
> > data-lanes and a mode-switch property on endpoints.
> >
> > Also include the link to the product brief in the bindings.
> >
> > Signed-off-by: Pin-yen Lin <treapking@chromium.org>
> >
> > ---
> >
> > Changes in v6:
> > - Remove switches node and use endpoints and data-lanes property to
> >   describe the connections.
> >
> >  .../display/bridge/analogix,anx7625.yaml      | 73 ++++++++++++++++++-
> >  1 file changed, 71 insertions(+), 2 deletions(-)
> >
>
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>
> yamllint warnings/errors:
> ./Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml:218:1: [error] syntax error: found character '\t' that cannot start any token (syntax)
>
> dtschema/dtc warnings/errors:
> make[1]: *** Deleting file 'Documentation/devicetree/bindings/display/bridge/analogix,anx7625.example.dts'
> Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml:218:1: found character '\t' that cannot start any token
> make[1]: *** [Documentation/devicetree/bindings/Makefile:26: Documentation/devicetree/bindings/display/bridge/analogix,anx7625.example.dts] Error 1
> make[1]: *** Waiting for unfinished jobs....
> ./Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml:218:1: found character '\t' that cannot start any token
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml: ignoring, error parsing file
> make: *** [Makefile:1492: dt_binding_check] Error 2
>
> doc reference errors (make refcheckdocs):
>
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20221124102056.393220-4-treapking@chromium.org
>
> This check can fail if there are any dependencies. The base for a patch
> series is generally the most recent rc1.
>
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
>
> pip3 install dtschema --upgrade
>
> Please check and re-submit after running the above command.
>

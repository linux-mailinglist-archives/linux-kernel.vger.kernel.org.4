Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD6A66382EF
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 04:58:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbiKYD6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 22:58:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbiKYD6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 22:58:33 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4F0026545
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 19:58:29 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id z18so4751471edb.9
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 19:58:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qG1EXeCBFcyO3EVAf0VFxb1QU3GfLO5BAHKXK8QXU44=;
        b=cZ/iUq/8Ac4sXum6PlSkHb/8lyC1wBkmt7ce4NtB1gel3ZSjx7+/j9VGw3mOb3qQ75
         z6OPVvh42cBseSf3c90EAdRkVfv5lG9N/kDoZLZEIPvPbhbLOrcU+xTYq7do2H3H1j12
         XG72/gjTaeyAUuMMhwn3+Bt4Rity7g86DEFAY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qG1EXeCBFcyO3EVAf0VFxb1QU3GfLO5BAHKXK8QXU44=;
        b=W10WBm1EPN3/DYuFfDbbTbvwsFeD1bSG9WFJj9cb4Rn6TXKPmJc4PKtJ8ycnuFFC56
         w4xh0QWrC2cMz/sMVJdHe2JxURVII3Gns3wHt20ajsaDqjcQDigEYZg1OlExGiVWfYKf
         kMpxvzN4LvDDDLAYfDKEYbJ/m5MYwlDOU48p8W47VG/i+Wb0KzfUexecjR27B5TkCBd+
         sQSJuer0oisBq8PIN/27fecwauNJQuz4dvrdOH9gaxj+hzSiEPffSG9CHvKz13yW8UH8
         0AYaYs9LVjoyNiyOBx+NpYHquVeWxwq2gfXVAKsiy4JONYI/f74I66XrC8pac+zcxxJm
         pHaA==
X-Gm-Message-State: ANoB5pkflbNu4+q0uxBam8KkoTNpUdJySPwbjx6oI/+dtn+idbLxWxBC
        qfcbP4T2FixOqd6Xs5N6L776ayZ7YBl4kU1ECYOgLg==
X-Google-Smtp-Source: AA0mqf60CqwQOnre/TZIa/ZhVJ8FaIC4IKsOt/yGrHCUPoKZRFRMA3X+qFsKNmLvAyf46Xo33hjWsB1M1Hyr48/9OyU=
X-Received: by 2002:a05:6402:3895:b0:468:15f1:54b5 with SMTP id
 fd21-20020a056402389500b0046815f154b5mr14693061edb.8.1669348708173; Thu, 24
 Nov 2022 19:58:28 -0800 (PST)
MIME-Version: 1.0
References: <20221124102056.393220-1-treapking@chromium.org>
 <20221124102056.393220-7-treapking@chromium.org> <166930150123.3946649.3725588692267123167.robh@kernel.org>
In-Reply-To: <166930150123.3946649.3725588692267123167.robh@kernel.org>
From:   Pin-yen Lin <treapking@chromium.org>
Date:   Fri, 25 Nov 2022 11:58:17 +0800
Message-ID: <CAEXTbpfFN=HKCNpQc6wrKozK-X14ky1jrw8GBnkk4rPm1LWoXA@mail.gmail.com>
Subject: Re: [PATCH v6 6/7] dt/bindings: drm/bridge: it6505: Add mode-switch support
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Xin Ji <xji@analogixsemi.com>, Lyude Paul <lyude@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Benson Leung <bleung@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        David Airlie <airlied@gmail.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        Prashant Malani <pmalani@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        =?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= 
        <nfraprado@collabora.com>, Andrzej Hajda <andrzej.hajda@intel.com>,
        Allen Chen <allen.chen@ite.com.tw>,
        Marek Vasut <marex@denx.de>, linux-acpi@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-kernel@vger.kernel.org, Guenter Roeck <groeck@chromium.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Rob Herring <robh+dt@kernel.org>,
        chrome-platform@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for accidentally using the tab characters. Will fix this in v7.

On Fri, Nov 25, 2022 at 1:39 AM Rob Herring <robh@kernel.org> wrote:
>
>
> On Thu, 24 Nov 2022 18:20:55 +0800, Pin-yen Lin wrote:
> > ITE IT6505 can be used in systems to switch the DP traffic between
> > two downstreams, which can be USB Type-C DisplayPort alternate mode
> > lane or regular DisplayPort output ports.
> >
> > Update the binding to accommodate this usage by introducing a
> > data-lanes and a mode-switch property on endpoints.
> >
> > Signed-off-by: Pin-yen Lin <treapking@chromium.org>
> >
> > ---
> >
> > Changes in v6:
> > - Remove switches node and use endpoints and data-lanes property to
> >   describe the connections.
> >
> >  .../bindings/display/bridge/ite,it6505.yaml   | 94 ++++++++++++++++++-
> >  1 file changed, 90 insertions(+), 4 deletions(-)
> >
>
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>
> yamllint warnings/errors:
> ./Documentation/devicetree/bindings/display/bridge/ite,it6505.yaml:99:1: [error] syntax error: found character '\t' that cannot start any token (syntax)
>
> dtschema/dtc warnings/errors:
> make[1]: *** Deleting file 'Documentation/devicetree/bindings/display/bridge/ite,it6505.example.dts'
> Documentation/devicetree/bindings/display/bridge/ite,it6505.yaml:99:1: found character '\t' that cannot start any token
> make[1]: *** [Documentation/devicetree/bindings/Makefile:26: Documentation/devicetree/bindings/display/bridge/ite,it6505.example.dts] Error 1
> make[1]: *** Waiting for unfinished jobs....
> ./Documentation/devicetree/bindings/display/bridge/ite,it6505.yaml:99:1: found character '\t' that cannot start any token
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/bridge/ite,it6505.yaml: ignoring, error parsing file
> make: *** [Makefile:1492: dt_binding_check] Error 2
>
> doc reference errors (make refcheckdocs):
>
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20221124102056.393220-7-treapking@chromium.org
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

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2046667241
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 13:33:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbjALMdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 07:33:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjALMdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 07:33:12 -0500
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 607D76384
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 04:33:10 -0800 (PST)
Received: by mail-vs1-xe2f.google.com with SMTP id v127so14479950vsb.12
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 04:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lmMMKRN2mYFSKBWdfS4KEk8FcK8S7SAJEuBn9XGJN0Y=;
        b=gFe2+58oQUeTne9Zkfg/uZ9QWaIynLRPo7PQDJ5C/B/JiBw/x/ytir+8cc2ShEVEpM
         h1jAtFbbp7ClBkAXMOF0BppMfBNqixsIgnHhR3ykhKHeUymrnYCtxiYLGCoe2TjT9Bmt
         XMEDeAyOFogPrwD8JuhSHAK3nr+cnt+udZNp8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lmMMKRN2mYFSKBWdfS4KEk8FcK8S7SAJEuBn9XGJN0Y=;
        b=YgBl8ygaGKf0nnA9th/+iX5dIioVEAvnZawb9BFlvidHJbd3HtHfiWgX0Wsd7aczT5
         kzmOaoANLMFI6VnWF/R8bHG4AnQBrL9YTLe0myLpfFc8QGsPS77Y7CJvHnhbw3/JdJNz
         +Rqk/JB2KknacMlnyjWsNKqbFApSoiUsK87KNTelXGutJjN/y/di7D5R/0+2G8hdgP3L
         ebxsg0zuP3INPSb2yG/ReIwDpnGxTQ6lX+H7CZLIqCB1yvOosUvsDRSK6XPOzq93cE82
         dHMBD3TadNdCwnERNdQF5PJy6Y4DsAyWKrRszeNN4FoV6Mf1+fcUch1+pRsRIOn/nuJb
         9+aA==
X-Gm-Message-State: AFqh2kod+U3RGMCBVPk3iP5I5nwViF2oBxXDvX/GjblCngJgHVTo34OB
        AO6hM7kPUqlG3nGTpGV3dRLnM/3ibY+PqcDBVW9iew==
X-Google-Smtp-Source: AMrXdXtCB2FwlHoY21KCpYVwLL1xj0HeaIsLRbFONUmvlRokBMQ/nNZG1R0mfhDYTDrxpXmDZBtfE8Cd1Wy2420mG2Q=
X-Received: by 2002:a05:6102:3d9f:b0:3c4:4918:80c with SMTP id
 h31-20020a0561023d9f00b003c44918080cmr9078574vsv.9.1673526789365; Thu, 12 Jan
 2023 04:33:09 -0800 (PST)
MIME-Version: 1.0
References: <20230112042104.4107253-1-treapking@chromium.org> <20230112042104.4107253-10-treapking@chromium.org>
In-Reply-To: <20230112042104.4107253-10-treapking@chromium.org>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Thu, 12 Jan 2023 20:32:58 +0800
Message-ID: <CAGXv+5ErwJFmu3tFX5RjB9jj-2YWH6mabnHFxnRWv+oAZud=1Q@mail.gmail.com>
Subject: Re: [PATCH v10 9/9] drm/bridge: it6505: Register Type C mode switches
To:     Pin-yen Lin <treapking@chromium.org>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Marek Vasut <marex@denx.de>, devicetree@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        =?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= 
        <nfraprado@collabora.com>, chrome-platform@lists.linux.dev,
        linux-kernel@vger.kernel.org, Hsin-Yi Wang <hsinyi@chromium.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        dri-devel@lists.freedesktop.org,
        Stephen Boyd <swboyd@chromium.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Allen Chen <allen.chen@ite.com.tw>,
        Xin Ji <xji@analogixsemi.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
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

On Thu, Jan 12, 2023 at 12:22 PM Pin-yen Lin <treapking@chromium.org> wrote:
>
> Register USB Type-C mode switches when the "mode-switch" property and
> relevant port are available in Device Tree. Configure the "lane_swap"
> state based on the entered alternate mode for a specific Type-C
> connector, which ends up updating the lane swap registers of the it6505
> chip.
>
> Signed-off-by: Pin-yen Lin <treapking@chromium.org>

Tested-by: Chen-Yu Tsai <wenst@chromium.org>

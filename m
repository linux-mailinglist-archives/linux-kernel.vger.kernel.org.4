Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A208069EE03
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 05:39:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbjBVEjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 23:39:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbjBVEjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 23:39:18 -0500
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 210742E0E9
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 20:39:14 -0800 (PST)
Received: by mail-vs1-xe35.google.com with SMTP id o6so7491892vsq.10
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 20:39:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GVoxvyPN1nhO1N4WDOubFYF2WsT9Vx0F6vnuM2++yDk=;
        b=aL/X1/QSvGLZUB2gQzJlQGgNBI0utUwoe+QVxxv47ccsL91gPFsZ8EhrIKAcwkTtl5
         ydBjo6D40FwxudR7M8CIsAgSmn4szkb4iSQsSHKOznqjBjEFAFopUM8ubJQuGalc73Zb
         9O0Cr60WrMikcg0bCxsbDMDeXgTY4ejDaw4gc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GVoxvyPN1nhO1N4WDOubFYF2WsT9Vx0F6vnuM2++yDk=;
        b=hX1qH6nFbg+3RSGZtB4kvGgDsMnGc70g9qNR4HPiXsRA/umKLGKOzl3E2NLG4RvvzZ
         sK3DNxRMOUTJVotyr3IsgtcCdMQM9Na9bzfeo8jdKloFNwidBmQsxbKv7Q7Fcy0eNJCl
         Q3arHGnfrPU18gO5kofnjuoARhEnB3q5asj3yv7NMwjJpRfEZLiP8Vp/Nk/axNITsQ5L
         gPe/D2dz3hXvNNNw4gOHwnok6ehIWWnZu2/UjvvzNGom+2/S3uy6RxGUvbavGpqrw2Yc
         EWmp6LFjmUrYIcr4xFLHcUxKfMlVfJBpF1fMXmKTrNGxoos5CDSuu+uBhntuxqPdiqye
         nZDw==
X-Gm-Message-State: AO0yUKX4HWG3SEDoRcNZWlH3FSH7cJHxitMTrF3ECZiTb3RwsGf4qLrs
        asDz1d5hgrlDaAhDZwI+0I72hvO4r5lkJSqE0yD28g==
X-Google-Smtp-Source: AK7set8Svy6X2qVPrDh0/xqnxlJyxoyam0jIuQ00GgQwGtx0+ljaNuLzHxrSOvTRQu+v7FfJ8TiLYQfAUv4WRifKOu0=
X-Received: by 2002:a05:6102:570b:b0:3fc:58d:f90f with SMTP id
 dg11-20020a056102570b00b003fc058df90fmr1475672vsb.60.1677040753210; Tue, 21
 Feb 2023 20:39:13 -0800 (PST)
MIME-Version: 1.0
References: <20230221153740.1620529-1-angelogioacchino.delregno@collabora.com> <20230221153740.1620529-10-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230221153740.1620529-10-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Wed, 22 Feb 2023 12:39:02 +0800
Message-ID: <CAGXv+5EJpkzKFJFzuz8d5xNzxwnJ=X+MpvXspUHYCNKB8YRNaQ@mail.gmail.com>
Subject: Re: [PATCH v2 09/10] drm/panfrost: Add mediatek,mt8192-mali compatible
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     airlied@gmail.com, daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, steven.price@arm.com,
        alyssa.rosenzweig@collabora.com, matthias.bgg@gmail.com,
        robh@kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2023 at 11:37 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> From: Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
>
> Required for Mali-G57 on the Mediatek MT8192 and MT8195, which
> uses even more power domains than the MT8183 before it.
>
> Signed-off-by: Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
> [Angelo: Removed unneeded "sram" supply, added mt8195 to commit description]
> Co-developed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Reviewed-by: Steven Price <steven.price@arm.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

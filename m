Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C891C6CF1E6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 20:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbjC2SLT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 14:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjC2SLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 14:11:14 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD7B4214
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 11:10:48 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-5456249756bso308304067b3.5
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 11:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1680113440;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s36Q4sLQX/3/tv2niFl6Gc9T++Xctk19QhnwqMt3BVM=;
        b=eDsYeqiG8GB4aZVHJzDU7byR1P1jPt7YE7V+7LrQkBjkHGKR65terpAGMEbNbrpWtc
         GbKOZDyCq7ZL/+Zsg31N3BVfxEvsJ1GDaWJFB38pSjVUW4/6WGSR96i/6pIpJUY1T9+N
         2W7sklR7qOx9HkWIJmhgVq8bUgKpEeVJ7TTmU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680113440;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s36Q4sLQX/3/tv2niFl6Gc9T++Xctk19QhnwqMt3BVM=;
        b=cxRWUsrqD3spjhfKMuk8puwr11LnPLGAQK85WDBmPewl60DsphdCHf8Jk+lUVlYt1W
         MuLcaULgEv7RU8Szle/UuIUeiqc0fdnqoSu9U80uGDfzmsB3hXNd/+5Y9pXlQ2Jc/2in
         x1qmbE2KBaIY47f+B7lm+gB8IrfPDy19mlgrojB3sX+KteBDDvMX8q+y4kGjLGR1Amty
         zfL6SmDz9cS0hKQpyTAGDJnvuPbOsljdJ2zf9UWvJDlAYywedVRry/U4zU5Wb0NU5HyR
         NGC/uA2TvA8WTK6JFzuLqdO2boLANS/PoZSorEYULif7E7EsjxMe07LHBbEAb3ng2Wja
         iQvQ==
X-Gm-Message-State: AAQBX9fqmG3wUWD62SLyBX1q4cTkHjY9BrDJT5xznbhgE8sQIPgMOpHq
        AnHu9wkqKF2lZAWRU4/XuBbznxPLAxRqkdLaVgICAg==
X-Google-Smtp-Source: AKy350bTV90Nmmdqq5XdDMT52Ufu5ut5fzXMHi+iq0KHhNlusnr1XWTmvpO5LoXs+iXfO3xl7HbVrgeRFLebGR+jpH0=
X-Received: by 2002:a81:ac46:0:b0:544:6828:3c09 with SMTP id
 z6-20020a81ac46000000b0054468283c09mr10157919ywj.0.1680113440045; Wed, 29 Mar
 2023 11:10:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230218111712.2380225-1-treapking@chromium.org>
In-Reply-To: <20230218111712.2380225-1-treapking@chromium.org>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Wed, 29 Mar 2023 23:40:28 +0530
Message-ID: <CAMty3ZD3SY-WCtYK0dexdLxCk8d+2tJ=D9xb5uR06jPGCd=56g@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] Add generic-display-mux driver and bindings
To:     Pin-yen Lin <treapking@chromium.org>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        chrome-platform@lists.linux.dev,
        Nicolas Boichat <drinkcat@chromium.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Guenter Roeck <groeck@chromium.org>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 18, 2023 at 4:47=E2=80=AFPM Pin-yen Lin <treapking@chromium.org=
> wrote:
>
> This series is developed for and tested on MT8173 board, and the layout i=
s:
>
>                                   /-- anx7688
> -- MT8173 HDMI bridge -- GPIO mux
>                                   \-- native HDMI

What is the part number of this GPIO mux? Does mux gpio interrupt
based and able to switch output HDMI and DP. If so, how this gpio
interrupt is different than the HPD in native HDMI? I mean does HPD
have any detection bottlenecks with mux gpio interrupt?

I do have GPIO Mux that input DSI and two outputs DMD/HDMI Input and
HDMI Out. 2x1 with 1x2 mux.

I'm thinking having a generic mux to select the specific out number of
outputs with associated interface outputs can be a viable solution to
address all use cases here.

Thanks,
Jagan.

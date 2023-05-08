Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0FAD6F9DBB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 04:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232364AbjEHC1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 22:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjEHC1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 22:27:05 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF37C40E3
        for <linux-kernel@vger.kernel.org>; Sun,  7 May 2023 19:27:04 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id ada2fe7eead31-43478543ad0so1065057137.1
        for <linux-kernel@vger.kernel.org>; Sun, 07 May 2023 19:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1683512824; x=1686104824;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NIGaI7AoRYU4CptNG22N3Xgj/+0h3Xejz8PTM4bg9mY=;
        b=cBA6vAuO8LJez7PdckNifF4buIJQwn0a0dc5Wz/GSw9bSYwmfJvhxb8Idnsp7T6OMy
         hZL/ZPvA2533OMdcL+f1k3MCPucJhefBcGSBwCRbEu6k5WoGxazYFdIP63QhYj5UbVQc
         3DRW/1rCElBfe+wOsslxXnnq7xrnf25wf3GuA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683512824; x=1686104824;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NIGaI7AoRYU4CptNG22N3Xgj/+0h3Xejz8PTM4bg9mY=;
        b=GuenzHBQnqSuCaXkriUoJgSPNVfmyJVfHzXSFvSsx6lGaq4LS+srylkAA68ThzfIXn
         xdiuKTQ2kMwC/+vq/4mRTBi763Tgp3N7b994sUCwp67Jaovs3fc1vAhlUTCS5qZWimRo
         EtHGM4SBl7ohaxEy2SEY6uXz0cChmpGGIPyBPMGUfgu1OR5hg9ebc4en8siHjiQ33uxu
         9BZReIIwKk2s/stdONgZbD3s3v+U4bblFHCQFkXnFH9HwTJrJZSNoES+salebxMoARuo
         nUlRfDI/elt2RJ7t+aj2jylUVKN/edlrpmtlveqGVPHoaC2fK6tAqmFaXou5lWLVFmi0
         kW/A==
X-Gm-Message-State: AC+VfDwoCIz2YdRaHPeqAL4GM7ph+8i1U/MaL4xeRhHtL+eIR9B2woSx
        PYV1iJ6oDF/mcAoPynlL7R7eUTBVWCC+4BKfPESIhA==
X-Google-Smtp-Source: ACHHUZ6TS2ol1t6UooR5qGJfNvnT2PxdKXiffL9hVv+balRGgS96GUFpCOf1xMIUrvIL749QC5ZcR6JGiAD5thV5h7c=
X-Received: by 2002:a67:f8cf:0:b0:426:2a37:4a6b with SMTP id
 c15-20020a67f8cf000000b004262a374a6bmr3098252vsp.25.1683512823989; Sun, 07
 May 2023 19:27:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230506192453.725621-1-aford173@gmail.com> <20230506192453.725621-5-aford173@gmail.com>
In-Reply-To: <20230506192453.725621-5-aford173@gmail.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Mon, 8 May 2023 10:26:52 +0800
Message-ID: <CAGXv+5Hi=Oh9u6QB8_7h4P2zq9GLSS59g+fJsJfaXuhubuP=VA@mail.gmail.com>
Subject: Re: [PATCH V5 4/6] drm: bridge: samsung-dsim: Select GENERIC_PHY_MIPI_DPHY
To:     Adam Ford <aford173@gmail.com>
Cc:     dri-devel@lists.freedesktop.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Robert Foss <rfoss@kernel.org>,
        Jonas Karlman <jonas@kwiboo.se>, aford@beaconembedded.com,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        linux-kernel@vger.kernel.org,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 7, 2023 at 3:25=E2=80=AFAM Adam Ford <aford173@gmail.com> wrote=
:
>
> In order to support variable DPHY timings, it's necessary
> to enable GENERIC_PHY_MIPI_DPHY so phy_mipi_dphy_get_default_config
> can be used to determine the nominal values for a given resolution
> and refresh rate.
>
> Signed-off-by: Adam Ford <aford173@gmail.com>
> Tested-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>

Tested-by: Chen-Yu Tsai <wenst@chromium.org>

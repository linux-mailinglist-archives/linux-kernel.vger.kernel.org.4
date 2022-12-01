Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41D5763EC0F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 10:12:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbiLAJMl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 04:12:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbiLAJMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 04:12:37 -0500
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8549D21B
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 01:12:33 -0800 (PST)
Received: by mail-vs1-xe35.google.com with SMTP id 124so944528vsv.4
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 01:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ALhdSAWsghUtCus/0uCzkcW2mIgHq/m8cptp/lUwSm8=;
        b=Of0kh94fnlxSCsdiTYxtv2RE7VW9Z88mWIB1zYKB8gIOj/TP0UcYpIEZ3A8aAWTQSa
         CRxETJdf6LJi3Ts6AkhEPxKvB1kEjcHUhYjljn0vVUsuXSlGffqnGoElOFXQK3TcBE4M
         bEQ4YiR2kv7KDz6EKDjYE9lHKgebvbJvQHBsg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ALhdSAWsghUtCus/0uCzkcW2mIgHq/m8cptp/lUwSm8=;
        b=x3OMYbgBeQGujdGFu7Krd85FnyP2E+KbvLR+WGfXwMZQUcYZvoe+HG2JXMaDd+Zv3S
         PMQN59yW0lhjbJTTP/MBct7sQRw7IatireWHAjESTyfydTS3I0ktox8qUT4HkKFdDQDA
         jbqx2X8JCo9eIXo2dkUgnIroDUPL6r8D+MabewexdZ+n3Ywn7fG60S2rX3qW9SuGT8VG
         pNsKE57fNveuk5AAuhpH0Y8GVsmGspalHv0Ddqi9rPRR2jfoJbNGu+8N45ULf1iYdQUs
         1/VeF8P976HS2EjKGTbTElXCJxjUKpIPkJ49Qu1ed5Uo/XQIoHsUP9xTycCfLzl2wEnO
         gjdw==
X-Gm-Message-State: ANoB5plrFwcOR3XhFtdEqYVmnZg3vy1uOYvO8+6bkUrirKp3k2Mzy3me
        7Cbb7Jy9F+Y+m0PJOj9ycbNPZf4NuH5GO24kINHVDA==
X-Google-Smtp-Source: AA0mqf5pDznuHdDmJa9FSw5s9Zyzj4ltqrR+GmrxSGK2M9Q3odMRAnvw6pHvQG/QVV0dO+6EmPnGmOEejJGbGfsV6Lw=
X-Received: by 2002:a67:1c85:0:b0:3b0:92e2:37b0 with SMTP id
 c127-20020a671c85000000b003b092e237b0mr13239162vsc.9.1669885952671; Thu, 01
 Dec 2022 01:12:32 -0800 (PST)
MIME-Version: 1.0
References: <20221128143832.25584-1-allen-kh.cheng@mediatek.com>
In-Reply-To: <20221128143832.25584-1-allen-kh.cheng@mediatek.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Thu, 1 Dec 2022 17:12:21 +0800
Message-ID: <CAGXv+5HVVYb2RGE+dJ7JWpoJ5_QDnvvFEn=xo+17it-OFDCMNg@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] Add vcodec lat and core nodes for mt8192
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, yunfei.dong@mediatek.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2022 at 10:38 PM Allen-KH Cheng
<allen-kh.cheng@mediatek.com> wrote:
>
> This series is based on linux-next.
>
> Change from v4:
>  - Add patch for removing dma-ranges
>  - Update child names to video-codec
>  - Update patch title and message
>
> Change from v3:
>  - Drop `vcodec_lat:` and `vcodec_core:`
>
> Change from v2:
>  - Add a dt-bindings patch for changing "vcodec" to "video-codec"
>  - Rename child names for vcodec lat and core nodes
>
> Change from v1:
>  - Replace node names with video-codec
>   [Allen-KH Cheng <allen-kh.cheng@mediatek.com>]
>
> Allen-KH Cheng (3):
>   media: dt-bindings: media: mediatek: Rename child node names for
>     decoder
>   media: dt-bindings: media: mediatek: Remove "dma-ranges" property for
>     decoder
>   arm64: dts: mt8192: Add video-codec nodes

Whole series is:

Tested-by: Chen-Yu Tsai <wenst@chromium.org>

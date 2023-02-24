Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6EAB6A1906
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 10:48:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbjBXJs0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 04:48:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjBXJsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 04:48:21 -0500
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE3C22A147
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 01:48:20 -0800 (PST)
Received: by mail-vs1-xe31.google.com with SMTP id x14so20653927vso.9
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 01:48:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Hy9qFm6Se/EXdsfdDRuKKStMA9t1Y7+V3hdvzyTdE1k=;
        b=DXKueC8GpWCpoaUHhYn/VQVDrlcC5bBvGx9yUjyrIaUxjgH/nZgFkXAlDhhIM4Rk1K
         fevzB1ccqZoM/IEbncOZ8uRBzbikbbjGgp4UmpOZmrPCgcJLJ2UXc5ibkBAy4ieK7itq
         7R5kC5Dod5amnYLIoK+eRQgN2GAqgId8oG5es=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hy9qFm6Se/EXdsfdDRuKKStMA9t1Y7+V3hdvzyTdE1k=;
        b=0PzaT66yB4xoUfnKEox3c4SCcqrg8YlOgr0SN1Ghbs3DqFI7XvseScn25E4/3RFPYk
         PbX4q16Qsnq/UwBF8GuTI3/QpPcBlNJUgbneKaXO0ZiYA00ZCQJLUGV+mKQK+k+0aQzj
         MgD1708cXhEUG5dwZ/pGBz9H4+QCPZw8HpGppQhnFZKu6nr30bintNHGFYE1PgR+hzZi
         tktqUE6ixectvwPHms52TikW1syuJtl/Tx4cTPuZ9tPKt+w2PQn1uZu8OCGGAFO6Q8Zn
         klO8fpqpqc21ZgE3u6I2gz7wsUpTvJeR4KO2SLOpiA7Aq6arWGL3HPYgxY9IV9U2NmJf
         Xy2A==
X-Gm-Message-State: AO0yUKUoGCX8OT0xBuNz4Q2PppFbISCDmMw8HR6vEfr1rqs7shdzraqa
        qh1zNhgsTPVtP6FlS5m2zsQR+cVe4L8z0OXItz/KiwiVL8ZZNQ==
X-Google-Smtp-Source: AK7set//leuBbGapBBCZqdtVWTRR+//pDwfT2YEJmSKyJPphUPRuePVjrJm1c2+unUfCTnRY/OH4DOBdzIniPgi5pX8=
X-Received: by 2002:a67:ec11:0:b0:411:c62b:6bf0 with SMTP id
 d17-20020a67ec11000000b00411c62b6bf0mr2046072vso.3.1677232099910; Fri, 24 Feb
 2023 01:48:19 -0800 (PST)
MIME-Version: 1.0
References: <20230223134345.82625-1-angelogioacchino.delregno@collabora.com> <20230223134345.82625-2-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230223134345.82625-2-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 24 Feb 2023 17:48:08 +0800
Message-ID: <CAGXv+5G8dkV-Po+960QeqMVUj6Sp7a08LYLitorWOWN=MhNKhQ@mail.gmail.com>
Subject: Re: [PATCH v2 01/16] arm64: dts: mediatek: mt8183-kukui: Couple VGPU
 and VSRAM_GPU regulators
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
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

On Thu, Feb 23, 2023 at 9:43 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Add coupling for these regulators, as they have a strict voltage output
> relation to satisfy in order to ensure GPU stable operation.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

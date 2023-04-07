Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 555A96DAA8A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 11:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239705AbjDGJCf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 05:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231778AbjDGJCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 05:02:33 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E986B8A5B
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 02:02:31 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-54c0c86a436so85619557b3.6
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 02:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1680858151; x=1683450151;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5FppLWQucE53T3kVXc5omQRaDshsHkdpFTYRMesBnJY=;
        b=XWXfbomq+a4GK+g4J603yOrle7HXbOCD0/bqXm/1K9d8zN1hDEfnng2wRGWQQHoXle
         paFjj9n5UVWz2kUKSmqiewCEgyZAhdcA/vXKSFWJDZh9E29EJ8vY+hC9hJrP5G69zbcD
         ED6LrQJitNeWtvI4H+y1I4YlF3D1ei4vwOgMZVIHjnngPPfyb+vnu89OjWpxvsb1WXmE
         YtbeKsto7G8uvQytTakqcgBjZzWf9ZehVTVs8Nz+96IvQ6GofsN/43hOzCu8ifGycHCP
         gR7/b93durtrSp3lc52tU9fDAfDLkOUMRKptTf+w0pXA5KbcDbNd9sXT04f4xWIIQDVZ
         T7og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680858151; x=1683450151;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5FppLWQucE53T3kVXc5omQRaDshsHkdpFTYRMesBnJY=;
        b=hSZBdUOnAaNfBoOPgNN694IzwBZJ2LHOaolgQvzMFfgaS/DeVeSF9rgneiwoDqudEy
         c6G5SmQnRK0+4WnYej399Z4JsV7CH/jw0xFfI3aGbWsXi5fF14KShGC3+G9+kYvUlzTf
         WHQEj0w4vystJSmi9/HeIgTZ85ovGdpI6YPoqGExVpZcp2m6E9Mt5uzhBD2e2JVpUBzB
         BpYsJWa1AH/cHXFdoXy77KWyByHUmeFaNjeHecgchHA5S80NgNZyfLe9bMgUfLNBL5kb
         ORWA6pixRuVte1xZ4m3SCN7F1ruq4fsIUZwsRlTwD//zfz+OmGI7E2hnN4pm6fqA/XYm
         y2lw==
X-Gm-Message-State: AAQBX9cmtFzXCgEMUlsKIJzQcVN70ZaQe0omCkmzhZPt9ubZ1SS/UBOD
        t5si0Qam14vRahLiEkbX2X5DwiPK/lMzgZsbpl+7cQ==
X-Google-Smtp-Source: AKy350Y/lfTR5L2LzB5ArFA2L6SsDySfhY/ENMv2I1LxVrMSWs3AzbbfRwRcz8JUhh1u8o30utGVfpOODc+PoOLxouM=
X-Received: by 2002:a81:c406:0:b0:54c:fd7:476e with SMTP id
 j6-20020a81c406000000b0054c0fd7476emr707442ywi.3.1680858151110; Fri, 07 Apr
 2023 02:02:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230407-smi-driver-v1-1-036d6d8e8993@baylibre.com> <796300c0-19e9-2c22-8385-1b33a92bf02f@linaro.org>
In-Reply-To: <796300c0-19e9-2c22-8385-1b33a92bf02f@linaro.org>
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Fri, 7 Apr 2023 11:02:20 +0200
Message-ID: <CAFGrd9qQWsu13Qrraz16JEO1rZhGYZd0zk_nPQDq=Q2oRyWPLg@mail.gmail.com>
Subject: Re: [PATCH] memory: mtk-smi: mt8365: Add SMI Support
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Yong Wu <yong.wu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le ven. 7 avr. 2023 =C3=A0 10:41, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> a =C3=A9crit :
>
> On 07/04/2023 10:39, Alexandre Mergnat wrote:
> > Add MT8365 SMI common support.
> >
> > Reviewed-by: Yong Wu <yong.wu@mediatek.com>
> > Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
> > ---
> > This serie add MT8365 SMI common driver support only because, to be
> > bisectable and avoid issue, this driver change and the related change i=
n
> > the DTS should be applied in the right order (driver first).
> >
> > Here the related DTS change: [1]
>
> 1. Where are the bindings? They always come with the driver.
> 2. Where is the changelog? What happened with requested changes? How a
> review tag can appear on v1?

Thanks for the fast feedback, I fix that right now.

Regards,
Alexandre

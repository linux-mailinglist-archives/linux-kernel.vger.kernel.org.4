Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABA0D6ADB0D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 10:53:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbjCGJxy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 04:53:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230473AbjCGJxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 04:53:41 -0500
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6036346172
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 01:53:36 -0800 (PST)
Received: by mail-ua1-x929.google.com with SMTP id n4so8408883ual.13
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 01:53:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678182815;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g5DlCuYa7/0gszYKTKl13EbxZ9aUeXgRvcmWQ1j6cpk=;
        b=iYVNJhITTewI0WpMkOykHA9MEJqLR9u5GxtRG70p5Zu/GSgLThwV/iZ8limQX6EPfM
         QsUNbKXXHV4j72gPV9NqqX/s7VJ+8MlE3JEPlKPZsPCh9I1iLiORTPTvoXJG0S3jK7Ed
         2g14iWOM2PvMqyYjxVBaV1NDiYlCAidKKmc4c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678182815;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g5DlCuYa7/0gszYKTKl13EbxZ9aUeXgRvcmWQ1j6cpk=;
        b=0ha/KjKgS6WWtaY3fqOkNMTR2DdtSif18+ioKTuj5gy2qG7C4ml5tVTdMpKUAjXqfa
         /JvgtwooH8ij85EFyz9dEVr/pbLNRgChugsrEYAUvLdn/LzXKHwKIarPVK7w2Z1AOBWY
         yifdEupQ7rsuMmWjEuXlDryKA07+chKiskUGFMzb4URG8kxfAjgOdxRkgwRFYCQ/+aTh
         1zCvcNsJhoVnLmBKFTNci6Kbo+cli9PA828ZB7lVKuwMf+o8VTrmSxfHcUnU9toQldBV
         ujja8ewV6TCcsnzNhEl+AWopnThLK83b0yfXEwY0UOdIB7hDc+qXTsPGC4gHZBfyojHd
         n7PA==
X-Gm-Message-State: AO0yUKU+q3ZmYNbzwMEt8wQKtPwfSn4gNxUsfzJ4UGd1I/q+kWTNTwnd
        OJ6hTIW9KcGQx3l3GhQNPS11nVWrbwzMTuk+U2DRDw==
X-Google-Smtp-Source: AK7set+q9jiPd9ivFHGiyrKW+e476+Rr3GZq5Ktk/6QxdnYWJr3wJ1xgCC/Coq26W/IugJcUukY4aCFPLpWw0ND7HAI=
X-Received: by 2002:a1f:9dc2:0:b0:406:1fd2:bb76 with SMTP id
 g185-20020a1f9dc2000000b004061fd2bb76mr8622549vke.0.1678182815197; Tue, 07
 Mar 2023 01:53:35 -0800 (PST)
MIME-Version: 1.0
References: <20230228102704.708150-1-angelogioacchino.delregno@collabora.com> <20230228102704.708150-10-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230228102704.708150-10-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 7 Mar 2023 17:53:24 +0800
Message-ID: <CAGXv+5G-2knqWMd9EtbAqXDwmRH+-ou0w__uXAXcfzyMoWdbRQ@mail.gmail.com>
Subject: Re: [PATCH v4 10/12] drm/panfrost: Add mediatek,mt8192-mali compatible
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
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 28, 2023 at 6:27=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> From: Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
>
> Required for Mali-G57 on the Mediatek MT8192 and MT8195, which
> uses even more power domains than the MT8183 before it.
>
> Signed-off-by: Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
> [Angelo: Removed unneeded "sram" supply, added mt8195 to commit descripti=
on]
> Co-developed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@co=
llabora.com>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> Reviewed-by: Steven Price <steven.price@arm.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
Tested-by: Chen-Yu Tsai <wenst@chromium.org>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD06A6ADB21
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 10:55:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbjCGJzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 04:55:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230482AbjCGJyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 04:54:35 -0500
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 044EF52F70
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 01:54:13 -0800 (PST)
Received: by mail-vs1-xe31.google.com with SMTP id f31so11809164vsv.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 01:54:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678182850;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vVaK5fa/4HYATIX0W7bJf4mZCzOtRFjIhnuFvVhvfeU=;
        b=Dl6wcGCiDkifqDwLsKfdUBlG3DuYQB56oycul9KEjs6Iszio/Yz5p1mDGhWQLucvtU
         h6fVddwe5sMWsgC/St49FnnZmOYUMLgFX+Yi2T/+TI4/xtlfn41+d2Lge3uOZqT6EMqs
         aH6wpLE2W9Hw7LTc82Zv3/s+vGzj3ipPp0I9U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678182850;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vVaK5fa/4HYATIX0W7bJf4mZCzOtRFjIhnuFvVhvfeU=;
        b=DiifN+fjX6/8Kc+dJaji3B46X2LoTPxwPQkK1bJPV06nCaVYy7StrOKtYDh7SLbeSq
         1xdgMXbfuu12I2Rk/pMU6PzOH9IVL5frxI+jD0CKzaBP9HuNpd+vCkMxLeraBeJlnOva
         SmOnpedFx0R48KYRhobMfo2BQnVKunDNEm3MvuKHgS0wkt6nRwsk/YSqhvTL7DFMDC9f
         gjaaD6rmx/ZZTaISNLJEa5vLCCFkzQMyJ3FyB0wGSauZhDWxwgO6ZfzAGDvKYKo32Rdf
         Ml5Oo3bx8brwQ/xJEIdmT6m3BYJ2O47GOJKWBlYC0ERNDvCyBUWUgzmWMZR13T4y50Ap
         T7wg==
X-Gm-Message-State: AO0yUKV1WlVWo/nF8qiLpol1CFDNa9QMVemGH6fywoFkUwVjuqchwnba
        lhnUR09pLKATuw7wD9sDXXFfxTB+Y0GV5bSvtVmoxg==
X-Google-Smtp-Source: AK7set+M+YbqM/phaVs9YXbp6uwuxjHLfZOSgI3fcVyoRwVBzUTftmT1tmU6GP/gFzeZL546fwapyRfVwBFvBG+dKU0=
X-Received: by 2002:a67:db97:0:b0:412:2ed6:d79b with SMTP id
 f23-20020a67db97000000b004122ed6d79bmr9257239vsk.3.1678182850374; Tue, 07 Mar
 2023 01:54:10 -0800 (PST)
MIME-Version: 1.0
References: <20230228102704.708150-1-angelogioacchino.delregno@collabora.com> <20230228102704.708150-8-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230228102704.708150-8-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 7 Mar 2023 17:53:59 +0800
Message-ID: <CAGXv+5GfT92mGRetF_m2BSyCbx6zArrhwBYV3U=JcMDEN0P9cw@mail.gmail.com>
Subject: Re: [PATCH v4 08/12] drm/panfrost: Increase MAX_PM_DOMAINS to 5
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
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
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
> Increase the MAX_PM_DOMAINS constant from 3 to 5, to support the
> extra power domains required by the Mali-G57 on the MT8192.
>
> Signed-off-by: Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> Reviewed-by: Steven Price <steven.price@arm.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
Tested-by: Chen-Yu Tsai <wenst@chromium.org>

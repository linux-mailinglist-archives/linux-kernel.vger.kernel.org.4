Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3239D69EFC5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 09:00:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbjBVIAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 03:00:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbjBVIAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 03:00:37 -0500
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67B0222025
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 00:00:36 -0800 (PST)
Received: by mail-ua1-x931.google.com with SMTP id x1so2306368uav.9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 00:00:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=E/ELBQfN+/3lXdDB7LXB4Z2052sqoav27oBRvmxfX5Y=;
        b=AT+IRCu07svzL8m3gIIkCn+JEKk2W/8SCpGDCVA+oSKuwo58MRo4ZcEhc6RxVyyV5h
         SH4xpigfLJChb7OmNwlbmVHd/ccstGcS85QW1xb9r0cVu1WFt+Nf9hV2DweSdhHYdjPX
         0Ij/WbhQi5RvciOPshvUX0SJhh8dn1E+l2nQg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E/ELBQfN+/3lXdDB7LXB4Z2052sqoav27oBRvmxfX5Y=;
        b=IY4kHVhTkChyMhWtb1jr67VZBp84SP8Qh3iMpxdDzCb6A+KD2N7vucexO2cH8a5ZeU
         s3gPYHFsdO35YmtzQJmMpxBF2Gx7AzTOL7ESWeqd++5QP6Xex8euipS/6EDkkDUYUdpZ
         VRRiqINdl/jATwnaQoTR3YZnHqCsEHM5kcab4MnY4hZBqUquwk8+wZrpwaSOEZGdmjn8
         a4J8tJq25nLdEJaYP5fhETuOWuUsLXBZ4y6JpXpS5GvmtXid0eN/fWi3loctiTTynZ8z
         2vmkw7k3MiiaNsIrQdJyd8ilY9EYKU6HTEpOXzRJyfZcD7/kWk8Q9DFO3G4Ms/wjs74u
         P/xQ==
X-Gm-Message-State: AO0yUKWBWYYxo9crxvEK93v0lqHi7sUTK2MJblvMPms+O/4LWl3O9N4X
        ifHofRT8vz3273JZyCbhAFcHSSktYZZJ6jeoS56wAA==
X-Google-Smtp-Source: AK7set9gHg9xT1t3caYU+/EH6XDWBjScNBL58kOvjAujH1+xQR8y6JHp+iLrLSPt9BTYSv2avB7S3b74hbnrFiwCMsk=
X-Received: by 2002:a1f:208d:0:b0:3e8:66ce:a639 with SMTP id
 g135-20020a1f208d000000b003e866cea639mr1301210vkg.2.1677052835469; Wed, 22
 Feb 2023 00:00:35 -0800 (PST)
MIME-Version: 1.0
References: <20230221153740.1620529-1-angelogioacchino.delregno@collabora.com> <20230221153740.1620529-4-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230221153740.1620529-4-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Wed, 22 Feb 2023 16:00:24 +0800
Message-ID: <CAGXv+5EhuZ4oqEc-gK+F8fktFra+0MD5pMi_qzDwnFXxgjUsAg@mail.gmail.com>
Subject: Re: [PATCH v2 03/10] dt-bindings: gpu: mali-bifrost: Allow up to 5
 power domains for MT8192
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
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2023 at 11:37 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> MediaTek MT8192 (and similar) needs five power domains for the
> Mali GPU and no sram-supply: change the binding to allow so.
>
> Fixes: 5d82e74a97c2 ("dt-bindings: Add compatible for Mali Valhall (JM)")
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

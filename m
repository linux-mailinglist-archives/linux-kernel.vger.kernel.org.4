Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 921BA6ADBE5
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 11:28:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbjCGK2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 05:28:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbjCGK17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 05:27:59 -0500
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21D22738A8
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 02:27:37 -0800 (PST)
Received: by mail-vs1-xe2d.google.com with SMTP id f31so11879126vsv.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 02:27:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678184856;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oQWWeSgJzRDMlqiwuu81ooiy+d+wn5swGzaHRiZJYgg=;
        b=gmu+hdgeQO4DLaMQAIBgOxQcm5fF1Lm3Ar4OTwBQRMayPM9zIf3PwUk72MU09LozmV
         gQ9Tdyj4MicaNl2dDTpGnA7tgGCWFcGhD/rnYjdeuJ90XwqcbNSlVDAbUabd3KaNFxOo
         +QwdamtK++gXs4b7HUfhVRbNXS+wxYKl+SDLw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678184856;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oQWWeSgJzRDMlqiwuu81ooiy+d+wn5swGzaHRiZJYgg=;
        b=Vib9ZinX6ctC4yB9OcErcAHPjZSgic3nCXkk2QvripuX0fUVmGihPk08YHtfbkYxPE
         cIePxRLlpAXWcpVsC08VdDDn9KGshhoPorF0yoyeyEtoRM9EUxcCMn4zbWr+HG/sd3Og
         jhRILweSLfz5umUukSump9NEFAoRhr6YltBxzMpUoSJ+jkvrxPAdPBOtS+8rLA+3nITU
         GlNsTU0VfG+H5ierZCRhIjXulq1nUh0VqiP8Uk7EZIFdvKO8bZ8hd67yEtnYJmbcxaXJ
         GWefDT9hSlUMX1JL1CBbJJJbek2y0BqfHIWxmvu9Tok7B64UXB14a/r1MMb+flewDBjd
         jUpA==
X-Gm-Message-State: AO0yUKWHtQL1PHUnwgQZRzG/VrkbrNc4VCTalf5rlfiR5LkQ+i40ba0/
        fhh+iuZVjR7+ezwgJ5LXGdFg0Vp5R3VdvWP71Kstwg==
X-Google-Smtp-Source: AK7set/nfUjGPRAD0f9xbAT5uy4DYnrTL6hnkblxAJK9+rSFg8OKB7S+yFpCVZviDWEpneSk0qGS+aaVnvZD9DRlCnQ=
X-Received: by 2002:a67:db97:0:b0:412:2ed6:d79b with SMTP id
 f23-20020a67db97000000b004122ed6d79bmr9301865vsk.3.1678184856050; Tue, 07 Mar
 2023 02:27:36 -0800 (PST)
MIME-Version: 1.0
References: <20230228102704.708150-1-angelogioacchino.delregno@collabora.com> <20230228102704.708150-3-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230228102704.708150-3-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 7 Mar 2023 18:27:24 +0800
Message-ID: <CAGXv+5E8n+OnWY0ChWekgoF26kXaPEEGUmVxmpJYC70+e3K-RA@mail.gmail.com>
Subject: Re: [PATCH v4 03/12] dt-bindings: gpu: mali-bifrost: Fix
 power-domain-names validation
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
> Commit ("dt-bindings: gpu: mali-bifrost: Add Mediatek MT8183")
> incorrectly introduced power domain names for MT8183, causing
> validation issues.
>
> Add power-domain-names to the base schema, allowing a maximum of
> five elements; since platforms having a single power domain don't
> need any actual domain name, disallow that for each sub-schema.
>
> Fixes: a7a596cd3115 ("dt-bindings: gpu: mali-bifrost: Add Mediatek MT8183=
")
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>

Tested-by: Chen-Yu Tsai <wenst@chromium.org>
  with `make dt_binding_check` and `make dtbs_check`

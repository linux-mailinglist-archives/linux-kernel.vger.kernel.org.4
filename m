Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB9076ADBDF
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 11:28:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbjCGK2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 05:28:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbjCGK1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 05:27:14 -0500
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3CF65291D
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 02:27:10 -0800 (PST)
Received: by mail-ua1-x930.google.com with SMTP id g19so8489868ual.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 02:27:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678184830;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0lIP6QMCX3nExnse1kF0X/k89ASNhvKrsoqP0TvYGno=;
        b=YA/vWYLL+KxXY1sPwdyBi7xdV37GzpA+yMEtwec/IcVfnN/Y7OW+zTmdCExJKPTKep
         sUHs6wFhVeM9+EKCrehvRB00bEadA1Lrrw1+brNUyvsK8bbk1z5r7CfTtHvTCt9fE1J2
         p7N36WMUM8nENpwHPcSzU+hfddZn7hAto9rDg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678184830;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0lIP6QMCX3nExnse1kF0X/k89ASNhvKrsoqP0TvYGno=;
        b=x7diTYvm7Dw9eMfvCNs3/M3K7rlEofdsZkse+cIbImjO6eJUDiDGbNsscfpPIJVkRA
         cDfVJdkNUFUijS9nONNN8Mc5BgZuJIUCCYhkXKgFh78KJI6BG+YPjT3h8EwIPITAUKB+
         QI7eYo4WA2q8JtaVgSLZcLcs23VTrPjmT81e8WGK38/5fgRwlLI3igDsDNwLhZUo/p1v
         3UiYIog4fC4oTir5h6iYHVbuZ0xaG/MouCRHa+FZ61cMzOWdbRNLW3x1PuCusqBSYufz
         gCGC4xqxoCUqTOhaWy7pt0+g62if/pRmEGld4D5Qq1Z3smhe5nuaeu3zItgg4jSD+NUB
         +4LA==
X-Gm-Message-State: AO0yUKWsN+WH7RDDUNd8eQMn3BSQYkR3O9CkIYTjHZX5T8jqzZawaKgH
        lxQSxfgjiGZ26r/3fl0MARZCdeKwjrsPfRao/Ylwlg==
X-Google-Smtp-Source: AK7set819ohzAaSDe0nZOxCmCgvs/Q8sYI8nIk6xQMEmrLHEWghxcsfgqRisZu1xB8xnfMWgTnPegQm6O/nqzaXnSRw=
X-Received: by 2002:ab0:4714:0:b0:68b:90f4:1d8c with SMTP id
 h20-20020ab04714000000b0068b90f41d8cmr3434006uac.1.1678184830022; Tue, 07 Mar
 2023 02:27:10 -0800 (PST)
MIME-Version: 1.0
References: <20230228102704.708150-1-angelogioacchino.delregno@collabora.com> <20230228102704.708150-4-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230228102704.708150-4-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 7 Mar 2023 18:26:59 +0800
Message-ID: <CAGXv+5E6EzucKFUOp1i0CgKh4tmaVMC-MV3FgjtgqmbhbB3_zg@mail.gmail.com>
Subject: Re: [PATCH v4 04/12] dt-bindings: gpu: mali-bifrost: Add sub-schema
 for MT8192's power domains
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
> MediaTek MT8192 (and similar) needs five power domains for the
> Mali GPU and no sram-supply: change the binding to allow so by
> also introducing power-domain-names in the generic binding;
> while at it, also disallow the newly introduced power-domain-names
> for all non-MediaTek bindings.
>
> Fixes: 5d82e74a97c2 ("dt-bindings: Add compatible for Mali Valhall (JM)")
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

Tested-by: Chen-Yu Tsai <wenst@chromium.org>
  with `make dt_binding_check` and `make dtbs_check`

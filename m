Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 528C86B1A6B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 05:27:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbjCIE1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 23:27:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjCIE1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 23:27:12 -0500
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA7C390B64
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 20:27:10 -0800 (PST)
Received: by mail-ua1-x92f.google.com with SMTP id s13so318206uac.8
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 20:27:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678336029;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ieOsjAqyzpAajCGC1a5mZjRKapEj1/IVvZ5C1bjX/7o=;
        b=SmHOlIfvlICUpOY6DbOtEod/qcZ4atqdL5fcjKjl7+LbbYwTZjl5ZED7Dq4SEk59ap
         ankUrwYHpFYkcIDvrBYd6LSIYXprJmtmR1CmFWk+oK01IPAe5jvSAteb1V3ZThU85Udw
         qmtUiHOlBORl27jOCtUK6kvLCmwL1IRiHgksc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678336029;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ieOsjAqyzpAajCGC1a5mZjRKapEj1/IVvZ5C1bjX/7o=;
        b=iEO7IZYYHrTpTCW3vbUNsHIFoVmtsZmRpjM7rzbJS/Th6Wg16AjXO3+v50yL+qqlyD
         9MWc+iwIipxM1t0L9e4CtPX/asJh8s2dF/ztoI7BatyrtWyLZkcRoN8S46fvhYi+ThpT
         5SxMh/qLPzISPb8WzL5jhNK1WeAbqsOwJvpmRiUrOecdoEAVQ7tz0hO4a5Sx14pjezOm
         reBDlK6utztZFRY+YrGcskXT8qysFcvnc6JwXxJ64b37Wb+tqvsFQRVS9uQLjF4iHuer
         pYSY/ap0XOD1x7R2+CiM5acalY5bwHo5KS5p7DmWed26xaW/D1y9NBc3nzs4HBgBuoI1
         5rpA==
X-Gm-Message-State: AO0yUKVUzzi10Xy7HPfhSRsYC3vPsb1lV99xF57YoKEEbBKBqlaQnYxb
        d8uSa58saBoIPshuHSkUTKDU09etgP6tQPNYGr6+/Q==
X-Google-Smtp-Source: AK7set/gee51c9AlWy0aEk/2rrxCvuyAgRAg2qGcJMrG0xU2avrdZyZgYSTGxy1emfR/hwcrDnyE7ZFHD9JuLjx4uVg=
X-Received: by 2002:ab0:470b:0:b0:688:c23f:c22f with SMTP id
 h11-20020ab0470b000000b00688c23fc22fmr7754413uac.1.1678336029680; Wed, 08 Mar
 2023 20:27:09 -0800 (PST)
MIME-Version: 1.0
References: <20230206100105.861720-1-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230206100105.861720-1-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Thu, 9 Mar 2023 12:26:58 +0800
Message-ID: <CAGXv+5H6jdWc0zKnW8LjsPYACoG1vRJHtTJUMHzY_8VYdX7g6g@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] MediaTek Frequency Hopping: MT6795/8173/92/95
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     sboyd@kernel.org, mturquette@baylibre.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        edward-jw.yang@mediatek.com, johnson.wang@mediatek.com,
        miles.chen@mediatek.com, chun-jie.chen@mediatek.com,
        rex-bc.chen@mediatek.com, jose.exposito89@gmail.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 6, 2023 at 6:01=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Changes in v3:
>  - Added commit to export register/unregister/parse FHCTL functions
>    to allow building clock drivers using FHCTL as modules
>
> Changes in v2:
>  - Rebased over v4 of my clock drivers cleanups series [1]
>
> This series adds support for Frequency Hopping (FHCTL) on more MediaTek
> SoCs, specifically, MT6795, MT8173, MT8192 and MT8195.
>
> In order to support older platforms like MT6795 and MT8173 it was
> necessary to add a new register layout that is ever-so-slightly
> different from the one that was previously introduced for MT8186.
>
> Since the new layout refers to older SoCs, the one valid for MT8186
> and newer SoCs was renamed to be a "v2" layout, while the new one
> for older chips gets the "v1" name.
>
> Note: These commits won't change any behavior unless FHCTL gets
>       explicitly enabled and configured in devicetrees.
>
> [1]: https://patchwork.kernel.org/project/linux-mediatek/list/?series=3D7=
14059
> AngeloGioacchino Del Regno (7):
>   clk: mediatek: fhctl: Add support for older fhctl register layout
>   clk: mediatek: clk-pllfh: Export register/unregister/parse functions
>   dt-bindings: clock: mediatek,mt8186-fhctl: Support MT6795,
>     MT8173/92/95
>   clk: mediatek: mt6795: Add support for frequency hopping through FHCTL
>   clk: mediatek: mt8173: Add support for frequency hopping through FHCTL
>   clk: mediatek: mt8192: Add support for frequency hopping through FHCTL
>   clk: mediatek: mt8195: Add support for frequency hopping through FHCTL

The changes look good to me overall. I've asked MediaTek to take a look
at the various parameters used is this series, as I don't have the register
definitions for the old version, and from what I've been told, the slope
and other parameters depend on the chip design as well as manufacturing
process used.

So, code wise this series is

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

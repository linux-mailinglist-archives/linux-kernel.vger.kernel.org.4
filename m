Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA6B6ADBEC
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 11:29:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbjCGK3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 05:29:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbjCGK3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 05:29:17 -0500
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3380B86DD3
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 02:28:18 -0800 (PST)
Received: by mail-vs1-xe34.google.com with SMTP id f13so11864246vsg.6
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 02:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678184892;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3OjoZPsqIE5ZBDC6k5US7ft7Fv6D8y/Y9uWB8Kp8Q1I=;
        b=Z+U2URwv5RAFmBuO1fEg8c71VhnLa2jYsgXMkp5j7Drw4naK5n5cxgxlNKPgrzSMyM
         FQzNREXnLmEfxBfWr6zvUaR2Ht1/1Agw21HatM5/ytBEQiNUbxJJ3cQXusQVS7XcRkr9
         OOzLIIWoz00nm4Y+rTN7eCzBboE0uhw5g0fq8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678184892;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3OjoZPsqIE5ZBDC6k5US7ft7Fv6D8y/Y9uWB8Kp8Q1I=;
        b=TwFJ5Z7JOBbJUUh2j9zGqcfPziMLvBjB8xdIwLomhpJlAO6d5+5Mf/gPRCDSbgNBdI
         gHBnXNOPYC4Q33dWwnTj0XRyoQd8PyceuxmbWHvoAV9xCacEiDfC9JY/LtkI+ndivRVD
         JcKBEvru7X0GG7CB1RWNv+cUeU6eMuIepRZBYOL3yaQvEHasCVQ+usNhrnOozqKqx7Fh
         1LgeJGZIbaVR+jlSmrrMKu3/VomZl0g+gbnhR40ouizXpAcNrOzlagd1JjkZAN7rOxX9
         63x5STAs6dWdJmet5bVnSKx2U4oUCU/ek4iWO8x1pbk4RxZgtbJ8EFYC7OGPcktHagQM
         Kqjw==
X-Gm-Message-State: AO0yUKXWgl1JCQegCrOrKLpvZptdwc3QJyUIX6zd/rEzJ5vDKX4dbcyv
        TUDkimTbOoZzzPNYx7P8T0kVqe9TaFCtHS4cW3tahQ==
X-Google-Smtp-Source: AK7set/ITkAjaSaTIwYUailNdnAEo1658Tu042kqe1qbbCjUu+Xu1rTiwAP1U/AG7z8p4PHEwOzJI22d7OmcVvhg4Po=
X-Received: by 2002:a67:e2c7:0:b0:412:2f46:4073 with SMTP id
 i7-20020a67e2c7000000b004122f464073mr8850110vsm.3.1678184892533; Tue, 07 Mar
 2023 02:28:12 -0800 (PST)
MIME-Version: 1.0
References: <20230228102704.708150-1-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230228102704.708150-1-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 7 Mar 2023 18:28:01 +0800
Message-ID: <CAGXv+5Fv7AbvMzZdfwvZXvRfLmmKSpPLeAJUOKWS_VSzeVE0wg@mail.gmail.com>
Subject: Re: [PATCH v4 01/12] dt-bindings: gpu: mali-bifrost: Split out
 MediaTek power-domains variation
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
> In preparation for adding new bindings for new MediaTek SoCs, split out
> the power-domains variation from the `else` in the current
> mediatek,mt8183-mali conditional.
>
> The sram-supply part is left in place to be disallowed for anything
> that is not compatible with "mediatek,mt8183-mali" as this regulator
> is MediaTek-specific and it is, and will ever be, used only for this
> specific string due to the addition of the mediatek-regulator-coupler
> driver.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
Tested-by: Chen-Yu Tsai <wenst@chromium.org>
  with `make dt_binding_check` and `make dtbs_check`

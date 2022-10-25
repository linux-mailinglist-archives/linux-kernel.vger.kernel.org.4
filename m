Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1198360D54D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 22:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232499AbiJYUNW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 16:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232331AbiJYUND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 16:13:03 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ABBB7E03B
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 13:13:01 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id a2so12257625vsc.13
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 13:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1CDt1y7e7BIyTnclLO8/l8wF0JXVZnj5kZesVA/eyFg=;
        b=K3/2yhlJoAiQZi9EIf9ab9ebsvLBXlapY9+VwvPvvaVRJdx5Qh7HaDiz2pbdxMyjy6
         7O0o8Vn/BmDMXgzxWGyev/NBW9V/cCjmYxXMKeQtMV/TakUujFewAyvj3sGn29sXYTwy
         HJUaeg9EChZ2sMJxySltPYCDU+/TXDc57BhfM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1CDt1y7e7BIyTnclLO8/l8wF0JXVZnj5kZesVA/eyFg=;
        b=fBWq1w6l94N0ybL7uzXGnuw1SOZkfhvIFJR6SQMBauN1mIQRa6W6OPq9agjKOg390a
         yqOxlJELtJT10CsZn2mE+fAWfCyu11DlDx7mkajrGOa8LzMqSCkJWEXp6/QTsWf2wVg1
         dmpmHSemCqvEfLgqIIgcpLS3JhXnYQ7oupN6QTPcAyLmdYaHX1qHqttK/KQGJqz2H4Ce
         geuTdTTdDvxDBhrFwj5r5B8FrcxLSMf5zDW9pGoJXI/Rqos8hm29c6H6Tsn7IThTzn3I
         d7csIKgyF6x2NlALb0rcKcP9oBzUg8F0H6PK1xQ1OPiHHkadumE/m3xSl+lWTxUQlOI+
         SS3Q==
X-Gm-Message-State: ACrzQf0MXY13XmxpOPTaCKmA92sHPMH9+EoBH6KIjq4sqxMem75CZNZk
        /5MA17avb4kET/t0Ylhv4cqHyPpy0J9VhSZr7283rQ==
X-Google-Smtp-Source: AMsMyM442Daimvpeuj+fzZhj86o7I+uEPF+apOJTcNTkmGt7gJrIuTpph61tawRfa3xTlXfYPexjfx9DegwQ7Ul9dgo=
X-Received: by 2002:a67:f106:0:b0:3aa:efc:8610 with SMTP id
 n6-20020a67f106000000b003aa0efc8610mr8867914vsk.65.1666728780555; Tue, 25 Oct
 2022 13:13:00 -0700 (PDT)
MIME-Version: 1.0
References: <20221024220015.1759428-1-nfraprado@collabora.com> <20221024220015.1759428-3-nfraprado@collabora.com>
In-Reply-To: <20221024220015.1759428-3-nfraprado@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 25 Oct 2022 13:12:49 -0700
Message-ID: <CAGXv+5HJo5x2ieOegmv5vkfh+rTevdR_fri-7PeK+Gd+GXVjNw@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] ASoC: dt-bindings: realtek, rt5682s: Add AVDD and
 MICVDD supplies
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Derek Fang <derek.fang@realtek.com>,
        kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 3:01 PM N=C3=ADcolas F. R. A. Prado
<nfraprado@collabora.com> wrote:
>
> The rt5682s codec can have two supplies: AVDD and MICVDD. They are

The actual chip also has LDO1_IN (for digital core and charge pump)
and DBVDD (for I/O). However in the Chromebook designs these two
and AVDD are all provided from the same power rail, through separate
filter banks.

Neither does the datasheet specify the ordering of AVDD, DBVDD, and
LDO1_IN for power sequencing, just that three should be toggled together.

Should we model these? Or wait until some design actually splits these?


ChenYu


> already used by sc7180-trogdor-kingoftown.dtsi, so document them in the
> binding.
>
> Signed-off-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
>
> ---
>
> Changes in v2:
> - Added mention that property is already used in a DT to the commit
>   message
>
>  Documentation/devicetree/bindings/sound/realtek,rt5682s.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/sound/realtek,rt5682s.yaml=
 b/Documentation/devicetree/bindings/sound/realtek,rt5682s.yaml
> index 1c0b06d82369..ac1dea5b4450 100644
> --- a/Documentation/devicetree/bindings/sound/realtek,rt5682s.yaml
> +++ b/Documentation/devicetree/bindings/sound/realtek,rt5682s.yaml
> @@ -90,6 +90,10 @@ properties:
>    "#sound-dai-cells":
>      const: 1
>
> +  AVDD-supply: true
> +
> +  MICVDD-supply: true
> +
>  additionalProperties: false
>
>  required:
> --
> 2.38.1
>

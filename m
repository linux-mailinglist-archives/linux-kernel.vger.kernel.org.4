Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D662C6EDDE0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 10:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233585AbjDYIXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 04:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233560AbjDYIXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 04:23:01 -0400
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B44434EC0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 01:22:53 -0700 (PDT)
Received: by mail-ua1-x92b.google.com with SMTP id a1e0cc1a2514c-7720fa201caso1537978241.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 01:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1682410973; x=1685002973;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yB1vq96921s8Z+v7/sB5m0qpEYlp9sw0LsfZcq/pqeU=;
        b=e0zftWCIDn7BTVxEmaVWy9Gyo3hq6Kgtm/4Abhf6x6VIHKKbOYbd9GfftVqodTX9Nk
         LOzm1akF5Z1CD3GiFNZqpjtwdwWTFZCGf7dkGtAfMCOOetpZIZtvKN/HOZdLnwgH03IA
         1KA9kNXv9xoVu3oNd7i2BRPKBknyO49QDYWaw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682410973; x=1685002973;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yB1vq96921s8Z+v7/sB5m0qpEYlp9sw0LsfZcq/pqeU=;
        b=mBKChhjNDnqynIqfhx0Cf35h6PJ/mVVC2+FQ1hN+zKs8s+JxBEW5oHECMoCw+0Qg6x
         ZSOR0ZQLGHytbH7lisGZlsSbT7mYoqNaoDCYOUtCjsBUDR0SGQSaioHxUmOG1WjnOeqr
         /Ucglo3jkji9hqyRiisVv9lNxzFtKgA5RtKB0Y8tEE3wNXsXKfY6fms2d0MZ8Rm58Itb
         CeUdlBTfnLRZNI/I+2/aI4QlYRKpLBzcD7B3UX4rEj5yHiRsuKU63FWbeJDMm2sDlo2G
         TueFT5Mj6pqb1uYI/XJDxJhbHYvkj/lzUTxy6VBYrv06FaijUZRM8hmwYjZ5f1lytnsI
         EkEw==
X-Gm-Message-State: AAQBX9eyEd5s/cHEAH5L0Wh3nTlSSPUE1Szdd6a0Wt3Ct8XwatCsrJZx
        j/iJnwj8JN0tsoiJu6Uxo0lLJzvbfPDBYQWBqk+vIw==
X-Google-Smtp-Source: AKy350YjDblx2hofGVRmKM8ugsEwJq7JQoSpSEm4sX81GgzE8gg2Ged5AMI6wkWcpR4sjHKb4lCgfG+BkoeTdboZ6es=
X-Received: by 2002:a1f:5e81:0:b0:440:5f56:dcc7 with SMTP id
 s123-20020a1f5e81000000b004405f56dcc7mr4735250vkb.1.1682410972801; Tue, 25
 Apr 2023 01:22:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230424112523.1436926-1-angelogioacchino.delregno@collabora.com> <20230424112523.1436926-3-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230424112523.1436926-3-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 25 Apr 2023 16:22:41 +0800
Message-ID: <CAGXv+5Gr6_UnBhM8xq9vXcSJatZAq644P7SqN5byR44t3VqkwA@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] arm64: dts: mediatek: mt8195: Assign dp-intf aliases
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 24, 2023 at 7:25=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Assign aliases for the primary and secondary dp-intf IP to properly
> and reliably enable DisplayPort functionality.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>

Tested-by: Chen-Yu Tsai <wenst@chromium.org>
Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

> ---
>  arch/arm64/boot/dts/mediatek/mt8195.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/d=
ts/mediatek/mt8195.dtsi
> index a44aae4ab953..b03a42fe27a6 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> @@ -24,6 +24,8 @@ / {
>         #size-cells =3D <2>;
>
>         aliases {
> +               dp-intf0 =3D &dp_intf0;
> +               dp-intf1 =3D &dp_intf1;
>                 gce0 =3D &gce0;
>                 gce1 =3D &gce1;
>                 ethdr0 =3D &ethdr0;
> --
> 2.40.0
>
>

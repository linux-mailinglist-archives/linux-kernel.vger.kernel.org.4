Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91E2569A4E6
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 05:33:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbjBQEc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 23:32:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjBQEc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 23:32:57 -0500
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A94D416AE8
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 20:32:55 -0800 (PST)
Received: by mail-vs1-xe36.google.com with SMTP id m1so4340925vst.7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 20:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/MeUKjw33jpqilmmYXQEGFRb0OCD/4Vq8XY4qGuBOYE=;
        b=S3awRWKrbCT7SjUcPzd0fvwXvqP30sAmcHpK21MWzkpsEU2B2urrTaswMUoqohl8ga
         INOvkTG37BexzEthZigt9wfPn9w957TxMGKzEkEKfWRbUOA0LGE9fQ4hAEwSqECPuPkA
         MyRSsGcuD4OR3nHWt3NkGIuU3DUpogrjTdmVo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/MeUKjw33jpqilmmYXQEGFRb0OCD/4Vq8XY4qGuBOYE=;
        b=QNtfreJ2VHmMZ/cM0NFJLQmk3uQTjLqRu0LwJQ/lyshklDfvzF6k8gJylj/d4n861C
         H+S7ieESXRfxzxtcEwZAVlL7wBNNxBqDzZorNu/LqE2el2Ty3pNrBBKgbQfwQZxOTVfH
         4Lf7KCXHu4QS+y6N3aRrEIz+O7hnRn1z8+nJQrZCYFRTfEB5xynSUtUVbE8JyLq9WuKe
         JskjfeGlL4yBECJAm/T84j7mR3ftro/JqkzMP/89LAFGFeBzallW9y16njut3w5xaywL
         m9pYEjCua+5C9EggA6kXww3Lx3tfn4Mhjp3fGt3sIpukoSqaXoMz54A68MJHGI6ueiQA
         0V8A==
X-Gm-Message-State: AO0yUKU3xttsItvrcP68xvzX1hUR1icu0BkhvmLue9nBp5o/bAwmD8BP
        QcjTlNNys2tI4z5Z3PtB599FKK/RVDQQEb8SyI/bWA==
X-Google-Smtp-Source: AK7set/cSGuBVDTCxSmRRGsS41MgtBnX0pHCKDtmZOdivWOY+N/IZzhla6F8qP11ESwesqemFfp/tlEhHshfqZsRNsc=
X-Received: by 2002:a67:f749:0:b0:3fc:58d:f90f with SMTP id
 w9-20020a67f749000000b003fc058df90fmr1532091vso.60.1676608374852; Thu, 16 Feb
 2023 20:32:54 -0800 (PST)
MIME-Version: 1.0
References: <20230214134127.59273-1-angelogioacchino.delregno@collabora.com> <20230214134127.59273-40-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230214134127.59273-40-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 17 Feb 2023 12:32:44 +0800
Message-ID: <CAGXv+5FtWp8BvLHJmJvXe=eXvM10-LTjQo9PkH1xKMvzY6YiHA@mail.gmail.com>
Subject: Re: [PATCH v2 39/47] clk: mediatek: Allow MT7622 clocks to be built
 as modules
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, matthias.bgg@gmail.com,
        johnson.wang@mediatek.com, miles.chen@mediatek.com,
        chun-jie.chen@mediatek.com, daniel@makrotopia.org,
        fparent@baylibre.com, msp@baylibre.com, nfraprado@collabora.com,
        rex-bc.chen@mediatek.com, zhaojh329@gmail.com,
        sam.shih@mediatek.com, edward-jw.yang@mediatek.com,
        yangyingliang@huawei.com, granquet@baylibre.com,
        pablo.sun@mediatek.com, sean.wang@mediatek.com,
        chen.zhong@mediatek.com, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com
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

On Tue, Feb 14, 2023 at 9:42 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Now that all drivers are using the simple probe mechanism change the
> MT7622 clock drivers to tristate in Kconfig to allow module build.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  drivers/clk/mediatek/Kconfig | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
> index b5636b3225e8..55727889ebf5 100644
> --- a/drivers/clk/mediatek/Kconfig
> +++ b/drivers/clk/mediatek/Kconfig
> @@ -336,7 +336,7 @@ config COMMON_CLK_MT6797_VENCSYS
>           This driver supports MediaTek MT6797 vencsys clocks.
>
>  config COMMON_CLK_MT7622
> -       bool "Clock driver for MediaTek MT7622"
> +       tristate "Clock driver for MediaTek MT7622"

Same as MT2712, mt7622-apmixedsys is builtin_platform_driver.

ChenYu

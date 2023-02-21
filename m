Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF7F69DAFA
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 08:12:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233492AbjBUHMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 02:12:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232229AbjBUHMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 02:12:47 -0500
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF027252BE
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 23:12:45 -0800 (PST)
Received: by mail-vs1-xe2f.google.com with SMTP id 6so3457971vsv.7
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 23:12:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1676963565;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yEsysSVdP9APPHINfBx/6hl5qqV1XS6eh2AICs0D4uM=;
        b=A25P4uxQE8wBG3G636S1q2+aUl/olyQCRf4NJKo1bLX2wwYXD8iLC4QbRq/t9170V2
         /LKCz5/t+oR3mw0UFfObs2RXCJp/roLc240TL00dkaTUS0STVi7/Sy9u6wCSNP8FS1ER
         DL+nihKO4Hn9T5sBZzhBhukAg+Gh6zEntL128=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676963565;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yEsysSVdP9APPHINfBx/6hl5qqV1XS6eh2AICs0D4uM=;
        b=scvgMjxAcjjKM1aMannygBjcjdf/6lVad+9j8mlDsHLAFsBgIVEhhqx2Km6xRwVxjn
         eeQA87pbfq4PJM5ggqehs7TjEkLZoNreIXC2jdISrUtuL4GkLRLwZQToOYT7ayxYjPhP
         bNOby2kDTQAZ3DI1KL8YH1vSp7xERL7i4aEo+9UstaXOClUhdi/htyQzleY+OVhhCupe
         0U0pAWb7hlClA1ZCZcaseAcMxYlXvcMLaP+AD4tS2zo3t5Yyil6PFC96keSSgQmUcAV/
         T+bMpnhPIjWwn4UKGuE0Qh1DOE0q9fgplPbMIPKTnAIDYXioYsJIh8CBXbOx/X0IiHFq
         TCiw==
X-Gm-Message-State: AO0yUKUDNXCtn/JWqGZlCM3ivCG9Utym14Pnvf/CVKU0EntmsENxJJXw
        fMWaN6hHXOxZyPFRiGg1C9ru5MjN5cBU9DBfNNdpnA==
X-Google-Smtp-Source: AK7set9U5LpZut3M2xqQTP9wK+Ik2Kq8zvDWC/9/TGGzH1/TbpTw+vR6hl9/c3FS7oWZdtisaP0IzOu712pE1N5C55M=
X-Received: by 2002:a67:f6c1:0:b0:411:a14d:6bac with SMTP id
 v1-20020a67f6c1000000b00411a14d6bacmr907848vso.44.1676963564997; Mon, 20 Feb
 2023 23:12:44 -0800 (PST)
MIME-Version: 1.0
References: <20230216130021.64875-1-angelogioacchino.delregno@collabora.com> <20230216130021.64875-7-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230216130021.64875-7-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 21 Feb 2023 15:12:34 +0800
Message-ID: <CAGXv+5EwqokPe_DOoNJ7QaCUt3phhnc_+2vDBi-atjYzs4kVtQ@mail.gmail.com>
Subject: Re: [PATCH v1 6/9] soc: mediatek: mtk-mutex: Replace max handles
 number with definition
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     matthias.bgg@gmail.com, jason-jh.lin@mediatek.com,
        chunkuang.hu@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 16, 2023 at 9:02 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Replace the magic number "10", defining the maximum number of supported
> handles with a MTK_MUTEX_MAX_HANDLES definition.
> While at it, also change the type for `id` from a signed integer to
> a unsigned 8 bits integer to save some (small) memory footprint, as
> this number is never higher than 10.

Depending on alignment of bool, we might not get that saving.

> This cleanup brings no functional changes.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

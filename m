Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F33969A60B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 08:26:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbjBQH0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 02:26:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjBQH0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 02:26:18 -0500
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA345D3DC
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 23:26:12 -0800 (PST)
Received: by mail-vs1-xe2e.google.com with SMTP id p14so4736360vsn.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 23:26:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=n3U1y+OS8xHFze5wneiT44BoEGBfIqVLDOTwRPTeO1c=;
        b=RpDZkxWnIFU+udhEWSYKG0R2/2OZcswMbc0u1muUPD8ygE4T8QIXgMwnHqHmjZwtbT
         yrHtsBMAvp6Ahvo1ot9R/doPW91e7Cr5MLmZ6y+igi7H5sk0pJah6IH8MtEQGhIw9HY+
         ZMNrKNUERpnlfCE5U0NvB3Q6ZxFdZbAh/4Ve8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n3U1y+OS8xHFze5wneiT44BoEGBfIqVLDOTwRPTeO1c=;
        b=jzZcHNSS2W+9dNmnLZ1hnx9I8GtjZJ6S+WyEhI8HD2YAOI2j986+zFf/b6HhmYNezt
         9HRR83NJ4henqBQats9Oz3V+LToV8ioiC2p0JKG0N1kd94bf9+iAtHl40HILBRPZ3nyx
         QafE/ay8Nj1s9K8Na8UZiyQhU/HRYnYB5VUpP53JcfSjcldMd1PVixCup3ItMmrtiV4S
         AVXmQpbKWxaIsygrdZQbmP1EPqlEBUVhgvB3lebHMB1tt1Z6tJpdu9IksBS8nkOhfRwk
         jdAcvFzJkTXlKiAP+FB+BlKY5B+r39piK32HfN3maUXhlTRRj7GMabe5k2pztsBXsUFW
         WGdw==
X-Gm-Message-State: AO0yUKUXWw1zKYo6YP+gc7H909VszhLRRL04ytQL10VCiIbhxk8B9U5X
        wd7Xlf7UTR7wAI6OCY+dkgZbtTlf4l08NGYGE7PIQw==
X-Google-Smtp-Source: AK7set/oYrpQGsELLVkMHCbstyKC7Vxeam0LT/Pg8NVkknGuitEFKcVtuuvscnIO+hmqQxJBaUY4SJSaIrtMIgipUcA=
X-Received: by 2002:a67:f749:0:b0:3fc:58d:f90f with SMTP id
 w9-20020a67f749000000b003fc058df90fmr1598974vso.60.1676618771782; Thu, 16 Feb
 2023 23:26:11 -0800 (PST)
MIME-Version: 1.0
References: <20230214134127.59273-1-angelogioacchino.delregno@collabora.com> <20230214134127.59273-42-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230214134127.59273-42-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 17 Feb 2023 15:26:00 +0800
Message-ID: <CAGXv+5FUANGiDpim4_i7pnvcKokrG7E+ucbtmPQp3Pv_hfpEmQ@mail.gmail.com>
Subject: Re: [PATCH v2 41/47] clk: mediatek: Allow all MT8183 clocks to be
 built as modules
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2023 at 9:42 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> All MT8183 clocks are platform drivers now! Allow module build for
> all of them.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

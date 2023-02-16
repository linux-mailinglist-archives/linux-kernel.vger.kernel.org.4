Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6379469925B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 11:56:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbjBPK4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 05:56:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjBPK4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 05:56:30 -0500
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15E4857743
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 02:55:47 -0800 (PST)
Received: by mail-vs1-xe32.google.com with SMTP id p14so1551302vsn.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 02:55:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zwzrytKcGK6J02tRdTcyqtWr69LMQ1V040meAEqQm/k=;
        b=FqZCf6BIpw8mQzSkpFjZJU+ChtW8JK4Q4m1K9wKTgdR6oqnvR084AUnCAual8LqGmt
         ojESksxzlOI7nXXoWAUvxR0mNEGpYu52c9hzYIFv5TLu6DN4PlAa0gs9OQMWGgj2XdEu
         8EPu1VNHlZ4tjLfAkdPbbId6oz2M9aYW/lGIc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zwzrytKcGK6J02tRdTcyqtWr69LMQ1V040meAEqQm/k=;
        b=EppeUmymt3JjUmV4iMlcnMogIHwCtSsKYkdJzpr6vtVjZT/0gN1dV8b1O29+eRgxbJ
         ragnMKJWuo1j6Ga8sjeHOBOwy1XPEfyyWag1qU3Ufe7fEwSxpvwQ0A7Xk0DjylwOhVxk
         wlUVsLDiHNiYYs8RC7VxXsPynAmyIrft6qvfATwqGmx3CAvu9+79zExnds5/yWmGHRKL
         G/PAiqDYHwa7rzzqsXO6d7/zWbvZsWuSPDtU2/PihzCfKm9K6eO07VfAKkYVZoAkdLtg
         dUKitXP//HL23J3N1F1X7uEn+qh+aWu8Zowa2dfpaBB35sAMIdIQifDsYZeibpSPWQV5
         JU7w==
X-Gm-Message-State: AO0yUKU/kQ74OBpC0bkgTVsK+eLZewDKBCB8ZcoTsUplnbK3W0rdrl+1
        q/RsgeOwfFdLT3eBa3VY9S9GRlvomWPEa8ePE3DB0w==
X-Google-Smtp-Source: AK7set+wt7rp+1cILEpIFwYvVl4saH+TpOxvH8a7hVqFk6+SLeAtwsmJrkP7H1j1ZOkGe5o5irDI97UoijSEBGRRa70=
X-Received: by 2002:a67:f749:0:b0:3fc:58d:f90f with SMTP id
 w9-20020a67f749000000b003fc058df90fmr1013119vso.60.1676544946210; Thu, 16 Feb
 2023 02:55:46 -0800 (PST)
MIME-Version: 1.0
References: <20230214134127.59273-1-angelogioacchino.delregno@collabora.com> <20230214134127.59273-26-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230214134127.59273-26-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Thu, 16 Feb 2023 18:55:34 +0800
Message-ID: <CAGXv+5GSTD+9_VwL+PniBGZ1gjt4TrNK3EOpjxeSFiMMmTjzbA@mail.gmail.com>
Subject: Re: [PATCH v2 25/47] clk: mediatek: mt7622: Convert to platform
 driver and simple probe
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
> Convert the MT7622 topckgen and pericfg clock drivers to platform
> drivers and use the simple probe mechanism. This also allows to
> build these clocks as modules.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

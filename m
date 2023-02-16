Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F079A698E2D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 08:57:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbjBPH5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 02:57:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjBPH5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 02:57:21 -0500
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com [IPv6:2607:f8b0:4864:20::a29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FEE5474DC
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 23:56:56 -0800 (PST)
Received: by mail-vk1-xa29.google.com with SMTP id i4so765850vkn.13
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 23:56:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=J+hrs2lAK+lA6xPSkPZh7f/c9FRJJboss5C8HsTnhGs=;
        b=VgoIMVhlFRtACzCN4hRa5+1Xi3pMJaBh96u+PgzGqHoDb9prJ0ayTGydLKG6Hm8wGY
         uMEFLNL07BW38H+oSAENCKGMlLRbEGukgcjjR0+ojtyIt9a5qEblrq1HAYdspZp1cQvH
         J67LUKdKoAl3g6dyDWhm4/20YnUKxGfw3l/Z4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J+hrs2lAK+lA6xPSkPZh7f/c9FRJJboss5C8HsTnhGs=;
        b=PRRyBHNXrSHEib1/3ug9ClO3KPJ/3OxSunAL2RZ2PUv/YwRWLevjx3QrsHqi8p+hPI
         s+054eMBeXHCCqVV1PtOdpCDAIfhGoQBOuyARt4ajqbz2khWSRcYu9D8O2bvzg0fE0ED
         9FpT60sTq1KE2kLpUWROwSg7IAMh+3YZ8eEMOpDMbJ4yMY75I0fDDizljLY7D/OBFdbz
         JVmkpTI5IAzm2dd2fxc2IVP6W9+mq0zTepNXiThVIGFRUHwpmuTtyLfVaStNkMr2aRjj
         K0y63gIAUxeDG1x45IwSDYNLLUQcwK1ixX57fqQqQd0bqLon+FuH6AD38W2GMR3gTYic
         G58g==
X-Gm-Message-State: AO0yUKWP2iPJOqwKNRS+NgZsnLo0BGnlNr3rISMazV05IjY51VdOEeQk
        2XOZZ9EwhdBCZusGw95CVLVcommU3y6lMKbkN8qHPA==
X-Google-Smtp-Source: AK7set8Eqn9R6ofXaO/748ltgZlu/6B9VwxQwEV+syUHvhvMASt7xjoJPSBrlG/SL+2wb0Fic8N+2YfU1QUTcbDeKso=
X-Received: by 2002:a1f:a447:0:b0:3e8:66ce:a639 with SMTP id
 n68-20020a1fa447000000b003e866cea639mr780867vke.2.1676534208435; Wed, 15 Feb
 2023 23:56:48 -0800 (PST)
MIME-Version: 1.0
References: <20230214134127.59273-1-angelogioacchino.delregno@collabora.com> <20230214134127.59273-13-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230214134127.59273-13-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Thu, 16 Feb 2023 15:56:37 +0800
Message-ID: <CAGXv+5HDpAY1=s6966Dzv-d5Qp1XB7F-MkwR6QiHP+DWoznkXA@mail.gmail.com>
Subject: Re: [PATCH v2 12/47] clk: mediatek: mt8365: Join top_misc_mux_gates
 and top_misc_muxes arrays
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

On Tue, Feb 14, 2023 at 9:41 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> In preparation for migrating this driver to the simple probe mechanism,
> join the audio gates to the top_misc_mux_gates array of mtk_composite
> clocks in one top_misc_muxes array.
>
> While at it, since the `apll_i2s0_parents` array is for all i2s clocks,
> rename that to `apll_i2s_parents`.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

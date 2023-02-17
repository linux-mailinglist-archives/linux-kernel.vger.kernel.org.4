Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87DB269A609
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 08:26:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbjBQHZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 02:25:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjBQHZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 02:25:57 -0500
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B72F954D6F
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 23:25:56 -0800 (PST)
Received: by mail-vs1-xe2a.google.com with SMTP id d6so2271958vsv.6
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 23:25:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BHRAZTI5o+dIepaH+DVIh3O3w2k6AHu6HuSzNSZZ51M=;
        b=Eko4ttpHVL1yeaHVnXgT9itW5hX67NJh+/jUqhymVCKYf/deffoul4apjR/ukMEVSA
         AglCf2II8MP9RabSLDu9hJhwe8ak/89aqloZv2/aBhrHeqlSxm2BBSxtyFkQKUAydAsy
         Ssh/dE83khtqThZqiq9waclHTVhUt3PSlf22s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BHRAZTI5o+dIepaH+DVIh3O3w2k6AHu6HuSzNSZZ51M=;
        b=FWbhw3yKKH1SBx1sBJRc2THOk8zMh+Mi2Sbk1HKRjOJIQt8BIVq46DtetSMXzzsllJ
         bmNvHI1R/x25NdAnLQfP2+0v+lQV/gqY3mJdM3N/qPb/6I0fL4gaQf0IHA7pfkglVKO4
         8obRod9uN6xJQM41uw0qTtBCzEpm/fOnJhoY5J0v/1CUj1x1XmvtA4D9eKtcBS/a7kZi
         p/9sWhxjgk6ppsgOmbWNrPy0gRmGfRvMHVIt7FZdbd7CMnED7HKU1MSIe9ar72zRynCm
         8C9OtIEaqdFcwrhI83L+knXZIh5X5ZAsMyJv9BlugHruhfKHV+q/kIkI3mrlkDraaM5q
         OMqA==
X-Gm-Message-State: AO0yUKUZ0FVrU/WorU91mmbYQPaWRJKVsQM23q4h0SroDVmv3qylAxQw
        fExHDxlCZfUks9hJeJsyuLLYn4DibboJDPMHr4o65Q==
X-Google-Smtp-Source: AK7set+op5NKsZfnuTNwqTZsyjzkykGdrpEkYtkLelEWoJ7H0NvKBaaCN/fWgfRlW4RSk414IyvaAmkJ7R5mnd2mMH4=
X-Received: by 2002:a67:f749:0:b0:3fc:58d:f90f with SMTP id
 w9-20020a67f749000000b003fc058df90fmr1598873vso.60.1676618755906; Thu, 16 Feb
 2023 23:25:55 -0800 (PST)
MIME-Version: 1.0
References: <20230214134127.59273-1-angelogioacchino.delregno@collabora.com> <20230214134127.59273-41-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230214134127.59273-41-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 17 Feb 2023 15:25:44 +0800
Message-ID: <CAGXv+5HJx37Yz-8JQscN2=6+yjhrAdUoQUCG8bHjH1=w=srC1Q@mail.gmail.com>
Subject: Re: [PATCH v2 40/47] clk: mediatek: Allow all MT8167 clocks to be
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
> Almost all MT8167 clocks have been converted to use the common probe
> mechanism, moreover, now all of them are platform drivers: allow
> building as modules.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

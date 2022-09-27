Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEAFB5EC4A4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 15:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232695AbiI0Niu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 09:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232091AbiI0Nir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 09:38:47 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3687DC100
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 06:38:45 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id v10-20020a17090a634a00b00205e48cf845so414954pjs.4
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 06:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:mime-version:in-reply-to:references
         :user-agent:from:from:to:cc:subject:date;
        bh=kcqezBbHJffozFbEyx9wjhl1YSdIHaVumsP0lVEuZtQ=;
        b=zu0LDMWaZ2IiyJWen0shu8EVhyMeZSD0OIiKtU1o5V962A7jwSkPn4CMMQ0vz96Vth
         tmuzCaRlrru7doTeuXHFqIBlelgapdbTo80FoYEtNoYoaEZL+RORowAW5TQG758voXAB
         /qK4nyJaMel2BpXPOS+vQr8yEpETmpuh9xmFJL3bbdiLCPx3mFskJioDlySfvlYLDiz+
         5l4LD9rzPtofDwJzV7W1kwC3nRoiXAq20n8O9pp9eXpfcWtVB3QDe/+q+6K/KnMeAnfw
         i0uPy9j1+kZk4vpNwuHSzu0wEoCWjqtwlybaZfNOtus5P9tVWa7xP7C9GRMIprbloz4T
         aSVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:mime-version:in-reply-to:references
         :user-agent:from:x-gm-message-state:from:to:cc:subject:date;
        bh=kcqezBbHJffozFbEyx9wjhl1YSdIHaVumsP0lVEuZtQ=;
        b=g1b4pszllGypC9ECaCbjHAR/jYtjm+EtMlJyYzqNtdPa2mwOIBbPxik+Bd/q0F6vey
         EEV6mhYbHi5BF/covylv5wDDG/ouVKoKvi9DShaBLmSGHKQZc5gpGFp0WgFTCLXLXQu8
         +fxbwQuEdECnUSir/6UqfTLZ8VjG1I3v00L0TLEa2jOwSVXoSGk276PFYj9p5RGa4JBb
         0hPC25nkz8Rm7tOAHiBvGuiqptJww6/ZZEEKJFqSl891eQQ5vmuahy9M6wurBQ3piDn3
         pi/4mIIkCA/7H0y33Eu/jDXywzlc3i6SBpKzozYCTlWJ2/aYsNp45kyM/46uHdxjpR7E
         s/jw==
X-Gm-Message-State: ACrzQf2x6TXL3MZ6FF5LE71k5B39AVXb16Z8BY5/egY04MaeOquP86aD
        a/kqSPsCuqI55KE9YEXa9Y4fbnorP1IzoGOvjij0Jw==
X-Google-Smtp-Source: AMsMyM5rGXrkhuQrQe7LgcjEDdTHK+6y7t6lOaHNCTQ9hNJXjzQRFavvC9zWHs1/i1ytYfodZBY430bKtOUYXAKndGU=
X-Received: by 2002:a17:90b:2643:b0:205:bd0d:bdff with SMTP id
 pa3-20020a17090b264300b00205bd0dbdffmr4550660pjb.99.1664285925438; Tue, 27
 Sep 2022 06:38:45 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 27 Sep 2022 06:38:44 -0700
From:   Guillaume Ranquet <granquet@baylibre.com>
User-Agent: meli 0.7.2
References: <20220919-v1-0-4844816c9808@baylibre.com> <20220919-v1-16-4844816c9808@baylibre.com>
 <11592bcd-eec7-7cc0-86c6-8f440b6af447@linaro.org>
In-Reply-To: <11592bcd-eec7-7cc0-86c6-8f440b6af447@linaro.org>
MIME-Version: 1.0
Date:   Tue, 27 Sep 2022 06:38:44 -0700
Message-ID: <CABnWg9twi6inBOeLY=BOQ+o_CwbSW=L49_A+9VMy0L6vbokhXg@mail.gmail.com>
Subject: Re: [PATCH v1 16/17] drm/mediatek: dpi: Add mt8195 hdmi to DPI driver
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Vinod Koul <vkoul@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        CK Hu <ck.hu@mediatek.com>, Jitao shi <jitao.shi@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-mediatek@lists.infradead.org,
        dri-devel@lists.freedesktop.org,
        Pablo Sun <pablo.sun@mediatek.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Sep 2022 09:22, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>On 19/09/2022 18:56, Guillaume Ranquet wrote:
>> Add the DPI1 hdmi path support in mtk dpi driver
>>
>> Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
>>
>> diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediatek/mtk_dpi.c
>> index 630a4e301ef6..91212b7610e8 100644
>> --- a/drivers/gpu/drm/mediatek/mtk_dpi.c
>> +++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
>> @@ -15,7 +15,10 @@
>>  #include <linux/of_graph.h>
>>  #include <linux/pinctrl/consumer.h>
>>  #include <linux/platform_device.h>
>> +#include <linux/reset.h>
>>  #include <linux/types.h>
>> +#include <linux/regmap.h>
>> +#include <linux/mfd/syscon.h>
>
>Why do you need these headers in this patch?
>
>Best regards,
>Krzysztof
>

reset is used for reset_control but regmap and syscon are not used.
Those are leftover from a previous iteration of the patch, will drop
these in V2.

Thx,
Guillaume.

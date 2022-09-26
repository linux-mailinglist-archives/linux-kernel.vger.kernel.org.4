Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BCE15E981F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 05:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233322AbiIZDCI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 23:02:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233196AbiIZDCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 23:02:00 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3002B2C12F
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 20:01:57 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id dv25so11210169ejb.12
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 20:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=Skd+l8JquKxTkT+d04SuRhlV1yn9RBCkYSqV8apRUX8=;
        b=fMDjGMFeZ+MEZfjBLeXyZXO+5QURbDxXo1FUsSS2j688UXbghiFGIb5sDWVtiLfaTu
         HifASisiYD84FYcN4xahhmp+HSp/Fjyzm68aXl8cTDtA67mLClwfSSukEs6aYvvKicqJ
         DUEZqyaPDMlZkZcP8+NrKcf+0HixlqbnoQch0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Skd+l8JquKxTkT+d04SuRhlV1yn9RBCkYSqV8apRUX8=;
        b=HORJopKSHzupxIU4ahmyS4e0hZ45WMzHiO3fLL8qd3uiJJVZ5UeiZ2CGuFinj12QZn
         9Go+F6KPT/+hDPh+B22Af9JuC7yR1aAhCdKvlkrxKpwyFW6I4PuA0MamOPxsh/dLjflr
         TLQ0hroXZXKOi6a27TuyFiAYSCDI5/jQGgZ5ayGKXqAQJ/DL8kyt7mymtOuSZOJ3Mfm0
         Xz+3vJO8Xf3CKC+Ru7GUNiOV8+QtoNK6ByeaV2rI833NLcrSwQPgczNq+g7UEJKzOxwt
         N0Xy7gDow6EitXPzepqKJfngmHpHlpAJl5mnLTiUb5TzEG7ABupDS2v0go4u1SHtUd0M
         Z/8Q==
X-Gm-Message-State: ACrzQf3EHhf/Ts6g5ycF10f1qy6/kmbXWZRlj4pE4c6Zw/Q/Pbewh+Bi
        R6q5blujxGSdQYlDytKIuwgZfu1PPLXZ5w8y8ejd6g==
X-Google-Smtp-Source: AMsMyM7o8MwQQBDwguXkozM6n/umhwviFw/Nfd+rhMxsOtT2UejSuJCqg8qOL0/MW/9zxPZApsONr4Gwd23XXRSuZkU=
X-Received: by 2002:a17:907:7f93:b0:781:dbee:dece with SMTP id
 qk19-20020a1709077f9300b00781dbeedecemr16459188ejc.323.1664161315561; Sun, 25
 Sep 2022 20:01:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220921091455.41327-1-angelogioacchino.delregno@collabora.com> <20220921091455.41327-8-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220921091455.41327-8-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Mon, 26 Sep 2022 11:01:44 +0800
Message-ID: <CAGXv+5Hr6LYEZ8_3Z07XAVPbbSHZiwjR2QTrv9LdhwpYn35TFw@mail.gmail.com>
Subject: Re: [RESEND PATCH v6 7/8] clk: mediatek: clk-apmixed: Add helper
 function to unregister ref2usb_tx
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        p.zabel@pengutronix.de, y.oudjana@protonmail.com,
        jason-jh.lin@mediatek.com, ck.hu@mediatek.com,
        fparent@baylibre.com, rex-bc.chen@mediatek.com,
        tinghan.shen@mediatek.com, ikjn@chromium.org,
        miles.chen@mediatek.com, sam.shih@mediatek.com,
        bgolaszewski@baylibre.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        konrad.dybcio@somainline.org, marijn.suijten@somainline.org,
        martin.botka@somainline.org, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 21, 2022 at 5:15 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> The ref2usb_tx clock was introduced a long time ago and, at that time,
> the MediaTek clock drivers were using CLK_OF_DECLARE, so they would
> never unregister.
>
> Nowadays, unregistering clock drivers is a thing, as we're registering
> them as platform_driver and allowing them to be kernel modules: add a
> helper function to cleanup the ref2usb_tx clock during error handling
> and upon module removal.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

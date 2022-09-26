Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08EB95E9835
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 05:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233376AbiIZDV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 23:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbiIZDVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 23:21:18 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2237E1148
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 20:21:14 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id y8so7217456edc.10
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 20:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=hFRauekI8mX749A11zabMJwKnZcHcXKuDmO4So8v3vo=;
        b=AixRZnVWOzLnBwZfBtg6on2IFpinSMdiKGTGGn5iUYGSUPE1m3ciQrWBgacohOfZq9
         U71cXJlHnfjd7reOEUfvcUHl9kBuYXKnPwxe4kznA3T3bWB4rtqHA94ugxHWSNSTMvhJ
         pul2qPnhFvHhbaRs4NfMYx2PTEa67sX1Frz+8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=hFRauekI8mX749A11zabMJwKnZcHcXKuDmO4So8v3vo=;
        b=rweSsKbBJNKHCOxSna33R6Dv2XUYO9j+3UypLgLLilA1y8Jw+oGyaSKIs0BXj8qjDR
         TsmgHE745cmu6XYIABi45cP27hra8PMQYffPFLetAKHXUNgsKxXPjHqWfyXMOMyPUVSq
         Ps0dMKNkGNTObtVpoCcfzfS3P0KvmfOOtTM0Ay2vRoVXriQCtsf+Ycm4ISf0zcqhysV9
         jKqGeTQUKKtk/WQiZYlr+RGCDQg4GQegrAb+A6quF79PkZbcDJSNVu7wC5Xr7ZZyFMu7
         CWU0dTIHeABNjE+vpV2qeAAX8V6LQdqToCZ3IHeCT4GH4XSao2QmAOaa6TC4owLcWv/U
         qTeQ==
X-Gm-Message-State: ACrzQf3s5oG66ubjjpENaDStK3JHHD8/79rfZWQn/1wJoI3Ea4aS6E6K
        MyRKLk3b98S2HZwKYNHvV4LGmCbcfGYZ4RbRQdqYnw==
X-Google-Smtp-Source: AMsMyM68ZDwrrQBoFqZZC3KRonbtxs8Nb2DYXYPzyNANDUSJ7C79zpcMAPR6pS/a5apEOFxLB3kTcuzXbEP655raLi4=
X-Received: by 2002:a05:6402:3904:b0:451:f01c:9217 with SMTP id
 fe4-20020a056402390400b00451f01c9217mr19718052edb.78.1664162473029; Sun, 25
 Sep 2022 20:21:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220915072458.18232-1-angelogioacchino.delregno@collabora.com> <20220915072458.18232-7-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220915072458.18232-7-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Mon, 26 Sep 2022 11:21:01 +0800
Message-ID: <CAGXv+5FePqwjXW3A=7qZEayHEKc3JQOm_AFDXNZEJaapHqbxGQ@mail.gmail.com>
Subject: Re: [PATCH v2 06/10] clk: mediatek: clk-mt8195-topckgen: Register
 mfg_ck_fast_ref as generic mux
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     matthias.bgg@gmail.com, mturquette@baylibre.com, sboyd@kernel.org,
        miles.chen@mediatek.com, rex-bc.chen@mediatek.com,
        nfraprado@collabora.com, chun-jie.chen@mediatek.com,
        jose.exposito89@gmail.com, drinkcat@chromium.org,
        weiyi.lu@mediatek.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 15, 2022 at 3:25 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> This clock was being registered as clk-composite through the helpers
> for the same in the MediaTek clock APIs but, in reality, this isn't
> a composite clock.
>
> Appropriately register this clock with devm_clk_hw_register_mux().
> No functional changes.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

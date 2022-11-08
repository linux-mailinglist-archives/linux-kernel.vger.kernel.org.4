Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DF3462105E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 13:22:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233723AbiKHMW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 07:22:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233633AbiKHMWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 07:22:55 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C55A24509D
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 04:22:54 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id f27so38158469eje.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 04:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RNM4SlIpZK/Pvp+Nv1sq/TOqry7Wt2JczmvZLzER8lQ=;
        b=pmXu4BS5etWADJtDE2P7kY49YRZFXqqdzWrt9of2mDSdjOSG/RmeYs97cGlrY79FVH
         a58theOcmE/N/jiQP7QKeBXgc6W5rZ6WB/WDto0WYEOfqox3i1x/fqYRrdC7MnRkDJeh
         78rPUEhwgD1B2TA07imvz4c6favbeAAE04VpfRIzzKbqnGB/IViZCTrTqkiLEJfkve7T
         UDqZXLz7KOEMiVVy/9XniDn4rtzP99uzSz0+B+rwXTMiN3IAEW13Xs1az9JJ6KwLcTbG
         FXVsSTmOtwDsL2p/xsDPoUuiHN9EfTizM9KB+/vDpkSz2fkxuIaXtKBDCbqUop2dbsiw
         NxHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RNM4SlIpZK/Pvp+Nv1sq/TOqry7Wt2JczmvZLzER8lQ=;
        b=AgtRLy8RS22OyrYBvSZePs7DURSfijjEMseNjbh1Zd0QCyqpsFG4sVFe7DFwAoO4e2
         frUP6T0FusGIBAhwAbGKaE1AX0iTty5z+JojYmRVkk4uuBNRoLg3tl1FDzg7oxzxY7kD
         onWW9TcPiSMvT5ti/kedXqiiTyRPg9ozZyLh9rURRoyZ2seGuYKIa1XG0HrQ+y2oX6iF
         NalxMG9QtD24nV8BPzYJt2f7/qtq8XlYEEu1akwUsK4KALzaJjvG+GN09He8imC2M8Uu
         spBKeP3s7ormyiUBDCQxC8aKyOu/5SrlmwVsbfxGrLcDhdcuBMC8OUy5GFTseA2idNMt
         knkg==
X-Gm-Message-State: ACrzQf1VWCAdzKrvQfzRniQkPIzCbxeLTqHRTlB2WpQG0mBEZuy4fqaT
        IqTxPzV0I4f4dbo/Www8/kN4T+clGLar4YTEEynoyw==
X-Google-Smtp-Source: AMsMyM5DWRrNDglgUtSRjboVATNg6viDXKYxNq5T/teuA30XG8xW8WBMihboBMWWlbMxHmCHS7MFaCZeJDEqcy+LEds=
X-Received: by 2002:a17:907:c1e:b0:7ae:31a0:571e with SMTP id
 ga30-20020a1709070c1e00b007ae31a0571emr20898444ejc.690.1667910173413; Tue, 08
 Nov 2022 04:22:53 -0800 (PST)
MIME-Version: 1.0
References: <20221028153505.23741-1-y.oudjana@protonmail.com> <20221028153505.23741-6-y.oudjana@protonmail.com>
In-Reply-To: <20221028153505.23741-6-y.oudjana@protonmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 8 Nov 2022 13:22:42 +0100
Message-ID: <CACRpkdaVxm3gwrwWg6Ni5W1Xx-k8cy9mE97n2bGvZDxum7DSKQ@mail.gmail.com>
Subject: Re: [PATCH v4 05/13] dt-bindings: pinctrl: mediatek,pinctrl-mt6795:
 Fix interrupt count
To:     Yassine Oudjana <yassine.oudjana@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        Andy Teng <andy.teng@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2022 at 5:35 PM Yassine Oudjana
<yassine.oudjana@gmail.com> wrote:

> From: Yassine Oudjana <y.oudjana@protonmail.com>
>
> The document currently states a maximum of 1 interrupt, but the DT
> has 2 specified causing a dtbs_check error. Replace the maximum limit
> with a minimum and add per-interrupt descriptions to pass the check.
>
> Fixes: 81557a71564a ("dt-bindings: pinctrl: Add MediaTek MT6795 pinctrl bindings")
> Suggested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Patch applied.

Yours,
Linus Walleij

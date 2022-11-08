Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 774F862104F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 13:20:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234189AbiKHMUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 07:20:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234194AbiKHMUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 07:20:47 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F0F029C84
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 04:20:42 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id m22so891067eji.10
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 04:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9L32CqPO5tpdtIdmdwuItDbHeb4WCU0OCUvAkL0z1s0=;
        b=PaH8zVNZFaWxZkBeTqFrrlAIn52Z6ALOySEFQbN+48YB7eswuhqFfbwMqDBq2GsSCR
         jNyGe3sfw9BsM3W78ySx+zpEwrY2gFRB+rnPJkIorUoFeKXDAokh8dE40JpXipGkbuPy
         RB9f8UlJcTdmz0I9lVinKLHKT4idjh8iIgQU/viUJUMSJI1RczuQ768aebjuYJ+Djd/K
         F22AwkMtR7jLfsJnJf0VmYF5W8lEah7PeJ+/RynLIY+zXK5/8BSsT/5YIW2ELhBGAIwq
         jD3Ar6khX4wA/0taPM3wyTh49EynpnfsTOmVdiv2KirYhA+1gxwCIOHhj5kWnni0ft0X
         j60Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9L32CqPO5tpdtIdmdwuItDbHeb4WCU0OCUvAkL0z1s0=;
        b=ot2+JQKPgdLgP7G1RbJ07By0XW4+rFYMe1nYiD/bV+o6BD1BxV1rcqrmtFTQwxK9OG
         eqNmu20ZmjhMpKjqVSCmw7oQ1FGkxxCSNE7yNahWGW8m7Qm71VQJQmiqgrCl4SwZaVWA
         uf6uPEykdyOIWWolgWl2jdAneN+qunFXousaZthY9HGOkbUeihcA9yVUuIWVXTdPa4Au
         FEGO2zWLo1VTKQN8wclYpvePs5trW6uaAP0cnQyVqORbQYXHgKUxoRaZZ/lNN328RDLt
         TlL2WrG0MKe2AFIpJknHKOFX4iGx8/3i8f9Gz3jAfCo763Ba7UrLQio9bxNMrm4gbCDz
         WTJg==
X-Gm-Message-State: ANoB5pn0LXdn65Xt9pNUhTzRXDTG6pIMMoloMGCNxbqgyEyGbdRo6Tue
        vK+sMB7HVGLXKPRwaEgsjfrUMpgQ9EfYLYl3QTsZSC4I464=
X-Google-Smtp-Source: AA0mqf7E/HvXj5m2jiuxDKBMSeyESiNXwJ8GfekmAZnuir2VaYGD+S+2Vjc6wyIWXX54igq6ImLmaPPOUbp/cZQLOjc=
X-Received: by 2002:a17:906:6acc:b0:7ae:658c:ee45 with SMTP id
 q12-20020a1709066acc00b007ae658cee45mr10905848ejs.190.1667910040934; Tue, 08
 Nov 2022 04:20:40 -0800 (PST)
MIME-Version: 1.0
References: <20221028153505.23741-1-y.oudjana@protonmail.com> <20221028153505.23741-3-y.oudjana@protonmail.com>
In-Reply-To: <20221028153505.23741-3-y.oudjana@protonmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 8 Nov 2022 13:20:29 +0100
Message-ID: <CACRpkdbXKhTXNrxUmoFjuO6rmwb-8+seaj-L9ZcHpdFUuYp_Dw@mail.gmail.com>
Subject: Re: [PATCH v4 02/13] dt-bindings: pinctrl: mediatek,mt6779-pinctrl:
 Improve description
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
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>
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
> The current description mentions having to put the pin controller
> node under a syscon node, but this is not the case in the current
> MT6779 device tree. This is not actually needed, so replace the
> current description with something more generic that describes
> the use of the hardware block.
>
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Patch applied to the pinctrl tree.

I am checking how much I can just apply so we get down the
depth of your patch stack.

Yours,
Linus Walleij

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D78A062105B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 13:22:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234195AbiKHMWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 07:22:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234205AbiKHMWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 07:22:12 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA1A51C1E
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 04:22:03 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id u24so22126206edd.13
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 04:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pwAIz5YfCHExcR//d2Cu4bwUY83DjgUJ7OTx4aGy0bY=;
        b=rRtHApUTLpmrb49VLXgA8lhpuLIaEa3606cZ54m2fuII2W/So0ITWAFEOlZ4VuODIp
         Y1H7bruRbTk/hT6r332Bqpy8CALuz4SrqJDFgAJbiafdnlD2qSNL4JEt3+uPYsEauc4q
         IJrPM50qDhnfdQUOP2RtMMkVr+RJ+6l9aY/Z6P8K47uU3TuE0Vl76mWT5HD+CQyLB9Px
         +LhD4z36nZDK8oVfJwJ8tNZ7A/MmL46f5Hjvagt7FRY8BLsHcxIVLeayMxhvMvZlJBnm
         iSxKSJLnrAJDXMGoJAp9cdhSWAGePaD9PgLbQuD1A4qIIY1j3R2pRC5qvqi1vc7oX5WV
         xDNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pwAIz5YfCHExcR//d2Cu4bwUY83DjgUJ7OTx4aGy0bY=;
        b=tHBZt8Zu0taRy2L5DxPz5Lt4ssVMjwCrN65wRQ8pb2Nxk+opZ4LOkLwqnwsrB+WDOn
         Os2PKuRL+1D+alpGefNvleDSYnL2IZJkPyw651ie4jvhHnUiN03QrHEgC6AV3AfOU/I+
         MtPFaUYvDHmolDvMKCeUg0oj89Yutgz3LBtMFhSywajse+2IFpau5hHNqRccG0pvF5xj
         4GyXsQQ0nW2VoFxxyD1AcmaKUM3GEAi0ipUqJJNmE5z/NwLHP+Nqsm89t94R4DWAw/wj
         LaRTsxpEi0z/88WBDCowOLP84qAEyxLU2cVcgpPRYeaBddMJAFyzH+oVofHevMwgPHgX
         MVzw==
X-Gm-Message-State: ACrzQf2W9Fta3SIP/lHdJZXx9iWQtuXEZ8A2JOS9rosv3sSJ43bbvqJO
        cwP/Bcuaph2iD3Mi7xuCRD4ERAzxCoF9vJTOUvDaWw==
X-Google-Smtp-Source: AMsMyM6Fgdh9c+uQFDawnv1UbeThmCU3kZMq94IY+4QXNwDLtyC7UETuZQ23UkDyD8Oirb1FDA8qn/LXTheGxCkZ8CI=
X-Received: by 2002:a05:6402:659:b0:463:a83c:e0af with SMTP id
 u25-20020a056402065900b00463a83ce0afmr900244edx.158.1667910122493; Tue, 08
 Nov 2022 04:22:02 -0800 (PST)
MIME-Version: 1.0
References: <20221028153505.23741-1-y.oudjana@protonmail.com> <20221028153505.23741-5-y.oudjana@protonmail.com>
In-Reply-To: <20221028153505.23741-5-y.oudjana@protonmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 8 Nov 2022 13:21:50 +0100
Message-ID: <CACRpkdbquWk3F=3CrkSWfWkWFQpzRPPbE3nL+zcuBx57aW4WYA@mail.gmail.com>
Subject: Re: [PATCH v4 04/13] dt-bindings: pinctrl: mediatek,mt6779-pinctrl:
 Add MT6797
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
> Combine MT6797 pin controller document into MT6779 one. reg and
> reg-names property constraints are set using conditionals.
> A conditional is also used to make interrupt-related properties
> required on the MT6779 pin controller only, since the MT6797
> controller doesn't support interrupts (or not yet, at least).
> drive-strength and slew-rate properties which weren't described
> in the MT6779 document before are brought in from the MT6797 one.
> Both pin controllers share a common driver core so they should
> both support these properties.
>
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Patch applied.

Yours,
Linus Walleij

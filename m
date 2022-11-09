Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DED5622598
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 09:38:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbiKIIiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 03:38:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbiKIIiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 03:38:17 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51AEC13EAC
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 00:38:16 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id ft34so8411495ejc.12
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 00:38:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=d0zbHYyI3ZOuc2iT4mRqGhJVf4w/uy1L6RiWzNixdzw=;
        b=QrtU63vqfuqIUrQ3kqQMZWDy6vEsvVjHcjlVfUpLrx71617/qp3+ZFH8CMJSjf68RY
         +RjQ58WQwSFw0FwaLRDMYCnnUNRozzE1/YVI4NobW/pkJwjJrMZQUTeYGBYzcotESyh5
         Ca08RMViWNc+ira8id0Qjg8IFx0Wt0Dr57vyJg+7TnxtJT+pRkAxFZ2FlfGCgH7M8ZlU
         ZqnjqMfpGNIudoOGIWluVanbb0krGGvBJjacfqUWHAdhQZinTFyWsu55WLCWb5QTOQ4t
         RscWB9DKYT8v1QIgs6rT63do3pmbdmfk6+Kpc3Dn4RZWK5wrAkFAdE1L6jq5rmAtS2Ra
         3Utg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d0zbHYyI3ZOuc2iT4mRqGhJVf4w/uy1L6RiWzNixdzw=;
        b=x18rOrACNCVPs4U7OjgY4On0/uStMm+1k9rb3wxws71whBLS23BJ5Wi33XrTVvTdod
         E6Jipcr7oL/GOHjK9qjgNdGDOAw9dcEdullXbCQATMUw2yYg6jsV+Cc3xBIzcLgYmz6f
         lr+4eaJ9bO208k3DS1WPcz4epnUp7pw28gqDpb5TCjh8xhlAj1Meg7E2WWcBcoAWnrer
         yvlgyCAxJ1IZfISSBsWmjhK9OGv7dog7uoygmEKTsweeBW5U2AMLHLL74h5mBxII2kvY
         CBL7uxh20+ZPdfVPWTpube9DHmFswFZoNCaCxB3ASx46HFgFKr5K6vN7Lqmpae9AW7VV
         +TPw==
X-Gm-Message-State: ACrzQf1MpQUXTYhH/qhoYGRmszSIbwbMzbxqzMt0W9+GSDIresmjKE0+
        3J78to9Vf6rdopzG83hJQbF71dqRks0uBg/T8iWiww==
X-Google-Smtp-Source: AMsMyM791qMulyNHY+wAqFSetNq8SvPUdo/dK2HW5kOtjxO8R3MbKqGDnl96Qe5xE0gDRsx6zbRmaL1YlM970Fgq/bI=
X-Received: by 2002:a17:907:c1e:b0:7ae:31a0:571e with SMTP id
 ga30-20020a1709070c1e00b007ae31a0571emr24177907ejc.690.1667983094822; Wed, 09
 Nov 2022 00:38:14 -0800 (PST)
MIME-Version: 1.0
References: <20221105084905.9596-1-linux@fw-web.de> <20221105084905.9596-2-linux@fw-web.de>
 <166765939131.4158830.8416727494529058690.robh@kernel.org> <trinity-c732b826-2a12-4ab1-aaac-294ac5524926-1667660774779@3c-app-gmx-bap26>
In-Reply-To: <trinity-c732b826-2a12-4ab1-aaac-294ac5524926-1667660774779@3c-app-gmx-bap26>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 9 Nov 2022 09:38:03 +0100
Message-ID: <CACRpkdZsP-aj6hcD2sOB8ypVqdxwC8dWOo0d52qnDpxppUwNAA@mail.gmail.com>
Subject: Re: Re: [PATCH v1 1/4] dt-bindings: pinctrl: mt7986: add generic
 bias-pull* support
To:     Frank Wunderlich <frank-w@public-files.de>
Cc:     Rob Herring <robh@kernel.org>, Frank Wunderlich <linux@fw-web.de>,
        Sam Shih <sam.shih@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sean Wang <sean.wang@kernel.org>
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

On Sat, Nov 5, 2022 at 4:06 PM Frank Wunderlich <frank-w@public-files.de> wrote:

> > Gesendet: Samstag, 05. November 2022 um 15:52 Uhr
> > Von: "Rob Herring" <robh@kernel.org>
>
> > yamllint warnings/errors:
> >
> > dtschema/dtc warnings/errors:
> > /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pinctrl/mediatek,mt7986-pinctrl.example.dtb: pinctrl@1001f000: mmc0-pins:mux:groups:0: 'emmc_51' is not one of ['emmc', 'emmc_rst']
> >       From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pinctrl/mediatek,mt7986-pinctrl.yaml
>
> this is already solved by this Patch:
>
> https://patchwork.kernel.org/project/linux-mediatek/patch/20221105092500.12145-1-linux@fw-web.de/
>
> i decided to send a v3 or if instead of including it into this series

That patch in turn says it needs another patch first.

Now I am utterly confused, it is really hard to follow these trains
of patches depending on and breaking each other left and right...

Can you please tell me which patches I need to apply and
in which order?

Yours,
Linus Walleij

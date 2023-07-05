Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25D897481C1
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 12:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbjGEKKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 06:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231384AbjGEKKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 06:10:21 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB62BFF
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 03:10:20 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-c2cf4e61bc6so7657065276.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 03:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688551820; x=1691143820;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S5BiZxAdo175caCNPuZri1kWZT7Qvo2b/jAKdwh4fGo=;
        b=OfyRAr1XW7hQ3Ug5ZYV83RPlh+OQjY+hZNUlo7TXuEAiE62322BbU2bzpy3jeDrn+O
         sOHHB8tlEdgWtyhJH1G1KfEBI8Myk45vygP4UCFwK+jqZBC6bK00Lhq8ZDeFzStzOUhL
         6+8iiOlPePTBoX/A5Z3ad9IvmVebeBa3k1UMzviqOxIqabHwgApVAvr9rxb1nCunAp0N
         KYcg2t7wqpbkN+SOaW+6BSdqqJAPbUeVZWRl4KhQ0cfqmdzofbSgnNzehST4aw+vel/Z
         zE1uF6JjFzyxrD9B/X0b+pmMZtrseJpyUBVAwc8+XOcTpyuCY1CvXJ3ei5UE3xb5y8Jl
         ATIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688551820; x=1691143820;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S5BiZxAdo175caCNPuZri1kWZT7Qvo2b/jAKdwh4fGo=;
        b=jezwKVeavAC1q6yUH0g+d5eYK36TPGWw/DmdMUnt5P3jB5FXQZbAq77eacfFOmTn2y
         wzsW+7+fYTtaSKK8IVU5WZQq8D3ySMe7PtRIGHQc66s+WUgP/rUrPB2LOw0baXVJxWCO
         ejU3k0uhz9V8Rk0+nyeu4RZXX57xIkAFR809U28KX9ZWH8LKX/xsakHiIKSY843S3LDQ
         9VRqIMKQlJtnXW2jnlHqNhm3Q1Oauaux3TGKpiP2sCmlyobqNgBjWW4Wxc8h0CdR2P0a
         AXjsAjE4ZZX/JgOsV3KbEiAXmXSAL2rqO/nvA3LSGAqbqBg11lHsWgLIYrsuKuyzd/6Z
         jLQQ==
X-Gm-Message-State: ABy/qLZuT0FhyQJffAxLlBNOkAVgWJZ8be+Mo8o2EBCoStpha+WARCbp
        8pCYr/52fw3hV8+wJq0RseVddXMvOw9DLc4Sc44zpg==
X-Google-Smtp-Source: APBJJlE8B6kTceIEY/HjSKPVfI5dkey3d/+conMUwS2ilyTvOTa/wNNq2saaTt+P5NoFmmRDanVQ3M4oLG7R+EgRgwo=
X-Received: by 2002:a25:3621:0:b0:c65:1369:3f6c with SMTP id
 d33-20020a253621000000b00c6513693f6cmr184700yba.16.1688551820039; Wed, 05 Jul
 2023 03:10:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230506-seama-partitions-v1-0-5806af1e4ac7@linaro.org>
 <20230506-seama-partitions-v1-1-5806af1e4ac7@linaro.org> <96c63925-91d5-994a-a531-2d7bdb3b642a@linaro.org>
In-Reply-To: <96c63925-91d5-994a-a531-2d7bdb3b642a@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 5 Jul 2023 12:10:08 +0200
Message-ID: <CACRpkdY5p9jVO0iyGhi7GACY+hBQ6a7OdoJ3W9hg22aUeNMvkA@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: mtd: Add SEAMA partition bindings
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 10, 2023 at 4:57=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:

> > +select: false
>
> You miss update to partitions.yaml. Anyway, for your testing,
> temporarily change it to true, to see errors.

This "select" just confuses me. I can set it to true and then I get
a flood of irrelevant errors, and the same if I change it to true for
any of the other childless partitions such as arm,arm-firmware-suite.yaml

So I do a best effort here...

> > +properties:
> > +  compatible:
> > +    const: seama
> > +
> > +  '#address-cells': false
> > +
> > +  '#size-cells': false
>
> You have children, so these must be true.

Not really, seama is childless.

I guess the example with fixed-partitions
was confusion, seama can be a subpartition in a set
of fixed-partions.

I'll try to write up something so it's clear.

Yours,
Linus Walleij

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E73A652FC7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 11:47:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234512AbiLUKrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 05:47:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiLUKqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 05:46:50 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 465D31A23B;
        Wed, 21 Dec 2022 02:46:49 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id a25so6569141qkl.12;
        Wed, 21 Dec 2022 02:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DNRS4XaCIr+pNxI0B6D9MO5nBjIMTxhyLlBWRC8jTtg=;
        b=S8Os2Joe8RDvk2V6E2MGGLoqLntI2mMHmuEybFVJNoVHzWZbW9dC7vqg6sI9Y5btYf
         px59axccSQV2bZa0K2uz/mh6Xwjq63L9deCfZW0f+8zWkuMHzjKGwN+wqw5jU6QzMfRQ
         g6vCwZaqaiRvgzMRHikIhZ9xLVlrZXw/8QWjVcCnPiygimu8OWBRk0+bCjCR38g8gZoI
         i4kxMAO7Qs+z4chydFCmXZnxqkpfyebP/MZTAMJbuGfH3b17OY09C/Z4quubPJQ2vMnw
         IsNMdJCeS50+5JTmb+tIpAVREUshqaSRMFhJ4xJtYfoWnsZkUPKraR4kjzMoxm4eBqVM
         pBaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DNRS4XaCIr+pNxI0B6D9MO5nBjIMTxhyLlBWRC8jTtg=;
        b=tI2C9HgYUZ6hd5MwCbSDT82mU3Wql5IBy3CHlweAzCrwf6eA8SZNwKm65kOEfGJdfu
         oVYynt+Xnc6yE0V/f238Bdvi47erxsEw8jvDnRCUiG9LJV70mHwI3UAtNnDPfrp+n8T9
         JU0oNdf/7FfeLSk47H4XojGEMRai2iMBEp7ePS7AR/jpfg5+ZnDx3e6JzjSYf1SsCb/5
         fx7LexG+lEkawTq8lgm3KK/8QqaEZ4UpY1EQU/KEqQL/BO8VzITGhW57v+byD9rZsRAe
         d9EA6LbefEVe6j/yirddLv8uqDJ6TEaXB5h0axItO0hn7m21YzTov/G24cK0AhS0fBsO
         cInQ==
X-Gm-Message-State: AFqh2koRdRlIk4knqZPxujUpsuK6nWsJsHhYbHe9bdo6YSNWyVfbXVci
        /VJPQzT+S/V363HNy5MN0yAf8WwpcTICXLOe/q0=
X-Google-Smtp-Source: AMrXdXtD5yxdeFw1QyHVaqgmf2rjXRA/KYamX6ZaftevXCzSpQC1KNQ0AGWes4jvtuAaq355TtF0VtN70rqTJVRaUDE=
X-Received: by 2002:a05:620a:13e9:b0:6ff:b886:54d3 with SMTP id
 h9-20020a05620a13e900b006ffb88654d3mr33992qkl.383.1671619608339; Wed, 21 Dec
 2022 02:46:48 -0800 (PST)
MIME-Version: 1.0
References: <Y6KfFEChA67E7oX/@VM-66-53-centos> <5a7907e3-f79e-5de9-ed1b-ec24ea52c437@linaro.org>
In-Reply-To: <5a7907e3-f79e-5de9-ed1b-ec24ea52c437@linaro.org>
From:   ty <zonyitoo@gmail.com>
Date:   Wed, 21 Dec 2022 18:46:36 +0800
Message-ID: <CAMmci2UgwqDyPPJXwGRsMW1Y1Cy2c6LMybk+7v7pGz-LtYzGTw@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] dt-bindings: arm: rockchip: Add EmbedFire LubanCat 1
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, DHDAXCW <lasstp5011@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Kozlowski,

Sorry that we didn't fully get the idea in your previous comments.

>
> On 21/12/2022 06:52, Yuteng Zhong wrote:
> > from: DHDAXCW <lasstp5011@gmail.com>
> >
> > LubanCat 1 is a Rockchip RK3566 SBC based
> > is developed by EmbedFire Electronics Co., Ltd.
> > Mini Linux Card Type Cheap Computer Development Board
>
> This is a friendly reminder during the review process.
>
> It seems my previous comments were not fully addressed. Maybe my
> feedback got lost between the quotes, maybe you just forgot to apply it.
> Please go back to the previous discussion and either implement all
> requested changes or keep discussing them.
>
> Thank you.

Your pervious comment were:

> Please wrap commit message according to Linux coding style / submission
> process:
> https://elixir.bootlin.com/linux/v5.18-rc4/source/Documentation/process/submitting-patches.rst#L586

So I think there must be something wrong in the message but I didn't
notice. This message has a `from` line, and the body was wrapped at 75
columns. Please help me make it better.



> >
> > Signed-off-by: Yuteng Zhong <zonyitoo@gmail.com>
> > Signed-off-by: DHDAXCW <lasstp5011@gmail.com>
> > ---
> >  Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
> > index 88ff4422a8c1..84d39a3a8843 100644
> > --- a/Documentation/devicetree/bindings/arm/rockchip.yaml
> > +++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
> > @@ -781,6 +781,11 @@ properties:
> >            - const: rockchip,rk3568-bpi-r2pro
> >            - const: rockchip,rk3568
> >
> > +      - description: EmbedFire LubanCat 1
> > +        items:
> > +          - const: embedfire,lubancat-1
> > +          - const: rockchip,rk3566
>
> Here as well.

This change was addressing the previous comment in V2:

> This is separate patch. Does not look like properly ordered. Don't add
> stuff at the end of files/lists.

The previous PATCH v2 merged changes in 3 diffent files:

1. arch/arm64/boot/dts/rockchip/Makefile
2. arch/arm64/boot/dts/rockchip/rk3566-lubancat-1.dts
3. Documentation/devicetree/bindings/arm/rockchip.yaml

What we do in this PATCH v4 was separated the 3 into a separated patch.

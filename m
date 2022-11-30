Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76D6163D92F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 16:21:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbiK3PV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 10:21:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiK3PVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 10:21:25 -0500
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C354B7CA90;
        Wed, 30 Nov 2022 07:21:23 -0800 (PST)
Received: by mail-oi1-f176.google.com with SMTP id h132so19081705oif.2;
        Wed, 30 Nov 2022 07:21:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jVQsDWcty0W2Sq3nzrlgytjKBwc4zZnmbfaiPfq+nVo=;
        b=sPVQe51VhxlKVi4cY2Tp79XDYptLoVcas5tEEJT/oetjnev6B5V6PXLPQXh0hokdIz
         Uny1HZEH8p/aktoNGK+NIhRZZi2BIQ9arItmpA51XQm6eRoVPp83m4/L63HBj64o3ji5
         JCCgf5Zko+IAk+bGM14puTUywcXR12fK032QWqvVqiw9uT8PPr0c4JP/P8ehW7uwGgkg
         nQmQ31+SIDUgASrh5u5EVJR4KiAKoPcl2ZawcJdAahtU0CWLPCRSiL3pwIgUkUiVZz8y
         XRmwXyxyuB70I6dS0T2a3+pzC0BtlrCc8AG6/WZ+yTvXdMKKMU/pT8UbDninC1C+BreE
         RuWQ==
X-Gm-Message-State: ANoB5pkNbtvyJxufDnwat9TNHiqb4c9qUXA9XvuhgsjDUK4PDXzHzjvt
        j5oeyELZ/B9U0JKZgo3XmQ==
X-Google-Smtp-Source: AA0mqf65tQ4bkkhQaj1hxke0tTpmLkf950uZWJtVKxOL1U2in72mGuD1bFpfr9voCXJ+TYxNV6FmiA==
X-Received: by 2002:a05:6808:3009:b0:354:94a6:a721 with SMTP id ay9-20020a056808300900b0035494a6a721mr20928808oib.194.1669821682842;
        Wed, 30 Nov 2022 07:21:22 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id q204-20020acaf2d5000000b00354d8589a15sm707667oih.45.2022.11.30.07.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 07:21:22 -0800 (PST)
Received: (nullmailer pid 2188909 invoked by uid 1000);
        Wed, 30 Nov 2022 15:21:21 -0000
Date:   Wed, 30 Nov 2022 09:21:21 -0600
From:   Rob Herring <robh@kernel.org>
To:     Yassine Oudjana <yassine.oudjana@gmail.com>
Cc:     Sean Wang <sean.wang@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        linux-kernel@vger.kernel.org, Andy Teng <andy.teng@mediatek.com>,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v5 2/7] dt-bindings: pinctrl: mediatek,mt6779-pinctrl:
 Improve pinctrl subnode and property descriptions
Message-ID: <166982168101.2188848.5173435934071756334.robh@kernel.org>
References: <20221118113028.145348-1-y.oudjana@protonmail.com>
 <20221118113028.145348-3-y.oudjana@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221118113028.145348-3-y.oudjana@protonmail.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 18 Nov 2022 14:30:23 +0300, Yassine Oudjana wrote:
> From: Yassine Oudjana <y.oudjana@protonmail.com>
> 
> Change "subnodes" to "subnode" in subnode description for better grammatical
> accuracy, capitalize pinmux description, wrap all descriptions at 80 characters,
> and remove literal style indicators from descriptions that don't need their new
> lines preserved.
> 
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> ---
>  .../pinctrl/mediatek,mt6779-pinctrl.yaml      | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>

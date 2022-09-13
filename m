Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C78A45B76DD
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 18:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbiIMQxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 12:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231648AbiIMQxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 12:53:03 -0400
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BFA7C00CD;
        Tue, 13 Sep 2022 08:46:19 -0700 (PDT)
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-1225219ee46so33222271fac.2;
        Tue, 13 Sep 2022 08:46:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=jvR+5cYBN/jmH4LHizAk50e3xiA5DYoi3s75z6jiRMY=;
        b=XhmX0fzckttRJfJqO6YPAeblaJtyNw1d23vfcNCoG2DgZDF+wE9qW4GZJ0c2viEoKj
         s8OBXRxR1AqqHyBcPxDxcGJb+uf+PtDjcstZeDaHskl6H3Hmoh2p83G7cINHBWp3XpqV
         8Q2o7m2T3BbTdJtjC9USlCO0zDOic0z0CSOcC5PfHfpyLUxpqwoXpy3PlocuTlMQJR5s
         Flwf09pQDCdKrYbwHwSYR9XHWcN4KxjxdyZ9kBIcXo9G5LS65y4Mk6R9cJ5el6Js69Ch
         YqfIw6s0VDcBglbKExww5tcSthHSiER7jlOqALYxXRVNuN3kHBTFkfv2EJBesghyA4Jh
         oT/g==
X-Gm-Message-State: ACgBeo2MzH06Xb8c8345bYka1KtMa0S2OkF6gXZUpfl5K2rzG3MszL0l
        K/Vc0NzmAZtvuu/yOi9ZeQ==
X-Google-Smtp-Source: AA6agR4JV7aKGKcSsm/3hcxmvaWfyHewMBq/2OdrrF0X9TNee1VdFTzf2OpU9JWPH89OowjsDjeoJA==
X-Received: by 2002:a05:6808:1441:b0:333:3929:d079 with SMTP id x1-20020a056808144100b003333929d079mr1859152oiv.21.1663083908038;
        Tue, 13 Sep 2022 08:45:08 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r196-20020acaa8cd000000b0034fd36e95bfsm1733767oie.31.2022.09.13.08.45.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 08:45:07 -0700 (PDT)
Received: (nullmailer pid 3793676 invoked by uid 1000);
        Tue, 13 Sep 2022 15:45:06 -0000
Date:   Tue, 13 Sep 2022 10:45:06 -0500
From:   Rob Herring <robh@kernel.org>
To:     Peter Chiu <chui-hao.chiu@mediatek.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Sam Shih <sam.shih@mediatek.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ryder Lee <ryder.Lee@mediatek.com>, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sean Wang <sean.wang@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2] dt-bindings: pinctrl: update bindings for MT7986 SoC
Message-ID: <20220913154506.GA3793619-robh@kernel.org>
References: <20220912092440.21011-1-chui-hao.chiu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220912092440.21011-1-chui-hao.chiu@mediatek.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Sep 2022 17:24:40 +0800, Peter Chiu wrote:
> Add wifi pins in the description and set 'maxItems' for groups and pins.
> 
> Reviewed-by: Sam Shih <sam.shih@mediatek.com>
> Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
> ---
> v2:
> - Set 'maxItems' for groups and pins.
> - Update commit message.
> - Remove '$ref: /schemas/types.yaml#/definitions/string-array'.
> ---
>  .../pinctrl/mediatek,mt7986-pinctrl.yaml      | 48 +++++++++++--------
>  1 file changed, 28 insertions(+), 20 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

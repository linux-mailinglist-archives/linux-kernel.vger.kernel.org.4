Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA105FC87B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 17:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbiJLPgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 11:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiJLPgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 11:36:35 -0400
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35621D9978;
        Wed, 12 Oct 2022 08:36:34 -0700 (PDT)
Received: by mail-oi1-f169.google.com with SMTP id j188so12496649oih.4;
        Wed, 12 Oct 2022 08:36:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n5lptyW3ie5pClcDGn5r9fNjFpkWHmTzbf2OcN0VuAU=;
        b=mCkEIB+J+Ljz0kUI9auglrJwIkJm74kgGhA8UUHrgOdLu8Q7uT8OZTpMBfUoVhyUfg
         DUiAzb5HEKY+4ntFmsSirnGlzBZQ/eGTHTiTt/90TKEsDMmKiXK6Dfch1OLJ3McikDD+
         2UEMWiUP6DqMTw1mRHFwkEfESobi5Fx+0bX6c71DABLmy7PNZK+nB9+NX6RboDP4uHyp
         fAbfBkrFGvUuaYLJbuA7FVlb40NNUzjMvzASkrgYZqKyiHH40lgUyUDOp46pbzSotL41
         H+MQTBBBRERrj4cRu7h/kl6CA/iAsCU9iA+Fe004g7ZNX3jlcwtman9X7C7TmzEezBut
         0sAw==
X-Gm-Message-State: ACrzQf0rPn5MzUGi3gDoW3rB9pXHENSsJZtMXgxuMk6Zp6js1tx7NFU0
        I61Xh+C6nuTbkQpiRL+H0g==
X-Google-Smtp-Source: AMsMyM7YihuyUnIzLG6/okwQkls3Kbv8bMnGi6YmV46cxfr/5CDfSMZlI0ueMUzM8VQx2RPDXUmARA==
X-Received: by 2002:a05:6808:1487:b0:354:923c:bc7a with SMTP id e7-20020a056808148700b00354923cbc7amr2454582oiw.145.1665588993393;
        Wed, 12 Oct 2022 08:36:33 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id a28-20020a544e1c000000b00339befdfad0sm6746011oiy.50.2022.10.12.08.36.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 08:36:32 -0700 (PDT)
Received: (nullmailer pid 2164100 invoked by uid 1000);
        Wed, 12 Oct 2022 15:36:34 -0000
Date:   Wed, 12 Oct 2022 10:36:34 -0500
From:   Rob Herring <robh@kernel.org>
To:     ChiaEn Wu <peterwu.pub@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        lee@kernel.org, robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        chiaen_wu@richtek.com, matthias.bgg@gmail.com,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        krzysztof.kozlowski+dt@linaro.org, cy_huang@richtek.com,
        sre@kernel.org
Subject: Re: [PATCH v3] dt-bindings: mfd: mt6370: fix the interrupt order of
 the charger in the example
Message-ID: <166558333754.1988433.10175192101178879616.robh@kernel.org>
References: <fcf4e7e7594070a8698dc0d4b96e031bcaa9b3a3.1665585952.git.chiaen_wu@richtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fcf4e7e7594070a8698dc0d4b96e031bcaa9b3a3.1665585952.git.chiaen_wu@richtek.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Oct 2022 15:08:14 +0800, ChiaEn Wu wrote:
> From: ChiaEn Wu <chiaen_wu@richtek.com>
> 
> Fix the interrupt order of the charger in the binding example.
> 
> Fixes: 76f52f815f1a ("dt-bindings: mfd: Add MediaTek MT6370")
> Signed-off-by: ChiaEn Wu <chiaen_wu@richtek.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
> v3
> - Add a 'Reviewed-by' tag.
> 
> v2
> - Revise the commit syntax.
> 
> v1
> - Due to this patch modifiacation
>   (https://lore.kernel.org/all/20221001202918.me7z2qzm7cmrkzsg@mercury.elektranox.org/),
>   there will get some warnings in linux-next when compiling the dts.
> ---
>  Documentation/devicetree/bindings/mfd/mediatek,mt6370.yaml | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Applying to go into rc1 along with the other mt6370 fix, thanks!

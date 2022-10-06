Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0A225F6E06
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 21:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231887AbiJFTQK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 15:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232069AbiJFTP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 15:15:56 -0400
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2046EC6949;
        Thu,  6 Oct 2022 12:15:52 -0700 (PDT)
Received: by mail-oi1-f181.google.com with SMTP id v134so3103326oie.10;
        Thu, 06 Oct 2022 12:15:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=21hNv+nZ869o4qhHs3w2kIGrD509wB6x9WnNWTl2ai4=;
        b=Om5gFoctUkZSrIPV92H/gn7i6F6XpxjWc0iNsEuh9uq1WBEToR78reWBhiXjdTG7Cd
         MJiT42qgzApNuhD2o9M4KwybtnHNeubqH9DYkFh9kPMiEzWE89fvqB0BL1CDeo8u1/c0
         t3n+x34IYocsO+eYCla3l0jNRZeqM6NAJiy9BKtNQ7IKYmxwRyld3q0DbL+1tLF0Fg9/
         Ro2DSHtkbQi1tdWJQrtVD24DFaqWkmHJmc8lrzexwDwWXdmlS4vl1gIeFHJgnw7fMt+o
         yApq9iGzkYYMoYowV2JKCs0gm3sr01E+Bhj3Q4YYFQCYOGGeLOfxkuWeWTLlOxd4CRvU
         S/qw==
X-Gm-Message-State: ACrzQf3FF5ZSoYqduFkjAB5NPfPIFnKRUM8ksyJwFzXzM5Pt5Uu/ZuLe
        zSjQHXXD8J49cptENLq3oQ==
X-Google-Smtp-Source: AMsMyM5VgjxQ1Wp5dG64oir/yFkUIJN8TuHLx8FIisZIq8C87xbt5crQOesIvyyvmVvxZYhaCmwW0Q==
X-Received: by 2002:a05:6808:f12:b0:353:d701:f435 with SMTP id m18-20020a0568080f1200b00353d701f435mr5718532oiw.292.1665083751545;
        Thu, 06 Oct 2022 12:15:51 -0700 (PDT)
Received: from robh_at_kernel.org ([2607:fb90:8a65:c536:245:842:a3a4:9017])
        by smtp.gmail.com with ESMTPSA id p7-20020aca5b07000000b00342e8bd2299sm8433oib.6.2022.10.06.12.15.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 12:15:51 -0700 (PDT)
Received: (nullmailer pid 47054 invoked by uid 1000);
        Thu, 06 Oct 2022 19:15:49 -0000
Date:   Thu, 6 Oct 2022 14:15:49 -0500
From:   Rob Herring <robh@kernel.org>
To:     Yassine Oudjana <yassine.oudjana@gmail.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Andy Teng <andy.teng@mediatek.com>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-mediatek@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sean Wang <sean.wang@kernel.org>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 03/10] dt-bindings: pinctrl: mediatek,mt6779-pinctrl:
 Make gpio-ranges optional
Message-ID: <166508374257.46912.14127423308546660871.robh@kernel.org>
References: <20221005174343.24240-1-y.oudjana@protonmail.com>
 <20221005174343.24240-4-y.oudjana@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221005174343.24240-4-y.oudjana@protonmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 05 Oct 2022 20:43:36 +0300, Yassine Oudjana wrote:
> From: Yassine Oudjana <y.oudjana@protonmail.com>
> 
> The pin controller can function without specifying gpio-ranges. Remove
> it from required properties. Remove it for that reason and to prepare
> for adding other pin controllers which currently don't have the
> gpio-ranges property defined where they are used in DTS. This should
> allow dtbs_check to pass on those device trees.
> 
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> ---
>  .../devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml     | 1 -
>  1 file changed, 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C6655F6E44
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 21:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231878AbiJFTcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 15:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbiJFTcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 15:32:39 -0400
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48CD5C2C81;
        Thu,  6 Oct 2022 12:32:38 -0700 (PDT)
Received: by mail-oi1-f172.google.com with SMTP id s192so3184294oie.3;
        Thu, 06 Oct 2022 12:32:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ou2iWBMYAeA/yRIZnkILz0jhRRskqquaQO86kp7WlKY=;
        b=6/m8LEu0l51Mnxg4rBcdXW/JAmq2QwSKC3IGMgcbuq/112HGz17ER9Vs/ITkvb3PeA
         pyMrId2kONAj8KYc5P0/Y03PUTCrXixMNfYpPUKdyEwcq46g1+MUT1koOWDizgkyT4PU
         cP3g1tGdzBE0XtCsRZysi4U01qdLm+aGh1xf+Oq4l7UjhDQPQnXMgdN3MELH/AGg9Eb6
         +n4z1oBEZHlO4U8ZdP8vgr3JmYnO5VYrGqahL6N+aOqsvAsRV76nWaLHGlDGbUCjhOZA
         olNU+DKuZnjJYIeNKgLOGxMTzxDpuscwWdTgBzd0JWyLw+FthNj5phPcIzNAV+/vTojU
         ObFw==
X-Gm-Message-State: ACrzQf0vS8oMm309skLIaEoM7paVJQ9l5cwC6whvJl4/VK9vVjWiPJ86
        q0+9x9lxgy5Bpp8ibR4Osw==
X-Google-Smtp-Source: AMsMyM6+iKp6n/gVIENPluD3O291vWyTSKOHTvo1T/SMpsq0uv6Gqf3JBN4hgfpp+k6Ft2W1pkEHoA==
X-Received: by 2002:a05:6808:118e:b0:345:9c3e:121d with SMTP id j14-20020a056808118e00b003459c3e121dmr624143oil.211.1665084757531;
        Thu, 06 Oct 2022 12:32:37 -0700 (PDT)
Received: from robh_at_kernel.org ([2607:fb90:8a65:c536:245:842:a3a4:9017])
        by smtp.gmail.com with ESMTPSA id z90-20020a9d24e3000000b00655c6b2655esm171173ota.68.2022.10.06.12.32.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 12:32:36 -0700 (PDT)
Received: (nullmailer pid 60798 invoked by uid 1000);
        Thu, 06 Oct 2022 19:32:35 -0000
Date:   Thu, 6 Oct 2022 14:32:34 -0500
From:   Rob Herring <robh@kernel.org>
To:     Yassine Oudjana <yassine.oudjana@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Teng <andy.teng@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        linux-mediatek@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Sean Wang <sean.wang@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 09/10] dt-bindings: pinctrl: mediatek,mt6779-pinctrl:
 Document MT6735 pin controller bindings
Message-ID: <166508475428.60747.9048131740903882168.robh@kernel.org>
References: <20221005174343.24240-1-y.oudjana@protonmail.com>
 <20221005174343.24240-10-y.oudjana@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221005174343.24240-10-y.oudjana@protonmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 05 Oct 2022 20:43:42 +0300, Yassine Oudjana wrote:
> From: Yassine Oudjana <y.oudjana@protonmail.com>
> 
> Add bindings for the pin controller found on MediaTek MT6735 and
> MT6735M SoCs, including describing a method to manually specify
> a pin and function in the pinmux property making defining bindings
> for each pin/function combination unnecessary. The pin controllers
> on those SoCs are generally identical, with the only difference
> being the lack of MSDC2 pins (198-203) on MT6735M.
> 
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> ---
>  .../pinctrl/mediatek,mt6779-pinctrl.yaml      | 41 +++++++++++++++++++
>  1 file changed, 41 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

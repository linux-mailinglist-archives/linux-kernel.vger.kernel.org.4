Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 735045F6DFB
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 21:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232060AbiJFTOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 15:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231793AbiJFTON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 15:14:13 -0400
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 359EAA3F45;
        Thu,  6 Oct 2022 12:14:13 -0700 (PDT)
Received: by mail-oo1-f45.google.com with SMTP id m11-20020a4aab8b000000b00476743c0743so2061672oon.10;
        Thu, 06 Oct 2022 12:14:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3uOkqH8wHIIwG3lpTmOvwfF29077xeAWMGdj9Sqlpxw=;
        b=Yz27A3sm4FVeUcOzBqmYXr/nEz0fKGJ3aA53in65MirZamGrYGWUKMdE4GdlzZVDE4
         v7sMlkkCEEjie2fYtnnTesfzTKvMOjgLQsMoyDVtf3jQyTz95EGKFZZI+1HZJtFEDX9n
         D7qx5BzN/mpOQIHqiSbUzXd6Oe6rETnwjSU5gTQxBv9PsPNfyYNu66hgv6N3/L/AC8x9
         omQ/exPZ/9qGp6HPI5nLtVxcGPf0ZZN1DAeGFjkC4SeRYhtJ+IJiicB5472XXABTGG4P
         ivWrdi7mnBEvEqStNgXqPzH79TqGr+TGi6FYyvwqB5fx0GXgDFeheHIG2TRu7+xCJT20
         PN1g==
X-Gm-Message-State: ACrzQf2wT/rkcyJvVLcX4nxVdYTNv6GlSzlS19N551anPxBaqr418Ih4
        vHdOo6yEdgsg4fBEbgLnXQ==
X-Google-Smtp-Source: AMsMyM71fwoUSf9tYFfjBz2mhmMUwcP7xYkN22Uv0oapeMLU2C9RJk3TElcPHKa3Anb+dB7iYTEPuA==
X-Received: by 2002:a9d:30d1:0:b0:654:1288:7cb2 with SMTP id r17-20020a9d30d1000000b0065412887cb2mr605971otg.43.1665083652496;
        Thu, 06 Oct 2022 12:14:12 -0700 (PDT)
Received: from robh_at_kernel.org ([2607:fb90:8a65:c536:245:842:a3a4:9017])
        by smtp.gmail.com with ESMTPSA id f13-20020a056830204d00b006594674d4ddsm195126otp.44.2022.10.06.12.14.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 12:14:11 -0700 (PDT)
Received: (nullmailer pid 45552 invoked by uid 1000);
        Thu, 06 Oct 2022 19:14:08 -0000
Date:   Thu, 6 Oct 2022 14:14:08 -0500
From:   Rob Herring <robh@kernel.org>
To:     Yassine Oudjana <yassine.oudjana@gmail.com>
Cc:     Sean Wang <sean.wang@kernel.org>, linux-gpio@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Andy Teng <andy.teng@mediatek.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 02/10] dt-bindings: pinctrl: mediatek,mt6779-pinctrl:
 Improve description
Message-ID: <166508364780.45491.15443497028230774224.robh@kernel.org>
References: <20221005174343.24240-1-y.oudjana@protonmail.com>
 <20221005174343.24240-3-y.oudjana@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221005174343.24240-3-y.oudjana@protonmail.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 05 Oct 2022 20:43:35 +0300, Yassine Oudjana wrote:
> From: Yassine Oudjana <y.oudjana@protonmail.com>
> 
> The current description mentions having to put the pin controller
> node under a syscon node, but this is not the case in the current
> MT6779 device tree. It seems that this is not actually needed, so
> replace the current description with something more generic that
> describes the use of the hardware block.
> 
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> ---
>  .../bindings/pinctrl/mediatek,mt6779-pinctrl.yaml          | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C21F56E9D63
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 22:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232439AbjDTUoW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 16:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232395AbjDTUoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 16:44:17 -0400
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9617A35A3;
        Thu, 20 Apr 2023 13:44:15 -0700 (PDT)
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6a5f1503886so544979a34.2;
        Thu, 20 Apr 2023 13:44:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682023455; x=1684615455;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XdeZ8xzgVHosFDJ9K3Fl96nM7x/G+I3DI1EVKMB5/cI=;
        b=SRVQIT5ZdzinBXJ0Z+dqRD64un+w4n0qvmQOpjQ4Sq5Rs6C7W5wddwI/kBB7Ma2/Bx
         YHb9SmPeisaHAF1PBSdTEqMKLD5yqWBpGSTzblwYjzco830jY0feEXIfaVAJYc6VjLFk
         n7JJV9P++xdsqMlHuIhWCQy3HpyQ7DVeB2whuvoaSpJsggtuvj1tzGz6ui4oM8ocvEEI
         c5nwq/whf/iCNibZT+kSscIYSmLYytqT5tqY4u7xT21FOcCVJ08p+CufUTSVYrL/+/OQ
         9AscmzQVS7sC7y6LcuFBiFHVkht7imiOnI7PHmkBsQKWpwZKrY2NfmVRqD9Lz6XndGEr
         8svQ==
X-Gm-Message-State: AAQBX9fHCkVsOHEWI9Wha/HTPiDwHyyL8Ihcg9uXnBJG7wk7geec4pam
        kSfd9I1cvjLTidQz/GH5gw==
X-Google-Smtp-Source: AKy350aEuuhzmBltlqVshkcKGlza/qYtsoMU4SNFpJGHeliRLT5wVxIePHagH1cABEcZFMnqjpbW7A==
X-Received: by 2002:a05:6870:e749:b0:17a:aeff:5228 with SMTP id t9-20020a056870e74900b0017aaeff5228mr2130851oak.47.1682023454819;
        Thu, 20 Apr 2023 13:44:14 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id g11-20020a9d618b000000b006a3f4c6f138sm1091275otk.36.2023.04.20.13.44.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 13:44:14 -0700 (PDT)
Received: (nullmailer pid 3467149 invoked by uid 1000);
        Thu, 20 Apr 2023 20:44:13 -0000
Date:   Thu, 20 Apr 2023 15:44:13 -0500
From:   Rob Herring <robh@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: arm/soc: mediatek: Drop unneeded quotes
Message-ID: <168202340162.3466084.977084044786860402.robh@kernel.org>
References: <20230322173501.3970991-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230322173501.3970991-1-robh@kernel.org>
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


On Wed, 22 Mar 2023 12:34:59 -0500, Rob Herring wrote:
> Cleanup bindings dropping unneeded quotes. Once all these are fixed,
> checking for this can be enabled in yamllint.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/arm/mediatek/mediatek,infracfg.yaml   | 4 ++--
>  .../devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml      | 4 ++--
>  .../bindings/arm/mediatek/mediatek,mt7622-pcie-mirror.yaml    | 4 ++--
>  .../devicetree/bindings/arm/mediatek/mediatek,mt7622-wed.yaml | 4 ++--
>  .../bindings/arm/mediatek/mediatek,mt7986-wed-pcie.yaml       | 4 ++--
>  .../bindings/arm/mediatek/mediatek,mt8186-clock.yaml          | 4 ++--
>  .../bindings/arm/mediatek/mediatek,mt8186-sys-clock.yaml      | 4 ++--
>  .../bindings/arm/mediatek/mediatek,mt8192-clock.yaml          | 4 ++--
>  .../bindings/arm/mediatek/mediatek,mt8192-sys-clock.yaml      | 4 ++--
>  .../bindings/arm/mediatek/mediatek,mt8195-clock.yaml          | 4 ++--
>  .../bindings/arm/mediatek/mediatek,mt8195-sys-clock.yaml      | 4 ++--
>  .../devicetree/bindings/arm/mediatek/mediatek,pericfg.yaml    | 4 ++--
>  Documentation/devicetree/bindings/soc/mediatek/devapc.yaml    | 4 ++--
>  13 files changed, 26 insertions(+), 26 deletions(-)
> 

Applied, thanks!


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B82BF6E6DE3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 23:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232877AbjDRVL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 17:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232860AbjDRVLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 17:11:55 -0400
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CC726A56;
        Tue, 18 Apr 2023 14:11:54 -0700 (PDT)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-187c78c6657so583975fac.2;
        Tue, 18 Apr 2023 14:11:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681852313; x=1684444313;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wq4XES0A3vZMGZurOPdlsGHZykLyFbZWmGpJXYBbCNw=;
        b=fo3rYVE+OHinTgrmuBKyxuNLh/LjMRJGU+H59pl5IpXSbrMCPkgwSBfA2Gu7fdZ7en
         YqzddyHu2PaxM2vbBdznIJV7Nsd1w0B1SAEoqPRQjFbWBE1+14T+WyoTHD7WuES5r42v
         pof9h8m1lJSpwnumvo3msh8zGB5C5wk1Y9/c16L10Ve5fVPurw/Ub3dmNiJCz5userpT
         L77drTsf4IP3gW4XUtUEDFB9SV96FCMFMqjJ7ZgEByOr5FRBQP0XKuQStSuua1UF49EA
         nBjhFsvr0VXsFM/69Ms2/ymscsdWhTHR50NOdLmthlkHji5ZiLUwANbxMDdHLNhbKoDe
         3y6w==
X-Gm-Message-State: AAQBX9eIxHDuz8xoqtZLjaAabVs2nnfeBFWYNbkkx5oGkU4b7dZFpI+B
        85ZRY5DykKhTNu3om1KVBQ==
X-Google-Smtp-Source: AKy350asGV+/EQnR8K/k603pg3P1vk2PcyjMx5ZRioEAbPquyMv9OeqaOF+GvaSzzXOg6OCwjSe3hw==
X-Received: by 2002:a05:6871:729:b0:187:a6fd:f1c7 with SMTP id f41-20020a056871072900b00187a6fdf1c7mr2115232oap.5.1681852313474;
        Tue, 18 Apr 2023 14:11:53 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id dy16-20020a056870c79000b0017197629658sm6077372oab.56.2023.04.18.14.11.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 14:11:52 -0700 (PDT)
Received: (nullmailer pid 2345963 invoked by uid 1000);
        Tue, 18 Apr 2023 21:11:51 -0000
Date:   Tue, 18 Apr 2023 16:11:51 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Xin Ji <xji@analogixsemi.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        linux-kernel@vger.kernel.org,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Daniel Vetter <daniel@ffwll.ch>,
        Robert Foss <rfoss@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maxime Ripard <mripard@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        dri-devel@lists.freedesktop.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        David Airlie <airlied@gmail.com>, devicetree@vger.kernel.org,
        Thierry Reding <treding@nvidia.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: Re: [PATCH] dt-bindings: display: simplify compatibles syntax
Message-ID: <168185230077.2345727.991435195687309100.robh@kernel.org>
References: <20230414104230.23165-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230414104230.23165-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 14 Apr 2023 12:42:30 +0200, Krzysztof Kozlowski wrote:
> Lists (items) with one item should be just const or enum because it is
> shorter and simpler.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Rebased on next-20230406. I hope it applies cleanly...
> ---
>  .../display/bridge/analogix,anx7625.yaml      |  3 +--
>  .../display/panel/sharp,lq101r1sx01.yaml      |  4 ++--
>  .../bindings/display/solomon,ssd1307fb.yaml   | 24 +++++++++----------
>  3 files changed, 14 insertions(+), 17 deletions(-)
> 

Applied, thanks!


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3432678A11
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 22:58:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbjAWV6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 16:58:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231872AbjAWV6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 16:58:11 -0500
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9B62EC73;
        Mon, 23 Jan 2023 13:58:04 -0800 (PST)
Received: by mail-oi1-f170.google.com with SMTP id p185so11683067oif.2;
        Mon, 23 Jan 2023 13:58:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=md9gCIYD77xOEN3dY8UkAkR3swU6EZCyCXStPTGJ4jM=;
        b=3NjQYyBYbN7fBQxsgDCJfjuxhKvHI/ejQADbPZCD31x+piMrfsDNW7YQOlrLzPCZSO
         SZ2PFfDxKeeAHo/cJ6w7HAOJs8v+ywMrRDzx6iCYLkVrjrGHu+AuCbCOxrYyjNGz4wwx
         VnSm9lTL+g5D9Ct7gnL2g7oaDAiSsGX/OL8Bm5xl7Rwb+FkTZvtTaD2uvsoL2ZuJVxJm
         LgsUhLqahMGD6QB05w17WLhuJSUfz0VouIuUl8PS9WRGLFpf839E/FE/mrNPrPqszLRh
         xxdL9NLuF0ANRnb+02ycnEFcLyRC5KV8TIui+tbYH+jlQ3RNEpyyAjKk/Mdq6RHTBeno
         MNaw==
X-Gm-Message-State: AFqh2kph5irr+UR8vxZYiZrftL76NK5sEaHzwffy+2QnlkrI9M9MDCfZ
        rd6CsH7UrzzTpf/w/CKeDhaH6oRyQw==
X-Google-Smtp-Source: AMrXdXtXg6vJP5jHd24H4/vNZBlDLpSsVqGZPwZuyLNt9CwkwU2pWN8ncEISBk9upKooGAgYLA65nQ==
X-Received: by 2002:aca:bf06:0:b0:35e:1875:d85 with SMTP id p6-20020acabf06000000b0035e18750d85mr10968143oif.8.1674511083813;
        Mon, 23 Jan 2023 13:58:03 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id k8-20020a05680808c800b0036718f58b7esm254766oij.15.2023.01.23.13.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 13:58:03 -0800 (PST)
Received: (nullmailer pid 2710303 invoked by uid 1000);
        Mon, 23 Jan 2023 21:58:02 -0000
Date:   Mon, 23 Jan 2023 15:58:02 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/3] dt-bindings: power: fsl,imx-gpc: correct compatibles
Message-ID: <167451108214.2710264.5991181390253327206.robh@kernel.org>
References: <20230120071717.138188-1-krzysztof.kozlowski@linaro.org>
 <20230120071717.138188-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230120071717.138188-2-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 20 Jan 2023 08:17:16 +0100, Krzysztof Kozlowski wrote:
> fsl,imx6qp-gpc, fsl,imx6sl-gpc and fsl,imx6sx-gpc use generic fallback
> fsl,imx6q-gpc in the DTS, even though these are different devices.  The
> common part (thus the fallback) is a interrupt controller routing back
> to GIC.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/power/fsl,imx-gpc.yaml | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>

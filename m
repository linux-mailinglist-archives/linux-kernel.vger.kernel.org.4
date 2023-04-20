Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 453DF6E9A36
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 19:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbjDTRDN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 13:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbjDTRDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 13:03:10 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A973230CA;
        Thu, 20 Apr 2023 10:03:09 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id 5614622812f47-38c00f19654so532524b6e.2;
        Thu, 20 Apr 2023 10:03:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682009873; x=1684601873;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sskrH87l2JddzTI2ulk4grlY8ICMx+GkEeA1KtebY70=;
        b=RnjI77ZDbTXXHvi4J6+N72aXu9CipAb0rOEhgVU6jwsHWxzcDtjZ3VKGkmXsCQ/DLo
         WiPcW/cfTIr3EHWqkqWj4bAsava9z8zYt4r+bi4QUZilJ4PQG9FqxAd/eeJ7SLkus7Up
         yscAcpNJnz0Gvt4psE8E/cPlPA8szkrt8N7mKxbdfndt4DXG+Q/ESml9Z0LwfxB+TPor
         PaQUKHetaNzydlhwbwk4+g/KYkHnOseru50aivXVQ+znSnwsrPoQLOAhxFulXebcSDdj
         L3dMoggKdUCkeKtHIILU1El8L4Sh5/N3TR6iUKOjq8vUqQXoTHsJVFWSXo1/tM1KiUJ9
         PxTg==
X-Gm-Message-State: AAQBX9eQLV7Nnvk6xIugO4lB3zSl1ucCH1t7zZAvaPty0laPi4LxtPpU
        Wud019uhlCb1WlSO4py/YQ==
X-Google-Smtp-Source: AKy350YBjL+oqX2R5+mr73qGeuIpf6viyx4+RGoEDkYDmMt6BGN9FChhDAsnd3DggYVvXwoK7BNF2g==
X-Received: by 2002:a05:6808:2104:b0:38d:e623:bb1a with SMTP id r4-20020a056808210400b0038de623bb1amr1681315oiw.50.1682009873379;
        Thu, 20 Apr 2023 09:57:53 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r83-20020acaf356000000b003845f4991c7sm765305oih.11.2023.04.20.09.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 09:57:52 -0700 (PDT)
Received: (nullmailer pid 3013188 invoked by uid 1000);
        Thu, 20 Apr 2023 16:57:52 -0000
Date:   Thu, 20 Apr 2023 11:57:52 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Peng Fan <peng.fan@nxp.com>, devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Xu Yang <xu.yang_2@nxp.com>, linux-usb@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH] dt-bindings: usb: ci-hdrc-usb2: allow multiple PHYs
Message-ID: <168200987182.3013134.13057709706986760718.robh@kernel.org>
References: <20230420065051.22994-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230420065051.22994-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 20 Apr 2023 08:50:51 +0200, Krzysztof Kozlowski wrote:
> Qualcomm MSM8974 comes with USB HS phy in two variants, although final
> DTS chooses only one.  Allow such combination in the ChipIdea USB2
> bindings and also disallow any other properties in the ulpi node.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> DTS will be fixed separately.
> ---
>  Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>


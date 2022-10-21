Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7A3606D44
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 03:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbiJUB4h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 21:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiJUB4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 21:56:34 -0400
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BEC318D478;
        Thu, 20 Oct 2022 18:56:32 -0700 (PDT)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-132fb4fd495so1800800fac.12;
        Thu, 20 Oct 2022 18:56:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fydIsMYn3BewSKh94s3xFmCTrmlCzd+B5ulnPbaabJU=;
        b=G29pHmoPTeXFd0IdStR2mxYjXH43Avc7WIKSb4wBTmj5klPmjvvh4WT0YSw3R9Y9nt
         FFTmy4nxdgGJUOom5J5/GaUPg5krL0TPTrqfQZzUM8DxCVyobxhdlEWBAtQGAdMEjp90
         IJTUxYdBu2KG/e8RRIUlrRRY6RYxztUV4sgU9O1YJbKDNGoqIsaByuXY0mtp2MAhvhhZ
         EEN4DKu1myCEryHGWgGrVrJ5dFLXI6GtMWLgRrnWTvDBtpPkAJXI/BYXzYEdv/5HqYUO
         +XuVSX7LmDsNir0QC6uFNr0aIr+mibsU2DfqZ4C76ak3SD4WzKEZBrKHMROVvEpOPdI7
         ac+g==
X-Gm-Message-State: ACrzQf3srx93quaKUYf8/wFsVTBBY0tZ/J8b5zwhWEqWU2gQZE6OV7Bc
        xtH2SZjRtIeoHUmqcVuvgQ==
X-Google-Smtp-Source: AMsMyM4gP8ZuOjCQJhQJIrtqcG7n85msXVGfLpUQXLeDaFhozhy80dSFQfWJC/tI+27fIyTKFwGd9g==
X-Received: by 2002:a05:6871:154:b0:136:5e72:d59b with SMTP id z20-20020a056871015400b001365e72d59bmr10024696oab.87.1666317390400;
        Thu, 20 Oct 2022 18:56:30 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id w24-20020a4a9d18000000b0047f94375092sm8232493ooj.40.2022.10.20.18.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 18:56:29 -0700 (PDT)
Received: (nullmailer pid 2157019 invoked by uid 1000);
        Fri, 21 Oct 2022 01:56:31 -0000
Date:   Thu, 20 Oct 2022 20:56:31 -0500
From:   Rob Herring <robh@kernel.org>
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     linux-mediatek@lists.infradead.org, Vinod Koul <vkoul@kernel.org>,
        devicetree@vger.kernel.org, linux-phy@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-kernel@vger.kernel.org,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] dt-bindings: phy: mediatek: tphy: add compatible for
 tphy-v4
Message-ID: <166631739023.2156965.8672610831833263050.robh@kernel.org>
References: <df51b63add2830d91b527db64fba6ffdb7765f5d.1666193782.git.daniel@makrotopia.org>
 <07c5d962515c4f675f076bb91d69eaf651b187c6.1666193782.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07c5d962515c4f675f076bb91d69eaf651b187c6.1666193782.git.daniel@makrotopia.org>
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

On Wed, 19 Oct 2022 16:38:14 +0100, Daniel Golle wrote:
> V4 can be found in MT7986 and MT7981 SoCs, it supports PCIe with two
> lanes.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
>  Documentation/devicetree/bindings/phy/mediatek,tphy.yaml | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2169D5F5566
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 15:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbiJENac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 09:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbiJENa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 09:30:28 -0400
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CCE14A11F;
        Wed,  5 Oct 2022 06:30:26 -0700 (PDT)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-132e9bc5ff4so803867fac.7;
        Wed, 05 Oct 2022 06:30:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=irQeqZ8WEX66ZHtDLuvQlYzdGNkgZkPT/seAIhsHDCE=;
        b=r6TNBLVaXtnbGtF7uk6kCPerWr3Ba/YdTCl/P22adYP9n2eukw9Eetp/vv82q8PUHJ
         tRhHba0FneVd9676Km2uJqRKYzHGFaz6JMcWeh7tG/lmSR7mfiY7SguND0k23IileDKG
         D3B8g9hOV8oLZG2tXqCNQtsbtwuGmqywjio5AxFmdAMgz2WO3tqba6HyPC4wzHdW677V
         eC3p2Ljt/UtOXzQKO6R/2OXKTJnaPEeAi5R9LzDH84CPuSlId8gB9A10K5S/pWx22hbW
         KOt5XLJrfx4KXjgw0dk9ZJQnDrXYkL2HtrllsXXXRQjaaz6Qfl4GU3ju/olGFuQLwEUn
         5D2Q==
X-Gm-Message-State: ACrzQf1pqvxrm6JZi6lKhiVOtgBYTAdF4rbiYBElINqpUKr0AmBkjLPP
        7K6fw0S50L3uvAlgxCnsKw5Wk2E7nA==
X-Google-Smtp-Source: AMsMyM7Dc9AAulz+lgm5eba8K4nXKXzu0+Ca/UyNBORLFk6fdfkXj2d1AselHUi2iVcgMfsHwdmvvg==
X-Received: by 2002:a05:6870:14c1:b0:12d:be49:8c23 with SMTP id l1-20020a05687014c100b0012dbe498c23mr2600372oab.21.1664976625001;
        Wed, 05 Oct 2022 06:30:25 -0700 (PDT)
Received: from robh_at_kernel.org ([2607:fb90:5fee:ea3a:4239:ad4:650a:6e66])
        by smtp.gmail.com with ESMTPSA id t14-20020a056870638e00b001313ec705f3sm5177066oap.37.2022.10.05.06.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 06:30:24 -0700 (PDT)
Received: (nullmailer pid 3275000 invoked by uid 1000);
        Wed, 05 Oct 2022 13:30:22 -0000
Date:   Wed, 5 Oct 2022 08:30:22 -0500
From:   Rob Herring <robh@kernel.org>
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>,
        Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@ragnatech.se>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jacopo Mondi <jacopo@jmondi.org>, linux-kernel@vger.kernel.org,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-media@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-renesas-soc@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 2/4] media: dt-bindings: Document Renesas RZ/G2L CRU
 block
Message-ID: <166497662123.3274947.8880601658127889560.robh@kernel.org>
References: <20221004234343.54777-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221004234343.54777-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221004234343.54777-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

On Wed, 05 Oct 2022 00:43:41 +0100, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> Document the CRU block found on Renesas RZ/G2L (and alike) SoCs.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> ---
> v2 -> v3
> * Updated clock names
> 
> v1 -> v2
> * Dropped media prefix from subject
> * Dropped oneOf from compatible
> * Used 4 spaces for indentation in example node
> * Marked port0/1 as required
> * Updated example node
> * Included RB tag from Laurent
> 
> RFC v2 -> v1
> * Dropped endpoint stuff from port1 as suggested by Rob
> * Updated description for endpoint
> 
> RFC v1 -> RFC v2
> * Dropped CSI
> ---
>  .../bindings/media/renesas,rzg2l-cru.yaml     | 157 ++++++++++++++++++
>  1 file changed, 157 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/renesas,rzg2l-cru.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>

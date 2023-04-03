Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DC736D5306
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 23:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233159AbjDCVG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 17:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231636AbjDCVG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 17:06:26 -0400
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FDD01BC3;
        Mon,  3 Apr 2023 14:06:25 -0700 (PDT)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-177b78067ffso32300991fac.7;
        Mon, 03 Apr 2023 14:06:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680555984;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=08JlvI1hUhZyrM2szVAGCNyVcRh4I7s+6U0f0q0JQOQ=;
        b=6N/XF47UWf/cGl+wzEvmpaSM4Tcm5oWtrJohp7cCxOEAujaLDsMc4zQGXvTMeJGe8Y
         vfGBayPzHjH0glfKpTdXtElQulMVOpz6bpWCN99Q01Hh1fPmScYQeWNqfKRvbMkJRRGr
         wVEXIdilDrOitebontkWEc7FKaqHvMXpilVxDecCp6WyiWMPZx10lBbJRjL3bIGqDxNq
         x2WSS0t+EmCc8U18V6C69dme2j8tZL8IyzZPdSck99ji1Mz4F7CB3V+zel/k1iG0X7bE
         kU6cpsDobIUCUj+cDkgFcXC/SIJcBfcQw2PdOpzAhOz791ZF3jPrVgJLkRy1DWFsF4Wn
         bTjg==
X-Gm-Message-State: AAQBX9fraFz+S3ZluySLXvOud+tMS8b1fKtaRqxN+GQ21BW6VJODy5/A
        Mj/kjml2VFLXG/a6WHP+Dg==
X-Google-Smtp-Source: AKy350aevd645dF3st8Velo9cm7pPfpzlct8rQ/ePIbcFPF1B1iFeLjt+3CLri2lBgSP9iq2Cb9PHQ==
X-Received: by 2002:a05:6870:f223:b0:180:5367:33ba with SMTP id t35-20020a056870f22300b00180536733bamr318161oao.48.1680555984621;
        Mon, 03 Apr 2023 14:06:24 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id kw17-20020a056870ac1100b001802d3e181fsm3978033oab.14.2023.04.03.14.06.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 14:06:23 -0700 (PDT)
Received: (nullmailer pid 1772263 invoked by uid 1000);
        Mon, 03 Apr 2023 21:06:22 -0000
Date:   Mon, 3 Apr 2023 16:06:22 -0500
From:   Rob Herring <robh@kernel.org>
To:     Francesco Dolcini <francesco@dolcini.it>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        dri-devel@lists.freedesktop.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marek Vasut <marex@denx.de>, devicetree@vger.kernel.org,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] dt-bindings: display: bridge: sn65dsi83: Add DSI
 video mode
Message-ID: <20230403210622.GA1740065-robh@kernel.org>
References: <20230330101752.429804-1-francesco@dolcini.it>
 <20230330101752.429804-2-francesco@dolcini.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230330101752.429804-2-francesco@dolcini.it>
X-Spam-Status: No, score=0.8 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023 at 12:17:51PM +0200, Francesco Dolcini wrote:
> From: Francesco Dolcini <francesco.dolcini@toradex.com>
> 
> SN65DSI8[34] device supports burst video mode and non-burst video mode
> with sync events or with sync pulses packet transmission as described in
> the DSI specification.
> 
> Add property to select the expected mode, this allows for example to
> select a mode that is compatible with the DSI host interface.

Why does this need to be in DT? The source and sink drivers should know 
what their capabilities are and pick the best common one.

Rob

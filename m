Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 043C96AFB17
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 01:29:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbjCHA31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 19:29:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjCHA3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 19:29:24 -0500
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34CE08E3EA;
        Tue,  7 Mar 2023 16:29:23 -0800 (PST)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-176261d7f45so17088594fac.11;
        Tue, 07 Mar 2023 16:29:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678235362;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GbkJoaBSLlit3t2d1saVpRVwe6uVOOAmLerdrHEmPA4=;
        b=p2yvaWYjckX+CNvJpkwIpdrMm6QazUzIHgpvQzgBCqGWYwKquKcfWvGbOiT1TnDYIa
         yhPsptKrQInoBwF9PMIjmST+Plyv7FodJrzAkQycV1J4OqZSwO2KA3PEMyDS292diVsC
         Qo9hXoECrzSP1djufQ4JpyhyP75U3QR5mxIS5QjJUuYdaO+Zn66zr88nm/CzVFyXY6I5
         SAInM0yJdHdWrstvxYhK1SqWoN5lNOfmCEZjXhfXObHaZ1tWQwpzpWhNQngNM0GBPzft
         tsyxZ6zoywifYYIFg9hhS+To+LiW1fyi2G3NUbrAmijket0viforcDPaz/tuL2qEy5dV
         gZiA==
X-Gm-Message-State: AO0yUKWAYAYN6l6dd40ptTQh9ks+r/2lCDrkBR6lLcHFDUYVQzjFgIZe
        lHvLLAfWtNBPYftyT41asg==
X-Google-Smtp-Source: AK7set83LoWLF5mpats1V58zuDPQ+pBXFeCwEfyRTuwpQDFg/1Md/+txVRbI6H1CFcRNahYc39uAKg==
X-Received: by 2002:a05:6870:c0d5:b0:176:55ad:9237 with SMTP id e21-20020a056870c0d500b0017655ad9237mr9249005oad.38.1678235362468;
        Tue, 07 Mar 2023 16:29:22 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id c22-20020a056870a59600b0017197629658sm5660538oam.56.2023.03.07.16.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 16:29:21 -0800 (PST)
Received: (nullmailer pid 535800 invoked by uid 1000);
        Wed, 08 Mar 2023 00:29:21 -0000
Date:   Tue, 7 Mar 2023 18:29:21 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     dri-devel@lists.freedesktop.org, David Airlie <airlied@gmail.com>,
        devicetree@vger.kernel.org,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Rob Herring <robh+dt@kernel.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-kernel@vger.kernel.org,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Robert Foss <rfoss@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] dt-bindings: display: bridge: parade,ps8622: convert to
 dtschema
Message-ID: <167823536016.535746.4969388774205630189.robh@kernel.org>
References: <20230221170955.62448-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230221170955.62448-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 21 Feb 2023 18:09:55 +0100, Krzysztof Kozlowski wrote:
> Convert the Parade PS8622/PS8625 DisplayPort to LVDS Converter bindings
> to DT schema.  Changes during conversion: add missing vdd12-supply, used
> by Linux driver.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../display/bridge/parade,ps8622.yaml         | 115 ++++++++++++++++++
>  .../bindings/display/bridge/ps8622.txt        |  31 -----
>  2 files changed, 115 insertions(+), 31 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/parade,ps8622.yaml
>  delete mode 100644 Documentation/devicetree/bindings/display/bridge/ps8622.txt
> 

Applied, thanks!


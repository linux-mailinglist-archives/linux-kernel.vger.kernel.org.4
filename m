Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 733E0672265
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 17:04:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbjARQEH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 11:04:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231164AbjARQDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 11:03:39 -0500
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CDB8568B1;
        Wed, 18 Jan 2023 07:59:38 -0800 (PST)
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-15eec491b40so14982080fac.12;
        Wed, 18 Jan 2023 07:59:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uYLwATUgXkSjEpYITC3xrrUBVVSKhXYf3klEB5MK1WI=;
        b=wJarYY+HrgKVucUCJ5rTw5IKetYZsM7YtISq7AyN6sEfYSd3slyw9MGTIAANYoix2Z
         5zrryNcVrwujEyqtvhMlnhamMnNwEph8UuvxsFfJ5nfgvGTCVHn1SedrgIu3cVQURFvr
         f1uDya2bHSv/TXqg72mDWRGysBdTOsCIiY0D3wl9FsgZnPNpv/Fz7vO4J2M5U9nR0RaL
         tUy3LEmmG0MvzAkqrA0hmDd/13r70/F/j5PKQG1rTwLWidoXhIQCsexBEAf32mt+/Yop
         Ad+txOkYJ4HOdIH3PksrCgaSQugMAA+j0yCq1i1XbJHdHXkbfwwL+VeIqe2YAxIrPEdJ
         Jqtg==
X-Gm-Message-State: AFqh2kpXi0k4z5jNHAYNh+NQO38MZvnvHVFy+ekUBrMVUlpIaYHhMLx8
        qpw5qXf7DdNW2Vb37VS1cA==
X-Google-Smtp-Source: AMrXdXtNXcgtaf4kqxp3LkeZgl009U5TgsdRR7APA5uSgwVb7Iat9myzCJOSH4NszFG9TWuteb8Vig==
X-Received: by 2002:a05:6870:4b9b:b0:15f:29ff:b84b with SMTP id lx27-20020a0568704b9b00b0015f29ffb84bmr4426352oab.53.1674057577328;
        Wed, 18 Jan 2023 07:59:37 -0800 (PST)
Received: from robh_at_kernel.org ([4.31.143.193])
        by smtp.gmail.com with ESMTPSA id e23-20020aca1317000000b0035028730c90sm1293795oii.1.2023.01.18.07.59.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 07:59:37 -0800 (PST)
Received: (nullmailer pid 80474 invoked by uid 1000);
        Wed, 18 Jan 2023 15:59:36 -0000
Date:   Wed, 18 Jan 2023 09:59:36 -0600
From:   Rob Herring <robh@kernel.org>
To:     Moudy Ho <moudy.ho@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Michael Turquette <mturquette@baylibre.com>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v6 2/4] dt-bindings: arm: mediatek: mmsys: Add support
 for MT8195 VPPSYS
Message-ID: <167405753490.79458.14830841571648305293.robh@kernel.org>
References: <20230118031509.29834-1-moudy.ho@mediatek.com>
 <20230118031509.29834-3-moudy.ho@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230118031509.29834-3-moudy.ho@mediatek.com>
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


On Wed, 18 Jan 2023 11:15:07 +0800, Moudy Ho wrote:
> For MT8195, VPPSYS0 and VPPSYS1 are 2 display pipes with
> hardware differences in power domains, clocks and subsystem counts,
> which should be determined by compatible names.
> 
> Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
> ---
>  .../devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml        | 2 ++
>  1 file changed, 2 insertions(+)
> 


Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.

Missing tags:

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>



Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03E725B62DD
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 23:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbiILViE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 17:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbiILVh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 17:37:57 -0400
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AB6C4C60A;
        Mon, 12 Sep 2022 14:37:56 -0700 (PDT)
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-12803ac8113so26942400fac.8;
        Mon, 12 Sep 2022 14:37:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=BHNK/xH+mhQJiZxZdU0ybg1u2AYkzOcqp8cQqgJ1qYc=;
        b=tQcSsAxw8ASH0FSYkCRocrKGrO4hxyPXaoxkTCHiifDna4GtVY3taF7DIzFAH+3CEA
         5+SdcBFhSeE/74+XFVWCJlx2DV9MeC2EdheSi5lqPfueOACB/L2uMMxevAuCX7HJYYxP
         a58jMTC1cMUhPD2MTdGkqFQnayOpQfTRPTC+PesqTVZ6esKfyxiZlTUKgKFL+SvSkuu0
         YrKYTfJorCBIE4zTHbcnhvOxIocBHWA26XMzHOU0fR48KR5sjFik49WziPAepzKFRTLP
         ZK/lLiG++Q/Ao9pKjsu7aLH+Lt+ttEtYtVTiu6JGS6d7H16zmRqhn0UP+dOhSHFEg4+N
         f5uQ==
X-Gm-Message-State: ACgBeo1PJE4GtfDODhvgHX0kkf0485o17HzaKdm5L9lRlVS8e4Ukmf+7
        X95MtHOcNuw9VOtBVRuaMQ==
X-Google-Smtp-Source: AA6agR7Q2f7QGvzITg1wOOoy7fhFuc9v9GHyCZijQT0w2SIi0n8gG1E9UqGwLwefbawZKU/G6mw3zg==
X-Received: by 2002:a05:6870:e616:b0:12b:82e8:dc53 with SMTP id q22-20020a056870e61600b0012b82e8dc53mr207070oag.276.1663018675791;
        Mon, 12 Sep 2022 14:37:55 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id u22-20020a056871009600b0012b342d1125sm5342647oaa.13.2022.09.12.14.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 14:37:55 -0700 (PDT)
Received: (nullmailer pid 1943256 invoked by uid 1000);
        Mon, 12 Sep 2022 21:37:54 -0000
Date:   Mon, 12 Sep 2022 16:37:54 -0500
From:   Rob Herring <robh@kernel.org>
To:     Julius Werner <jwerner@chromium.org>
Cc:     linux-kernel@vger.kernel.org,
        Doug Anderson <dianders@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Jian-Jia Su <jjsu@google.com>, devicetree@vger.kernel.org,
        Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH 2/4 v2] dt-bindings: memory: Add numeric LPDDR compatible
 string variant
Message-ID: <20220912213754.GA1942982-robh@kernel.org>
References: <20220907232914.243502-1-jwerner@chromium.org>
 <20220907232914.243502-2-jwerner@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220907232914.243502-2-jwerner@chromium.org>
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

On Wed, 07 Sep 2022 16:29:12 -0700, Julius Werner wrote:
> This patch allows a new kind of compatible string for LPDDR parts in the
> device tree bindings, in addition to the existing hardcoded
> <vendor>,<part-number> strings. The new format contains manufacturer and
> part (revision) information in numerical form, such as lpddr3-ff,0201
> for an LPDDR3 part with manufacturer ID ff and revision ID 0201. This
> helps cases where LPDDR parts are probed at runtime by boot firmware and
> cannot be matched to hardcoded part numbers, such as the firmware on the
> qcom/sc7280-herobrine boards does (which supports 4 different memory
> configurations at the moment, and more are expected to be added later at
> a point where the boot firmware can no longer be updated to specifically
> accomodate them).
> 
> Signed-off-by: Julius Werner <jwerner@chromium.org>
> ---
>  .../memory-controllers/ddr/jedec,lpddr-props.yaml    | 10 ++++++++++
>  .../memory-controllers/ddr/jedec,lpddr2.yaml         |  8 +++++---
>  .../memory-controllers/ddr/jedec,lpddr3.yaml         | 12 ++++++++----
>  3 files changed, 23 insertions(+), 7 deletions(-)
> 
> Changelog:
> 
> - v2
>   - Updated commit message to describe intended use case as an example
> 

Acked-by: Rob Herring <robh@kernel.org>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82A1D63FC95
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 01:11:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232045AbiLBAL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 19:11:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231573AbiLBALT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 19:11:19 -0500
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19534CBA78;
        Thu,  1 Dec 2022 16:11:18 -0800 (PST)
Received: by mail-ot1-f43.google.com with SMTP id g51-20020a9d12b6000000b0066dbea0d203so2018872otg.6;
        Thu, 01 Dec 2022 16:11:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zGq1WNX8Tw/ZC1WhR0e9GI27emRflXnQa00eSJUvyNA=;
        b=nQSWBaBt+9kXdIppe/FxQuQeTYolowNlB/+GrEtCug/9cXUTspEmWoxYYkfIOB8pc2
         y5Aaz2OuSUOubD+d+CcnHvrgaxVemNCfn38KuRyEpxqD4g/6e2OfMVA/2CiuZMZKwmbo
         x32vE8TA5mX2hr2lX+4wUwTdkTeeNlhSruA/Sz24C4mTu2vkZzvAlTUst2fvWNt1bNyP
         SRymCwtbiShBQBvgOrf/rGC+5eAlokhNLpPvX1M4o0fyx01Adx8IG5FfOs0MvtAIfHqb
         t+HIVJA2hvfSv3Ail0TITJjltQ8oC/Den0j/6yjZ00Y+tMpfMGVWLtfx/Ep+wCkMmZQR
         LIvw==
X-Gm-Message-State: ANoB5pmfHDgeU3q7immPvG3G4JL26ZnE4NOZ3h1wVIlSzTTXE1hnkANG
        x+7CjI5jFJLia2QwBKqw+w==
X-Google-Smtp-Source: AA0mqf4o+fnjDBcjQQyria01GTLlxp+FNl8ndgi9chbNkyUgWIvyVqEL1opVmYQWA1/2b3VIDGPCxQ==
X-Received: by 2002:a05:6830:2a0a:b0:66c:3703:f04e with SMTP id y10-20020a0568302a0a00b0066c3703f04emr34665718otu.287.1669939877279;
        Thu, 01 Dec 2022 16:11:17 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id j24-20020a544818000000b00354932bae03sm2427124oij.10.2022.12.01.16.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 16:11:16 -0800 (PST)
Received: (nullmailer pid 1741058 invoked by uid 1000);
        Fri, 02 Dec 2022 00:11:16 -0000
Date:   Thu, 1 Dec 2022 18:11:16 -0600
From:   Rob Herring <robh@kernel.org>
To:     Otto =?iso-8859-1?Q?Pfl=FCger?= <otto.pflueger@abscue.de>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <mripard@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?utf-8?q?=2C?=devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>
Subject: Re: [PATCH v2 3/3] dt-bindings: display: panel: mipi-dbi-spi: Add
 io-supply
Message-ID: <166993987552.1741002.2270540744689432336.robh@kernel.org>
References: <20221201160245.2093816-1-otto.pflueger@abscue.de>
 <20221201160245.2093816-4-otto.pflueger@abscue.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221201160245.2093816-4-otto.pflueger@abscue.de>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 01 Dec 2022 17:02:45 +0100, Otto Pflüger wrote:
> Add documentation for the new io-supply property, which specifies the
> regulator for the I/O voltage supply on platforms where the panel
> panel power and I/O supplies are separate.
> 
> Signed-off-by: Otto Pflüger <otto.pflueger@abscue.de>
> ---
>  .../bindings/display/panel/panel-mipi-dbi-spi.yaml        | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

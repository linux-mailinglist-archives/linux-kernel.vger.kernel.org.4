Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4B2E6BDBC7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 23:36:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbjCPWgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 18:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbjCPWgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 18:36:15 -0400
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BDFFBDD1C;
        Thu, 16 Mar 2023 15:36:05 -0700 (PDT)
Received: by mail-il1-f172.google.com with SMTP id a13so1830829ilr.9;
        Thu, 16 Mar 2023 15:36:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679006165;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WGmqBO8tvtG99/0k+ELulYxIgVhet2LAkasG7nMBflU=;
        b=SgHByLiLxhdOSQ1K0fy8fFUvgSYT6xW6BXTH1MtMiNQQ2R+WKoah4N/VCRIXs4GPef
         mJJI1M3AOnq7hzgMwZG0pbpF3MOzkd9AAjj05nrEwy+sLQzWsqakfR0XQYBSwPZiXMP8
         xdOOhlfOxOo9NIRvgVbGvTtbQCQMSinhnE/UfCSA9zivt5UOXmdZ/nHo85lozL9iHTZw
         zgWkcJrWC92HjZSHWbuemIM4jPE4X2Gw2Ek0gdSbNTtUDPzmpSh+2UVesBHNGsbggytl
         anwY9boQQALlO4pn7B85JNIPTniPj6JViNVQiI/dS5FTBwkUwLtCLXTH5tBwPzuR2yq0
         PeBw==
X-Gm-Message-State: AO0yUKVcpRHrfQl1cKHm8z7E0RejXnCWjRP7B68TfFcnSX3fPR7ulEgv
        rYPidNADu6E2hT4w13+feA==
X-Google-Smtp-Source: AK7set/CrJeH6VccMrXbVdIiMGuP3h22tHMJ9Qj/yyC9FRABV2twpZnJk9b3XH2fZ4Qmu2QJFA8b9g==
X-Received: by 2002:a05:6e02:f86:b0:318:1cff:5e18 with SMTP id v6-20020a056e020f8600b003181cff5e18mr597404ilo.3.1679006164805;
        Thu, 16 Mar 2023 15:36:04 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id u19-20020a02b1d3000000b004054a9c3fb8sm155566jah.89.2023.03.16.15.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 15:36:04 -0700 (PDT)
Received: (nullmailer pid 4013517 invoked by uid 1000);
        Thu, 16 Mar 2023 22:36:02 -0000
Date:   Thu, 16 Mar 2023 17:36:02 -0500
From:   Rob Herring <robh@kernel.org>
To:     bchihi@baylibre.com
Cc:     ye.xingchen@zte.com.cn, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org, rafael@kernel.org,
        matthias.bgg@gmail.com, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, devicetree@vger.kernel.org,
        amitk@kernel.org, james.lo@mediatek.com, rex-bc.chen@mediatek.com,
        linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
        linux-mediatek@lists.infradead.org,
        angelogioacchino.delregno@collabora.com, khilman@baylibre.com,
        p.zabel@pengutronix.de, linux-pm@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Subject: Re: [PATCH 1/4] dt-bindings: thermal: mediatek: Add AP domain to
 LVTS thermal controllers for mt8195
Message-ID: <167900616235.4013462.1734891901730113817.robh@kernel.org>
References: <20230307154524.118541-1-bchihi@baylibre.com>
 <20230307154524.118541-2-bchihi@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230307154524.118541-2-bchihi@baylibre.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 07 Mar 2023 16:45:21 +0100, bchihi@baylibre.com wrote:
> From: Balsam CHIHI <bchihi@baylibre.com>
> 
> Add AP Domain to LVTS thermal controllers dt-binding definition for mt8195.
> 
> Signed-off-by: Balsam CHIHI <bchihi@baylibre.com>
> ---
>  include/dt-bindings/thermal/mediatek,lvts-thermal.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>


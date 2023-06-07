Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 671E572696F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 21:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233130AbjFGTF0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 15:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233097AbjFGTFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 15:05:24 -0400
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B8AF1BF7;
        Wed,  7 Jun 2023 12:05:24 -0700 (PDT)
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-33b0bfb76cfso6072545ab.2;
        Wed, 07 Jun 2023 12:05:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686164723; x=1688756723;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=figfwtvOwiBf/xUpTgDHOe/+/jU9SkWfSgFbF/zJYLM=;
        b=BCQcBXPqnR5ihQvI+2WzdLbrQA6FaZpRWGM5Zm7UNU+jcGA2s2xHpmLGp7grjDB+p0
         YPAjuFmyuu6LdWNQ7R+c0IgvUGtYFK49P6Dt4kY7HtY2fdqiBfKimNoyw2QADmHtwdPQ
         hpZtIUxxDAuA58znxyQvfRSzodluUGTuwIAmDV4x1iKDrPw49U1Rj9MujGJDDPawvLP3
         18TCgvW8a5Hm/uSdr4Yz2v6nYQqTj3yLcRQv414qXkP5u10XSGdx8v6C7K8PT4FLPIpo
         af0AwmfqypNAv8FshrD8YmVjWZUJNnvKe2F6wBFPUE6SxJRhNIRiaNJ0YmFckyBAnIYG
         yphg==
X-Gm-Message-State: AC+VfDyoQTIOdmSGZQR6d6qhBYogb7dATtlPcxpG0dCSP/gA2b7nRYzx
        a8krp6CB/0OHDxSwMt5MTg==
X-Google-Smtp-Source: ACHHUZ4xcqktIrvSensylRmtZw8kuAdpLj5SvxnY4MXQFmF5N/oMep/sLguTKrjxJpwtErgjNBzItw==
X-Received: by 2002:a92:db48:0:b0:32b:75bc:cda2 with SMTP id w8-20020a92db48000000b0032b75bccda2mr4888663ilq.22.1686164723349;
        Wed, 07 Jun 2023 12:05:23 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id p8-20020a92d488000000b003383276d260sm3807794ilg.40.2023.06.07.12.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 12:05:22 -0700 (PDT)
Received: (nullmailer pid 3779658 invoked by uid 1000);
        Wed, 07 Jun 2023 19:05:20 -0000
Date:   Wed, 7 Jun 2023 13:05:20 -0600
From:   Rob Herring <robh@kernel.org>
To:     Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc:     linux-kernel@vger.kernel.org, gabriel.fernandez@foss.st.com,
        Michael Turquette <mturquette@baylibre.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>, gabriel.fernandez@st.com,
        Alexandre TORGUE <alexandre.torgue@foss.st.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v2] dt-bindings: rcc: stm32: Sync with u-boot copy for
 STM32MP13 SoC
Message-ID: <168616471902.3779570.15724807223592608191.robh@kernel.org>
References: <20230510184305.v2.1.I417093ddcea282be479f10a37147d1935a9050b7@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230510184305.v2.1.I417093ddcea282be479f10a37147d1935a9050b7@changeid>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 10 May 2023 18:51:40 +0200, Patrick Delaunay wrote:
> Minor cosmetic change, aligned with files in U-Boot:
> - change obsolete SPDX id : GPL-2.0+ and use the same license
>   GPL-2.0-only for the 2 files
> - use correct mail address gabriel.fernandez@foss.st.com
> - remove extra space
> 
> Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> ---
> 
> Changes in v2:
> - Change title "Fix STM32MP13 include file"
> - Use the same license for the 2 files GPL-2.0-only as recommended
>   to avoid check-patch issue on next
> 
>  include/dt-bindings/clock/stm32mp13-clks.h   | 6 +++---
>  include/dt-bindings/reset/stm32mp13-resets.h | 4 ++--
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>


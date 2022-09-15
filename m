Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94DA45B9C37
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 15:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbiIONpF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 09:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbiIONob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 09:44:31 -0400
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6611298762;
        Thu, 15 Sep 2022 06:44:14 -0700 (PDT)
Received: by mail-oi1-f174.google.com with SMTP id o204so2265285oia.12;
        Thu, 15 Sep 2022 06:44:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=gMxTOzHkcWge9Q4IbSisMNPR1RGRWkYO9XtQCHRh3ms=;
        b=TEO2sCL/aFR9F3dzJdQhDu9qQFFKUa1zDvLH9fPR3vbm0Ac6cWwItXnwonQUQC1ruy
         XYhECCQqf3o+hDzk5v3egd5EyXuACkJarM0WcgJwX/o/0UuQfwJX1Vbs3t1xkHXKN8l9
         13HJ9zxs6W7yQhVaflgMZE1Zb9DDtHIovc4V1cD4kbV4CjVfXXMPOVWQrrYR5FFznA+V
         0gikp+2byTt7obuiWFNW4bbIwZaVXmETcJ0WjxdJ8ehQX6uh7qY+1kxDhzzSfZs5QnuE
         6Kf+vkrdhiYQeLUszcibQwr+8edSsvq5VvaExuOQ24cD1odHBtE/iYmndlEaWxhcYUyo
         JOig==
X-Gm-Message-State: ACgBeo1haDr9OrDj1g/p1Hy/xGUTHS7MsGRAGhLMCN9nQ+bBwAMbBWSR
        arrintZRGYtFvORgoNgrZA==
X-Google-Smtp-Source: AA6agR5SNtXFe4DrKZFjR7FljpNxxvhmRUx65guYUAHT/NFf+H7R9cIUqitMOcQ1JIiP3ZGWRLgxLw==
X-Received: by 2002:a05:6808:16a4:b0:34f:8f51:3cd6 with SMTP id bb36-20020a05680816a400b0034f8f513cd6mr4526617oib.17.1663249453552;
        Thu, 15 Sep 2022 06:44:13 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id i27-20020a4a6f5b000000b0046d91d5285asm7887651oof.39.2022.09.15.06.44.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 06:44:13 -0700 (PDT)
Received: (nullmailer pid 1169330 invoked by uid 1000);
        Thu, 15 Sep 2022 13:44:12 -0000
Date:   Thu, 15 Sep 2022 08:44:12 -0500
From:   Rob Herring <robh@kernel.org>
To:     Julius Werner <jwerner@chromium.org>
Cc:     Jian-Jia Su <jjsu@google.com>, Dmitry Osipenko <digetx@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH 2/4 v4] dt-bindings: memory: Add numeric LPDDR compatible
 string variant
Message-ID: <20220915134412.GB1168889-robh@kernel.org>
References: <20220915003222.1296421-1-jwerner@chromium.org>
 <20220915003222.1296421-2-jwerner@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220915003222.1296421-2-jwerner@chromium.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Sep 2022 17:32:20 -0700, Julius Werner wrote:
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
> - v3
>   - no changes
> - v4
>   - no changes
> 


Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.


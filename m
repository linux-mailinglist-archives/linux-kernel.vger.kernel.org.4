Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BCC25EB4FC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 01:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbiIZXCq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 19:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiIZXCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 19:02:41 -0400
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1629A720A;
        Mon, 26 Sep 2022 16:02:39 -0700 (PDT)
Received: by mail-ot1-f54.google.com with SMTP id br15-20020a056830390f00b0061c9d73b8bdso5388421otb.6;
        Mon, 26 Sep 2022 16:02:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=TmS5+X4pLYVYH89RFG+N2VbfzYq4t5hSiusvv4Jlq5I=;
        b=QR7l/2MmHkaT0SUzKijCLrD9ngRyW/htGUD1Kg5lZGTZFkYoSP2GA83+nxcHeWgHYF
         SMVCVsTtqC232kJGq6aAwBzKsUQ6U8UVxs+XpdCtvFF9OQeu1d4szJG5zZtXXDmUlmGv
         j0vsgqZPU2jZX8wsYbxXDwRsNqH2rK8xodHPS/JKJ2po0FyR2QSM9/t+zfLKHL9h1iQl
         /8YtD5LEJTE6ZNg/C10o5K2LUAZHKWR+NpuNz06wUemdh2CYLminvddi+U5DQdOdOhXE
         PKn87KOzC5kAjh1Z4NMSnGFiJ0mLLE7AuSOy9AQHLGvomVfFQlHwp5JOfAGQMNi+F/Ub
         rBsg==
X-Gm-Message-State: ACrzQf3BnBFD3cfDz4ay+2uHEvTQwliyuii1GLjamhkeji3kQ5QSPNea
        vjm/leSDuQrxs5UcV0LkIA==
X-Google-Smtp-Source: AMsMyM64gmuEGrnM1z+5TQNLgzvx4Cn9fhx9QC2j1LdnTPhHdfqmycio7t54+hj8gvjrM9lGXLXWAg==
X-Received: by 2002:a05:6830:13d0:b0:655:cad8:e57 with SMTP id e16-20020a05683013d000b00655cad80e57mr11115841otq.156.1664233358887;
        Mon, 26 Sep 2022 16:02:38 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id k67-20020a9d19c9000000b006396521c804sm8382105otk.55.2022.09.26.16.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 16:02:38 -0700 (PDT)
Received: (nullmailer pid 3128731 invoked by uid 1000);
        Mon, 26 Sep 2022 23:02:37 -0000
Date:   Mon, 26 Sep 2022 18:02:37 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-pm@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2] dt-bindings: power: reset: restart-handler: add
 common schema
Message-ID: <20220926230237.GA3128685-robh@kernel.org>
References: <20220923203603.515714-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220923203603.515714-1-krzysztof.kozlowski@linaro.org>
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

On Fri, 23 Sep 2022 22:36:03 +0200, Krzysztof Kozlowski wrote:
> Add common schema for restart and shutdown handlers, so they all use
> same meaning of "priority" field.  The Linux drivers already have this
> property and some systems want to customize it per-board in DTS.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Changes since v1:
> 1. Use double ':'
> 
> v1 was marked as changes-requested in Rob's patchwork, but I think there
> was not actual consensus on any other changes to make.
> 
> v1:
> https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20220907123630.57383-1-krzysztof.kozlowski@linaro.org/
> 
> See also:
> https://lore.kernel.org/all/8fe93da3-f768-16ae-7025-1cfa97a42b27@linaro.org/
> https://lore.kernel.org/all/20220831081715.14673-1-pali@kernel.org/
> ---
>  .../bindings/power/reset/gpio-restart.yaml    | 13 ++------
>  .../bindings/power/reset/restart-handler.yaml | 30 +++++++++++++++++++
>  2 files changed, 33 insertions(+), 10 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/power/reset/restart-handler.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>

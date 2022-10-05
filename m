Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9F745F5544
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 15:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbiJENZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 09:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbiJENY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 09:24:59 -0400
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F3A1EEF8;
        Wed,  5 Oct 2022 06:24:56 -0700 (PDT)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-131dda37dddso18881974fac.0;
        Wed, 05 Oct 2022 06:24:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XblGBiVWunq/5AH0NgRtHm6ev1QmpK3EFUSqh7n0QCs=;
        b=chNlxh/chLgxx8kA0m7lGjw8mYD5C2f2ivMAyVcismBzktvgyZgzHWPv+X5TPnKc7Y
         o4dD5Wj+gPPfvqexHWcuL0TRnakals3CyIk33vX6gZg+Yni3q9j5TUD7em/gIwbmhlyI
         4ZJzY2NIfe5c8tO1PrQjgfT5oymYSA3+3QJI34NionX+5+sbqA/bfNY2zpDPds9I7Wpq
         oRn0cH1v9dh88B1n+4N+hqfrbsLkVbJRUoXDo6yuPEmQZm542jlvo55ny+2bfDKWUFAm
         qpLH7sliyt+A23vO3gCNqSvGeLkyZb8rn3F6GPo45TTBBzyGb8uvqabTebbQTVCDTvSi
         yKHA==
X-Gm-Message-State: ACrzQf0fSOSMERMe9aGp8g3sy9mRo9T/eaIhTS5Sq2NAZBr3HSFh8LUU
        k6/KRqC14l8YVp2Vky0H6zrK2jCk6Q==
X-Google-Smtp-Source: AMsMyM4zkR5tqtiek9zvCWt7nguIIlXqUbUFSNk1htu3119sr35KNk94ROL7OzkIy6DikpU9egKzvQ==
X-Received: by 2002:a05:6870:612c:b0:132:a4d3:e0d8 with SMTP id s44-20020a056870612c00b00132a4d3e0d8mr2533657oae.95.1664976295307;
        Wed, 05 Oct 2022 06:24:55 -0700 (PDT)
Received: from robh_at_kernel.org ([2607:fb90:5fee:ea3a:4239:ad4:650a:6e66])
        by smtp.gmail.com with ESMTPSA id m125-20020aca3f83000000b0034ffacec0basm4277982oia.15.2022.10.05.06.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 06:24:54 -0700 (PDT)
Received: (nullmailer pid 3268023 invoked by uid 1000);
        Wed, 05 Oct 2022 13:24:53 -0000
Date:   Wed, 5 Oct 2022 08:24:53 -0500
From:   Rob Herring <robh@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, devicetree@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>,
        Hector Martin <marcan@marcan.st>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        Sven Peter <sven@svenpeter.dev>, towinchenmi@gmail.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: apple,aic: Document A7-A11
 compatibles
Message-ID: <166497629188.3267955.11156012087252607194.robh@kernel.org>
References: <20221004112724.31621-1-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221004112724.31621-1-konrad.dybcio@somainline.org>
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

On Tue, 04 Oct 2022 13:27:23 +0200, Konrad Dybcio wrote:
> Document the compatibles for Apple A7-A11 SoCs.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> ---
> Changes since v2:
> - drop s5l8960x fallback for A8-A11, now apple,aic is the fallback for all
> 
>  .../bindings/interrupt-controller/apple,aic.yaml          | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>

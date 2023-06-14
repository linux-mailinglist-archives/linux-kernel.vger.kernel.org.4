Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79CCE730B17
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 01:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233272AbjFNXAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 19:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjFNXAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 19:00:49 -0400
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51F30211D;
        Wed, 14 Jun 2023 16:00:48 -0700 (PDT)
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-33cb82122c7so30244025ab.1;
        Wed, 14 Jun 2023 16:00:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686783647; x=1689375647;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6RZOm4/qsqljNAn5DDwj0i4QvMF+OH3D+Yj42xVFIXE=;
        b=d1zvGT9BplMBk5wTJbptGMXHEDbfe7m1yCG9dhf1fMBXsAqVPWWuGRM1ANR0jf5V/f
         xWf5O7Zdi/YZoqT6w/SSVJQ6lzZNHu9VWa1Cq/xcLf1sxWwz2MbA6HzHxPA8/liipGv2
         VrV78cagO1s+FjOSavsbORrtPyEtIv8AcjT4gzUNobx2Q4RrdXUAOYy7a0L/vxU/4R5Z
         g77EqlSwnM0x5PZXAUXhHrljluFRubsyoOHo0ArLPXzie+z28BiMX+9FJOVlUgkQkTsy
         U0hxpT/5j7HyPtsGJdbdwS+qrZygBx4cZYO2yotPsVkfuy4rhlD3M/YJJbg4D3fRue6C
         Gr3A==
X-Gm-Message-State: AC+VfDzbuk/64DmuMHn23r8mUbggesN3V23Qj7D9zeqwGgAtkVLoTaNU
        QnFNyMTxadZCGUFrAIHHiA==
X-Google-Smtp-Source: ACHHUZ5Shx7XgX4uzqxXwfrN69JGCNYVb1kQNCoGU85ystsCfK9wt6w4QE572JyzEsAzoFIVsH48TQ==
X-Received: by 2002:a92:cd06:0:b0:33b:1635:359f with SMTP id z6-20020a92cd06000000b0033b1635359fmr14095451iln.22.1686783647471;
        Wed, 14 Jun 2023 16:00:47 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id q15-20020a02c8cf000000b0040f7db6a264sm5228754jao.114.2023.06.14.16.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 16:00:46 -0700 (PDT)
Received: (nullmailer pid 3022170 invoked by uid 1000);
        Wed, 14 Jun 2023 23:00:44 -0000
Date:   Wed, 14 Jun 2023 17:00:44 -0600
From:   Rob Herring <robh@kernel.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nikunj Kela <nkela@quicinc.com>,
        Prasad Sodagudi <psodagud@quicinc.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH 09/16] dt-bindings: firmware: arm,scmi: Extend bindings
 for protocol@13
Message-ID: <20230614230044.GA3019052-robh@kernel.org>
References: <20230607124628.157465-1-ulf.hansson@linaro.org>
 <20230607124628.157465-10-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230607124628.157465-10-ulf.hansson@linaro.org>
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

On Wed, Jun 07, 2023 at 02:46:21PM +0200, Ulf Hansson wrote:
> The protocol@13 node is describing the performance scaling option for the
> ARM SCMI interface, as a clock provider. This is unnecessary limiting, as
> performance scaling is in many cases not limited to switching a clock's
> frequency.
> 
> Therefore, let's extend the binding so the interface can be modelled as a
> generic "performance domain" too. The common way to describe this, is to
> use the "power-domain" bindings, so let's use that.

What's wrong with the performance-domain binding?

> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> Cc: Conor Dooley <conor+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  Documentation/devicetree/bindings/firmware/arm,scmi.yaml | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> index 5824c43e9893..cff9d1e4cea1 100644
> --- a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> +++ b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> @@ -145,8 +145,8 @@ properties:
>        '#clock-cells':
>          const: 1
>  
> -    required:
> -      - '#clock-cells'
> +      '#power-domain-cells':
> +        const: 1
>  
>    protocol@14:
>      $ref: '#/$defs/protocol-node'
> -- 
> 2.34.1
> 

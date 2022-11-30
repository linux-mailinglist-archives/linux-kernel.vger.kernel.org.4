Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C86AD63E29E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 22:21:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbiK3VVy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 16:21:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbiK3VVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 16:21:48 -0500
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A5A8C452;
        Wed, 30 Nov 2022 13:21:46 -0800 (PST)
Received: by mail-oi1-f170.google.com with SMTP id s141so2443043oie.10;
        Wed, 30 Nov 2022 13:21:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D6oucUpw2izyyoNZHfAlvHQCZA+vRw/APBGaY6rSHO4=;
        b=vRYjsbEvswKTce5pM8fOsghh1su4NVBmYoa6pBAfEX0NuVf5z28DxC6U4/hKgK+PTP
         ezt7vV9Xrgka7308nAfuiWVni8crfQqWFi4znFuPax1vuRBg8It2Uk2WkWov2qLwxKze
         p/ir6yLRk5daF3SbMENJ1LxXa2lejQ6cgLbDG8cXtZ22A72Zy5Eup94904HZk9s87KIy
         WtWzZFkS/ipU1TCiQYCez8QepxPvTpoqhDzW+Vpvyr9v9FviMFVYbXrEtYObCWe0zjPc
         193OrJ/2eBk2uh8OiHSjD3GrXasFD9elXjlz+XwhobGrivlwc8JfhLr9R8p1ftC2DYI/
         o8LQ==
X-Gm-Message-State: ANoB5plXOiBuWRNbmKcEzhsH9BJNT9qho2xFxgoloO45yypcMvmBk5SA
        FYTOXKnRX1BfimVjNSEWPw==
X-Google-Smtp-Source: AA0mqf6BIW6n9xsEakRHiyi02adKnCXXX6hTdoNR7GbdbCF0SqOB0EDvZzI2IbYpVhxJFs+tr2S3tw==
X-Received: by 2002:a05:6808:2394:b0:35b:a08d:5d67 with SMTP id bp20-20020a056808239400b0035ba08d5d67mr11242808oib.291.1669843306204;
        Wed, 30 Nov 2022 13:21:46 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id p184-20020acabfc1000000b00354efb5be11sm1078550oif.15.2022.11.30.13.21.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 13:21:45 -0800 (PST)
Received: (nullmailer pid 2948741 invoked by uid 1000);
        Wed, 30 Nov 2022 21:21:44 -0000
Date:   Wed, 30 Nov 2022 15:21:44 -0600
From:   Rob Herring <robh@kernel.org>
To:     Rahul Tanwar <rtanwar@maxlinear.com>
Cc:     devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-lgm-soc@maxlinear.com,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v5 2/4] dt-bindings: x86: apic: Introduce new optional
 bool property for lapic
Message-ID: <166984330418.2948681.17674473045828402706.robh@kernel.org>
References: <20221124084143.21841-1-rtanwar@maxlinear.com>
 <20221124084143.21841-3-rtanwar@maxlinear.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221124084143.21841-3-rtanwar@maxlinear.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 24 Nov 2022 16:41:41 +0800, Rahul Tanwar wrote:
> Intel defines a few possible interrupt delivery modes. With respect
> to boot/init time, mainly two interrupt delivery modes are possible.
> PIC Mode - Legacy external 8259 compliant PIC interrupt controller.
> Virtual Wire Mode - use lapic as virtual wire interrupt delivery mode.
> 
> For ACPI or MPS spec compliant systems, it is figured out by some read
> only bit field/s available in their respective defined data structures.
> But for OF based systems, it is by default set to PIC mode. Presently,
> it is hardcoded to legacy PIC mode for OF based x86 systems with no
> option to choose the configuration between PIC mode & virtual wire mode.
> 
> For this purpose, introduce a new boolean property for interrupt
> controller node of lapic which can allow it to be configured to virtual
> wire mode as well.
> 
> Property name: 'intel,virtual-wire-mode'
> Type: Boolean
> 
> If not present/not defined, interrupt delivery mode defaults to legacy PIC
> mode. If present/defined, interrupt delivery mode is set to virtual wire
> mode.
> 
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Rahul Tanwar <rtanwar@maxlinear.com>
> ---
>  .../interrupt-controller/intel,ce4100-lapic.yaml   | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

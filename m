Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5885C6D6872
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 18:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235398AbjDDQKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 12:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231564AbjDDQKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 12:10:30 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33ADB2115
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 09:10:29 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id gp15-20020a17090adf0f00b0023d1bbd9f9eso36704627pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 09:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680624628;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v+B/JT9f2XQi1Ts+26L2tM44cn4QZI62fpiXlWnzWlM=;
        b=lEqWaYKvGS7RXgQrB43Gj6wldMofXYAD3zRvzH9erZ4JHbHYcm6fYKUOS9kNlhuEdt
         ytmY6larNVlfzr1/mJV0SDDx4LQ2SnldxKtBEYHlExKnyQtqnDRZgFBpmhXQ6QPLQCbb
         otSFsObTzE5yVWrZNJ6ukvyhluIfdi4DCKrP5XOsIUhbjFEKA5juub9oecxiKDFN7z3V
         JzwHJ3G0NmXrnvvZqZ7dAv6ruGtLfGMh1WRbX5gbMzAZv85YYo29GpJFz9gqtnPYBrLO
         UO9fzQ0sLAR9O8a/6xnP/nrldazdOryJaBfdfKa1Gyeb+MeJEZqTX2xrbxEsvPalgXMo
         cbQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680624628;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v+B/JT9f2XQi1Ts+26L2tM44cn4QZI62fpiXlWnzWlM=;
        b=iDGOPMBFzeV7ZNoA73+9AKjhTAXXoJ7Iy++k2kG2Rsr0kRMMP73f6TGNaUkwf+bzMb
         05Q3YrtY2kIWDg/jjK6F34N5mvPTtyftkgktjCWg25rWAf0HJRjG/rDPT8VYGcBFkD5t
         5rN4N5ZGtbdaBrQ22lyZdjcfOn3JH7y766ZrChoFy0ZYkTo64AkShWEQMbar3Wkqfvn4
         9MESuu503Q0g0eeCZcd3g0WGwzkpPGMZGO6Ofes43/HVM/byiLmplPa4jzSyzRVDgpHo
         9Pi+GniSyBnjYnRVI0fabQlzOZ4ldp9mLIyY1EizmMicSgDzSG3k8IDmqK942enV4Or9
         KeQQ==
X-Gm-Message-State: AAQBX9frLJNBXyeRQQCfVUNIA0pnyG/yd1eqquFMkCoUckutOHw9Acx2
        4NOzNA8pt8tydRujua8oFVqU2g==
X-Google-Smtp-Source: AKy350aSm43AJ/Lm9e7dDPcWPamSbUIIzv9qUSXk4b2xDFieXZHxj/jx0Xqen335Rs1Xo+vkld9V1Q==
X-Received: by 2002:a17:902:f311:b0:1a2:19c1:a974 with SMTP id c17-20020a170902f31100b001a219c1a974mr2230568ple.68.1680624628594;
        Tue, 04 Apr 2023 09:10:28 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:5720:7b2b:8f9d:fb9])
        by smtp.gmail.com with ESMTPSA id x13-20020a170902b40d00b0019a70a85e8fsm8502009plr.220.2023.04.04.09.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 09:10:28 -0700 (PDT)
Date:   Tue, 4 Apr 2023 10:10:25 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, mike.leach@linaro.org,
        james.clark@arm.com, anshuman.khandual@arm.com, leo.yan@linaro.org,
        linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH] MAINTAINERS: Remove Mathieu Poirier as coresight
 maintainer
Message-ID: <20230404161025.GA3755681@p14s>
References: <20230404111117.569795-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230404111117.569795-1-suzuki.poulose@arm.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 04, 2023 at 12:11:17PM +0100, Suzuki K Poulose wrote:
> Mathieu Poirier is no longer involved in maintainig the CoreSight self-hosted
> tracing subsystem.
> 
> Mathieu, Thank you very much creating and maintaing the subsystem all these
> years !
>

The CoreSight subsytem is definitely in good hands with you guys...

> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Acked-by: Mathieu Poirier <mathieu.poirier@linaro.org>

> ---
>  CREDITS     | 5 +++++
>  MAINTAINERS | 1 -
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/CREDITS b/CREDITS
> index 847059166a15..216e86f56dd9 100644
> --- a/CREDITS
> +++ b/CREDITS
> @@ -3459,6 +3459,11 @@ D: several improvements to system programs
>  S: Oldenburg
>  S: Germany
>  
> +N: Mathieu Poirier
> +E: mathieu.poirier@linaro.org
> +D: CoreSight kernel subsystem, Maintainer 2014-2022
> +D: Perf tool support for CoreSight
> +
>  N: Robert Schwebel
>  E: robert@schwebel.de
>  W: https://www.schwebel.de
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 90abe83c02f3..6c971e95a6fd 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2091,7 +2091,6 @@ F:	arch/arm/boot/dts/cx92755*
>  N:	digicolor
>  
>  ARM/CORESIGHT FRAMEWORK AND DRIVERS
> -M:	Mathieu Poirier <mathieu.poirier@linaro.org>
>  M:	Suzuki K Poulose <suzuki.poulose@arm.com>
>  R:	Mike Leach <mike.leach@linaro.org>
>  R:	Leo Yan <leo.yan@linaro.org>
> -- 
> 2.34.1
> 

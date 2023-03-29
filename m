Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D89C06CF6E8
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 01:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbjC2XVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 19:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbjC2XVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 19:21:41 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D00DE3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 16:21:40 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id d13so15611846pjh.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 16:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680132099;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=f8qo35RjOtl0n5atRPRPgKBlfz3NPfN74R+gLtzfZno=;
        b=AN5lakAYU2YwPCZv5IXuj8GImGfbiFxNyWPd3Q/bKzGa9cJwZIwQykHgDyV13HGeIh
         2+cvZJrWFjI1ZLBjtQ6fLRtYbrs3825m0X8pEzkaEOCKmyqbBltR9IbedLVRxERV6DED
         L0j+Nl+K5VxahabLRNDTbJ+6dQiovSSGWtO5pytkfsab5slgNL4mFmI0m+bd0vChKsIL
         8FnfO2py1Xy4T1PpSFdaLntUmgcRioQzFCBTHc2ABf/Hwf8bs45VseM/EAaXUG+gjIFz
         smY8R09TRfqbAdea1J2LPVDk4+kXbz9mi8IZUfMGxEqaPTu1VwuLfT4sPJPEygZv9uhp
         /Wdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680132099;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f8qo35RjOtl0n5atRPRPgKBlfz3NPfN74R+gLtzfZno=;
        b=nogUWqbCnHiLQ4KSM7IdYtlBPMCdxQmOigj4mhhLmV8qgaQbhf2bgTp7y+n7Ihg1UG
         eCrfF5AFHqnQpbMvbR4LJqXxLulPdwhtLUo5BSVUtWreGXSsaSyBjRDUvpP8MEMjl14l
         3jut1XTEQMIUvTknk8sWcxkhEBTmYdBDXfMNGBpc/GMIV1cy6qOVTdLrFQbWqekhjKFo
         qyibuEvlhKA0FKFJhKMV/XzBNN4gTUkfqL5Hr58SDSCi+TGuEjNMfMFUp8tQQ1jdvfgC
         YHry6za5LsMOpZpvpigFl8qK+O4rnoD29d3HL/nNnVvuC1cl2d0BjIsJ17hcD+Kgn6ht
         G3Lw==
X-Gm-Message-State: AAQBX9dlwFzluhNkeGwvW6VeTfCSiPze/GsS/6Wnr0ahsCbKLv4A3Al7
        Xqt5+iIn73NXnWSG1uIfyihauQ==
X-Google-Smtp-Source: AKy350ZA6kI8qQtbdbWubei9iqLpNRAeZyjVREBI4+sHgF4nxpOQ5nQ6k6XwQ62VniYIKK3I3R7gcQ==
X-Received: by 2002:a17:90b:1e4f:b0:23f:4dfd:4fc1 with SMTP id pi15-20020a17090b1e4f00b0023f4dfd4fc1mr23913116pjb.43.1680132099571;
        Wed, 29 Mar 2023 16:21:39 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:6b79:83ab:5e33:50a5])
        by smtp.gmail.com with ESMTPSA id d5-20020a17090a2a4500b0023efa52d2b6sm1915857pjg.34.2023.03.29.16.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 16:21:39 -0700 (PDT)
Date:   Wed, 29 Mar 2023 17:21:36 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Devarsh Thakkar <devarsht@ti.com>
Cc:     andersson@kernel.org, devicetree@vger.kernel.org,
        p.zabel@pengutronix.de, linux-remoteproc@vger.kernel.org,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, s-anna@ti.com, hnagalla@ti.com,
        praneeth@ti.com, nm@ti.com, vigneshr@ti.com, a-bhatia1@ti.com,
        j-luthra@ti.com, rogerq@kernel.org
Subject: Re: [PATCH v8 0/3] Add single core R5F IPC for AM62 SoC family
Message-ID: <20230329232136.GA3393405@p14s>
References: <20230327152832.923480-1-devarsht@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230327152832.923480-1-devarsht@ti.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2023 at 08:58:29PM +0530, Devarsh Thakkar wrote:
> AM62 SoC family don't have a multicore R5F cluster,                             
> instead they have a single core R5F.                                            
> This enables IPC support with single core R5F for AM62                          
> family of SoCs.
> 
> While at it, also simplify the cluster mode setting usage
> by using soc_data specific checks only at probe.
> 
> Devarsh Thakkar (3):
>   remoteproc: k3-r5: Simplify cluster mode setting usage
>   dt-bindings: remoteproc: ti: Add new compatible for AM62 SoC family
>   remoteproc: k3-r5: Use separate compatible string for TI AM62x SoC
>     family
> 
>  .../bindings/remoteproc/ti,k3-r5f-rproc.yaml  |  76 ++++++++---
>  drivers/remoteproc/ti_k3_r5_remoteproc.c      | 127 ++++++++++++------
>  2 files changed, 138 insertions(+), 65 deletions(-)

I have applied this set.

Thanks,
Mathieu

> ---
> V2:                                                                             
>   - dt-bindings: Avoid acronyms, use "Device Manager" instead of "DM"           
> V3:                                                                             
>   - dt-bindings: Use separate if block for each compatible for                  
>     ti,cluster-mode property                                                    
>   - dt-bindings: Rearrange compatibles as per alphabatical order                
> V4:                                                                             
>   - dt-bindings: Place each enum in separate line in allOf                      
> V5:                                                                             
>   - No change (fixing typo in email address)                                    
> V6:                                                                             
>   - dt-bindings: Remove reviewed-by due to new modifications to use             
>     cluster-mode=3                                                              
>     Introduce Simplify cluster-mode setting preamble patch per review           
> comments                                                                        
>   - Use CLUSTER_MODE_SINGLECORE for AM62x                                       
>   - Set PROC_BOOT_CFG_FLAG_R5_SINGLE_CORE for single core.                      
> V7:                                                                             
>   - Override to appropriate cluster-mode per firmware status flag               
>     without checking soc_data                                                   
>   - Set appropriate mode as default if not provided in DT                       
>   - Check mode validity against SoC data during probe                           
>   - Rebase on top of 6.3 linux-next                                             
> V8:                                                                             
>   - Avoid using soc_data while overriding cluster mode for IPC-only mode  
> -- 
> 2.34.1
> 

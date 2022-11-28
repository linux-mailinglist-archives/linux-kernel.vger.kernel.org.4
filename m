Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1111A63AEB9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 18:18:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232910AbiK1RSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 12:18:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232903AbiK1RR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 12:17:59 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B872BF5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 09:17:58 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id k5so10144679pjo.5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 09:17:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XLdUnL0wA67xH3uPfTJaGkkNCljEYOw6YgU8NoVz4bg=;
        b=yJVIxDvXFka2qUujlZIJjlFfYATp29B6BBaF51bGgaQtJOnIsctkLpSuKR9gJzYCKf
         XsS/tgpE0FSRp58KJJVhAE726p7Rl6llXMnLLLKmG7VjNMh+9AFVzhFLDOX8Di9M2206
         37MiQ5gDOax4f7/ycb7xQdzG2joLzzvaIL+obi1isRbfCEwtS78VpKXE0aOxFZcod0zH
         Cc0hH6SR7moTwDTTsn2Na5u8cJ9xxWUoZitxOmRtZT3orC1xP9z2mUsxGrEAg7A6g3o8
         olbvWS+DTLu8omaoXqrLojYGzCDJhMCIb4KWQb26k/48zQyQ3m3Cx4t1r8x3VuhWXZ68
         ghzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XLdUnL0wA67xH3uPfTJaGkkNCljEYOw6YgU8NoVz4bg=;
        b=7nG/P2a5+5AbN/CHvs4c/zx/unRACrZy71NiM2SG0RPbUgVH9iddY2UrBuN4b9AGRz
         PSzNK+zxdKFfSvf09JVU/oTdR9yNXXmLieTs5Lzhab0Wa09nzUfsJxMgBS9+jXo3LNae
         1j/uQjqxtjA7iXAlH2wUmWSsZJSvGgu2sV6obSMdStfyO8mWBA2sl4LnFBnAk9v1zNWR
         DJjJHkEjx3z2UPZKzZIr5Bgnw3YSb5620xW7Y9DSrR+5bo7v+3OfcnroknmJraXiywNn
         c8ZRnuoqAJTx16R5KY/GCbpOtclvFUEtB34D5OYk+mSg2CvEWAqQhwoJTjmQtuL3LQwK
         m/RA==
X-Gm-Message-State: ANoB5pnROcc8Cfma4aDYoYtPZkovES++WOPsPH9nmFb8KU1PjuXG3Ymz
        xPr5w2CHFkEFtqnxXBioxVn8Vw==
X-Google-Smtp-Source: AA0mqf5ejOtQtgRIZgjHCUazH7TdmWH1m715Vqc1xOD8UkaYHogNY5gK2AnYz4vNyxAglE6lHTkrpw==
X-Received: by 2002:a17:903:1314:b0:189:86b4:c4a with SMTP id iy20-20020a170903131400b0018986b40c4amr7008067plb.30.1669655877981;
        Mon, 28 Nov 2022 09:17:57 -0800 (PST)
Received: from p14s ([2604:3d09:148c:c800:908e:93f3:e339:ae71])
        by smtp.gmail.com with ESMTPSA id l2-20020a170903244200b00176b3c9693esm9106112pls.299.2022.11.28.09.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 09:17:57 -0800 (PST)
Date:   Mon, 28 Nov 2022 10:17:54 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Devarsh Thakkar <devarsht@ti.com>
Cc:     andersson@kernel.org, p.zabel@pengutronix.de,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        s-anna@ti.com, hnagalla@ti.com, praneeth@ti.com, nm@ti.com,
        vigneshr@ti.com, a-bhatia1@ti.com, j-luthra@ti.com
Subject: Re: [PATCH 1/2] Documentation: dt-bindings: k3-r5f-rproc: Add new
 compatible for AM62 SoC family
Message-ID: <20221128171754.GB1010946@p14s>
References: <20221115060934.13279-1-devarsht@ti.com>
 <20221115060934.13279-2-devarsht@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221115060934.13279-2-devarsht@ti.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DT people need to ack this patch, and for that to happen they need to be
CC'ed on the patch, as checkpatch is explicitly instructing to do.

On Tue, Nov 15, 2022 at 11:39:33AM +0530, Devarsh Thakkar wrote:
> AM62 family of devices don't have a R5F cluster, instead
> they have single core DM R5F.
> Add new compatible string ti,am62-r5fss to support this scenario.
> 
> When this new compatible is used don't allow cluster-mode
> property usage in device-tree as this implies that there
> is no R5F cluster available and only single R5F core
> is present.
> 
> Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
> ---
>  .../bindings/remoteproc/ti,k3-r5f-rproc.yaml  | 48 +++++++++++++------
>  1 file changed, 34 insertions(+), 14 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/ti,k3-r5f-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/ti,k3-r5f-rproc.yaml
> index fb9605f0655b..1f5eae806c2f 100644
> --- a/Documentation/devicetree/bindings/remoteproc/ti,k3-r5f-rproc.yaml
> +++ b/Documentation/devicetree/bindings/remoteproc/ti,k3-r5f-rproc.yaml
> @@ -21,6 +21,9 @@ description: |
>    called "Single-CPU" mode, where only Core0 is used, but with ability to use
>    Core1's TCMs as well.
>  
> +  AM62 SoC family support a single R5F core only which is used for DM firmware
> +  and can also be used as a remote processor with IPC communication.
> +
>    Each Dual-Core R5F sub-system is represented as a single DTS node
>    representing the cluster, with a pair of child DT nodes representing
>    the individual R5F cores. Each node has a number of required or optional
> @@ -28,6 +31,9 @@ description: |
>    the device management of the remote processor and to communicate with the
>    remote processor.
>  
> +  Since AM62 SoC family only support a single core, there is no cluster-mode
> +  property setting required for it.
> +
>  properties:
>    $nodename:
>      pattern: "^r5fss(@.*)?"
> @@ -38,6 +44,7 @@ properties:
>        - ti,j721e-r5fss
>        - ti,j7200-r5fss
>        - ti,am64-r5fss
> +      - ti,am62-r5fss
>        - ti,j721s2-r5fss
>  
>    power-domains:
> @@ -80,7 +87,8 @@ patternProperties:
>        node representing a TI instantiation of the Arm Cortex R5F core. There
>        are some specific integration differences for the IP like the usage of
>        a Region Address Translator (RAT) for translating the larger SoC bus
> -      addresses into a 32-bit address space for the processor.
> +      addresses into a 32-bit address space for the processor. For AM62x,
> +      should only define one R5F child node as it has only one core available.
>  
>        Each R5F core has an associated 64 KB of Tightly-Coupled Memory (TCM)
>        internal memories split between two banks - TCMA and TCMB (further
> @@ -104,6 +112,7 @@ patternProperties:
>            - ti,j721e-r5f
>            - ti,j7200-r5f
>            - ti,am64-r5f
> +          - ti,am62-r5f
>            - ti,j721s2-r5f
>  
>        reg:
> @@ -207,20 +216,31 @@ patternProperties:
>        - firmware-name
>  
>      unevaluatedProperties: false
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          enum:
> +            - ti,am64-r5fss
> +    then:
> +      properties:
> +        ti,cluster-mode:
> +          enum: [0, 2]
> +
> +    else:
> +      properties:
> +        ti,cluster-mode:
> +          enum: [0, 1]
> +
> +  - if:
> +      properties:
> +        compatible:
> +          enum:
> +            - ti,am62-r5fss
> +    then:
> +      properties:
> +        ti,cluster-mode: false
>  
> -if:
> -  properties:
> -    compatible:
> -      enum:
> -        - ti,am64-r5fss
> -then:
> -  properties:
> -    ti,cluster-mode:
> -      enum: [0, 2]
> -else:
> -  properties:
> -    ti,cluster-mode:
> -      enum: [0, 1]
>  
>  required:
>    - compatible
> -- 
> 2.17.1
> 

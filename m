Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 464B363DBAB
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 18:13:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbiK3RNe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 12:13:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230395AbiK3RNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 12:13:01 -0500
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBDBB8B186;
        Wed, 30 Nov 2022 09:09:07 -0800 (PST)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-14286d5ebc3so21767711fac.3;
        Wed, 30 Nov 2022 09:09:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yZGjfXWGP2AzRUdq3pVVndzAw3sxyvCWjlEcVt3nu7E=;
        b=QFpycQSsMTwhqc8SclnpIdPwrjO3c0n06cYYvUmhHN4jwG2z9SSS2aFrHq/fzYmtv9
         Ju5LzESdoBxRWTOBTD0uPFt9q26RpKBMGfuFj/AGvkRWliAv8eLrOg7WDzWkOjz5RzV3
         HqHcNH9QJiMHOJ86Dng/5ZrHwBTVk/4slAXiQnOqilLARgzXpcT5J111NDnD5jMUI0sD
         qlhItc2ZBqfZDHkppEqxnVRH4zzMY0pxCmPrIXy1+dl96/GsVZMN+f8+E88udAyMwQpI
         DID+saaWA/UCUZolYBujLfJwc12M3TmrZdTJJlDlBrMhg47VFg7oyFkTYV8a9QO5JuCB
         9t6A==
X-Gm-Message-State: ANoB5pmJAMF2bWuDEQLKhLXx7Z4ToI6VjA329+Xf8ylcKBmcrIoKC5vQ
        29Q6F+H/jnQsrTqWfhEtKw==
X-Google-Smtp-Source: AA0mqf5NogTdghJJR30Thmn+fVMr7pF6s8gWLgPlvLoTPPv/xeMWqjs0deU7LszWBkE+i6++tvXbsw==
X-Received: by 2002:a05:6870:60a4:b0:132:79b1:f85 with SMTP id t36-20020a05687060a400b0013279b10f85mr26890824oae.274.1669828147028;
        Wed, 30 Nov 2022 09:09:07 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r129-20020acaa887000000b00359ba124b07sm826585oie.36.2022.11.30.09.09.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 09:09:06 -0800 (PST)
Received: (nullmailer pid 2459261 invoked by uid 1000);
        Wed, 30 Nov 2022 17:09:05 -0000
Date:   Wed, 30 Nov 2022 11:09:05 -0600
From:   Rob Herring <robh@kernel.org>
To:     Luca Weiss <luca@z3ntu.xyz>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        devicetree@vger.kernel.org, Andrew Davis <afd@ti.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH v4] dt-bindings: input: Convert ti,drv260x to DT schema
Message-ID: <166982814519.2459212.9752110415413633511.robh@kernel.org>
References: <20221118174831.69793-1-luca@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221118174831.69793-1-luca@z3ntu.xyz>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 18 Nov 2022 18:48:29 +0100, Luca Weiss wrote:
> Convert the drv260x haptics binding to DT schema format.
> 
> The only notable change from .txt format is that vbat-supply is not
> actually required, so don't make it a required property.
> 
> Acked-by: Andrew Davis <afd@ti.com>
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
> Changes in v4:
> * use non-deprecated enable-gpios for 'required' and example
> 
>  .../devicetree/bindings/input/ti,drv260x.txt  |  50 --------
>  .../devicetree/bindings/input/ti,drv260x.yaml | 109 ++++++++++++++++++
>  2 files changed, 109 insertions(+), 50 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/input/ti,drv260x.txt
>  create mode 100644 Documentation/devicetree/bindings/input/ti,drv260x.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>

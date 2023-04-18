Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CFAD6E6F6E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 00:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231830AbjDRWi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 18:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbjDRWiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 18:38:24 -0400
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CBA18A41;
        Tue, 18 Apr 2023 15:38:20 -0700 (PDT)
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-541eee15ef5so765724eaf.1;
        Tue, 18 Apr 2023 15:38:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681857499; x=1684449499;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e2/A+Gx/RhFVLks2UG5AnZqCcthwPtxaqKmn9AKzS5I=;
        b=Bmj3QxfWyfM15Ywm6rYP3sfJkULG4jHK5kx28Vnd6/ZiRPCphxfabEOWd//y7JIlQL
         OHmllBeCt4lMkw484tf8XkdgAnGhXMf/2FqDHn6QsmravfY+uDjv+O/U5nGl1g9uYhtw
         7FHRp2ZLzYxLfqz2deBWaWkvNQlFtoICP21X1E6UFSr8YIrcjt+gYta1zzih2HC2iMZo
         9CxJHamMNXeWugdu3Dh1zKhRKNuG33HzYHWH0Po6aWfYwM2yNCidYlkDY29ktHLf9nru
         L5+YfkTXERcyf8S++sQpcRdwUlZDy27H+SKqUMp1vHULTTTV56LxsHnKWb5L64mzRcDn
         m2FQ==
X-Gm-Message-State: AAQBX9dGt9SyGCyWxgMbTTo8X29xsyeeXsxyEHtMibHk68gLOk0hSRkC
        2pr2rfb0NWnStKwkDLsE+nypYxDAyw==
X-Google-Smtp-Source: AKy350YEbVFLHekLfyoZ4H8A13lexfoGonhYFWXJXkzygvUti6w/ildRmCBfJS4o8Vh0hse15AtMmw==
X-Received: by 2002:a05:6870:1694:b0:187:85c1:8075 with SMTP id j20-20020a056870169400b0018785c18075mr2453011oae.15.1681857499708;
        Tue, 18 Apr 2023 15:38:19 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id o1-20020a05687072c100b0018456166c7asm6128328oak.39.2023.04.18.15.38.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 15:38:19 -0700 (PDT)
Received: (nullmailer pid 2453195 invoked by uid 1000);
        Tue, 18 Apr 2023 22:38:18 -0000
Date:   Tue, 18 Apr 2023 17:38:18 -0500
From:   Rob Herring <robh@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH 1/2] dt-bindings: sram: Add compatible for ST-Ericsson
 U8500 eSRAM
Message-ID: <168185749819.2453142.14346352869181196608.robh@kernel.org>
References: <20230417-ux500-sram-v1-0-5924988bb835@linaro.org>
 <20230417-ux500-sram-v1-1-5924988bb835@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230417-ux500-sram-v1-1-5924988bb835@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 17 Apr 2023 09:34:56 +0200, Linus Walleij wrote:
> This adds an SoC-specific binding for the banks of eSRAM
> available in the ST-Ericsson U8500.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  Documentation/devicetree/bindings/sram/sram.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>


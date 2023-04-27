Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B38F16F0745
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 16:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244037AbjD0OZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 10:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244070AbjD0OYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 10:24:49 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 657B549E1;
        Thu, 27 Apr 2023 07:24:29 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-18b5c8c2a49so5369601fac.3;
        Thu, 27 Apr 2023 07:24:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682605407; x=1685197407;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Hq4grDEDt/Oj8MLtTtn2ti2V14UBOPOnIQkLRnCWAs=;
        b=AtR1GF8kywkMpS0HxD86vmLCXxUaK538n8rcWZLsSEhuK0DQ6Su7T0tkMb3JQPiKDN
         XPtSKDsYMA7S7C91Q1q8pg+8f2rM3D7RLh0oFcpX7+pZti5NykeqQSsUFCqegWBigtzS
         8KUbpLxZeyGTNavyUF7pJhFnLxSllpNNb711QLbAZFGPwfEEmW4T4FH1p72GV6gey2ac
         tjNUE3qlkRcRCpt74Ln5KfD4puVVckswxgZ0xWhKv4ZFWZAyvDAXDKC6QDSB8ZwDWYTD
         FTauvfIIVwrIRaFEqGX1IVAhqYmjPEGTE2fMPHM2C3WJ3lQ/86Yo3zY/+Itg3BRkw7tC
         BZrA==
X-Gm-Message-State: AC+VfDyk22VbsgItR/qrxv3pLVna+YTEp1gTlIrX4GSEm6xPGIXTQFb4
        xhTpQrPmYsKNBTxeIpxDoA==
X-Google-Smtp-Source: ACHHUZ69NrO0nvfkAwrXNiXDurRIt4xbVe0xGVtrBaHC3bzSfttdfGzQiHK6gCD/b9OQa/bKGuhbZA==
X-Received: by 2002:a05:6808:317:b0:38e:aa4:e4a4 with SMTP id i23-20020a056808031700b0038e0aa4e4a4mr804181oie.8.1682605407570;
        Thu, 27 Apr 2023 07:23:27 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id ca20-20020a056808331400b0038ebd84ce2bsm5259241oib.19.2023.04.27.07.23.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 07:23:26 -0700 (PDT)
Received: (nullmailer pid 2991901 invoked by uid 1000);
        Thu, 27 Apr 2023 14:23:26 -0000
Date:   Thu, 27 Apr 2023 09:23:26 -0500
From:   Rob Herring <robh@kernel.org>
To:     Karl Chan <exkcmailist@inbox.lv>
Cc:     linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        jbrunet@baylibre.com, khilman@baylibre.com,
        linux-arm-kernel@lists.infradead.org,
        martin.blumenstingl@googlemail.com,
        krzysztof.kozlowski+dt@linaro.org, neil.armstrong@linaro.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: Re: [PATCH v5 1/2] dt-bindings: arm: amlogic: add Xiaomi Mi box 3
 binding
Message-ID: <168260540558.2991868.9005828920169849530.robh@kernel.org>
References: <20230425165624.11999-1-exkcmailist@inbox.lv>
 <20230425165624.11999-2-exkcmailist@inbox.lv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230425165624.11999-2-exkcmailist@inbox.lv>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 26 Apr 2023 00:56:23 +0800, Karl Chan wrote:
> From: "Karl Chan"  <exkcmailist@inbox.lv>
> 
> Add the board binding for the Xiaomi Mi box 3 Android Set-Top Box device.
> 
> Signed-off-by: Karl Chan <exkcmailist@inbox.lv>
> ---
>  Documentation/devicetree/bindings/arm/amlogic.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>


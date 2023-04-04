Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8F46D6546
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 16:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235363AbjDDO0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 10:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235278AbjDDO0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 10:26:08 -0400
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4A004C13;
        Tue,  4 Apr 2023 07:25:47 -0700 (PDT)
Received: by mail-ot1-f47.google.com with SMTP id o25-20020a9d4119000000b006a11eb19f8eso16222906ote.5;
        Tue, 04 Apr 2023 07:25:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680618347;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B55O9gA7vaYXICMr9SJHzaOtnTvtSD1xBb+aJX6NQzQ=;
        b=Q6piR2VZRn2RBJ2eC14ysjuKjdQow3Icqg3O/8TuVNLqKJq2nuw5C70JD4ZIGUjOVw
         Ysk4ZW4UmDDbw8TwPPUzVDEJ0+VQJw50LBDcTS/LszCSKrxdNF6oDDbr1HLMqXCQd1T7
         jvHmTTMxog0vxKwGvxe88uiFa3fIS+0MTylPtOEjtWiiKTVFICTRaG3loYhL90HXTU+t
         h5Rx1k+fTbMxDVMXZt1DGk5m6lufsHQ6kpbxW5e/fVRnGHV9KITiP2tv5ZJuZqRTPRlt
         fEPZ4zAGB0Un6MYuX7GmyNQxvb7WmRjTFiOl+ms2NUeWnIoeU367DhI31ShmvGz+sQa+
         7m3w==
X-Gm-Message-State: AAQBX9fwRb/9DddO90Kf392O+p/r8vbqvwBzqY0rJKcvGTkoaKq7UBVI
        j6/B65hK56rqRLmxN6rJyw==
X-Google-Smtp-Source: AKy350aZivBXjglElKTyJb4uxCvPHgWk/4MGuiIWmBx3WlxovCOJEP8w5cZ+FIpZE/XjbsfiLya7GQ==
X-Received: by 2002:a9d:6b94:0:b0:69f:ac87:f872 with SMTP id b20-20020a9d6b94000000b0069fac87f872mr1509169otq.13.1680618346680;
        Tue, 04 Apr 2023 07:25:46 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id e14-20020a9d6e0e000000b0069f951899e1sm5610888otr.24.2023.04.04.07.25.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 07:25:46 -0700 (PDT)
Received: (nullmailer pid 3834119 invoked by uid 1000);
        Tue, 04 Apr 2023 14:25:45 -0000
Date:   Tue, 4 Apr 2023 09:25:45 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, Roger Quadros <rogerq@kernel.org>,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH 3/3] dt-bindings: usb: ti,keystone-dwc3: drop
 assigned-clocks
Message-ID: <168061834511.3834080.16768361106806766398.robh@kernel.org>
References: <20230403191850.374839-1-krzysztof.kozlowski@linaro.org>
 <20230403191850.374839-3-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230403191850.374839-3-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=0.8 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 03 Apr 2023 21:18:50 +0200, Krzysztof Kozlowski wrote:
> The meta schema from DT schema already defines assigned-clocks, so there
> is no need for device schema to mention it at all.  There are also no
> benefits of having it here.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/usb/ti,keystone-dwc3.yaml         | 8 --------
>  1 file changed, 8 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>


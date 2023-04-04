Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4841D6D653F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 16:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235209AbjDDOZs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 10:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235867AbjDDOZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 10:25:42 -0400
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AE6355A9;
        Tue,  4 Apr 2023 07:25:33 -0700 (PDT)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-17aaa51a911so34738506fac.5;
        Tue, 04 Apr 2023 07:25:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680618332;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ApT4/BK1w7ic9F4sBvqn2kPYM1w0Sn+odMgc/sq2JvM=;
        b=fArgFi9Vf7DsvAk9KmGEZZBdBiVULTAvpZJl+ISrqGkWJ8zapcirwE/q8XZp7MHcnQ
         undBTBsMdLoEjpe08WCZ3aK3IdXvsYGK8HQL6WPdSiR6P2joOCHJPke5QVq9TkDDp7j2
         hhc3OVmoR6nDl59EjbVFZ/ll3j4mSnOvZtH7y9DfbxzDcXs9Q1fpxh43S7z6jB8ZmK9J
         WHbzF8rH3iZXNREQwM8gKrRRZbj/DDjcKuynJvkjwJx5fRQJ5qzCiS9QW+Vt9QyULgR5
         pQeNHTehW0q96Nk2SqGl28ihgsS4hVYHttxb1sgO65CxYf+AmYEnK2g5XFkketE8mN6s
         0hwg==
X-Gm-Message-State: AAQBX9enz2SqdlwATfh3xZAAxwdsYZMgys4wDp3ht158KcSwpRvwQy1J
        VsiNyIwLpvUkYQU2AEep7A==
X-Google-Smtp-Source: AKy350ZUp9g4CNJcEzGG1ZdTCE/lLLo6LkrUbne54r031+kRziV/pc060KzUIpJQZHr0c7d2vdYY3A==
X-Received: by 2002:a05:6870:c684:b0:17a:acbb:d1e4 with SMTP id cv4-20020a056870c68400b0017aacbbd1e4mr1663599oab.53.1680618332200;
        Tue, 04 Apr 2023 07:25:32 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id tw16-20020a056871491000b0017ae909afe8sm4814352oab.34.2023.04.04.07.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 07:25:31 -0700 (PDT)
Received: (nullmailer pid 3833637 invoked by uid 1000);
        Tue, 04 Apr 2023 14:25:31 -0000
Date:   Tue, 4 Apr 2023 09:25:31 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-usb@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Roger Quadros <rogerq@kernel.org>,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: usb: mediatek,mtk-xhci: drop
 assigned-clocks
Message-ID: <168061833065.3833579.13089366523003216178.robh@kernel.org>
References: <20230403191850.374839-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230403191850.374839-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=0.8 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 03 Apr 2023 21:18:48 +0200, Krzysztof Kozlowski wrote:
> The meta schema from DT schema already defines assigned-clocks, so there
> is no need for device schema to mention it at all.  There are also no
> benefits of having it here.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/usb/mediatek,mtk-xhci.yaml        | 8 --------
>  1 file changed, 8 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA7406E9DE4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 23:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232298AbjDTVaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 17:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbjDTVad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 17:30:33 -0400
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3827530C5;
        Thu, 20 Apr 2023 14:30:32 -0700 (PDT)
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6a604259983so1136652a34.2;
        Thu, 20 Apr 2023 14:30:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682026231; x=1684618231;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ATht8q/CS7yxKYxJHjIaLdg/Mk6t9WcQns9JFqiJGcE=;
        b=hOQD+2VAdTDOgqp4KZ64ep3EenMW3S2IgVPsmCFI9FVi7xiO9kpHBV1iG+5tQhGJGB
         oTEwjYiPbg34rkMmCVdJZedkMpeGpLDDqMvsOMBHZhj6cleif1HHnaiMIqIepoHqXY/y
         GFxQy3f5WRROnGJ84HVKH6E5jlh9286tL0u6v5HNO/igX5RmTsqHioGB/AjKiTHIo4RD
         MJHSWcO77vBv6SG2UhwN+siulYBwTp3QX7/d1Lep8ltaBytrObDBSho2wTc69mYDqK9S
         wNWVy6b84sGXp0bk9SuTbTE7UlNkFA/yrdjNfPmGMkytjVKEyeoXzMsm6pl7yndL9ayP
         DPow==
X-Gm-Message-State: AAQBX9dJYnLCqVpcZ92yGR31LYBsE50UzW9k64C3B34Ayl3IbSseVtxg
        fnvQ4E0qJ2OOgDrXNgmECQ==
X-Google-Smtp-Source: AKy350Zu5SKq+FOHsTX+3TUAClUUFnxjs2jKsT+5gqD0b3RPFo5nJwJzjk37cWGrIjq8JLZNK2lcWQ==
X-Received: by 2002:a9d:77cc:0:b0:6a4:3c4d:8eaf with SMTP id w12-20020a9d77cc000000b006a43c4d8eafmr1315601otl.35.1682026231426;
        Thu, 20 Apr 2023 14:30:31 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id y7-20020a056830208700b0069fa776d3c2sm1150266otq.18.2023.04.20.14.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 14:30:30 -0700 (PDT)
Received: (nullmailer pid 3586692 invoked by uid 1000);
        Thu, 20 Apr 2023 21:30:29 -0000
Date:   Thu, 20 Apr 2023 16:30:29 -0500
From:   Rob Herring <robh@kernel.org>
To:     Olivia Mackall <olivia@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: rng: Drop unneeded quotes
Message-ID: <20230420213029.GA3518858-robh@kernel.org>
References: <20230327170153.4105594-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230327170153.4105594-1-robh@kernel.org>
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

On Mon, Mar 27, 2023 at 12:01:53PM -0500, Rob Herring wrote:
> Cleanup bindings dropping unneeded quotes. Once all these are fixed,
> checking for this can be enabled in yamllint.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/rng/amlogic,meson-rng.yaml | 4 ++--
>  Documentation/devicetree/bindings/rng/brcm,iproc-rng200.yaml | 4 ++--
>  Documentation/devicetree/bindings/rng/mtk-rng.yaml           | 4 ++--
>  Documentation/devicetree/bindings/rng/ti,keystone-rng.yaml   | 2 +-
>  4 files changed, 7 insertions(+), 7 deletions(-)

Applied, thanks!

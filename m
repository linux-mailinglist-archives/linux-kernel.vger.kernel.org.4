Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB045E69A8
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 19:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbiIVR3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 13:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231963AbiIVR3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 13:29:36 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 484E1DEC1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 10:29:34 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id z20so11866092ljq.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 10:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=+5ktU3TDpe3BHuTbwoZ764cAXObTROyDXShVbxkedjg=;
        b=WTOkIz1x4ybGbAs8B/cWZxP4QvzdnlgE7FCibEM9pXldRAzbcaEDIstRmDAHw+YjNm
         BXbx/lu11awGrUGl7Tlf5SbXmWj7WLXV3l3snFERdhhF5LViUFN5ssoDWYiOT4oy4zGI
         qVd+pFrmxNkPaEfTitlmlZBlDJKUd+ZSryHLHjYeRnZef76RYm0Zhao4haRXI8SqnHbe
         TsbpNlygaJ2++kfT0qeVw3z8nyyWsoci1UWTypk40t9PWx5sdPF6f7wBVolOXBSmoRXM
         9yiPtC3rEwrCycOzSW8BSmY/bMx7hgZvLO/Uv2tnJP//qwc4Xh6B/yEZGAZkV5lNEgHE
         geOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=+5ktU3TDpe3BHuTbwoZ764cAXObTROyDXShVbxkedjg=;
        b=RQ2FFlOMEAnG5kY75W+kMuOyZ5fjJDSvyU1oBouV6q78HndH7ZdQt92RrII2wpTY7e
         XfCirfd+/ZIbGerLwM5bMjhOovqziGJW98DNaArSU/OuiHrmCpP+WJYsXrehRIYnhhBz
         iAd6rs9d765l/FIiaBy6EA6C1ycGF5bWSPOT2A1taprxfxd4I7QH9+ergqoULwctbxte
         /0RbZ/31pn+8zSPRtdkbLDm6pgRlleNc4VIK7RmbT67YiAjLprh0QJ4+e66Lqbh/tI4Z
         8nnNdQRjQRVXByqzlD/3mkDuM6dhmDTfpEUe1GRAiNsP7R5CoGdvuup+DSU9vVl8ipgj
         8umw==
X-Gm-Message-State: ACrzQf3kVit7BEXK3jHu49q7N49KpzR0+QXuXbJ0gquZ2ORV6fqBIpMZ
        5EAzz/vY/o3wQ1XwP4YLaCHmUg==
X-Google-Smtp-Source: AMsMyM7q+CRO6rvOlarBOiLCvoTHsA/CVxmXYPQcgm3Xy63aIchuZFS+ZWs5+S7YO+//DL44qYUztA==
X-Received: by 2002:a2e:bd09:0:b0:264:6516:93f9 with SMTP id n9-20020a2ebd09000000b00264651693f9mr1503819ljq.127.1663867773771;
        Thu, 22 Sep 2022 10:29:33 -0700 (PDT)
Received: from krzk-bin (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id r10-20020ac24d0a000000b0048af3c090f8sm1039477lfi.13.2022.09.22.10.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 10:29:33 -0700 (PDT)
Date:   Thu, 22 Sep 2022 19:29:31 +0200
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Tomer Maimon <tmaimon77@gmail.com>
Cc:     linux-kernel@vger.kernel.org, joel@jms.id.au, yuenn@google.com,
        tali.perry1@gmail.com, benjaminfair@google.com,
        krzysztof.kozlowski+dt@linaro.org, avifishman70@gmail.com,
        devicetree@vger.kernel.org, venture@google.com,
        linux-crypto@vger.kernel.org, olivia@selenic.com,
        openbmc@lists.ozlabs.org, robh+dt@kernel.org,
        herbert@gondor.apana.org.au
Subject: Re: [PATCH v1 1/2] dt-bindings: rng: nuvoton,npcm-rng: Add npcm845
 compatible string
Message-ID: <20220922172931.rf37x4xig5znjvlu@krzk-bin>
References: <20220922142216.17581-1-tmaimon77@gmail.com>
 <20220922142216.17581-2-tmaimon77@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220922142216.17581-2-tmaimon77@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Sep 2022 17:22:15 +0300, Tomer Maimon wrote:
> Add a compatible string for Nuvoton BMC NPCM845 RNG.
> 
> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> ---
>  Documentation/devicetree/bindings/rng/nuvoton,npcm-rng.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/rng/nuvoton,npcm-rng.yaml:20:9: [warning] wrong indentation: expected 6 but found 8 (indentation)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1681163

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9869F6BD9AC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 20:58:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbjCPT6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 15:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbjCPT6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 15:58:07 -0400
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E3C3BD4E4;
        Thu, 16 Mar 2023 12:57:23 -0700 (PDT)
Received: by mail-il1-f170.google.com with SMTP id 4so1631986ilz.6;
        Thu, 16 Mar 2023 12:57:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678996611;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jQMHjPaeXjRCbmwReybTxCj3piy1a1zt9f0lIOYUeaM=;
        b=gSwrMa3UF8042FXu+ojBw5H3t3lOxPuslFr8ZEFxZDrqb4ivVgccw/TWtlfaaXaaF4
         leCDoj0bNkzyLi6m/1R1b4YuFqicDQE6soDLhGSZ9XYQ7c7V6NmLLJVUkDdezD6VE4YN
         hzWwTRxH2OMAey6RY3hcLT6MXBPO8Ctgo18DH3aD9rls9gXdBkHfbO4gnE9Quulyl3fY
         1CiKApWSfyXiP7IuGMba7i8IjvOvMdciRqjKMsWGvm7ODLTWdhkSeIRITTfzeBTHItUm
         UeK833vVE7f+K7gq6Exnk7Y7PC7f8rJboQm80zoxqtnGiYU5so2JHCXp7Ft8d5Wd/iW8
         eH5g==
X-Gm-Message-State: AO0yUKXbrRhq4//nkjyDi0IjSDiwc6bEUHcVh90TFg+JsalMu9JbXeOv
        1chOkkW//yNLDpVGDl+aHNX2aMw4JA==
X-Google-Smtp-Source: AK7set/xRgAPFMSNNxoPPmiqrGXjmP7KYb/XlTkpq5V1/UNgry6o/5bHXBqkyYiFFZ0XwssSf1mXbg==
X-Received: by 2002:a92:c10f:0:b0:311:13c1:abd4 with SMTP id p15-20020a92c10f000000b0031113c1abd4mr7365041ile.24.1678996611038;
        Thu, 16 Mar 2023 12:56:51 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id r17-20020a92ac11000000b00312f2936087sm61266ilh.63.2023.03.16.12.56.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 12:56:50 -0700 (PDT)
Received: (nullmailer pid 3780293 invoked by uid 1000);
        Thu, 16 Mar 2023 19:56:48 -0000
Date:   Thu, 16 Mar 2023 14:56:48 -0500
From:   Rob Herring <robh@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-crypto@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, Pankaj Gupta <pankaj.gupta@nxp.com>,
        linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>,
        Gaurav Jain <gaurav.jain@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH] dt-bindings: crypto: fsl,sec-v4.0: Convert to DT schema
Message-ID: <167899646621.3777210.10339304142738109858.robh@kernel.org>
References: <20230220213334.353779-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230220213334.353779-1-robh@kernel.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 20 Feb 2023 15:33:33 -0600, Rob Herring wrote:
> Convert Freescale CAAM/SEC4 binding to DT schema format. The
> 'fsl,sec-v4.0' and 'fsl,sec-v4.0-mon' parts are independent, so split
> them into separate schema files.
> 
> Add a bunch of missing compatibles for v5.0, v5.4, etc. Drop unused
> 'ranges', '#address-cells', and '#size-cells' from fsl,sec-v4.0-mon nodes.
> 
> There's one DTB warning for LS1012a which has a 2nd 'reg' entry for
> 'fsl,sec-v4.0-rtic'. Leaving that as there is no clue as to what it is for.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../bindings/crypto/fsl,sec-v4.0-mon.yaml     | 150 +++++
>  .../bindings/crypto/fsl,sec-v4.0.yaml         | 266 +++++++++
>  .../devicetree/bindings/crypto/fsl-sec4.txt   | 553 ------------------
>  3 files changed, 416 insertions(+), 553 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/crypto/fsl,sec-v4.0-mon.yaml
>  create mode 100644 Documentation/devicetree/bindings/crypto/fsl,sec-v4.0.yaml
>  delete mode 100644 Documentation/devicetree/bindings/crypto/fsl-sec4.txt
> 

Applied, thanks!


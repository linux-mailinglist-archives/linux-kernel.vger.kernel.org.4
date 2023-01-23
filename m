Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3BBE678A05
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 22:56:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231664AbjAWV4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 16:56:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjAWV4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 16:56:31 -0500
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BEED30B13;
        Mon, 23 Jan 2023 13:56:31 -0800 (PST)
Received: by mail-ot1-f48.google.com with SMTP id cc13-20020a05683061cd00b00684b8cf2f4dso8132515otb.12;
        Mon, 23 Jan 2023 13:56:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qRGcBcFExkgiQlPILZm8yierOUGy2T61UQrgAg+vNvI=;
        b=wwcmxVLWBJSjsaNuqra0ZRqc0qgePs5vW+zmEdQIhe88rPbeP9egByvDQO0Ru6YHgT
         A9d5AfATrQCWOX7QdwxuddcUy04Oq8otRRnMBDqjFj//fBDqm6yCkQLmE2O9Ah1+qKY3
         51i7gUXIQo8lS1RNNDwGWI6/B0Ia5b7yJFJ9SdAahff93TXm3pcfm+c2822mkp9WymZc
         haakdkDKEitKCHQKwa9ZH8+EgpmBB+T0lKbdxE7BLx8st0wPkQmS+/usMFTbg2L453Nw
         WqonVdEIxTP9WbGvEngU+Gz+KQ3WXyBlR+HS4E8OLMJsxxjfaAaUQAy9YHLn3uo7o56A
         bRJg==
X-Gm-Message-State: AFqh2krx0sjj7UuQEjH0NRsdu6UfGo86hjl02ZkNdXHtsoNFvFhuTbWN
        Y7c30Lvr2xjqEnW4z0AXJK6mlP/bVg==
X-Google-Smtp-Source: AMrXdXuiFoseVsNeQ6kz8MZHNhsiu9ndrbi3zKJ6ucozFrmExZHvq29A+xB4DbUKUuSbj+3zBhMGwA==
X-Received: by 2002:a9d:3c5:0:b0:684:d418:573b with SMTP id f63-20020a9d03c5000000b00684d418573bmr12432987otf.29.1674510990511;
        Mon, 23 Jan 2023 13:56:30 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id o33-20020a0568301c6100b006865223e532sm171918otg.51.2023.01.23.13.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 13:56:30 -0800 (PST)
Received: (nullmailer pid 2708213 invoked by uid 1000);
        Mon, 23 Jan 2023 21:56:29 -0000
Date:   Mon, 23 Jan 2023 15:56:29 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH 1/3] dt-bindings: power: fsl,imx-gpc: document
 fsl,imx6ul-gpc compatible
Message-ID: <167451098887.2708155.10295452383611628333.robh@kernel.org>
References: <20230120071717.138188-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230120071717.138188-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 20 Jan 2023 08:17:15 +0100, Krzysztof Kozlowski wrote:
> Document existing fsl,imx6ul-gpc compatible used with fsl,imx6q-gpc
> fallback:
> 
>   imx6sl-evk.dtb: gpc@20dc000: compatible: ['fsl,imx6sl-gpc', 'fsl,imx6q-gpc'] is too long
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/power/fsl,imx-gpc.yaml    | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>

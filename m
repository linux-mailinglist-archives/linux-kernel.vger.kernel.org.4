Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55470733A3B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 21:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbjFPT4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 15:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbjFPT4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 15:56:39 -0400
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4AE2359D;
        Fri, 16 Jun 2023 12:56:38 -0700 (PDT)
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-77ac2eb07a3so39207639f.2;
        Fri, 16 Jun 2023 12:56:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686945398; x=1689537398;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qS/HVMvqz+3lSoqw9RtE/dO2ukSdMAzMn+pgkdvUh6w=;
        b=QEGDNs6bloovdRE9Vnx9fVwOXd/Ih0hFt3VejJyexUtf331RonA4c2IbJsVussc/U+
         KLm0ALZW4EzC9kSrLNifgNyYhEDi308TQE3runAWS/TwK8njLdE/NDnrtv+7Y1qdU6k2
         Rk8koAd2t06IdsauXjEG3Nxl9TH41kS7qPdhgKVAaMpIPUfGPZXIrxngfH+mBO9sspMF
         QHfxR9MhWMv+xhdJVVby9e3DSz1g6fvNo3MStYsdNgTOuIVNuBcZC1sWz1YwqupGY93H
         R6+cNcurC9yJBicknmdtPibMuy7uJGE5/S+ZMIkf3D8MSYXmENI8UGJ3He24DtEgHGoA
         wVdA==
X-Gm-Message-State: AC+VfDyLyl4uXjCRgYb8nmU1N4B25NInStqnOtbZeS8DKbHS+JabOggz
        +FZCwU2D63A79fXL6SIFxA==
X-Google-Smtp-Source: ACHHUZ6huIxB7TX+/DLvdKdc8mYNTXyBGF99Ajc4+Uni1wbszykli1jrwEBBrzCBaNSbKvMS1cO2lA==
X-Received: by 2002:a05:6602:29b1:b0:76c:6674:243b with SMTP id u17-20020a05660229b100b0076c6674243bmr123367ios.15.1686945397889;
        Fri, 16 Jun 2023 12:56:37 -0700 (PDT)
Received: from robh_at_kernel.org ([2605:ef80:80c2:7a4a:82c2:d6b3:423e:4a47])
        by smtp.gmail.com with ESMTPSA id q20-20020a02c8d4000000b0040fa0f43777sm6420098jao.161.2023.06.16.12.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jun 2023 12:56:37 -0700 (PDT)
Received: (nullmailer pid 934772 invoked by uid 1000);
        Fri, 16 Jun 2023 19:56:21 -0000
Date:   Fri, 16 Jun 2023 13:56:21 -0600
From:   Rob Herring <robh@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     =?iso-8859-1?Q?Fern=E1ndez?= Rojas <noltari@gmail.com>,
        Peng Fan <peng.fan@nxp.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Marek Vasut <marex@denx.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Suman Anna <s-anna@ti.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-remoteproc@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-clk@vger.kernel.org, Abel Vesa <abelvesa@kernel.org>,
        devicetree@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        - <devicetree-spec@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: Re: [PATCH] dt-bindings: Remove last usage of "binding" or "schema"
 in titles
Message-ID: <168694537949.934680.13323062117489358147.robh@kernel.org>
References: <20230615213154.1753313-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230615213154.1753313-1-robh@kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 15 Jun 2023 15:31:54 -0600, Rob Herring wrote:
> The Devicetree bindings document does not have to say in the title that
> it is a "Devicetree binding", but instead just describe the hardware.
> 
> Most of these have been fixed already, so fix the handful that snuck in.
> With this, a meta-schema check can be enabled to catch these
> automatically.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/clock/brcm,bcm63268-timer-clocks.yaml   | 2 +-
>  Documentation/devicetree/bindings/clock/imx8mp-audiomix.yaml    | 2 +-
>  .../devicetree/bindings/power/reset/restart-handler.yaml        | 2 +-
>  .../devicetree/bindings/remoteproc/ti,pru-consumer.yaml         | 2 +-
>  .../devicetree/bindings/reserved-memory/framebuffer.yaml        | 2 +-
>  5 files changed, 5 insertions(+), 5 deletions(-)
> 

Applied, thanks!


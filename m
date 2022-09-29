Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 247675EFE8E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 22:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbiI2UTa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 16:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiI2UT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 16:19:28 -0400
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C1031FE191;
        Thu, 29 Sep 2022 13:19:28 -0700 (PDT)
Received: by mail-oo1-f51.google.com with SMTP id m11-20020a4aab8b000000b00476743c0743so880013oon.10;
        Thu, 29 Sep 2022 13:19:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=oUJJ1b7lap06bTmVazhE0UVHNBGg3Stxn6xK3EbQtFw=;
        b=DfzYjLrm0KJSAK2GRGH9RbKX7KvmlZUeg+SetrH68/rUe1i+cicwptWKERApWr8e4p
         X1DObQN5xfs2II/dcusOqj8L+8xTDnlyBBNnj3WDtI6CLK9DnYouToktBJr/In9deg1C
         Bz3rzazvdq9wS2VRiOqpmqWlRENXynv/6A5wAhZ0gd91EBrwTLuN6MS7Lgyn8lzleJXq
         TDt9cfG1+WfHKGS8qG1bTmL9vM5Sz/i2s7Jk8jVkxztrLHyUlB2hU1C16i3EZzaEbVF8
         ypOFDwqyGwI0SA9AM6syg26wLsZchnYS/8IA+jcy0N8CQu+mnWMfUGwITmhIBjVPrlWZ
         W09w==
X-Gm-Message-State: ACrzQf3qBsdKhAeZNaaV+a9G/gmIUp0mrQJnBT4FL6rkSATFE99lN7y6
        Au7j0wbQo1jBYBn0jptKuTeY5myDIQ==
X-Google-Smtp-Source: AMsMyM4hQ9E/GdknJ7QEniGYzaf35/OJYaDl7ZSslM6z1Qx76RrhpZxsPh4JLO49KagzVXfEH2zjxA==
X-Received: by 2002:a05:6830:1cc8:b0:65c:8e3:cfd with SMTP id p8-20020a0568301cc800b0065c08e30cfdmr2161084otg.28.1664482767384;
        Thu, 29 Sep 2022 13:19:27 -0700 (PDT)
Received: from macbook.herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id u13-20020a056871058d00b001227148da8csm167887oan.36.2022.09.29.13.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 13:19:26 -0700 (PDT)
Received: (nullmailer pid 2670413 invoked by uid 1000);
        Thu, 29 Sep 2022 20:19:25 -0000
Date:   Thu, 29 Sep 2022 15:19:25 -0500
From:   Rob Herring <robh@kernel.org>
To:     Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc:     Rob Herring <robh+dt@kernel.org>, michael@amarulasolutions.com,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Christophe Roullier <christophe.roullier@foss.st.com>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        Lee Jones <lee.jones@linaro.org>
Subject: Re: [RFC PATCH v4 1/5] dt-bindings: arm: stm32: add compatible for
 syscon gcan node
Message-ID: <166448276515.2670368.18048403536166255218.robh@kernel.org>
References: <20220925175209.1528960-1-dario.binacchi@amarulasolutions.com>
 <20220925175209.1528960-2-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220925175209.1528960-2-dario.binacchi@amarulasolutions.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Sep 2022 19:52:05 +0200, Dario Binacchi wrote:
> Since commit ad440432d1f9 ("dt-bindings: mfd: Ensure 'syscon' has a
> more specific compatible")
> It is required to provide at least 2 compatibles string for syscon node.
> This patch documents the new compatible for stm32f4 SoC to support
> global/shared CAN registers access for bxCAN controllers.
> 
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> ---
> 
> (no changes since v1)
> 
>  .../devicetree/bindings/arm/stm32/st,stm32-syscon.yaml          | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

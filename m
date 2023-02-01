Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28A91685CBD
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 02:41:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbjBABlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 20:41:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231296AbjBABlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 20:41:14 -0500
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A4D59541;
        Tue, 31 Jan 2023 17:41:11 -0800 (PST)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-16346330067so21770889fac.3;
        Tue, 31 Jan 2023 17:41:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ARcpraQzdyShL/3uOhJbU55iw6ZjqLdVd5dZPXUPPKs=;
        b=zi4gjtCkk4rz0m6/OWIkWQIDD3GWdzY5Dhwc06EnkeJ5UMNJiDgqtIyAtloc9j4zXn
         nOI9XA8e1TEXuhN2u2iwZ6MoasRG8SyoRxCs/2CwCRxAp/gXxPnPZQVr3pYGmnHm67hQ
         amFhv003OCdcp2nO9KsQb9N3cBOgsmyhyZUZCFGlLDLxmcC29imPSvsVaQlLag0j+v/e
         i6yey/5Y7OM/h2mY7sax+pA2t+JVxw4RfhjIhRLD73kg+xsLPcrOQxbhAN9EJxGypWJf
         cnbQngvGY7I+vHcSw+E2+NhbLUj/+F8xB7mtrF4gxsDjcTebEqlgUDetemxqhjDgQp/u
         74MQ==
X-Gm-Message-State: AO0yUKXJfkKHxGAF+RakHVSfDUBHC+vT1LEk2betZIbVECKIWtXsXFfh
        fLVE+/nCzWI8qljh+s4ckw==
X-Google-Smtp-Source: AK7set+7vdv8wCpcZTaEjMIlQXTj5qX8pbN6bW9oRbbgZSH7MorUaN+g7rqVEpjZGOJmdPN5Wr2Oyg==
X-Received: by 2002:a05:6870:315:b0:15f:b59a:55f1 with SMTP id m21-20020a056870031500b0015fb59a55f1mr123340oaf.16.1675215670603;
        Tue, 31 Jan 2023 17:41:10 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id lm27-20020a0568703d9b00b0015f83e16a10sm7267887oab.44.2023.01.31.17.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 17:41:10 -0800 (PST)
Received: (nullmailer pid 2293844 invoked by uid 1000);
        Wed, 01 Feb 2023 01:41:09 -0000
Date:   Tue, 31 Jan 2023 19:41:09 -0600
From:   Rob Herring <robh@kernel.org>
To:     Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc:     linux-tegra@vger.kernel.org, devicetree@vger.kernel.org,
        Daniel Vetter <daniel@ffwll.ch>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Richard Leitner <richard.leitner@skidata.com>,
        Rob Herring <robh+dt@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        David Airlie <airlied@gmail.com>,
        linux-staging@lists.linux.dev,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v4 02/21] dt-bindings: display: tegra: vi: add 'vip'
 property and example
Message-ID: <167521566867.2293789.16573974181219415861.robh@kernel.org>
References: <20230130141603.323221-1-luca.ceresoli@bootlin.com>
 <20230130141603.323221-3-luca.ceresoli@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230130141603.323221-3-luca.ceresoli@bootlin.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 30 Jan 2023 15:15:44 +0100, Luca Ceresoli wrote:
> The Tegra20 VI peripheral can receive parallel input from the VIP parallel
> input module. Add it to the allowed properties and augment the existing
> nvidia,tegra20-vi example to show a 'vip' property.
> 
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> 
> ---
> 
> Changed in v4:
>  - complete the removal of 'channel@0'
> 
> Changed in v3 (suggested by Rob Herring):
>  - drop 'endpoint', unneeded as there's no extra properties in the
>    endpoints
> 
> Changed in v2 (suggested by Krzysztof Kozlowski):
>  - rename "i2c3" -> "ic2"
>  - add review tag
> ---
>  .../display/tegra/nvidia,tegra20-vi.yaml      | 59 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 60 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>


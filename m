Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA0D616AD9
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 18:36:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbiKBRgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 13:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbiKBRg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 13:36:28 -0400
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D91262E68E;
        Wed,  2 Nov 2022 10:36:27 -0700 (PDT)
Received: by mail-oi1-f179.google.com with SMTP id l127so3537199oia.8;
        Wed, 02 Nov 2022 10:36:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dc4JAgk8Ii0fgkzieAWE/TIH/BW67oauzyHYmto7l7U=;
        b=Mz2YUhmFGGAndCGSEX8BmqfK03K4tAT6E9PmJNaB8MqDJhnHYFWYSq9BQV75J8DSk1
         Xz3BUMKyZ6FB26gFwwuA5ovId5Uf7rT/y8s/wNkllgsyRwqqcDCLeUczt47KkUEiEJ8e
         XRu1D0ccwn4BRGBX4DRVFfjMXSLL2yKl0Ob8r3UePCUV6pijpfaCnmGtNrxfpqt9/QSh
         u3sVbFpaz1ZNzgsfVom8wMpkIKk3FlRNVRCASEH3JWKJ5e+UyeMMgChJO0sSMUiPy5IH
         CuSHK91U0izt0VAOCdaYSjDiry6eRd6hoTvSJjXjowzhCwwt8oyjF8GGPPO9+UeDDaA7
         fw1Q==
X-Gm-Message-State: ACrzQf2R6Dgqs2YIam2rjLir2QkGnYuzxkW8URi37lUrdqRj7hIWK35W
        QkhzIjv9RtLhgF9tKXLKcw==
X-Google-Smtp-Source: AMsMyM4M1GRaJRywzUivoqCEdYakTYpamT9qpsbEkb6DOPywrUizEjjMqFiCfjXluzSPYDgzufwUXg==
X-Received: by 2002:a05:6808:f10:b0:355:ba4:257e with SMTP id m16-20020a0568080f1000b003550ba4257emr14133728oiw.58.1667410587158;
        Wed, 02 Nov 2022 10:36:27 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id k12-20020a056820016c00b0049a96a62a3bsm3759044ood.48.2022.11.02.10.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 10:36:26 -0700 (PDT)
Received: (nullmailer pid 6608 invoked by uid 1000);
        Wed, 02 Nov 2022 17:36:28 -0000
Date:   Wed, 2 Nov 2022 12:36:28 -0500
From:   Rob Herring <robh@kernel.org>
To:     Richard Acayan <mailingradian@gmail.com>
Cc:     devicetree@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
        Thierry Reding <treding@nvidia.com>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Andy Gross <agross@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-kernel@vger.kernel.org, Robert Marko <robimarko@gmail.com>,
        Chanho Park <chanho61.park@samsung.com>,
        Das Srinagesh <quic_gurus@quicinc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
        linux-arm-msm@vger.kernel.org, phone-devel@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH 1/4] dt-bindings: arm: cpus: add qcom kryo 360 compatible
Message-ID: <166741058756.6553.9405126757347444857.robh@kernel.org>
References: <20221101235722.53955-1-mailingradian@gmail.com>
 <20221101235722.53955-2-mailingradian@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221101235722.53955-2-mailingradian@gmail.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 01 Nov 2022 19:57:19 -0400, Richard Acayan wrote:
> The Snapdragon 670 uses CPUs named Kryo 360 silver and Kryo 360 gold.
> Add the compatible string in the documentation.
> 
> Signed-off-by: Richard Acayan <mailingradian@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/cpus.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

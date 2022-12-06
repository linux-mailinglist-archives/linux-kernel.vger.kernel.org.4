Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB9C644424
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 14:08:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234007AbiLFNIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 08:08:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234032AbiLFNHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 08:07:41 -0500
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D9402DAAC;
        Tue,  6 Dec 2022 05:06:11 -0800 (PST)
Received: by mail-ot1-f48.google.com with SMTP id a7-20020a056830008700b0066c82848060so9206375oto.4;
        Tue, 06 Dec 2022 05:06:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U7j3ufR+17LIatwXfzkS37AMrM5wspfABSKG5ziauPQ=;
        b=M1acO28Jh/4npjelxfOull61rTR+NWc6OQ4jN/Suyno+uoo2X5nVZ/gmp4VYMAHOGU
         0xuPjs59VklI+GolqNJ6gjuQIstRJaphB5bezvfU0jhc0yzRgWniuvbLQwRhPMg32hyz
         uEsOjepkWwDq2A62nwEgV0h3gatMuDPyRACLGJJm729gkKf6NRQiYQHTDp8JuJL0bpoa
         G5ZSKPfrQtSOyRe5fkpcPMyfUXIwf9/7hgihmADXONhN2yhjQEnKwxjOS6rZUQckVrK6
         N4v8k4ohYYjRwoSHNMC6vjuL66tg/fDJIH2m553S/saEZ/XSeO8v6xcf2Snr8VtPp23K
         HK4g==
X-Gm-Message-State: ANoB5pmfV0058MhKcidq/HdGzALHV9dGyKqiYFTFJrtDuDHGbXL+de2n
        rx+z6rwxOS0jGTjDtzqsyA==
X-Google-Smtp-Source: AA0mqf6fMNQa1MZRHTu4Mys3lQ0bmDkZi6wAqFtT3FMcdVbZJcgwFXkLbhyX3YOzWrZ33rTdzoJTUg==
X-Received: by 2002:a05:6830:698f:b0:66c:57d2:54fc with SMTP id cy15-20020a056830698f00b0066c57d254fcmr35241262otb.378.1670331952892;
        Tue, 06 Dec 2022 05:05:52 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id a10-20020a056870d60a00b001438fb3b0a0sm10568716oaq.44.2022.12.06.05.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 05:05:52 -0800 (PST)
Received: (nullmailer pid 230603 invoked by uid 1000);
        Tue, 06 Dec 2022 13:05:51 -0000
Date:   Tue, 6 Dec 2022 07:05:51 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Yannick Fertre <yannick.fertre@foss.st.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jeff Chase <jnchase@google.com>, Joe Tessler <jrt@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-tegra@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Alain Volmat <alain.volmat@foss.st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Subject: Re: [PATCH v2 9/9] media: dt-bindings: st,stih-cec: convert to DT
 schema
Message-ID: <167033195070.230546.1336389323664376235.robh@kernel.org>
References: <20221205151845.21618-1-krzysztof.kozlowski@linaro.org>
 <20221205151845.21618-10-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221205151845.21618-10-krzysztof.kozlowski@linaro.org>
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


On Mon, 05 Dec 2022 16:18:45 +0100, Krzysztof Kozlowski wrote:
> Convert ST STIH4xx HDMI CEC bindings to DT schema.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/media/cec/st,stih-cec.yaml       | 66 +++++++++++++++++++
>  .../devicetree/bindings/media/stih-cec.txt    | 27 --------
>  MAINTAINERS                                   |  2 +-
>  3 files changed, 67 insertions(+), 28 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/media/cec/st,stih-cec.yaml
>  delete mode 100644 Documentation/devicetree/bindings/media/stih-cec.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>

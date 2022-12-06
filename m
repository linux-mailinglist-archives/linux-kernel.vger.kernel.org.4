Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4AB644401
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 14:05:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235185AbiLFNEf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 08:04:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235037AbiLFND7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 08:03:59 -0500
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEB492B192;
        Tue,  6 Dec 2022 05:03:06 -0800 (PST)
Received: by mail-ot1-f52.google.com with SMTP id db10-20020a0568306b0a00b0066d43e80118so9210009otb.1;
        Tue, 06 Dec 2022 05:03:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZsHz7oem0hvoy253pLElia6MFpzna6RsOWGgM/OIK/c=;
        b=T4FLbVv69VHjiRhHTv9UK6/yyBlvxZC4dOlstgJwAUt0ghqojPrb6qOam6Uu0J6y2T
         esiyN4ZJSwb0CpxOitsgUT0pnyZGN+0hv+6aD07/7JTa/a8a5xvjoh2RKa7MyEbV3MKN
         mkR6jD3PACbcC+LnCcJiFJzyelxwWyiiy0oDbBo56MGyUm1KEGM1BIiTXBfxpJlqePQ+
         OCT9tv8SRnBCFVv8u9Bwl2h9DM4cPPURqTafo0DeDxjfUtliKQ3PuPEWEcjwOj+U+88W
         Llc2QJ0QVycjRLhy2bKeQ1cahmCE1UHyynkeG/y6S3puHhFZY+d76IQyOgUjRpCWUmYU
         GKsQ==
X-Gm-Message-State: ANoB5pkEX6JiVe51lm6c4Lnsl6VOsvRNN9zvMxUVvM2HK8MkUccVO1k0
        Nf3o9oD4TvLsPpY88f62DA==
X-Google-Smtp-Source: AA0mqf4yMjf4z/y/6VWpMK8yj5aLgyx2b7hfiA+lsr5PO0CdV8vmOyeAkgnmUv8+mjnlGm72eQ9eCg==
X-Received: by 2002:a05:6830:3499:b0:66e:6dc2:cc19 with SMTP id c25-20020a056830349900b0066e6dc2cc19mr13611372otu.28.1670331786082;
        Tue, 06 Dec 2022 05:03:06 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id q38-20020a056871082600b00144a3c526d9sm3252124oap.52.2022.12.06.05.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 05:03:04 -0800 (PST)
Received: (nullmailer pid 226253 invoked by uid 1000);
        Tue, 06 Dec 2022 13:03:03 -0000
Date:   Tue, 6 Dec 2022 07:03:03 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-samsung-soc@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Joe Tessler <jrt@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Alain Volmat <alain.volmat@foss.st.com>,
        linux-tegra@vger.kernel.org, Jeff Chase <jnchase@google.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Yannick Fertre <yannick.fertre@foss.st.com>,
        linux-media@vger.kernel.org,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        devicetree@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-kernel@vger.kernel.org,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 4/9] media: dt-bindings: amlogic,meson-gx-ao-cec:
 reference common CEC properties
Message-ID: <167033178234.226181.8075242304535927739.robh@kernel.org>
References: <20221205151845.21618-1-krzysztof.kozlowski@linaro.org>
 <20221205151845.21618-5-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221205151845.21618-5-krzysztof.kozlowski@linaro.org>
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


On Mon, 05 Dec 2022 16:18:40 +0100, Krzysztof Kozlowski wrote:
> Reference common HDMI CEC adapter properties to simplify the binding and
> have only one place of definition for common properties.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Acked-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  .../bindings/media/cec/amlogic,meson-gx-ao-cec.yaml        | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

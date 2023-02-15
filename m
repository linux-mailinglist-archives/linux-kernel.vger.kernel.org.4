Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1C78698686
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 21:50:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbjBOUu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 15:50:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbjBOUub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 15:50:31 -0500
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEDA745F4A;
        Wed, 15 Feb 2023 12:47:46 -0800 (PST)
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-16e353ce458so204385fac.9;
        Wed, 15 Feb 2023 12:47:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pMgbY1yX1M4f0ZAvv2XhWbT4uDROp3YWiwlwViDpOPI=;
        b=o0U7HpUYspD/hgA+BJA2DWLKP9XcPqJnnFSvzil0jfODVr3BwqezdadlJiZGCdL65X
         YwNUqU2EnMC/O0HFku7GCxR9seQ+F4k4alRNI4MKolSDVe5LWgXfmwvtc38Bg3t7jpN3
         KTT53vIARCmjoNo2zjGxwF3dTCY+g5a5OHolNTFVM8h7kov29Z/7revV315uJpGh9YtZ
         9TncsGthhAhiu7ulmAt6H2EgaqUyt+6qOmvqufUExbLc2cKL4UTsTiPgFCvDrRG4BJkn
         gVgn9QyXLI1KAwfTUDJQQ2LgwaO0DA9pis17TJXELF9S4Ps58Bb1lhRxP07vHby8iiTf
         sTIA==
X-Gm-Message-State: AO0yUKXEuKqlxfcfN6xe5YnT1/snylBdedl53N0zk9vb5lV7m/58ARaF
        NHsNaedipcGfaM5DH3FSYw==
X-Google-Smtp-Source: AK7set8GPUEY+gIAYlE3f3O6s2u72g0/ghhD9WE1lrfhcMfu9ExHImg+FujTtfrjPepwhSp6XKW9Hw==
X-Received: by 2002:a05:6870:3288:b0:16e:1b4e:a592 with SMTP id q8-20020a056870328800b0016e1b4ea592mr2078124oac.3.1676494017980;
        Wed, 15 Feb 2023 12:46:57 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id y9-20020a4a2b49000000b0051aab373a8dsm7304582ooe.32.2023.02.15.12.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 12:46:57 -0800 (PST)
Received: (nullmailer pid 525911 invoked by uid 1000);
        Wed, 15 Feb 2023 20:46:56 -0000
Date:   Wed, 15 Feb 2023 14:46:56 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-media@vger.kernel.org,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/7] media: dt-bindings: i2c: samsung,s5k6a3: convert
 to dtschema
Message-ID: <167649401635.525858.271351307744119068.robh@kernel.org>
References: <20230214104508.51955-1-krzysztof.kozlowski@linaro.org>
 <20230214104508.51955-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230214104508.51955-2-krzysztof.kozlowski@linaro.org>
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


On Tue, 14 Feb 2023 11:45:02 +0100, Krzysztof Kozlowski wrote:
> Convert the Samsung S5K6A3(YX) raw image sensor bindings to DT schema.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> DTS is being fixed here:
> https://lore.kernel.org/all/20230211134731.85957-3-krzysztof.kozlowski@linaro.org/
> ---
>  .../bindings/media/i2c/samsung,s5k6a3.yaml    | 98 +++++++++++++++++++
>  .../bindings/media/samsung-s5k6a3.txt         | 33 -------
>  2 files changed, 98 insertions(+), 33 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/media/i2c/samsung,s5k6a3.yaml
>  delete mode 100644 Documentation/devicetree/bindings/media/samsung-s5k6a3.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>


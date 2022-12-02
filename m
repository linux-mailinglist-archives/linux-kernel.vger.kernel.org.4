Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 379F963FC8F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 01:10:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231905AbiLBAKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 19:10:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231197AbiLBAKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 19:10:15 -0500
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F07813E2B;
        Thu,  1 Dec 2022 16:10:14 -0800 (PST)
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-1441d7d40c6so4016003fac.8;
        Thu, 01 Dec 2022 16:10:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PGeYHnvnTVDlKGK4hioDNG3fleZ+PJeVl+Dm2RKNwOU=;
        b=W5hlg2537CzRUFgUTizUBgnDPKVl4jYUSbFySokkMFJB9/j4FGQ4GdMKlGZDcbdrMK
         0MqnPJL+dyv7VbdsxaohnpJduwSWtOtBDRS7ZDLauTriqONuWXg0kPj/FOoQv0ZZc0EM
         dsrS6UigBclzCRvC9LJYNlHagV2ysXdcYILzPs9lEh68LK9zyIUIxLUbdN9XB0t2Ulnq
         NRdd/BizVpRoHlWRnsd2PeCcnnVboFKALmXp2m9uhOaSakr/shvbqD80CHJzytCgMH1C
         V3Tc8m4mSROFE50vkI6hW192JtUwJlJh8Nw2Xig1MXfQUunRGCvEyRfTYigAUBEc/OYx
         a9rA==
X-Gm-Message-State: ANoB5pkD8dHy5z4VlIQ+w8bJQUB/MBOrTWKXee6B9GlVOyaSZ/F/46Ba
        X5STLSybpMTeNdT75lVqyRhUuQoBSg==
X-Google-Smtp-Source: AA0mqf7uRg6b6qtxr2t5RJ4GYa22NfhZLse52fRxHJjxwpeAsxIEkybweZESJtoRNQqA++D8YYmWTA==
X-Received: by 2002:a05:6870:d916:b0:143:11e:934c with SMTP id gq22-20020a056870d91600b00143011e934cmr28388761oab.234.1669939813807;
        Thu, 01 Dec 2022 16:10:13 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id f67-20020a9d2c49000000b0066e6adc3a3esm2544795otb.67.2022.12.01.16.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 16:10:13 -0800 (PST)
Received: (nullmailer pid 1739460 invoked by uid 1000);
        Fri, 02 Dec 2022 00:10:12 -0000
Date:   Thu, 1 Dec 2022 18:10:12 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, Andy Gross <agross@kernel.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH] dt-bindings: serial: qcom,msm-uart: Convert to DT schema
Message-ID: <166993981190.1739421.3476554672523016927.robh@kernel.org>
References: <20221201133036.45288-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221201133036.45288-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 01 Dec 2022 14:30:36 +0100, Krzysztof Kozlowski wrote:
> Convert the Qualcomm MSM SoC UART (non-DMA) bindings to DT schema.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/serial/qcom,msm-uart.txt         | 25 ---------
>  .../bindings/serial/qcom,msm-uart.yaml        | 56 +++++++++++++++++++
>  2 files changed, 56 insertions(+), 25 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/serial/qcom,msm-uart.txt
>  create mode 100644 Documentation/devicetree/bindings/serial/qcom,msm-uart.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0D8D67BD96
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 22:04:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236136AbjAYVEM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 16:04:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236602AbjAYVEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 16:04:10 -0500
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 309932F791;
        Wed, 25 Jan 2023 13:04:09 -0800 (PST)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-12c8312131fso125662fac.4;
        Wed, 25 Jan 2023 13:04:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3umJdp0RAk9hjr5PrBIEZs36K07t7ZzqXE0MOXb8Q90=;
        b=d18HZfo/WBhFZGs2FGglXmPaeGrapQgxzz3jRm8+j5X1OKJMHDc7lmwAvcJHOuNXjh
         0S9XngN0hL65zpT7Vhiiwlu4ptU9phPD02eTRDiF6eNhBS9D+RW0CkWZqB2f1URXjvXl
         bsXJNo1HJtdArvtRYKxQVmFvaex+SXiDouS0n7OAQO4dmWtcCcxrTApC2w8B3UNEHqHW
         bJIyv0j6x7cLWV1HhrWNbCpFkUIw5S7y7D1MNl3TEIgu7WlyE9UGx2lO0Iy1+kc0rKkG
         7ZxcColQx+NUNfZZi7zrS9kl/38xy52ETHCQJgRgpXzUGFVAzYqB6ZP9a2jTZn6Az8Fj
         AapA==
X-Gm-Message-State: AO0yUKVVZ9Dqb97yfamJd2e1kAUtkkdH12cLaDfE7vSlJ98sm2hL3deA
        WojJh43c3hjYDHGCWgRV3zr8LqZ/WQ==
X-Google-Smtp-Source: AK7set92TI7dfJnJyXOZWBGbJwJQ1xgBdvAZKKEZQCyJ9GCO64gsAyaoEPDoxz0n5d3Q1ORj8jIelg==
X-Received: by 2002:a05:6870:b289:b0:163:1ea3:2151 with SMTP id c9-20020a056870b28900b001631ea32151mr3418388oao.40.1674680648356;
        Wed, 25 Jan 2023 13:04:08 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id ls11-20020a0568704b4b00b0014c8b5d54b2sm2364197oab.20.2023.01.25.13.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 13:04:08 -0800 (PST)
Received: (nullmailer pid 2892386 invoked by uid 1000);
        Wed, 25 Jan 2023 21:04:07 -0000
Date:   Wed, 25 Jan 2023 15:04:07 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: interconnect: samsung,exynos-bus: allow
 opp-table
Message-ID: <167468064668.2892331.14944394685213771126.robh@kernel.org>
References: <20230125090849.122189-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230125090849.122189-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 25 Jan 2023 10:08:49 +0100, Krzysztof Kozlowski wrote:
> The opp-table can be located in the exynos-bus node which uses it, so
> allow such child node.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../interconnect/samsung,exynos-bus.yaml      | 27 +++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

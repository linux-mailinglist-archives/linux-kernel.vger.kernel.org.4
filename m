Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA04061698D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 17:45:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232089AbiKBQpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 12:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231924AbiKBQoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 12:44:44 -0400
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A48881159;
        Wed,  2 Nov 2022 09:40:57 -0700 (PDT)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-1322d768ba7so20910489fac.5;
        Wed, 02 Nov 2022 09:40:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m+qIpBdMeiwMSdKxhevqq/k7KwaaJsQLzkW85JVdIao=;
        b=DFjHh/zUlhLF146ohXsixdVd7nzc+Jok+rsiGLlhd2lSJQ3IgCPuAu3rbvzmOPITSG
         rcs7JMmSL1qotArEWh3goYKnnRXSZf6wiMiFGNcplltX8+rQDuoc1L6bd+x5QDyS97Od
         prBbp/MsMN1SFKIoEtSga/YNOqzYmHwo24gbQY91i/N8dnHfc0rh/n++empiU7k3e0PN
         Udx16bnLaqRAiF/Bs/e6QeBIP7wwSXmhhnjW1bq8MVewtZBBwZ3S4zhbTHf84YV+cuFQ
         TksLjoPDDtQgQgnrpOJ178Q8/SKiPMLl/Z7WHPupivIbBTnSwbLJsLfyhQnI/OJ2GSJ6
         XAOQ==
X-Gm-Message-State: ACrzQf1goGgqPao4QkyIN9kdAA8K4nGJlQMGv5vSq96Ijl4g3gnimOSu
        7NNvrTCFD8ZV9VHoCYjy+A==
X-Google-Smtp-Source: AMsMyM6f3lSc5rozDexOGm1YJwC+cz1fMbEXwplGHe3C/bKL7xZEBfeU6Fgy9bW+3b/j+e12LhudwQ==
X-Received: by 2002:a05:6870:785:b0:131:e39c:9140 with SMTP id en5-20020a056870078500b00131e39c9140mr15365528oab.261.1667407256894;
        Wed, 02 Nov 2022 09:40:56 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id i16-20020a056870a69000b0013b8b3710bfsm6213718oam.13.2022.11.02.09.40.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 09:40:56 -0700 (PDT)
Received: (nullmailer pid 4016578 invoked by uid 1000);
        Wed, 02 Nov 2022 16:40:58 -0000
Date:   Wed, 2 Nov 2022 11:40:58 -0500
From:   Rob Herring <robh@kernel.org>
To:     Zev Weiss <zev@bewilderbeest.net>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org,
        Naresh Solanki <naresh.solanki@9elements.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        openbmc@lists.ozlabs.org, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 2/3] dt-bindings: regulator: Add regulator-output
 binding
Message-ID: <166740725744.4016522.5256752936838143557.robh@kernel.org>
References: <20221031233704.22575-1-zev@bewilderbeest.net>
 <20221031233704.22575-3-zev@bewilderbeest.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221031233704.22575-3-zev@bewilderbeest.net>
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


On Mon, 31 Oct 2022 16:37:03 -0700, Zev Weiss wrote:
> This describes a power output supplied by a regulator, such as a
> power outlet on a power distribution unit (PDU).
> 
> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
> ---
> 
> Changes since v1:
>  - removed 'regulator-leave-on' property
> 
>  .../bindings/regulator/regulator-output.yaml  | 39 +++++++++++++++++++
>  1 file changed, 39 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/regulator-output.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>

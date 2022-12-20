Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9705D65256F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 18:17:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233010AbiLTRRo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 12:17:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbiLTRRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 12:17:40 -0500
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 870431A061;
        Tue, 20 Dec 2022 09:17:37 -0800 (PST)
Received: by mail-oi1-f169.google.com with SMTP id r205so10207385oib.9;
        Tue, 20 Dec 2022 09:17:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GxxRltPnXbABKktCGQ8zwETVztAmhzzDOOp/Wg2nlpc=;
        b=aoeToO6K+OnMa52DAOx/K54ync/nJ5V2Jf//4+33wrMpFiRN5E3oqngywo2wjHnlRF
         kqJBNlc5edpWOmPFmKZzSWXc2ndDACjyLEoIVUDLl3SWRalyHyKcfE3LoAtBMt75/8sz
         UeU1vX6i0FoLW9t9zeIEo6MZ2jznGaeZDLvUNjhC5hGatkyf8hQL1YNBJz2GnfuZYQv2
         wcyic7e8aHDvLyf6zHydu2cAGIOK7bDxTjzhFrlkA+ZfsXOPONbz1MM+EHCbWUgcjztT
         Bc3XaH3R4rGrilmayLnc+cRE2bTKttTpWsxlqABBqLs14xCPg/9T/Pc+s5SwO5021lH3
         wVhQ==
X-Gm-Message-State: AFqh2kqlGdPOJhWJUscKPZZgG8vTA9GQjsQkFUAISv9FTx7XYiQctEYJ
        fY90VXG6uUGTHOHadldSvQ==
X-Google-Smtp-Source: AMrXdXuO/wOlwYiXQn7ZI54TbiSVbxGP6NiQzf8l3N9gVTMJwG+z71xQNrzWlzyNCtGWysHj47MmhA==
X-Received: by 2002:a05:6808:1312:b0:361:bf9:ce49 with SMTP id y18-20020a056808131200b003610bf9ce49mr3562623oiv.27.1671556656717;
        Tue, 20 Dec 2022 09:17:36 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id y9-20020acae109000000b0035bd1909a66sm5720273oig.57.2022.12.20.09.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 09:17:36 -0800 (PST)
Received: (nullmailer pid 766782 invoked by uid 1000);
        Tue, 20 Dec 2022 17:17:35 -0000
Date:   Tue, 20 Dec 2022 11:17:35 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sriranjani P <sriranjani.p@samsung.com>
Cc:     pankaj.dubey@samsung.com, devicetree@vger.kernel.org,
        ravi.patel@samsung.com, sathya@samsung.com,
        linux-arm-kernel@lists.infradead.org, alim.akhtar@samsung.com,
        linux-samsung-soc@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] dt-bindings: soc: samsung: exynos-sysreg: add
 dedicated SYSREG compatibles to Exynos850
Message-ID: <167155665450.766713.18230881915109975731.robh@kernel.org>
References: <20221214044342.49766-1-sriranjani.p@samsung.com>
 <20221214044342.49766-2-sriranjani.p@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221214044342.49766-2-sriranjani.p@samsung.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 14 Dec 2022 10:13:39 +0530, Sriranjani P wrote:
> Exynos850 has two different SYSREGs, hence add dedicated compatibles for
> them and deprecate usage of generic Exynos850 compatible alone.
> 
> Signed-off-by: Sriranjani P <sriranjani.p@samsung.com>
> ---
>  .../soc/samsung/samsung,exynos-sysreg.yaml        | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>

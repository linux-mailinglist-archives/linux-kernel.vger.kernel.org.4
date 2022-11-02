Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2017B616475
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 15:07:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbiKBOHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 10:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231332AbiKBOHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 10:07:02 -0400
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABE0D97;
        Wed,  2 Nov 2022 07:07:00 -0700 (PDT)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-13b103a3e5dso20430479fac.2;
        Wed, 02 Nov 2022 07:07:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9er61rLTBDnFyJZShqMJ3LkA0GzgHcLhxyQpRM+ciNU=;
        b=Pr6JuBqUw3+xSHfL6WftUM29q1N684kb6jkWWGcp6smwzJUEaoZ+L29XRiLYcQlREN
         PHzpMg73PMX3QbfHMvQa0U8sBJ/kXgOJNbMn05gIKOM0HBR8uzIp52wvkMpzD326cgyx
         Vb/EAzO2pCNarHtauvemx39P42LJASqp9vpuXumvuvu+cuxfK9XS62PeQxRnxv8J62KA
         xPR3iLlBEKIipV640mLA4bIoe1FKZBOuGkPOB9+AdS4Pu0v/Veuor5DaUZERXLXSoqp+
         fQjigdlJyiQbXCgwU33gFCnU+wwaLPgPAHZ+LTcA2Ex9nRR/cF0Bnd7O+qnZpA+tY9T8
         ffqw==
X-Gm-Message-State: ACrzQf2PKizsN74NJsUfRuOcNpkCQu2y+er8XHvtdhEhyKKLcWpISSfp
        hqllTivljsXnF9l27f2/zk1UTC4lzA==
X-Google-Smtp-Source: AMsMyM6AH/1vUSOk369DDFflviS2CfUE+qkgVnv2XYW9rWojMI8/NlFnXDrPIDmDMtvADWJMW6yYnQ==
X-Received: by 2002:a05:6870:6593:b0:13b:c1a:e8ac with SMTP id fp19-20020a056870659300b0013b0c1ae8acmr14833081oab.271.1667398019920;
        Wed, 02 Nov 2022 07:06:59 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r24-20020a056870179800b00132f141ef2dsm6010170oae.56.2022.11.02.07.06.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 07:06:59 -0700 (PDT)
Received: (nullmailer pid 3724848 invoked by uid 1000);
        Wed, 02 Nov 2022 14:07:01 -0000
Date:   Wed, 2 Nov 2022 09:07:01 -0500
From:   Rob Herring <robh@kernel.org>
To:     cy_huang <u0084500@gmail.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, broonie@kernel.org,
        lgirdwood@gmail.com, cy_huang@richtek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: regulator: Add bindings for Richtek
 RT6190 regulator
Message-ID: <20221102140701.GA3704610-robh@kernel.org>
References: <1667183334-16511-1-git-send-email-u0084500@gmail.com>
 <1667183334-16511-2-git-send-email-u0084500@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1667183334-16511-2-git-send-email-u0084500@gmail.com>
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

On Mon, Oct 31, 2022 at 10:28:53AM +0800, cy_huang wrote:
> From: ChiYuan Huang <cy_huang@richtek.com>
> 
> Add devicetree binding for Richtek RT6190 4-Switch buckboost controller.
> 
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> ---
> Hi, Rob:
> 
> Since I didn't got any reply from the v2 dt-binding question.
> https://lore.kernel.org/lkml/CADiBU3_WUeyYdnmnG0Ff2pH+b3u1zOtP1z44LcA53Ba5c9nrEw@mail.gmail.com/
> In v3, I aleady fixed it following by your comment.
> 
> I'm just wondering the corrent usage.
> As I know, 'enable-gpios' comes from 'gpio-consumer-common.yaml'.
> In the common yaml file, it's already declared 'enable-gpios' maxItems as '1'.
> That's why I just declared it as 'true'.

Yes, you are right. Either way is fine then.

> Since v3:
> - Fix the typo 'upply' to 'supply'.
> - Declare 'enable-gpios' maxItems as 1.
> - Declare the 'maxItems' for the property 'regulator-allowed-modes'.
> 
> Since v2:
> - Rename binding filename to 'richtek,rt6190.yaml'
> 
> ---
>  .../bindings/regulator/richtek,rt6190.yaml         | 79 ++++++++++++++++++++++
>  1 file changed, 79 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/richtek,rt6190.yaml

Reviewed-by: Rob Herring <robh@kernel.org>

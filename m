Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFFB568FB9C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 00:51:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbjBHXv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 18:51:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbjBHXvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 18:51:53 -0500
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BADB7EFA;
        Wed,  8 Feb 2023 15:51:50 -0800 (PST)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-15ff0a1f735so592368fac.5;
        Wed, 08 Feb 2023 15:51:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SeopQBZWSFT12ftEApLU1dIxhgsa3H+xUNavQnJepUM=;
        b=MMhqvwpi+HByQx90p4DjmV5ckEKiugFpsEPAaYSKrPWOmtCkvKPJcpQSe712r57EdY
         uTDQXyvss1jlMdF88ymvaPoRHFXFJi6keXQ5k4W/m07roqyxXtg4ROUofB6LRStkyzdf
         D7d4mR7GsKeZrCcR+D/Zed6bHNHE0kAilfO5+dt4No9ZNt+LKFAJyUd+ngegEwJyW8qC
         yG0r8mAvO50xhdyD9og+Zx1V8qWOZZ3a+nciQWc/GKZwdJzhXip6Wblyx0YFxIDpuKVs
         8m7Bre3vCz/4uk9kHyRyrTlO6rA57z7FrMDpHJG+FRlmDNnOrQWt0kpkaSYGNEgiZ3Kx
         WE3Q==
X-Gm-Message-State: AO0yUKVooP3REXz/XcFsrlOk0ErDtgQ/54cN4LaGhO6akTjBo0Is2zuL
        w2UMkgAe7mOS1m1RCWTY8A==
X-Google-Smtp-Source: AK7set9R9u8bHSmytawMInx5vWRPC0UiQfX8JT1WvCRVWGTkvNPnP/P9GmuW9K2SjDcnXa28c/2R2w==
X-Received: by 2002:a05:6870:41d0:b0:163:6bf1:15a with SMTP id z16-20020a05687041d000b001636bf1015amr5231943oac.22.1675900309758;
        Wed, 08 Feb 2023 15:51:49 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id b3-20020a05687061c300b00163c90c1513sm7401523oah.28.2023.02.08.15.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 15:51:49 -0800 (PST)
Received: (nullmailer pid 2940966 invoked by uid 1000);
        Wed, 08 Feb 2023 23:51:48 -0000
Date:   Wed, 8 Feb 2023 17:51:48 -0600
From:   Rob Herring <robh@kernel.org>
To:     ChiaEn Wu <chiaen_wu@richtek.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, sre@kernel.org,
        cy_huang@richtek.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        peterwu.pub@gmail.com
Subject: Re: [Patch][next] dt-bindings: power: supply: Revise Richtek RT9467
 compatible name
Message-ID: <20230208235148.GA2939644-robh@kernel.org>
References: <dc8873c3125f7aa6f84dc7b33a44bf00907e0814.1675853673.git.chiaen_wu@richtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc8873c3125f7aa6f84dc7b33a44bf00907e0814.1675853673.git.chiaen_wu@richtek.com>
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

On Wed, Feb 08, 2023 at 11:14:24AM +0800, ChiaEn Wu wrote:
> Revise RT9467 compatible name from "richtek,rt9467-charger" to
> "richtek,rt9467"
> 

Reported-by: Rob Herring <robh@kernel.org>

> Fixes: e1b4620fb503 ("dt-bindings: power: supply: Add Richtek RT9467 battery charger")
> Signed-off-by: ChiaEn Wu <chiaen_wu@richtek.com>
> ---
>  .../devicetree/bindings/power/supply/richtek,rt9467-charger.yaml      | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A94A6DF862
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 16:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231585AbjDLOZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 10:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbjDLOZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 10:25:00 -0400
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABA394206;
        Wed, 12 Apr 2023 07:24:59 -0700 (PDT)
Received: by mail-oi1-f170.google.com with SMTP id bh10so7865481oib.1;
        Wed, 12 Apr 2023 07:24:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681309499; x=1683901499;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zL+50zPLrjuLA8fqBLOEQM7c2a2HckTPPr7Ny3uRBP0=;
        b=G9EyqYSznBb+w1tqCZsahndgaduGxNDH8dXO/Ef91LcPiXKdiQHGeUDJ/bAxXTbtgg
         Cg6BYt9Y0+LDX/eQsXitHCRPFqU+gA2qvHZXZ/Yh4KzZaQaE2PfhhqntjuSKcKBkmr4N
         BwIpfKWP6akfWulm7Bf26Dmo50VBHq5ITVnuxHZ9cONNIZXasJfxFVmM5A0Z1j+0lwyB
         I0icvzPWglq0X6baty3bCedM9JV8o+GcFMyPFllMVdEaSPYJXZ+OARo9SCgqxaq0oFtt
         zkDx052G/DDkvWTn79lPpGKx1/BqLt66c9G/A8ianshD8lJ/ISl8syo4FhFBEwXj3bH3
         /b5A==
X-Gm-Message-State: AAQBX9f+YLaHSG8pZ682ryJ5BfXNEgoiiw9k4HuXBZJeZ+LmfK/o1lf/
        QhvG8uM4TVvWE51/84aZ+rASWXfjCA==
X-Google-Smtp-Source: AKy350ZRWCnOuzOVFhOnHWoQ1lacuWyjXo0ay+clioHA9u4vMZliLv5kBRkMbBNTgscun57W5oShRQ==
X-Received: by 2002:a05:6808:88:b0:386:ea33:755b with SMTP id s8-20020a056808008800b00386ea33755bmr1083158oic.19.1681309498919;
        Wed, 12 Apr 2023 07:24:58 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id b124-20020aca3482000000b0038bc0cb5d52sm3498572oia.9.2023.04.12.07.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 07:24:58 -0700 (PDT)
Received: (nullmailer pid 2312911 invoked by uid 1000);
        Wed, 12 Apr 2023 14:24:57 -0000
Date:   Wed, 12 Apr 2023 09:24:57 -0500
From:   Rob Herring <robh@kernel.org>
To:     Dipen Patel <dipenp@nvidia.com>
Cc:     linus.walleij@linaro.org, jonathanh@nvidia.com,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        brgl@bgdev.pl, robh+dt@kernel.org, gregkh@linuxfoundation.org,
        linux-gpio@vger.kernel.org, timestamp@lists.linux.dev,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        linux-tegra@vger.kernel.org, thierry.reding@gmail.com,
        linux-doc@vger.kernel.org
Subject: Re: [V5 03/10] dt-bindings: timestamp: Deprecate nvidia,slices
 property
Message-ID: <168130949723.2312853.9364535944152473595.robh@kernel.org>
References: <20230406171837.11206-1-dipenp@nvidia.com>
 <20230406171837.11206-4-dipenp@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230406171837.11206-4-dipenp@nvidia.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 06 Apr 2023 10:18:30 -0700, Dipen Patel wrote:
> The property is not necessary as it is a constant value and can be
> hardcoded in the driver code.
> 
> Signed-off-by: Dipen Patel <dipenp@nvidia.com>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  .../bindings/timestamp/nvidia,tegra194-hte.yaml           | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE71736F2E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 16:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233438AbjFTOvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 10:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231777AbjFTOvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 10:51:25 -0400
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A46A01A3;
        Tue, 20 Jun 2023 07:51:24 -0700 (PDT)
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3425eb6865eso7253235ab.1;
        Tue, 20 Jun 2023 07:51:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687272684; x=1689864684;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CPCDEgOuT2rA1ixLARbuE2uBRGhTdut5Cc9HNDy/Nfw=;
        b=T/3EqS09SHTwMVJkA7Gs9qDgXYxYsh3ZNWb4fFC7kt0mX6baQs4561xZn+ESw2y+nO
         aM/WOE3dbuXuS6QGZB7BEzA1PmR7Et9hR8zL470z7Z3NndG2LQByq47QiOfh1oK0+D7B
         CUHPPdX2DEaca88gYxrR5GwOTIjHAaUdL6jpxMb2J6xLdrwcbaSRXo4KXHupZ2ffLbLm
         KssqMBuRwtxIhUeY3HMpH5u86HbJik9jCUQwScJR6bw/3R62eKqw+xqfY0Xmwyww//1+
         rzomILAL+shd25muS1kXUa66XrDeFRNltsWyGWuv+8AyTbbcoQQr9LOW4COjDVdcg2GO
         stUQ==
X-Gm-Message-State: AC+VfDzK+EGDi1j3PdayHtMxpFL2UWmSzUBSt+fIHd4FQFICICnaevHN
        +aMLNcHiiallmiQFdaB2So21jt91CQ==
X-Google-Smtp-Source: ACHHUZ68toVkGN/nMw9z0B6GdODZCZwCjDhewdfTvf3eQgYof7J6oWpaRpG3UhEujZrAanNSr6nRIw==
X-Received: by 2002:a05:6e02:1beb:b0:33e:51bf:727d with SMTP id y11-20020a056e021beb00b0033e51bf727dmr9170619ilv.10.1687272683847;
        Tue, 20 Jun 2023 07:51:23 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id f25-20020a02cad9000000b0041d8acd35b0sm686881jap.3.2023.06.20.07.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 07:51:23 -0700 (PDT)
Received: (nullmailer pid 3577630 invoked by uid 1000);
        Tue, 20 Jun 2023 14:51:21 -0000
Date:   Tue, 20 Jun 2023 08:51:21 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH] dt-bindings: arm: drop unneeded quotes and use absolute
 /schemas path
Message-ID: <168727268121.3577565.13260147801672542586.robh@kernel.org>
References: <20230609140754.65158-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230609140754.65158-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 09 Jun 2023 16:07:54 +0200, Krzysztof Kozlowski wrote:
> Cleanup bindings dropping unneeded quotes. Once all these are fixed,
> checking for this can be enabled in yamllint.  Also absolute path
> starting with /schemas is preferred.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/arm/arm,vexpress-juno.yaml        | 10 +++++-----
>  .../devicetree/bindings/arm/cpus.yaml          | 18 +++++++++---------
>  .../devicetree/bindings/arm/psci.yaml          |  2 +-
>  3 files changed, 15 insertions(+), 15 deletions(-)
> 

Applied, thanks!


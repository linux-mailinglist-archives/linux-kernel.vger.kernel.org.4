Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A294654769
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 21:41:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbiLVUlj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 15:41:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbiLVUlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 15:41:15 -0500
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B84912AB1;
        Thu, 22 Dec 2022 12:40:55 -0800 (PST)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-14449b7814bso3853874fac.3;
        Thu, 22 Dec 2022 12:40:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jnBz8eeKizZYt94fvfql8mf6HshaTd0IO3owHnhYilk=;
        b=DShRsq0JccjKfNdqJwFjs3ykqLwBiDWV4tlXWrxipV+4wwvIPomJ6r0TYlCXHfKOVr
         Gxq/D5cwW3hyh28HpFUXHIAAyIsaxDOXPIieHCpHJTHiTNxkIj+pv2WruUZKymyR+lHM
         e893VJHXOv0EMmZnubOHAdyjZvaOxWv1uIuzZQI8Y3gVNKwEDq7T86MOJie+noQhQSBg
         yn66WCI3Ki7WUSpzUB+qvdGJI51w8koGErdN2PRJVcFewoIb5K/bj+4EdG20mG5LBc+2
         F4NnsJ5M4RGUup3szYXIG/G609hNjyOkpWsMvPWs6TeSjYiDBNmxWtUVFXj0E+/5gd7j
         CMtw==
X-Gm-Message-State: AFqh2koYC/Xelz8H3WWlyq60eBY3b9VpsUendB91SyuPIvqz/Pk0YCKs
        jlY2EmhYoC1PX6qr9b8b9A==
X-Google-Smtp-Source: AMrXdXvnlaOpydtz121X22CM+JoesTbwPRx+uOohxf0uybdbJWFTqySszg7BdCq+tOUcaIGXrrHbNg==
X-Received: by 2002:a05:6870:b624:b0:144:6d65:fe49 with SMTP id cm36-20020a056870b62400b001446d65fe49mr3954856oab.7.1671741654285;
        Thu, 22 Dec 2022 12:40:54 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id u3-20020a056870304300b00136f3e4bc29sm716880oau.9.2022.12.22.12.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 12:40:53 -0800 (PST)
Received: (nullmailer pid 2082309 invoked by uid 1000);
        Thu, 22 Dec 2022 20:40:53 -0000
Date:   Thu, 22 Dec 2022 14:40:53 -0600
From:   Rob Herring <robh@kernel.org>
To:     Colin Foster <colin.foster@in-advantage.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Roger Quadros <rogerq@kernel.org>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v1] dt-bindings: memory-controllers: ti,gpmc: fix typo in
 description
Message-ID: <167174165175.2082238.1901745325507661042.robh@kernel.org>
References: <20221222182309.575069-1-colin.foster@in-advantage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221222182309.575069-1-colin.foster@in-advantage.com>
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


On Thu, 22 Dec 2022 10:23:09 -0800, Colin Foster wrote:
> Fix typo where 'GPMC driver implements an interrupt controller' instead of
> 'and interrupt controller'
> 
> Signed-off-by: Colin Foster <colin.foster@in-advantage.com>
> ---
>  .../devicetree/bindings/memory-controllers/ti,gpmc.yaml         | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks!

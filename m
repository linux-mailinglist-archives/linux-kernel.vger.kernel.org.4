Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FFEA6D9DD1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 18:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238524AbjDFQr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 12:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239475AbjDFQrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 12:47:24 -0400
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF74AD03;
        Thu,  6 Apr 2023 09:46:59 -0700 (PDT)
Received: by mail-ot1-f52.google.com with SMTP id o25-20020a9d4119000000b006a11eb19f8eso19806141ote.5;
        Thu, 06 Apr 2023 09:46:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680799619; x=1683391619;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y5R2nnvokLlBhefou6r+FxkRDSzpDeUjT394xl/l7UI=;
        b=1uMBfbHOXn+BvqRq1kLYeydfkcNfCYm7p+V2wLCZyeA0/0Ei0sv7oJu752+4kMM9wB
         Ln9fY2TV5Yun9wDBZDUyB+swSoipJKrg4r8gnQZWCg0llhBpUBdGJ4Rk2zncVhGCHp57
         j0U2Kz8CnVjC64v04SG08immqCvtLb3fvzX3zJH9TwU6KYj3hnoxPICHMLJep6l1bS1L
         3RcoNW+8uqA4ZwIYUzCNiX+2nki0tN+6UZ5YRN+UBZ9aZR7MDPj0Oh9BJrChMVoG103C
         ihDMZfkQNrtp+7hJaatmS2eHw9pKh4P8SALZbjdzpIh/c4KHAgmkRsXA+P9bNCX83UTY
         cL+A==
X-Gm-Message-State: AAQBX9fQ1oLN6rYLac1+z3FCjH7S3qxSTWjdTCXqcaQumZOQkPp43k1Y
        Cao1FTIAK1bGnXk5qGrj0A==
X-Google-Smtp-Source: AKy350Z3OYaa76+/4YxtLF2Qu+11ekm4rdpDupLiBwu+MAGdjJcY/6Zgjftgeu/hCJZiZwQrzIXP8g==
X-Received: by 2002:a05:6830:1be4:b0:69f:91db:51f1 with SMTP id k4-20020a0568301be400b0069f91db51f1mr4937068otb.29.1680799618832;
        Thu, 06 Apr 2023 09:46:58 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id s7-20020a0568301e0700b006a1508d348dsm875024otr.22.2023.04.06.09.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 09:46:58 -0700 (PDT)
Received: (nullmailer pid 3281922 invoked by uid 1000);
        Thu, 06 Apr 2023 16:46:57 -0000
Date:   Thu, 6 Apr 2023 11:46:57 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Swapnil Jakhade <sjakhade@cadence.com>,
        Abraham I <kishon@ti.com>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Yuti Amonkar <yamonkar@cadence.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-phy@lists.infradead.org
Subject: Re: [PATCH 1/5] dt-bindings: phy: cadence-sierra: drop
 assigned-clocks
Message-ID: <168079961708.3281867.11311371291138451400.robh@kernel.org>
References: <20230404190115.546973-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230404190115.546973-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=0.8 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 04 Apr 2023 21:01:11 +0200, Krzysztof Kozlowski wrote:
> The meta schema from DT schema already defines assigned-clocks, so there
> is no need for device schema to mention it at all.  There are also no
> benefits of having it here and a board could actually need more of clock
> assignments than the schema allows.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/phy/phy-cadence-sierra.yaml       | 8 --------
>  1 file changed, 8 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>


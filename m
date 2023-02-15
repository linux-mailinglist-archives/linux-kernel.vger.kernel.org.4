Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E60A6986D3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 22:02:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbjBOVCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 16:02:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbjBOVBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 16:01:49 -0500
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A5C64347D;
        Wed, 15 Feb 2023 12:59:53 -0800 (PST)
Received: by mail-il1-f169.google.com with SMTP id b9so110277ila.0;
        Wed, 15 Feb 2023 12:59:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QK1gGb0uKs0Zfv2jPvuJwt4S9KC6N99B7lOfm5u6XV4=;
        b=GkCKLBl7Oj7BkEX1sRxsp8pxKoDr0Xds9vRsPGM0IhM7M0gDAcJDSbgnALzYeNDmTU
         PNpqAZZkBN8hRPcBvDqOzY8HfULdnRFzEIaKXymuIY+xVD/fkz8IeCFnKAax24PbwIBA
         K9pjBstFgg3K9s9McQS7JnncmXEF58uP61xYUxu+ZqaGC7l5BfqhbiWgOCKDZ9lryrJp
         wGPhsugjV5QsjYJwgqKKB5zAk74YIho9ng5nXXOJZcodo1Uewl/1WPcvgwykipTpOHiD
         Bbbph8ydF3KSwMdLYAwVUwLewmcrD3daAnIN9du1djCWD9ajc3n5Z7M9OogUmZhvJkYm
         vHOQ==
X-Gm-Message-State: AO0yUKWdPBYDDbkMK/vTltjU4UQGx67D4mtm+hYbV2ZqtmqLR9+iyVQK
        YILSz1Pceh8eaCYsefy+9ZIlfXJKVw==
X-Google-Smtp-Source: AK7set8eaBEQTDD9zYPnhp0hAGOCCqiAZjyn3VbRfvNILDg7QgnTk7zQA+XtDtYRT8nZOyBz7tKvnw==
X-Received: by 2002:a05:6870:73cd:b0:15f:420:d7f6 with SMTP id a13-20020a05687073cd00b0015f0420d7f6mr2060244oan.23.1676494217283;
        Wed, 15 Feb 2023 12:50:17 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id q1-20020a056870e60100b00163b85ef1bfsm7355021oag.35.2023.02.15.12.50.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 12:50:16 -0800 (PST)
Received: (nullmailer pid 529714 invoked by uid 1000);
        Wed, 15 Feb 2023 20:50:16 -0000
Date:   Wed, 15 Feb 2023 14:50:16 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        devicetree@vger.kernel.org,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-media@vger.kernel.org, Alim Akhtar <alim.akhtar@samsung.com>,
        linux-samsung-soc@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 4/7] media: dt-bindings: samsung,exynos4212-fimc-lite:
 convert to dtschema
Message-ID: <167649421586.529655.11610103059265471616.robh@kernel.org>
References: <20230214104508.51955-1-krzysztof.kozlowski@linaro.org>
 <20230214104508.51955-5-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230214104508.51955-5-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 14 Feb 2023 11:45:05 +0100, Krzysztof Kozlowski wrote:
> Convert the Samsung Exynos SoC series camera host interface (FIMC-LITE)
> bindings to DT schema.  Changes during conversion - adjust to existing
> DTS and Linux driver: add iommus and power-domains.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/media/exynos-fimc-lite.txt       | 16 -----
>  .../media/samsung,exynos4212-fimc-lite.yaml   | 63 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  3 files changed, 64 insertions(+), 16 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/media/exynos-fimc-lite.txt
>  create mode 100644 Documentation/devicetree/bindings/media/samsung,exynos4212-fimc-lite.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>


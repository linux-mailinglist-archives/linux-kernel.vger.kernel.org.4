Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B64AD5B6ED2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 16:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232396AbiIMOFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 10:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231781AbiIMOFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 10:05:10 -0400
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C1B217AB5;
        Tue, 13 Sep 2022 07:05:09 -0700 (PDT)
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-1280590722dso32422347fac.1;
        Tue, 13 Sep 2022 07:05:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=xaesEF6Lfa7W1zJ6vFq2YbimoamHUz/4xsPADg2pI8U=;
        b=RwUD0q3JC+YmmFu5pL2OrGMDcPn/E2pVWwX0jNlBkd5Y29iohNZWJcgS+LM8GAW6Tu
         wiTYmgRK7F9K8Edp8rCQ4602xjIQAY25bQHmBftPUXppAIhfYwVFtJmkhSjTw8ugBSFt
         uEMjiWxmHWVvkd57VatGuJIqqjITGF6TIQRaCs15MMp6qkJ3+I+//zEmxm777zIUwRSu
         HgKahI4FgJ8Q4mPolNv0IvlGcyQtu4B3Hjg4wKFHyGF6A3GEgvDZdYuIuTlyWSAoUii9
         Ap3G+UySAmoXvZXp4kX1bTA+OImCjLBlZLGPm1r7O1rHYGAdq3gzxtiFpqaYte3L8P5v
         yIag==
X-Gm-Message-State: ACgBeo16qvksH6PBcM7XQBaCJuCx7SUwiY5bSLsUegkstgNtDh+KWYyL
        3LaUUz9TPouz1cxK8JBCaw==
X-Google-Smtp-Source: AA6agR5MZRUSO5U2/vJRsvdSOp4dyqOHS68xLdRjVDmKQUFF5s/TuXl3QUxdaeD4NpNEuWbsXwlnmw==
X-Received: by 2002:a05:6808:21a2:b0:345:d23e:d2e2 with SMTP id be34-20020a05680821a200b00345d23ed2e2mr1526157oib.273.1663077908262;
        Tue, 13 Sep 2022 07:05:08 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id q6-20020acaf206000000b003451c927e0dsm5119169oih.38.2022.09.13.07.05.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 07:05:07 -0700 (PDT)
Received: (nullmailer pid 3590506 invoked by uid 1000);
        Tue, 13 Sep 2022 14:05:07 -0000
Date:   Tue, 13 Sep 2022 09:05:07 -0500
From:   Rob Herring <robh@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Serge Semin <fancer.lancer@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        linux-clk@vger.kernel.org, linux-mips@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH RESEND v11 6/8] dt-bindings: clk: baikal-t1: Add DDR/PCIe
 reset IDs
Message-ID: <20220913140507.GA3590451-robh@kernel.org>
References: <20220909192616.16542-1-Sergey.Semin@baikalelectronics.ru>
 <20220909192616.16542-7-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220909192616.16542-7-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 09 Sep 2022 22:26:14 +0300, Serge Semin wrote:
> Aside with a set of the trigger-like resets Baikal-T1 CCU provides
> additional directly controlled reset signals for the DDR and PCIe
> controllers. As a preparation before adding these resets support to the
> kernel let's extent the Baikal-T1 CCU IDs list with the new IDs, which
> will be used to access the corresponding reset controls.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
> 
> ---
> 
> Changelog v11:
> - This is a new patch created by detaching the DT-part from:
> [PATCH v10 6/7] clk: baikal-t1: Add DDR/PCIe directly controlled resets support
>   (@Krzysztof)
> ---
>  include/dt-bindings/reset/bt1-ccu.h | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

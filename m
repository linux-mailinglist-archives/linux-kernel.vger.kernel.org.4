Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E818618BC0
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 23:43:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbiKCWnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 18:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiKCWno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 18:43:44 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF9F5F48;
        Thu,  3 Nov 2022 15:43:42 -0700 (PDT)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id A7BD21C0003;
        Thu,  3 Nov 2022 22:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1667515421;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=i8DpmqlDLlwURwllUprgYYKvPoTdjInJ2hQ/q4dzJm4=;
        b=au9TAKpfIW4i/iLRoai8B/42wcoxQz4qiT8w89QQOpKcEi9Y4cHFq56t4I/G3aGDiW95SA
        oFF/MGZyY6J3RL7Oz6rlQfv4FHkKRg3bEuBHJNJMacAHcXaZJVWeSdbgeP3O5Uk2bdVnWZ
        b62NupO/G0LTh+KZvdae94wt/66i2KvaLLkz7liiGjWKlSTlxASIugn8U83kVKt7X6hcTz
        bQeUF6XVWV3cWtOpqcQhRHjDqUa8DbPAdWi9ysGJhHE+IScK16iicl1W/gCRbWbbuCZscM
        7X5xpAXuqYy9OgQ0Jn/ad4pw4viHM6oF7DFhyEGm+u1kMKmv9KtJy+ZOxZSANA==
Date:   Thu, 3 Nov 2022 23:43:40 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     glazveze@delta.nl
Cc:     linux-rtc@vger.kernel.org,
        Mike Looijmans <mike.looijmans@topic.nl>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: rtc: ds1307: Add support for Epson
 RX8111
Message-ID: <Y2REHDAHFNJIUbL4@mail.local>
References: <20221101083123.11695-1-glazveze@delta.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221101083123.11695-1-glazveze@delta.nl>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/11/2022 09:31:21+0100, glazveze@delta.nl wrote:
> From: Mike Looijmans <mike.looijmans@topic.nl>
> 
> The rx_8111 is quite similar to the rx_8030. This adds support for this
> chip to the ds1307 driver.
> 
> This adds the entry to the devicetree bindings.
> 
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>

The SoB has to match the sender address, it took some time to me to
understand this was for the same person...

> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
> 
> (no changes since v1)
> 
>  Documentation/devicetree/bindings/rtc/rtc-ds1307.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/rtc/rtc-ds1307.yaml b/Documentation/devicetree/bindings/rtc/rtc-ds1307.yaml
> index 98d10e680144..a9590da64b84 100644
> --- a/Documentation/devicetree/bindings/rtc/rtc-ds1307.yaml
> +++ b/Documentation/devicetree/bindings/rtc/rtc-ds1307.yaml
> @@ -30,6 +30,7 @@ properties:
>            - pericom,pt7c4338
>            - epson,rx8025
>            - isil,isl12057
> +          - epson,rx8111
>            - epson,rx8130
>  
>        - items:
> -- 
> 2.17.1
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

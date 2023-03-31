Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A46B26D217D
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 15:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232773AbjCaNeE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 09:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232647AbjCaNeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 09:34:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6657D1BF62
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 06:34:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 01A9862223
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 13:34:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8617DC433EF;
        Fri, 31 Mar 2023 13:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680269641;
        bh=8m/coCpDPCAG/paZ3Qk5TU9S4lgF4qCpfZNEk7ocRSc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OkfZA0FgreHLqxUgORZpElngsigIPIi5OMc474njbPTnUkFlJntOBJHxuG+U9Bm66
         GM5r6uiE1cSBlOnxbLScq4aCFFkiMrYjFMsQbm8i1eZhHzRSZiya/kTyHXtVb+mxf4
         LoiQgK3B9CYRrhz9k1Be5TjkGpLy6XlGzLFbG6nr4N2aN6IuwS6LHWwGV8FYFr3pKM
         vhsG/LCVw4Dzbu5D7r18t2mrWwk4o29x37YQWZwqQvnUCQ7rrVFehQlWD0rIZGOqBm
         +HmOy6ft1vpqF/cxNt8oDUK3IQ6ajW9dfVYikkx4n867yPqkJBdv0sbDFz+PrAGGQZ
         pZxleRYZ28VCw==
Date:   Fri, 31 Mar 2023 19:03:57 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Siddharth Vadapalli <s-vadapalli@ti.com>
Cc:     kishon@kernel.org, rogerq@kernel.org,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, srk@ti.com
Subject: Re: [PATCH 0/2] PHY-GMII-SEL: Add support for J784S4 SoC
Message-ID: <ZCbhRQ2B8+RrSh5z@matsya>
References: <20230331062521.529005-1-s-vadapalli@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230331062521.529005-1-s-vadapalli@ti.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31-03-23, 11:55, Siddharth Vadapalli wrote:
> Hello,
> 
> This series TI's J784S4 SoC. A new compatible is added for the J784S4 SoC,
> with QSGMII mode enabled. Also, the CPSW9G instance of J784S4 SoC supports
> USXGMII mode. Thus, add support to configure USXGMII mode.

Sorry this fails to apply for me, pls rebase and send

> 
> Note:
> This series is based on top of the following series:
> https://lore.kernel.org/r/20230309063514.398705-1-s-vadapalli@ti.com/
> 
> The patch corresponding to the device-tree bindings for the compatible
> "ti,j784s4-cpsw9g-phy-gmii-sel" is posted at:
> https://lore.kernel.org/r/20230315092408.1722114-1-s-vadapalli@ti.com
> Since the above patch has received an Acked-by from Krzysztof Kozlowski,
> I am posting this series using the compatible.
> 
> Regards,
> Siddharth.
> 
> Siddharth Vadapalli (2):
>   phy: ti: gmii-sel: Add support for CPSW9G GMII SEL in J784S4
>   phy: ti: gmii-sel: Enable USXGMII mode for J784S4
> 
>  drivers/phy/ti/phy-gmii-sel.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> -- 
> 2.25.1

-- 
~Vinod

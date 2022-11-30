Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14DC963D2D7
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 11:10:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234274AbiK3KKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 05:10:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbiK3KKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 05:10:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 245302CCAE;
        Wed, 30 Nov 2022 02:10:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C754AB81A94;
        Wed, 30 Nov 2022 10:10:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 433AFC433D7;
        Wed, 30 Nov 2022 10:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669803018;
        bh=8d2EyBum02jSvq5TyPACplNPoJXoWUyy1F3ado4PgN0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HGwIjSAbuawGjctC9kPCHugNh73Y5M3qj3zGaMHYXQ101O16XkaLvKDe7ISGRh3/l
         lc+xQ8aSYUwb5tK8SfAb87d9lTEesBi9IQAjBLQby3yYlpcl7ekt640rc4cWMoCwEq
         6qd7hfvh4z7ZpxAVGfdnxo8jU8HIYRw6PF8P7AaMWqmC/YDB+ygVaxheadRGKetDlP
         CGSrNbANzKtnW0ixMUhM59ed5UCvU+sIqqUOWfCQl5lLiACpO7Toik/7Uu4mXfjxSm
         MD1f52gv85HTF1LQAM4qIiPcd/a7kj/UhE9anH8l9GIzRHEy0lnMeWUf5vJGFcdUkl
         yrMLXuBzwIcmQ==
Date:   Wed, 30 Nov 2022 10:10:12 +0000
From:   Lee Jones <lee@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        linux-kernel@vger.kernel.org,
        Support Opensource <support.opensource@diasemi.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marek Vasut <marex@denx.de>, kernel@dh-electronics.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: mfd: da9062: Correct file name for watchdog
Message-ID: <Y4csBBZ3OnpXS5TR@google.com>
References: <20221122111124.6828-1-cniedermaier@dh-electronics.com>
 <20221122111124.6828-2-cniedermaier@dh-electronics.com>
 <ad9720b1-fb9a-e251-bf03-1870a980b0f4@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ad9720b1-fb9a-e251-bf03-1870a980b0f4@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Nov 2022, Krzysztof Kozlowski wrote:

> On 22/11/2022 12:11, Christoph Niedermaier wrote:
> > Replace the watchdog file name with the name currently in use.
> > 
> > Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
> > ---
> > Cc: Support Opensource <support.opensource@diasemi.com>
> > Cc: Lee Jones <lee@kernel.org>
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> > Cc: Marek Vasut <marex@denx.de>
> > Cc: kernel@dh-electronics.com
> > Cc: devicetree@vger.kernel.org
> > To: linux-kernel@vger.kernel.org
> > ---
> >  Documentation/devicetree/bindings/mfd/da9062.txt | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/mfd/da9062.txt b/Documentation/devicetree/bindings/mfd/da9062.txt
> > index bab0d0e66cb3..e96629eb9f48 100644
> > --- a/Documentation/devicetree/bindings/mfd/da9062.txt
> > +++ b/Documentation/devicetree/bindings/mfd/da9062.txt
> > @@ -85,7 +85,7 @@ Sub-nodes:
> >  
> >  - onkey : See ../input/da9062-onkey.txt
> >  
> > -- watchdog: See ../watchdog/da9062-watchdog.txt
> > +- watchdog: See ../watchdog/da9062-wdt.txt
> 
> How is this related to LED patch? Don't mix threads.

Que?

  [PATCH] dt-bindings: mfd: da9062: Correct file name for watchdog

-- 
Lee Jones [李琼斯]

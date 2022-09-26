Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5A825E9AE1
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 09:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234282AbiIZHqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 03:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234222AbiIZHpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 03:45:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 963E51DF14;
        Mon, 26 Sep 2022 00:44:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 62FD7617D8;
        Mon, 26 Sep 2022 07:44:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE9DCC433D6;
        Mon, 26 Sep 2022 07:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664178290;
        bh=LmWrjgoUL9IPset2wdPLvegGqtEiITrCbJZGhnwP62k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i14R2V7mbV7g1X47iVWy/rKdNqvDfF3hM6kk47jaG3tQNs5WzBUHn0lBnu2cWv8mV
         yp4/SMiRsJMzPD+dWI0qYp0ggTfAIUqiEkVlI9lUwC7uY6b2vlLKtCDjYu3RZupx5g
         PHbOLWtNtihd27dkJiMM4xeY0z5JVpyH0jtsjBB9NiwBGfe1UzX+hikaYPb8xWWhgl
         cBuapVcsFbDH2fqE+Rc7f0Xoi6fQ8XX8GcUmYcGWpI9YPaF8St0iRWGIpxWdGniIrp
         RSvUTvKyQORcj7BJbZpzvgPT1GRT8oawVwMKZp67lroq9tGHTX+gdfOqEShEuRHUxg
         gTDZpvoLmF0IA==
Date:   Mon, 26 Sep 2022 08:44:45 +0100
From:   Lee Jones <lee@kernel.org>
To:     Conor Dooley <conor@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Steve Twiss <stwiss.opensource@diasemi.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH] dt-bindings: mfd: dlg,da9063: add missing regulator
 patterns
Message-ID: <YzFYbQ0CXvAuYJBx@google.com>
References: <20220916190009.2292223-1-conor@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220916190009.2292223-1-conor@kernel.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Sep 2022, Conor Dooley wrote:

> From: Conor Dooley <conor.dooley@microchip.com>
> 
> Commit 5621d3977e29 ("dt-bindings: mfd: Add missing (unevaluated|
> additional)Properties on child nodes") exposed a flaw in the original
> binding, where "merged" versions of some regulators were missing,
> leading to warnings on the HiFive Unmatched Devicetree.
> 
> Add the missing patterns (and merge some of the trivial ones).
> 
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> I opted not to include a fixes tag for the conversion since it just
> converted what was already there. I figured the original text binding
> is just incomplete rather than "broken", but if you don't agree the
> fixes tag would be:
> Fixes: c7f15d43a5c5 ("mfd: devicetree: Add bindings for DA9063")
> 
>  Documentation/devicetree/bindings/mfd/dlg,da9063.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]

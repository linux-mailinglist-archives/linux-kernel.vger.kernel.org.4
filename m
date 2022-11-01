Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F0216147A9
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 11:25:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbiKAKZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 06:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiKAKZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 06:25:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66166D120;
        Tue,  1 Nov 2022 03:25:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 01B646155E;
        Tue,  1 Nov 2022 10:25:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8FCFC433D6;
        Tue,  1 Nov 2022 10:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667298312;
        bh=xaFUexV7MYwXBZ2ARe4EZEhgaYRXQWZ3AJuXjnpw1uY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u5gO4DFSfUwgEwxwj2Hne3ZKxcSXO49SUTYi9bc2H8kENoQ4V4Axr2tykanogWvRb
         mL71xZiwh8nXKABsAIkgkeNKZwiwSvs/vaoAioBxbSf2hUQYWpWORJqpPKPah5DUAW
         Ap/5YySro6biKUJda8QHGaybG/pN541Dr8z3JTYjC8NRLvzOPKRVqYWv6+5vbCWRa1
         ZlvHW/9+Cbtc6NF6fI8fQ9xfh9RgryhyhJorQo8WndUDqbNJG08cLb9lLdIRy4Mt0C
         gc4/wQefBumoHFXRHLTM1clfjHqd3MB/ZBDjYjxz6Z1GYAFGo0/p2IdS7aIMy1f1nU
         Msx52f1p7LuXQ==
Date:   Tue, 1 Nov 2022 10:25:06 +0000
From:   Lee Jones <lee@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Dmitry Osipenko <digetx@gmail.com>,
        Chris Zhong <zyw@rock-chips.com>,
        Zhang Qing <zhangqing@rock-chips.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: mfd: Expect specific type for
 monitored-battery
Message-ID: <Y2D0As4ezi/031lL@google.com>
References: <20221028231309.565451-1-krzysztof.kozlowski@linaro.org>
 <Y1+MNL+fCfreAqMh@google.com>
 <20221031192658.GA3286587-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221031192658.GA3286587-robh@kernel.org>
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Oct 2022, Rob Herring wrote:

> On Mon, Oct 31, 2022 at 08:49:56AM +0000, Lee Jones wrote:
> > On Fri, 28 Oct 2022, Krzysztof Kozlowski wrote:
> > 
> > > Core schema does not define type of monitored-battery, so the schemas
> > > are expected to reference proper type.
> > > 
> > > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > > ---
> > >  Documentation/devicetree/bindings/mfd/ene-kb930.yaml      | 4 +++-
> > >  Documentation/devicetree/bindings/mfd/rockchip,rk817.yaml | 1 +
> > >  2 files changed, 4 insertions(+), 1 deletion(-)
> > 
> > Applied, thanks.
> 
> NAK. Please drop or revert.

Dropping is not a problem.

Would you mind providing some context?

-- 
Lee Jones [李琼斯]

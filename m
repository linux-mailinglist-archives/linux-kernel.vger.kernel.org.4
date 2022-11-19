Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA7E630C73
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 07:32:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbiKSGcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 01:32:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiKSGcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 01:32:13 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47E138DA77;
        Fri, 18 Nov 2022 22:32:12 -0800 (PST)
Received: from pyrite.rasen.tech (unknown [IPv6:2001:268:c210:aac1:54ed:fa5d:b703:111a])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id D6675749;
        Sat, 19 Nov 2022 07:32:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1668839530;
        bh=hXfe8VMNdTd6pcdsB0mu2cidi3JUTli3/j9RB6UOCHE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CwIDGdurCsoYEFqPvCaL628T18sUh1mZkxdvgUm/G7p96pRJPWjeYq8hlDnF7gY5H
         xcPVQcg8nw7Iy7Oro1J1fdJtBXYmg8DAIO2+1HaqI0JT57AZ3R3iiB3V+Dh7ZFVqMe
         XJT6zjfTCPYzmOs0VVx25MO6NIoxviJ7KO71WurM=
Date:   Sat, 19 Nov 2022 15:31:57 +0900
From:   Paul Elder <paul.elder@ideasonboard.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-media@vger.kernel.org, Dafna Hirschfeld <dafna@fastmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Helen Koike <helen.koike@collabora.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 01/14] dt-bindings: media: rkisp1: Add i.MX8MP ISP to
 compatible
Message-ID: <Y3h4Xak49kgvWYgl@pyrite.rasen.tech>
References: <20221118093931.1284465-1-paul.elder@ideasonboard.com>
 <20221118093931.1284465-2-paul.elder@ideasonboard.com>
 <feb97479-3c1b-9fd8-ffd7-f8e95151d8fe@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <feb97479-3c1b-9fd8-ffd7-f8e95151d8fe@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2022 at 02:02:28PM +0100, Krzysztof Kozlowski wrote:
> On 18/11/2022 10:39, Paul Elder wrote:
> > The i.MX8MP ISP is compatbile with the rkisp1 driver. Add it to the list
> > of compatible strings. While at it, expand on the description of the
> > clocks to make it clear which clock in the i.MX8MP ISP they map to,
> > based on the names from the datasheet (which are confusing).
> > 
> > Signed-off-by: Paul Elder <paul.elder@ideasonboard.com>
> > Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
> This is a friendly reminder during the review process.
> 
> It looks like you received a tag and forgot to add it.

Sorry, indeed I did. This series has been a bit hectic...


Thanks,

Paul

> 
> If you do not know the process, here is a short explanation:
> Please add Acked-by/Reviewed-by/Tested-by tags when posting new
> versions. However, there's no need to repost patches *only* to add the
> tags. The upstream maintainer will do that for acks received on the
> version they apply.
> 
> https://elixir.bootlin.com/linux/v5.17/source/Documentation/process/submitting-patches.rst#L540
> 
> If a tag was not added on purpose, please state why and what changed.
> 
> Best regards,
> Krzysztof
> 

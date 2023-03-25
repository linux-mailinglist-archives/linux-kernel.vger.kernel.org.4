Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E70346C909C
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 21:00:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231842AbjCYUAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 16:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjCYUA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 16:00:29 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BE75BF;
        Sat, 25 Mar 2023 13:00:28 -0700 (PDT)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 6DECB89F;
        Sat, 25 Mar 2023 21:00:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1679774426;
        bh=kViOzdjEgaW2tSk5jaBnv+4F4JR/5Lb7E3XGv99PQUc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vOJFUlz2TvUh0UcyixqmEaM54EnjQhP9Sgs88rh+XpGxQsSR41CZy4tBhSyZl8vw/
         ioXGhUcBliwEkvKNmu1c7YGugis8hsuzcA3/lRWLy4fSMAq38AivJaDUSUvEaVGYh7
         4ZhYtysbkcKidnMfInWdlii8QQHJGchtyuW+Th8M=
Date:   Sat, 25 Mar 2023 22:00:33 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Cc:     Paul Elder <paul.elder@ideasonboard.com>,
        linux-media@vger.kernel.org, Dafna Hirschfeld <dafna@fastmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] media: rkisp1: Miscellaneous improvements
Message-ID: <20230325200033.GG9876@pendragon.ideasonboard.com>
References: <20221117084217.3892680-1-paul.elder@ideasonboard.com>
 <20230221135730.zyfg3ainjg7btfzv@uno.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230221135730.zyfg3ainjg7btfzv@uno.localdomain>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacopo,

On Tue, Feb 21, 2023 at 02:57:30PM +0100, Jacopo Mondi wrote:
> On Thu, Nov 17, 2022 at 05:42:14PM +0900, Paul Elder wrote:
> > This patch series adds small improvements to the rkisp1 driver:
> > - Add NV16M and NV61M output
> > - Implement ENUM_FRAMESIZES
> >
> > As well as a small code cleanup.
> >
> > These patches have been sent before individually, so really this is a
> > resend, which also bunches them together.
> >
> > Laurent Pinchart (1):
> >   media: rkisp1: Make local immutable array variables static const
> >
> > Paul Elder (2):
> >   media: rkisp1: Add NV16M and NV61M to output formats
> >   media: rkisp1: Implement ENUM_FRAMESIZES
> 
> Has this series fell into cracks ? Support for VIDIOC_ENUM_FRAMESIZES
> in particular is a relevant feature and seems not controversial at all...

An alternative version of the first patch has been merged already, and
I've just sent a pull request for the other two.

> >  .../platform/rockchip/rkisp1/rkisp1-capture.c | 64 +++++++++++++++++--
> >  1 file changed, 60 insertions(+), 4 deletions(-)

-- 
Regards,

Laurent Pinchart

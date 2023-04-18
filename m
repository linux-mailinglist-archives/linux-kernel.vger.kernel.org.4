Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F299F6E6A8F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 19:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232262AbjDRRH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 13:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbjDRRH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 13:07:27 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD8B7F1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 10:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=ELo08Uz//08TqpFlhA8BRj6vq6RPAzoviX9qsv+yGYE=; b=YzS710UA4AO1y0a99vT+hKxRi2
        PTrhUi7NvYxAVN1D89vyomBKC3a+AuRJhxzNZ9ezH55RCWd6nlZ3n+uXfS0Dx6Tf9hDdUeJ4nLwhX
        Zebsid+NxEkNas4wqTog20gO/xuxRc9Qo3htYgt5RoKD3+M8MNGOMZAtViS7uWB2igwo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1pooSO-00Ad26-Em; Tue, 18 Apr 2023 18:45:28 +0200
Date:   Tue, 18 Apr 2023 18:45:28 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Rob Herring <robh@kernel.org>
Cc:     Gregory Clement <gregory.clement@bootlin.com>,
        linux-arm-kernel@lists.infradead.org,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bus: mvebu-mbus: Remove open coded "ranges" parsing
Message-ID: <4dfddc70-c763-4723-9763-10af8fb487ee@lunn.ch>
References: <20230216181204.2895676-1-robh@kernel.org>
 <20230418161907.GA1764573-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230418161907.GA1764573-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2023 at 11:19:07AM -0500, Rob Herring wrote:
> On Thu, Feb 16, 2023 at 12:12:04PM -0600, Rob Herring wrote:
> > "ranges" is a standard property, and we have common helper functions for
> > parsing it, so let's use them.
> > 
> > Cc: Andrew Lunn <andrew@lunn.ch>
> > Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> > Cc: Gregory Clement <gregory.clement@bootlin.com>
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> > Compile tested only!
> > ---
> >  drivers/bus/mvebu-mbus.c | 58 ++++++----------------------------------
> >  1 file changed, 8 insertions(+), 50 deletions(-)
> 
> As this hasn't been applied elsewhere, applied to DT tree.

Gregory sent his pull request to arm-soc today, and i don't see if. So
thanks for taking it.

       Andrew

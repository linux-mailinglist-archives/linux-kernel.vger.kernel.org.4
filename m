Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F27B73CB67
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 16:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232620AbjFXOeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 10:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjFXOeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 10:34:10 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C855B1BE7;
        Sat, 24 Jun 2023 07:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
        Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
        In-Reply-To:References; bh=sfmTGtS1SDG95I7HcTPQPFUjKryxcp/7FEsQyZgRUPw=; b=Zu
        VALNzjO2ZjVD5jCj337VClVnE3UjlO7qZX7Yyr/q9uEar5MvsblCqXBUudrRi9GGD2cmT4XmO3v/B
        A01GXaih9/wl6OivZkPw8rbQofm1ERNO+EcvOb+HbUHCujh9onUCy/LEYzvIxrmOQQlQYD2VGp0Bm
        lLRTFkn87XBQig4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qD4Kt-00HQv6-Ge; Sat, 24 Jun 2023 16:33:59 +0200
Date:   Sat, 24 Jun 2023 16:33:59 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Cc:     Grygorii Strashko <grygorii.strashko@ti.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-omap@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeroen Hofstee <jhofstee@victronenergy.com>,
        Tony Lindgren <tony@atomide.com>
Subject: Re: [RESEND][PATCH] net: cpsw: fix obtaining mac address for am3517
Message-ID: <457ae95b-8838-4c10-821c-379ed622ef41@lunn.ch>
References: <20230624121211.19711-1-mans@mansr.com>
 <ad0ec6ac-2760-4a03-8cee-0d933aea98eb@lunn.ch>
 <yw1x352h3plc.fsf@mansr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yw1x352h3plc.fsf@mansr.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 24, 2023 at 03:24:47PM +0100, Måns Rullgård wrote:
> Andrew Lunn <andrew@lunn.ch> writes:
> 
> > On Sat, Jun 24, 2023 at 01:10:59PM +0100, Mans Rullgard wrote:
> >> From: Jeroen Hofstee <jhofstee@victronenergy.com>
> >> 
> >> Commit b6745f6e4e63 ("drivers: net: cpsw: davinci_emac: move reading mac
> >> id to common file") did not only move the code for an am3517, it also
> >> added the slave parameter, resulting in an invalid (all zero) mac address
> >> being returned for an am3517, since it only has a single emac
> >
> > Hi Mans
> >
> > If there is only a single emac, why is the function being called with
> > slave=1? Given the description, it seems like you are fixing the wrong
> > problem.
> 
> See previous discussion:
> https://lore.kernel.org/lkml/d8ad5cab-5183-cddf-fa9a-4e7b9b8c9377@victronenergy.com/

Hi Måns

O.K. did i mention memory of a goldfish?

This is the sort of detail that should be in the commit
message. Otherwise reviewers are going to ask for an explanation, even
if it has been explained once, 6 years ago.

I assume you also want this back ported to stable? Please add a Fixed:
tag, and a Cc: stable@vger.kernel.org tag. And set the patch subject
to [PATCH net v3] to indicate this is for the net tree, not net-next.

Thanks
	Andrew

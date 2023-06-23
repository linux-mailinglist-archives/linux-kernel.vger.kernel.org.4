Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45F2173C305
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 23:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231808AbjFWVl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 17:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbjFWVl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 17:41:26 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6849BE8;
        Fri, 23 Jun 2023 14:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=WQCx5S2rzLd7RjvqC6LDqFRCoPVDdf+dtn8GX4ji/qw=; b=JnnXEtIGu6tZGGHN5/q8q6daj3
        7lBAOb+CZlE8Q8ycc8GwVRgXk2p5SW/8zk5uR06Ebrvv8fPzn4pbEM7NfokWIbXNqWEAaso9EPvob
        /yJ/ldkkKHwdzyzIceh8iTNtqB+yzfWatxdFxzOFidPd6JkhuMjQnA0zMB0no+tb5Ts0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qCoWk-00HOhO-4M; Fri, 23 Jun 2023 23:41:10 +0200
Date:   Fri, 23 Jun 2023 23:41:10 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Jeroen Hofstee <jhofstee@victronenergy.com>
Cc:     Simon Horman <simon.horman@corigine.com>,
        =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>,
        Tony Lindgren <tony@atomide.com>, netdev@vger.kernel.org,
        Mugunthan V N <mugunthanvnm@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        "open list:TI ETHERNET SWITCH DRIVER (CPSW)" 
        <linux-omap@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] net: cpsw: fix obtaining mac address for am3517
Message-ID: <675a346b-faed-4e86-87e7-b332da540055@lunn.ch>
References: <1477668756-2651-1-git-send-email-jhofstee@victronenergy.com>
 <20161028155213.2t3nwwe3lqaynaer@atomide.com>
 <d8ad5cab-5183-cddf-fa9a-4e7b9b8c9377@victronenergy.com>
 <20161028181914.mskebckucukzhxhz@atomide.com>
 <yw1x7cru445g.fsf@mansr.com>
 <ZJX9FBBvOTv10IO4@corigine.com>
 <de546232-0638-318a-535f-169184933a20@victronenergy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de546232-0638-318a-535f-169184933a20@victronenergy.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > I feel like I am missing something here.
> 
> That is a weird response, you feel like something is missing

There is. The patch.

Maintainers have a slightly better memory than a goldfish, but given
the high volume of patches, we don't remember threads from 2016. Also,
all our infrastructure has limited memory, this patch is not in lore,
and it is not in patchworks. So in terms of getting merged, it does
not exist.

We do however recommend that if a patch has not been merged within 2
weeks, it is rebased, any Acked-by: etc tags are added and the patch
reposted.

	Andrew

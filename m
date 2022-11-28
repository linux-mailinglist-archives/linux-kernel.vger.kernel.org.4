Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E0A463ABC5
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 15:58:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbiK1O6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 09:58:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231382AbiK1O6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 09:58:42 -0500
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3066A1FD
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 06:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1669647521; x=1701183521;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rSQv3Hdh7OZ3xNUTtdMaYSu/tI7aZ4nCrA3SqzPQo0o=;
  b=aL6JX5tLCc3F3q0OFgsBoJl1+i6wBIAUHLhywNgHEB/2C+7NP7FCkWr+
   UO1B8J1XxXHpLgcAq+PUtRBIcaNp8cXOdH62x81KAmqz9nIE0QPuALeEs
   pzPqsTsMK8YWATGSU5FlBPfUTm1jS2DKqoVA3VWAGskxIX99WGJ/lPZAt
   I6geVHBa+79/CM3/VfnSeU1WYed+NerRBEFaqZzTh78S6sR8s4YCoVO3L
   cbh6VzK1RIJhh7GmWCN1DZSlB9wndsL3hBItpOCvvUhCARmoyRWbo/CPU
   xzyAwYcPmVcdXJRW8eEkGF31F3E7L6Ldl0go7ti010YytFXlxi5apa6VE
   g==;
X-IronPort-AV: E=Sophos;i="5.96,200,1665439200"; 
   d="scan'208";a="27620207"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 28 Nov 2022 15:58:39 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Mon, 28 Nov 2022 15:58:39 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Mon, 28 Nov 2022 15:58:39 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1669647519; x=1701183519;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rSQv3Hdh7OZ3xNUTtdMaYSu/tI7aZ4nCrA3SqzPQo0o=;
  b=Z9To4f/5x1L+R1AvDqyUrKEDgNBK5WJAHj4h8ZCVibBil/7Cimr0uRyE
   MpQFOSZDII9GKXwvAybcvxR19FjyJgbpqswU/8jYyNFAFYmon3UJdRgF/
   15tEuJVDfc+iOgxUJi/pBcGNwJm6gExtiWBoURNsrssS2DgnsWOuvCZWF
   SnHCXGMxQY1KnSKF4UeOReKuTIvr1ox5yrvX7c988FfpBReRTDQ8cC43m
   glM2kJUkpwDFs2NxTXdAc7WVABqsVenIBZxyMyAxfOC7+8JM1yXgfXoyO
   X+crHeTCwjZh5/4xsGHpSgNoEczdlidbDojo6KlqnlhLr3GMEs7VVB71K
   g==;
X-IronPort-AV: E=Sophos;i="5.96,200,1665439200"; 
   d="scan'208";a="27620206"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 28 Nov 2022 15:58:39 +0100
Received: from steina-w.localnet (unknown [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 4F933280056;
        Mon, 28 Nov 2022 15:58:39 +0100 (CET)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] regmap: cache: downgrade log level for no cache defaults message
Date:   Mon, 28 Nov 2022 15:58:40 +0100
Message-ID: <3208991.44csPzL39Z@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <Y4EX7DLt/Lvde/SJ@sirena.org.uk>
References: <20220921071054.3132504-1-alexander.stein@ew.tq-group.com> <Y4EX7DLt/Lvde/SJ@sirena.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mark,

Am Freitag, 25. November 2022, 20:30:52 CET schrieb Mark Brown:
> * PGP Signed by an unknown key
> 
> On Wed, Sep 21, 2022 at 09:10:54AM +0200, Alexander Stein wrote:
> > Having no cache defaults is not a mistake, especially for devices
> > which do have some kind of strapping values which can't be provided
> > statically. For this case a warning is the wrong log level, the initial
> > cache values do need to be read form hardware. Reduce level to info.
> > 
> >  	if (!map->reg_defaults_raw) {
> >  	
> >  		bool cache_bypass = map->cache_bypass;
> > 
> > -		dev_warn(map->dev, "No cache defaults, reading back from 
HW\n");
> > +		dev_info(map->dev, "No cache defaults, reading back from 
HW\n");
> 
> This is a warning which is only generated in the case where we have a
> non-sparse cache where we won't read from the hardware in the csae of
> missing values and will instead just substitute zero as a default value.
> It's warning that we might end up changing values for the device
> unexpectedly in the case of a read/modify/write cycle that doesn't
> actually check what the device currently has set.
> 
> In this case if you can't use a rbtree cache I would recommend
> bootstrapping by initially reading without a cache first to get the
> default values, then replacing the regmap with one that uses the
> defaults you just read.  You'll need some care over suspend/resume
> though.

The driver I'm working on clk-renesas-pcie.c only has 8 registers, so there is 
no benefit to use a different cache than REGCACHE_FLAT.

But I currently fail to see why this is only for non-sparse caches. This is 
printed even before the cache_ops init() is called.

Before the call to regcache_hw_init() there is this comment:
> /* Some devices such as PMICs don't have cache defaults,
>  * we cope with this by reading back the HW registers and
>  * crafting the cache defaults by hand.
>  */

This is exactly what I want to do: Read back HW registers and create a cache.
Actually regcache_hw_init() is exactly doing what you are suggesting:
1. reading HW registers into map->reg_defaults_raw
2.
 a) copy them into map->reg_defaults
 b) read HW register individually if 1. failed

So thinking more about this, this warning should be removed altogether IMHO.

Best regards,
Alexander



